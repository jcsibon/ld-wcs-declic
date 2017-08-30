<!doctype HTML>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="../Common/EnvironmentSetup.jspf"%>
<%@ include file="../include/ErrorMessageSetup.jspf"%>
<%@ include file="../Common/nocache.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>

<jsp:useBean id="contentHelper" class="com.lapeyre.declic.cms.ContentHelper" scope="request"> </jsp:useBean>

<c:set var="mag" value="${content}" />
<c:set var="seo" value="${mag.seo}" />

<c:set var="pageTitle" value="${seo.titre}" scope="request"/>


<fmt:setBundle basename="/Widgets/Properties/widgettext" var="widgetText" />
<c:set var="widgetSuffix" value="" />

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	<flow:ifEnabled feature="FacebookIntegration">
		<%-- Facebook requires this to work in IE browsers --%>
		xmlns:fb="http://www.facebook.com/2008/fbml" 
		xmlns:og="http://opengraphprotocol.org/schema/"
	</flow:ifEnabled>
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}"
	xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><c:out value="${seo.titre}" /></title>
<meta name="viewport" content="<c:out value="${viewport}"/>" />
<meta name="description" content="<c:out value="${seo.description}"/>" />
<meta name="keywords" content="<c:out value="${seo.keyword}"/>" />
<meta name="pageName" content="${seo.titre}" />
<c:if test="${!seo.index && !seo.follow }" >
	<meta name="robots" content="${seo.index?'index':'noindex'},${seo.follow?'follow':'nofollow'}" />
</c:if>
<%-- Use only HTTPS URL for canonical --%>
<link rel="canonical" href="<c:out value="${fn:replace(seo.url, 'http://', 'https://')}"/>" />

<!--Main Stylesheet for browser -->
<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen" />
<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
<!-- Style sheet for print -->
<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print" />
<%--Main Stylesheet for google map override style --%>
<link rel="stylesheet" href="${jspStoreImgDir}css/storelocmap.css" type="text/css" media="screen" />

<!-- Include script files -->
<%@include file="../Common/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/lightSlider/jquery.lightSlider.min.js?${versionNumber}"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&language=fr${googleAuth}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/MapStoreLocator.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/SearchShopsJS.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/ShopsController.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/jScrollbar/jquery.scrollbar.js?${versionNumber}"></script>
<script type="text/javascript">
			var stockAvailability = null;
			dojo.addOnLoad(function() { 
					shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}" />','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
					SearchShopsJS.init();
					SearchShopsJS.initCountry("${CommandContext.country}");
					<c:set var="geoLocRequired" value="true" />
					<c:choose>
						<c:when test="${userType eq 'G'}">
							<c:set var="geoLocRequired" value="true" />
						</c:when>
						<c:otherwise>
							<wcbase:useBean id="addressDB" classname="com.lapeyre.declic.commerce.usermanagement.commands.SelfAddressDataBean" scope="page" />
							<c:if test="${!empty addressDB.selfAddress}">
								<c:set var="geoLocRequired" value="false" />
								<c:set var="address" value="${addressDB.selfAddress.address1}" />
								<c:set var="address" value="${address}+${addressDB.selfAddress.city}" />
								<c:set var="address" value="${address}+${addressDB.selfAddress.state}" />
								<c:set var="address" value="${address}+${addressDB.selfAddress.zipCode}" />
								SearchShopsJS.doSearchShopFromAddress('<c:out value="${address}" />');
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:if test="${geoLocRequired eq 'true'}">
						SearchShopsJS.geoLocSearch();
					</c:if>
			});

			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
					document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
				</c:if>
				MapStoreLocatorJS.autocenter=false;
</script>

	<c:set var="imageUrl" scope="page" value="${contentHelper.imageUrl}" />

<%-- social networks --%>
		<c:set var="titleToShare" value="${seo.titre}" scope="page"/>
		<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}${portUsed}" var="hostPath" />
		<c:set var="urlToShare" value="${hostPath}${storeLocatorURL}${seo.url}" scope="page"/>
		<c:set var="isStoreLocationPage" value="true"/>		
		<%@ include file="../Common/SocialNetworksSetup.jspf" %>
		<%@ include file="../Common/JSTLEnvironmentSetupExtForSocialNetworks.jsp" %>
</head>

<body>

	<%-- This file includes the progressBar mark-up and success/error message display markup --%>
	<%@ include file="../Common/CommonJSPFToInclude.jspf"%>

	<% out.flush(); %>
	<c:import url="${env_jspStoreDir}Widgets/Header/Header.jsp" />
	<% out.flush(); %>
	
	<%-- A Map to store the bread crumb items along with their URLs--%>
	<jsp:useBean id="breadCrumbItemsMap" class="java.util.LinkedHashMap" type="java.util.Map"/>
	<fmt:message var="storeLocator" key="storeLocatorBreadcrumbLabel" bundle="${storeText}" />
	<%-- Sets the Home url to the Map--%>
	<fmt:message var="home" key="BCT_HOME"  bundle="${widgetText}"/>
	<c:set target="${breadCrumbItemsMap}" property="${home}" value="${env_TopCategoriesDisplayURL}"/>
	<c:set target="${breadCrumbItemsMap}" property="${storeLocator}" value="${storeLocatorURL}"/>
	
	<c:set var="lastBreadCrumbItem" value="${seo.titre}"/>		
		
<div id="page">
	<div id="contentWrapper">
		<div id="content" role="main">
			<div class="rowContainer" id="containerMain">
				<!-- Begin Page -->
				<c:set var="carouselIdx" value="1" scope="request" />

				<div class="row">
					<div class="col12 slot1">
						<%@include file="../StoreLocatorArea/StoreLocator_BreadcrumbTrail_UI.jspf" %>
					</div>
				</div>
				<c:choose>
					<c:when test="${mag.code ==404}">
						<h2 class="error"><c:out value="${mag.message}"/></h2>
					</c:when>
					<c:otherwise>
						<div itemscope itemtype="${MICRO_DATA_STORE}">
							<meta itemprop="url" content="${env_absoluteUrlWithoutEndSlash }${seo.url}" />
							<meta itemprop="parentOrganization" itemtype="${MICRO_DATA_ORGANIZATION}"/>
							<meta itemprop="logo" content="${env_absoluteUrlWithoutEndSlash }${jspStoreImgDir}images/logo.png" />
							<meta itemprop="currenciesAccepted" conten="EUR" />
							<%@ include file="StorePresentation.jsp"%>
							<%@ include file="StoreServices.jsp"%>
							<div class="row storeMap" style="position:relative;">
									<%@include file="../StoreLocatorArea/StoreLocator_Map_UI.jspf" %>
							</div>
							<%@ include file="StoreHours.jsp"%>
							<%@ include file="StoreNews.jsp"%>
							<%-- <%@ include file="StoreRate.jsp"%> --%>
							<%@ include file="StoreQrCode.jsp"%>
							<div class="row whiteBackground padding-bottom mobile-hidden print-hidden favoritesShopsList">
								<%@include file="../StoreLocatorArea/FavoritesShopsDisplay.jsp" %>
								<%@include file="../StoreLocatorArea/NearestShopsDisplay.jsp" %>
							</div>
						
							<%--<div class="row padding-bottom mobile-hidden nearShopsList" style="position: relative"> --%>
							<%@include file="../StoreLocatorArea/StoreLocator_ListShops_Data.jspf" %> 
							<%@include file="../StoreLocatorArea/StoreLocator_ListShops_Script.jspf" %>
							<%-- <%@include file="../StoreLocatorArea/StoreLocator_ListShops_UI.jspf" %> --%>
							<!-- </div> -->
							<script type="text/javascript">
								dojo.addOnLoad(function() {
									google.maps.event.addListenerOnce(MapStoreLocatorJS.map, 'tilesloaded', function(){
										if(typeof MapStoreLocatorJS != "undefined"){
											var shopId = '<c:out value="${mag.idMagasin}" />';
											MapStoreLocatorJS.centerToShopById('\''+shopId+'\'');
											MapStoreLocatorJS.openInfoWindowById('\''+shopId+'\'');
											MapStoreLocatorJS.setZoom(14);
										}
									});
								});
							</script>
							<%--mantis 3202 : supprimer l'affichage des cooredonnees GPS --%>
							<%-- <%@ include file="StoreGPS.jsp"%> --%>
							</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>

		<%
		    out.flush();
		%>
		<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp" />
		<%
		    out.flush();
		%>
	<c:import url="../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="storeLocFiche" />
	</c:import>
</body>

</html>
