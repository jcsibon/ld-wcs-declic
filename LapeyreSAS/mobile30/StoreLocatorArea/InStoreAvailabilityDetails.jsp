<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP displays the In-Store Availability details of an item.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ taglib uri="flow.tld" prefix="flow" %>

<!-- BEGIN InStoreAvailabilityDetails.jsp -->

<%@ include file="../../Common/EnvironmentSetup.jspf"%>

<c:set var="storeAvailPage" value="true" scope="request"/>
<c:choose>
	<c:when test="${WCParam.pgGrp == 'catNav'}">
		<c:set var="categoryNavPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'search'}">
		<c:set var="searchPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'wishlist'}">
		<c:set var="wishlistPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'shoppingcart'}">
		<c:set var="shoppingcartPageGroup" value="true" scope="request"/>
	</c:when>
	<c:when test="${WCParam.pgGrp == 'prodComp'}">
		<c:set var="prodComparePageGroup" value="true" scope="request"/>
	</c:when>	
</c:choose>

<c:set var="itemId" value="${WCParam.itemId}" />
<c:set var="physicalStoreId" value="${WCParam.physicalStoreId}" />
<c:set var="physicalStoreIndex" value="${WCParam.physicalStoreIndex}" />

<c:if test="${!empty cookie.WC_physicalStores.value}">
	<c:set var="physicalStoreIds" value="${fn:split(fn:replace(cookie.WC_physicalStores.value, '%2C', ','), ',')}" />
</c:if>

<wcf:getData var="physicalStore"
		type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType"
		expressionBuilder="findPhysicalStoresByUniqueIDs">
	<wcf:param name="accessProfile" value="IBM_Store_Details" />
	<wcf:param name="uniqueId" value="${physicalStoreId}" />
</wcf:getData>

<wcf:getData var="inventoryAvailability"
		type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType"
		expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
	<wcf:param name="accessProfile" value="IBM_Store_Details" />
	<wcf:param name="catalogEntryId" value="${itemId}" />
	<wcf:param name="physicalStoreId" value="${physicalStoreId}" />
</wcf:getData>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title>
			<fmt:message bundle="${storeText}" key="MSTKLOCDETAILS_TITLE">
				<fmt:param value="${physicalStore.description[0].name}" />
			</fmt:message>
		</title>

		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="${viewport}" />
		<link rel="stylesheet" href="${env_vfileStylesheet_m30}" type="text/css" />

        <%@ include file="../include/CommonAssetsForHeader.jspf" %>
	</head>

	<body>
		<div id="wrapper" class="ucp_active"> <!-- User Control Panel is ON-->

			<%@ include file="../include/HeaderDisplay.jspf" %>

			<!-- Start Breadcrumb Bar -->
			<div id="breadcrumb" class="item_wrapper_gradient">
				<a id="back_link" href="javascript:if (history.length>0) {history.go(-1);}"><div class="back_arrow left">
					<div class="arrow_icon"></div>
				</div></a>
				<div class="page_title left"><c:out value="${physicalStore.description[0].name}" /></div>
				<div class="clear_float"></div>
			</div>
			<!-- End Breadcrumb Bar -->

			<div id="store_availability_details" class="item_wrapper item_wrapper_gradient">
				<c:set var="inventoryStatus" value="${(empty inventoryAvailability ? 'Unavailable' : inventoryAvailability.inventoryStatus)}" />
				<fmt:message bundle="${storeText}" var="message" key="INV_STATUS_${inventoryStatus}"/>
				<fmt:message bundle="${storeText}" var="availLiClassId" key="status_${inventoryStatus}"/>

				<ul id="availability">
					<li><strong><fmt:message bundle="${storeText}" key="MSTKLOCDETAILS_IN_STORE_AVAILABILITY"/></strong></li>
					<div class="item_spacer_5px"></div>
					<li class="<c:out value="${availLiClassId}" />">
						<img src="${jspStoreImgDir}${storeNameDir}/images/${inventoryStatus}.gif" width="12" height="12" alt="${message}" />
						<c:out value="${message}" />
						<c:choose>
							<c:when test="${inventoryStatus == 'Available'}">
								<c:if test="${!empty inventoryAvailability.availableQuantity}">
									(<fmt:formatNumber value="${inventoryAvailability.availableQuantity.value}" type="number" maxFractionDigits="0" />)
								</c:if>
							</c:when>
							<c:when test="${inventoryStatus == 'Backorderable'}">
								<c:if test="${!empty inventoryAvailability.availabilityDateTime}">
									<c:catch>
										<fmt:parseDate var="availabilityDate" value="${inventoryAvailability.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="UTC" />
									</c:catch>
									<c:if test="${empty availabilityDate}">
										<c:catch>
											<fmt:parseDate var="availabilityDate" value="${inventoryAvailability.availabilityDateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" timeZone="UTC" />
										</c:catch>
									</c:if>
									(<fmt:formatDate value="${availabilityDate}" dateStyle="long" />)
								</c:if>
							</c:when>
						</c:choose>
					</li>
				</ul>
				<div class="item_spacer"></div>

				<ul id="address">
					<li><strong><fmt:message bundle="${storeText}" key="MSTDT_ADDRESS"/></strong></li>
					<div class="item_spacer_5px"></div>
					<li>
						<c:out value="${physicalStore.locationInfo.address.addressLine[0]}" /><br />
						<c:out value="${physicalStore.locationInfo.address.city}" />, <c:out value="${physicalStore.locationInfo.address.stateOrProvinceName}" />
					</li>
					<div class="item_spacer"></div>
					<c:set var="tel" value="${fn:replace(physicalStore.locationInfo.telephone1.value, '.', '-')}" />
					<li><a id="store_phone_number" href="tel:+1-${fn:escapeXml(tel)}"><c:out value="${physicalStore.locationInfo.telephone1.value}" /></a></li>
					<div class="item_spacer"></div>
					<div class="single_button_container">
						<%@ include file="../Snippets/StoreLocator/ViewMap.jspf" %>
						<div class="clear_float"></div>
					</div>
				</ul>
				<div class="item_spacer"></div>

				<ul id="store_hours">
					<li><strong><fmt:message bundle="${storeText}" key="MSTDT_SHOP_HOURS"/></strong></li>
					<div class="item_spacer_5px"></div>
					<li>
						<c:forEach var="attribute" items="${physicalStore.attribute}">
							<c:if test="${attribute.name == 'StoreHours'}">
								<p>${attribute.value}</p>
							</c:if>
						</c:forEach>
					</li>
				</ul>
			</div>

			<c:if test="${fn:length(physicalStoreIds) > 1}">
				<div id="paging_control" class="item_wrapper">
					<c:if test="${physicalStoreIndex gt 0}">
						<wcf:url var="mInStoreAvailabilityDetailsView" value="m30InStoreAvailabilityDetailsView">
							<c:forEach var="thisParameter" items="${WCParamValues}">
								<c:if test="${thisParameter.key != 'physicalStoreId' and thisParameter.key != 'physicalStoreIndex'}">
									<c:forEach var="value" items="${thisParameter.value}">
										<wcf:param name="${thisParameter.key}" value="${value}" />
									</c:forEach>
								</c:if>
							</c:forEach>
							<wcf:param name="physicalStoreId" value="${physicalStoreIds[physicalStoreIndex - 1]}" />
							<wcf:param name="physicalStoreIndex" value="${physicalStoreIndex - 1}" />
						</wcf:url>
						<a id="mPrevStore" href="${fn:escapeXml(mInStoreAvailabilityDetailsView)}" title="<fmt:message bundle="${storeText}" key="PAGING_PREV_PAGE_TITLE"/>">
							<div class="back_arrow_icon"></div>
							<span class="indented"><fmt:message bundle="${storeText}" key="PAGING_PREV_PAGE"/></span>
						</a>
						<c:if test="${physicalStoreIndex+1 > fn:length(physicalStoreIds)}">
							<div class="clear_float"></div>
						</c:if>
					</c:if>
					<c:if test="${physicalStoreIndex lt fn:length(physicalStoreIds) - 1}">
						<wcf:url var="mInStoreAvailabilityDetailsView" value="m30InStoreAvailabilityDetailsView">
							<c:forEach var="thisParameter" items="${WCParamValues}">
								<c:if test="${thisParameter.key != 'physicalStoreId' and thisParameter.key != 'physicalStoreIndex'}">
									<c:forEach var="value" items="${thisParameter.value}">
										<wcf:param name="${thisParameter.key}" value="${value}" />
									</c:forEach>
								</c:if>
							</c:forEach>
							<wcf:param name="physicalStoreId" value="${physicalStoreIds[physicalStoreIndex + 1]}" />
							<wcf:param name="physicalStoreIndex" value="${physicalStoreIndex + 1}" />
						</wcf:url>
						<a id="mNextStore" href="${fn:escapeXml(mInStoreAvailabilityDetailsView)}" title="<fmt:message bundle="${storeText}" key="PAGING_NEXT_PAGE_TITLE"/>">
							<span class="right"><fmt:message bundle="${storeText}" key="PAGING_NEXT_PAGE"/></span>
							<div class="forward_arrow_icon"></div>
						</a>
						<c:if test="${physicalStoreIndex-1 < 1}">
							<div class="clear_float"></div>
						</c:if>
					</c:if>
				</div>
			</c:if>

			<wcf:url var="mProductDisplayView" value="ProductDisplay">
				<c:forEach var="thisParameter" items="${WCParamValues}">
					<c:if test="${thisParameter.key != 'physicalStoreId' and thisParameter.key != 'physicalStoreIndex'}">
						<c:forEach var="value" items="${thisParameter.value}">
							<wcf:param name="${thisParameter.key}" value="${value}" />
						</c:forEach>
					</c:if>
				</c:forEach>
			</wcf:url>

			<div id="back_to_product_page" class="item_wrapper_button">
				<div class="single_button_container">
					<fmt:message bundle="${storeText}" var="backToProductPage" key='MSTKLOCDETAILS_BACK_TO_PRODUCT_PAGE'/>
					<a id="product_page_link" href="${fn:escapeXml(mProductDisplayView)}" title="${fn:escapeXml(backToProductPage)}"><div class="secondary_button button_half"><c:out value="${backToProductPage}" /></div></a>
				</div>
			</div>
					
			<%@ include file="../include/FooterDisplay.jspf" %>						

		</div>
	<%@ include file="../../Common/JSPFExtToInclude.jspf"%> </body>
</html>

<!-- END InStoreAvailabilityDetails.jsp -->
