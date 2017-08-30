<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>
<!-- LAPEYRE_HOME -->
<!-- BEGIN TopCategoriesDisplay.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl" %>
<%-- Target2Sell BEGIN--%>
<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_HOME %>" scope="request" />
<%-- Target2Sell END --%>


<c:if test="${(WCParam.previousCommand eq 'logon' || WCParam.globalLogIn eq 'true') && env_shopOnBehalfEnabled_CSR eq 'true'}">
	<%-- User with CSR/CSS role has logged in. Redirect to CSR Landing Page. --%>
	<c:url var="redirectURL" value="CustomerServiceLandingPageView" scope="request">
	  <c:param name="langId" value="${param.langId}" />
	  <c:param name="storeId" value="${param.storeId}" />
	  <c:param name="catalogId" value="${param.catalogId}" />
	</c:url>
	<c:redirect url="/${redirectURL}" context="${env_contextAndServletPath}"/>
</c:if>


<wcf:rest var="getPageResponse" url="store/{storeId}/page/name/{name}">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:var name="name" value="HomePage" encode="true"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="profileName" value="IBM_Store_Details"/>
</wcf:rest>
<c:set var="page" value="${getPageResponse.resultList[0]}"/>
<c:set var="pageGroup" value="Content" scope="request"/>
<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="q" value="byObjectIdentifier"/>
	<wcf:param name="objectIdentifier" value="${page.pageId}"/>
	<wcf:param name="deviceClass" value="${deviceClass}"/>
	<wcf:param name="pageGroup" value="${pageGroup}"/>
</wcf:rest>

<c:set var="pageTitle" value="${onlineStoreSEO.SEOPageDefinitions[0].title}" scope="request"/>
<c:set var="metaDescription" value="${page.metaDescription}" />
<c:set var="metaKeyword" value="${page.metaKeyword}" />
<c:set var="fullImageAltDescription" value="${page.fullImageAltDescription}" scope="request" />
<c:set var="pageCategory" value="Browse" scope="request"/>

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
		<title><c:out value="${page.title}"/></title>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keywords" content="<c:out value="${metaKeyword}"/>"/>
		<meta name="pageIdentifier" content="HomePage"/>
		<meta name="pageId" content="<c:out value="${page.pageId}"/>"/>
		<meta name="pageGroup" content="content"/>
	    <link rel="canonical" href="<c:out value="${env_absoluteUrl}"/>" />
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jsAssetsDir}css/redesign/category/topCategoriesDisplay.css?${versionNumber}" type="text/css" />
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<link rel="stylesheet" href="${jspStoreImgDir}css/tooltipster.css?${versionNumber}" type="text/css"/>
		
		<!-- Include script files -->
		<%@include file="../../../Common/CommonJSToInclude_redesign.jspf" %>
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingList.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListServicesDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ECOCatalogEntry/javascript/ProductDisplay.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.PDP_FullImage/javascript/ProductFullImage.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.StandardProductDisplayWidget/javascript/StandardProductDisplayWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/Timer.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/TagManager.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.ItemAvailabilityInPhysicalStoresWidget/javascript/ItemAvailabilityInPhysicalStoresWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Stock/StockAvailability.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/tooltipster/jquery.tooltipster.min.js?${versionNumber}"></script>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				shoppingActionsJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','<c:out value="${env_CurrencySymbolToFormat}" />');
				shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
				});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>
		</script>
		
		<flow:ifEnabled feature="FacebookIntegration">
			<%@include file="../../../Common/JSTLEnvironmentSetupExtForFacebook.jspf" %>
			<%--Facebook Open Graph tags that are required  --%>
			<meta property="og:title" content="<c:out value="${pageTitle}"/>" /> 			
			<meta property="og:image" content="<c:out value="${schemeToUse}://${request.serverName}${portUsed}${jspStoreImgDir}images/logo.png"/>" />
			<meta property="og:url" content="<c:out value="${env_TopCategoriesDisplayURL}"/>"/>
			<meta property="og:type" content="website"/>
			<meta property="fb:app_id" name="fb_app_id" content="<c:out value="${facebookAppId}"/>"/>
			<meta property="og:description" content="${page.metaDescription}" />
		</flow:ifEnabled>
	</head>
	<body>
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
		
		<%-- ECOCEA : call CMS --%>
		<%out.flush();%>
		<c:import url="${env_jspStoreDir}/include/HomeContentContext.jsp">
			<c:param name="typePage" value="home" />
			<c:param name="id" value=""/>
			<c:param name="complement" value=""/>
		</c:import>
		<%out.flush();%>

		<!-- Begin Page -->
		<c:set var="layoutPageIdentifier" value="${page.pageId}"/>
		<c:set var="layoutPageName" value="${page.name}"/>
		<%@ include file="../../../Common/LayoutPreviewSetup.jspf"%>

		<div id="page"  class="homePage">
			<div id="grayOut"></div>

				<c:set var="overrideLazyLoadDepartmentsList" value="true" scope="request"/>
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp">
					<c:param name="overrideLazyLoadDepartmentsList" value="${overrideLazyLoadDepartmentsList}" />
				</c:import>
				<%out.flush();%>
			<c:if test="${widgetText == null || empty widgetText}">
				<fmt:setLocale value="${CommandContext.locale}" />
				<fmt:setBundle basename="/Widgets/Properties/widgettext" var="widgetText" />
			</c:if>
			<div class="compareCheckboxLabels">
				<label><fmt:message key="LAP003_COMPARE_ADD" bundle="${widgetText}"/></label>
				<label>     
				   	<fmt:message var="comparatorLabel" key="LAP004_COMPARE_ADDED" bundle="${widgetText}"/>
				   	<fmt:message var="comparatorLabelWithLink" key="LAP004_COMPARE_ADDED_WITHLINK" bundle="${widgetText}"/>
					<c:import url="/Widgets-lapeyre/Common/ECOComparatorControls.jsp">
						<c:param name="asCheckbox" value="true"/>
						<c:param name="comparatorLabel" value="${comparatorLabel}"/>
						<c:param name="comparatorLabelWithLink" value="${comparatorLabelWithLink}"/>
					</c:import>
			    </label>
			</div>
			<div class="homeContainer">
				<div id="content" role="main">
					<c:set var="pageDesign" value="${getPageDesignResponse.resultList[0]}" scope="request"/>
					<c:set var="PAGE_DESIGN_DETAILS_JSON_VAR" value="pageDesign" scope="request"/>
					<wcpgl:jsInclude/>
					<c:set var="rootWidget" value="${pageDesign.widget}"/>
					<wcpgl:widgetImport uniqueID="${rootWidget.widgetDefinitionId}" debug=false/>
				</div>
			</div>
			
<!-- 			<div id="footerWrapper"> -->
				<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
				<%out.flush();%>
<!-- 			</div> -->

		</div>
		
		<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%>
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="Home" />
	</c:import>
	</body>
	
	<script>
		$(document).ready(function() {
			/* Create link to LeMag in middleUniverse CMS content */
			var buttonLeMag = 	'<div class="mea-univers-button-container hide-on-large-only">' +
									'<a class="button button-green" href="/c/magazine">' +
										'<fmt:message bundle="${storeText}" key="homeButtonLeMagLabel"/>' +
									'</a>' +
								'</div>';
			
			$(".mea-univers-home").append(buttonLeMag);
			
			mediaPhone.addListener(function(changed) {
			    if(changed.matches) {
			    	hideMeaUniverseMobile();
			    }
			});
			
			mediaTablet.addListener(function(changed) {
			    if(changed.matches) {
			    	hideMeaUniverseTablet();
			    }
			});
			
			function hideMeaUniverseTablet() {
				$(".mea-univers-container .mea-univers-block").each(function(key, value) {
					  var pos = $(this).attr("data-position-tablet");
					  if(pos>2) {
						  $(this).css("display", "none");
					  } else {
						  $(this).css("display", "block");
					  }
					  
				});			
			}
			
			function hideMeaUniverseMobile() {
				$(".mea-univers-container .mea-univers-block").each(function(key, value) {
					  var pos = $(this).attr("data-position-mobile");
					  if(pos>4) {
						  $(this).css("display", "none");
					  } else {
						  $(this).css("display", "block");
					  }
				});			
			}
			
		});		
	</script>

<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutId}" pageId="${page.pageId}"/>
<!-- END TopCategoriesDisplay.jsp -->		
</html>