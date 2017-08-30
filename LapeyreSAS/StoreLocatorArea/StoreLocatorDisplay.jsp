<!doctype HTML>
<!-- LAPEYRE_LES_MAGASINS -->
<!-- BEGIN StoreLocatorDisplay.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@include file="../Common/nocache.jspf" %>

<fmt:setBundle basename="/Widgets/Properties/widgettext" var="widgetText" />
<c:set var="widgetSuffix" value="" />

<fmt:message var="pageTitle" key="storeLocatorBreadcrumbLabel" bundle="${storeText}" scope="request"/>

<%-- A Map to store the bread crumb items along with their URLs--%>
<jsp:useBean id="breadCrumbItemsMap" class="java.util.LinkedHashMap" type="java.util.Map"/>

<%-- Sets the Home url to the Map--%>
<fmt:message var="home" key="BCT_HOME"  bundle="${widgetText}"/>
<c:set target="${breadCrumbItemsMap}" property="${home}" value="${env_TopCategoriesDisplayURL}"/>

<%-- Sets the Home as the last bread crumb item --%>
<c:set var="lastBreadCrumbItem" value="${pageTitle}"/>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
<flow:ifEnabled feature="FacebookIntegration">
	<%-- Facebook requires this to work in IE browsers --%>
	xmlns:fb="http://www.facebook.com/2008/fbml" 
	xmlns:og="http://opengraphprotocol.org/schema/"
</flow:ifEnabled> 
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><c:out value="${pageTitle}"/></title>
		<meta name="viewport" content="<c:out value="${viewport}"/>"/>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keywords" content="<c:out value="${metaKeyword}"/>"/>
		<meta name="pageName" content="${pageTitle}"/>
		<%-- Use only HTTPS URL for canonical --%>
		<link rel="canonical" href="<c:out value="${fn:replace(env_absoluteUrl, 'http://', 'https://')}"/>tous-les-magasins" />
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jsAssetsDir}css/redesign/storeLocator.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/redesign/storeLocator-media.css?${versionNumber}" type="text/css" />
		
		
		
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<!-- Include script files -->
		<%@include file="../Common/CommonJSToInclude_redesign.jspf" %>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"></script>
		
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
			// Prevent JS error 'stockAvailability is not defined' caused by PageExt.jspf
			var stockAvailability = null;
			dojo.addOnLoad(function() { 
				shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}" />','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
				SearchShopsJS.init();
				SearchShopsJS.initCountry("${CommandContext.country}");
			});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>
		</script>
	</head>
		
	
<body class="storelocator" id="page">
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>

	<!-- Import Header Widget -->
	
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
		<%out.flush();%>
		
		<%@include file="StoreLocator_ListShops_Data.jspf" %>
		<%@include file="StoreLocator_ListShops_Script.jspf" %>
		<div>
			<div id="content" role="main">
				<div class="rowContainer" id="containerMain">
					<div class="row">
						<%@include file="StoreLocator_SearchBar_UI.jspf" %>
					</div>
					<div class="container" id="mapContainer">
						<div class="row">
							<div class="col s12 m4 l3"  id="listShopContainerRow">
								<%@include file="FavoritesShopsDisplay.jsp" %>
								<%@include file="NearestShopsDisplay.jsp" %>
							</div>
							<div class="col s12 m8 l9" style="position:relative;" id="mapShopContainerRow" class="col s12">
								<%@include file="StoreLocator_Map_UI.jspf" %>
							</div>
						</div>
					</div>
					<%-- <div class="row mobile-hidden" id="listShopByZip" style="position: relative">
						<%@include file="StoreLocator_ListShops_UI.jspf" %>
					</div> --%>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				<c:choose>
					<c:when test="${fn:length(extendedUserContext.defaultStores) > 0}">
						<c:set var="shopIdToCenter" value="${extendedUserContext.defaultStores[0].id}" />
						var shopId = '<c:out value="${shopIdToCenter}" />';
						MapStoreLocatorJS.centerToShopById('\''+shopId+'\'');
						MapStoreLocatorJS.openInfoWindowById('\''+shopId+'\'');
						MapStoreLocatorJS.setZoom(14);
					</c:when>
					<c:otherwise>
						SearchShopsJS.geoLocSearch();
					</c:otherwise>
				</c:choose>
			});
            $(document).ready(function() {
                var search = $( "#SimpleSearchForm_StoreLocator" ).val();
                /* If search bar already set, launch search */
                if(search != ""){
                    document.getElementById("searchShopsSubmitButtonId").click();
                } else {
                	SearchShopsJS.updateNearestShops(true);
                }
            });
		</script>

		<%out.flush();%>
		<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
		<%out.flush();%>
	<c:import url="../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="storeLoc" />
	</c:import>
		
</body>
<!-- END StoreLocatorDisplay.jsp -->
</html>
