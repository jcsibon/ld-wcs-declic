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
  * This JSP displays Item Availability.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ taglib uri="flow.tld" prefix="flow" %>

<!-- BEGIN ItemAvailability.jsp -->

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../../Common/EnvironmentSetup.jspf" %>

<c:if test="${! empty param.numEntitledItems && (param.numEntitledItems == 1 || (! empty cookie.WC_ItemSelectedAttributes.value)) }" >
	<c:set var="itemId" value="${param.itemId}" />
	<c:set var="productId" value="${param.productId}" />
	<c:if test="${param.numEntitledItems > 1 && ! empty cookie.WC_ItemSelectedAttributes.value}" >
		<c:set var="itemId" value="${fn:split(cookie.WC_ItemSelectedAttributes.value, '|')[0]}" />
	</c:if>
	
	<c:if test="${itemId != '0'}" >
		<c:if test="${!empty cookie.WC_physicalStores.value}">
			<c:set var="physicalStoreIds" value="${fn:split(fn:replace(cookie.WC_physicalStores.value, '%2C', ','), ',')}" />
		</c:if>
		
		<c:if test="${!empty physicalStoreIds}">
			<wcf:getData var="physicalStores"
					type="com.ibm.commerce.store.facade.datatypes.PhysicalStoreType[]"
					expressionBuilder="findPhysicalStoresByUniqueIDs">
				<wcf:param name="accessProfile" value="IBM_Store_Details" />
				<c:forEach var="thisPhysicalStoreId" items="${physicalStoreIds}">
					<wcf:param name="uniqueId" value="${thisPhysicalStoreId}" />
				</c:forEach>
			</wcf:getData>
		</c:if>
		
		<wcf:getData var="inventoryAvailabilities"
				type="com.ibm.commerce.inventory.facade.datatypes.InventoryAvailabilityType[]"
				expressionBuilder="findInventoryAvailabilityByCatalogEntryIdsAndOnlineStoreIdsAndPhysicalStoreIds">
			<wcf:param name="accessProfile" value="IBM_Store_Details" />
			<wcf:param name="catalogEntryId" value="${itemId}" />
			<wcf:param name="onlineStoreId" value="${storeId}" />
			<c:forEach var="thisPhysicalStore" items="${physicalStores}">
				<wcf:param name="physicalStoreId" value="${thisPhysicalStore.physicalStoreIdentifier.uniqueID}" />
			</c:forEach>
		</wcf:getData>
		
		<div class="item_wrapper">
			<ul class="entry">
				<li><strong><fmt:message bundle="${storeText}" key="MSTKLOC_PRODUCT_INV_ONLINE"/></strong></li>
				<div class="item_spacer_10px"></div>
				<c:remove var="inventoryAvailability" />
				<c:forEach var="thisInventoryAvailability" items="${inventoryAvailabilities}">
					<c:if test="${thisInventoryAvailability.inventoryAvailabilityIdentifier.externalIdentifier.onlineStoreIdentifier.uniqueID == storeId}">
						<c:set var="inventoryAvailability" value="${thisInventoryAvailability}" />
					</c:if>
				</c:forEach>
				<c:set var="inventoryStatus" value="${empty inventoryAvailability ? 'Unavailable' : inventoryAvailability.inventoryStatus}" />
				<fmt:message bundle="${storeText}" var="inventoryStatusMessage" key="INV_STATUS_${inventoryStatus}"/>
				<li class="status"><img src="${fn:escapeXml(jspStoreImgDir)}${storeNameDir}images/${inventoryStatus}.gif" width="9" height="9" alt="${inventoryStatusMessage}" /> ${inventoryStatusMessage}</li>
			</ul>
		</div>	
				
		<div class="item_wrapper">
			<ul class="entry">
				<li><strong><fmt:message bundle="${storeText}" key="MSTKLOC_PRODUCT_INV_STORE"/></strong></li>		
				<c:choose>
					<c:when test="${empty physicalStores}">
						<wcf:url var="mStoreLocatorView" value="m30StoreLocatorView">
							<c:set var="fromPageSet" value="false" />
							<c:forEach var="thisParameter" items="${WCParamValues}">
								<c:forEach var="value" items="${thisParameter.value}">
									<c:choose>
										<c:when test="${thisParameter.key eq 'fromPage'}">
											<wcf:param name="${thisParameter.key}" value="ProductDetails" />
											<c:set var="fromPageSet" value="true" />
										</c:when>
										<c:otherwise>
											<c:if test="${thisParameter.key ne 'productId'}">							
												<wcf:param name="${thisParameter.key}" value="${value}" />
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:forEach>
						
							<c:if test="${fromPageSet eq 'false'}">
								<wcf:param name="fromPage" value="ProductDetails" />
							</c:if>
							<wcf:param name="productId" value="${productId}" />					
						</wcf:url>
						<div class="item_spacer_10px"></div>
						<div class="single_button_container">
							<a id="store_locator_link" href="${fn:escapeXml(mStoreLocatorView)}"><div class="secondary_button button_full"><fmt:message bundle="${storeText}" key='INV_Link_Check_Store'/></div></a>
							<div class="clear_float"></div>
						</div>
			</ul>
		</div>
					</c:when>
					<c:otherwise>
			</ul>
		</div>
						<c:forEach var="thisPhysicalStoreId" items="${physicalStoreIds}" varStatus="status">
							<c:remove var="physicalStore" />
							<c:remove var="inventoryAvailability" />
							<c:forEach var="thisPhysicalStore" items="${physicalStores}">
								<c:if test="${thisPhysicalStore.physicalStoreIdentifier.uniqueID == thisPhysicalStoreId}">
									<c:set var="physicalStore" value="${thisPhysicalStore}" />
								</c:if>
							</c:forEach>
							<c:forEach var="thisInventoryAvailability" items="${inventoryAvailabilities}">
								<c:if test="${thisInventoryAvailability.inventoryAvailabilityIdentifier.externalIdentifier.physicalStoreIdentifier.uniqueID == thisPhysicalStoreId}">
									<c:set var="inventoryAvailability" value="${thisInventoryAvailability}" />
								</c:if>
							</c:forEach>
							<c:if test="${!empty physicalStore}">
								<c:set var="inventoryStatus" value="${(empty inventoryAvailability ? 'Unavailable' : inventoryAvailability.inventoryStatus)}" />
								<fmt:message bundle="${storeText}" var="inventoryStatusMessage" key="INV_STATUS_${inventoryStatus}"/>
								<fmt:message bundle="${storeText}" var="availLiClassId" key="status_${inventoryStatus}"/>
								<wcf:url var="mInStoreAvailabilityDetailsView" value="m30InStoreAvailabilityDetailsView">
									<c:forEach var="parameter" items="${WCParamValues}">
										<c:forEach var="value" items="${parameter.value}">
											<c:if test="${parameter.key ne 'productId'}">
												<wcf:param name="${parameter.key}" value="${value}" />
											</c:if>
										</c:forEach>
									</c:forEach>
									<wcf:param name="productId" value="${productId}" />
									<wcf:param name="itemId" value="${itemId}" />
									<wcf:param name="physicalStoreId" value="${thisPhysicalStoreId}" />
									<wcf:param name="physicalStoreIndex" value="${status.index}" />
								</wcf:url>
								<a id="<c:out value='availability_in_store_${status.count}'/>" href="${fn:escapeXml(mInStoreAvailabilityDetailsView)}" title="${fn:escapeXml(physicalStoreName)}">
									<div class="item_wrapper">
										<div class="item_avail_image_container"><img src="${jspStoreImgDir}${storeNameDir}images/${inventoryStatus}.gif" width="9" height="9" alt="${inventoryStatusMessage}" /></div>
										<div class="item_avail_info_container">
											<c:set var="physicalStoreName" value="${physicalStore.description[0].name}" />
											<c:out value="${physicalStoreName}" />: <c:out value="${inventoryStatusMessage}" />
										</div>
										<div class="forward_arrow_icon"></div>
										<div class="clear_float"></div>
									</div>
								</a>
							</c:if>
						</c:forEach>
						<wcf:url var="mSelectedStoreListView" value="m30SelectedStoreListView">
							<c:set var="fromPageSet" value="false" />
							<wcf:param name="storeList" value="true" />
							<c:forEach var="thisParameter" items="${WCParamValues}">
								<c:forEach var="value" items="${thisParameter.value}">
									<c:choose>
										<c:when test="${thisParameter.key eq 'fromPage'}">
											<wcf:param name="${thisParameter.key}" value="ProductDetails" />
											<c:set var="fromPageSet" value="true" />
										</c:when>
										<c:otherwise>
											<c:if test="${thisParameter.key ne 'productId'}">
												<wcf:param name="${thisParameter.key}" value="${value}" />
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:forEach>
		
							<c:if test="${fromPageSet eq 'false'}">
								<wcf:param name="fromPage" value="ProductDetails" />
							</c:if>
							<wcf:param name="productId" value="${productId}" />					
						</wcf:url>
						<fmt:message bundle="${storeText}" var="changeStore" key="INV_Link_Change_Store"/>
						<form id="change_stores_input" action="${fn:escapeXml(mSelectedStoreListView)}">
							<div class="item_wrapper">
								<div class="single_button_container">
									<a id="change_store" href="${fn:escapeXml(mSelectedStoreListView)}" title="${fn:escapeXml(changeStore)}">
										<div class="secondary_button button_full"><c:out value="${changeStore}" /></div>
									</a>
									<div class="clear_float"></div>
								</div>
							</div>
						</form>
					</c:otherwise>
				</c:choose>
	</c:if>
</c:if>
<!-- END ItemAvailability.jsp -->
