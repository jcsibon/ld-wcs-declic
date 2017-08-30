<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.ibm.commerce.member.facade.client.MemberFacadeClient" %>
<%@ page import="com.ibm.commerce.member.facade.datatypes.PersonType" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>


<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>


<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message bundle="${storeText}" key="pageTitleQuotation" /></title>
	<META NAME="robots" CONTENT="noindex,nofollow" />
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css" />
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
	<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
	<%-- <link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css" type="text/css" /> --%>
	
	
	<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
	
	<%-- CommonContexts must come before CommonControllers --%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js?${versionNumber}"/>"></script>
		
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
	<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>
	
	
	<wcf:url var="ToggleNewsletterForm" value="NewsletterToggleCmd">
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	</wcf:url>


</head>
<body>
<c:set var="quotationId" value="${WCParam.quotationId}"/>
<c:set var="suiviCom" value="${true}"/>

<%@ include file="QuotationDetails_data.jspf"%>
	<!-- Page Start -->
	<div id="page">
		<%out.flush();%>
		<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>

		<div id="contentWrapper">
			<div id="content" role="main">
				<div class="rowContainer">
					<div class="row">
						<div data-slot-id="1" class="col12 slot1 mobile-hidden">
							<%out.flush();%>
							<fmt:message var="lastBreadCrumbItem" key="myNewslettersBreadcrumbLabel" bundle="${widgetText}" />
							<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
								<c:param name="pageName" value="CompteClient" />
								<c:param name="breadCrumbMonCompte" value="true" />
								<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
							</c:import>
							<%out.flush();%>
						</div>
					</div>
					<c:set var="navMonCompteCurrentPage" value="myOrders"/>
					<%--@ include file="../../AccountSection/headerClient.jspf"--%>

					<div class="headerContent">
						<div class="ContentTitle center">
							<h2 class="titleBlock">
								<fmt:message bundle="${storeText }" key="quotationPageTitle" />
								<span><c:out value="${detailQuota.enTeteDocument.infosDocument.numeroDocument}" />
								</span>
							</h2>
							<br>
							<fmt:parseDate value="15/02/2015" pattern="dd/MM/yyyy" var="dateDispo" />
							<div class="statusDevis">
								<fmt:message bundle="${storeText}" key="quotationEndDateLabel"/>
								<fmt:formatDate value="${dateDispo}" pattern="d MMM yyyy" />
							</div>
						</div>
					</div>
					<br clear="all">
					<div class="row tunnel suiviCom">
						<div class="listeProduitsHeader">
							<div>
								<b> <c:choose>
										<c:when test="${orderQuantity <= 1}">
											<p>
												${orderQuantity}
												<fmt:message bundle="${storeText}" key="productLabel" />
											</p>
										</c:when>
										<c:otherwise>
											<p>
												${orderQuantity}
												<fmt:message bundle="${storeText}" key="productsLabel" />
											</p>
										</c:otherwise>
									</c:choose> </b>
							</div>
							<div></div>
							<div>
								<c:choose>
									<c:when test="${extendedUserContext.isPro}">
										<fmt:message bundle="${storeText}" key="htPriceColumnLabel" />
									</c:when>
									<c:otherwise>
										<fmt:message bundle="${storeText}" key="ttcPriceColumnLabel" />
									</c:otherwise>
								</c:choose>
							</div>
							<div>
								<fmt:message bundle="${storeText}" key="QuantityColumnLabel" />
							</div>
							<div>
								${tvaRateColumnLabel}
								<fmt:message bundle="${storeText}" key="vatColumnLabel" />
							</div>
							<div>&nbsp;</div>
							<div>
								<c:choose>
									<c:when test="${extendedUserContext.isPro}">
										<fmt:message bundle="${storeText}" key="htTotalPriceColumnLabel" />
									</c:when>
									<c:otherwise>
										<fmt:message bundle="${storeText}" key="ttcTotalPriceColumnLabel" />
									</c:otherwise>
								</c:choose>
							</div>
							<div>&nbsp;</div>
						</div>
						<div class="listeProduits">
							<%@ include file="../../../ShoppingArea/ShopcartSection/OrderItemDetail.jspf"%>
							<%-- TODO  get méthode de paiement --%>
						</div>
						<div class="montantTotal">
							<div style="height: auto;">
								<p>
									<fmt:message bundle="${storeText}" key="totalAmountLabel" />
								</p>
							</div>
							<div style="height: auto;">
								<p>
									<fmt:formatNumber value="${totalDevis}" maxFractionDigits="2"/><sup>${env_CurrencySymbolToFormat}</sup>
								</p>
							</div>
						</div>
					</div>
					<br clear="all">
					<div class="row center">
						<a class="button" style="width:20%;" href="javascript:window.print();"><fmt:message bundle="${storeText}" key="printButtonLabel" /></a>
						<jsp:useBean id="now" class="java.util.Date"/>
						<c:if test="${now<=dateDispo}">
							<a class="button green"><fmt:message bundle="${storeText}" key="quotationAddToCartButtonLabel" /></a>
						</c:if>
					</div>
					<br clear="all">
					<c:set var="shopId" value="${WCParam.shopId}"/>
					<c:catch var="ErrorShop">
						<wcbase:useBean id="shopDB" classname="com.lapeyre.declic.commerce.storelocator.beans.FullShopDataBean" scope="page">
							<c:set value="${shopId}" target="${shopDB}" property="identifier"/>
							<c:set value="${langId}" target="${shopDB}" property="languageId"/>
							<c:set value="${CommandContext}" target="${shopDB}" property="commandContext"/>
						</wcbase:useBean>
					</c:catch>
					<div class="row"> 
						<div class="shopContainer center" id="DocDetail">
							<c:choose>
								<c:when test="${empty ErrorShop}">
									<h2 class="titleBlock">
										<fmt:message bundle="${storeText}" key="orderStoreSectionTitle" />
									</h2>
									<%@ include file="ShopDisplayLinked.jspf"%>
								</c:when>
								<c:otherwise>
									<span class="titleBlock error"> <fmt:message bundle="${storeText}" key="errorShopOrder" /> </span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>

		<% out.flush(); %>
		<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<% out.flush(); %>
	</div>
</body>
</html>