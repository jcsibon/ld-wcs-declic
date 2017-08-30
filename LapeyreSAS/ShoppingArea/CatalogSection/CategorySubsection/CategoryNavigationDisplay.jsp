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
<!-- LAPEYRE_UNIVERS -->
<!-- BEGIN CategoryNavigationDisplay.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/JSTLEnvironmentSetupExtForRemoteWidgets.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>



<flow:ifEnabled feature="Analytics">
<cm:setCategoryCookie />
</flow:ifEnabled>

<c:set var="pageView" value="${WCParam.pageView}" scope="request"/>
<c:if test="${empty pageView}" >
	<c:set var="pageView" value="${env_defaultPageView}" scope="request"/>
</c:if>
<c:set var="pageCategory" value="Browse" scope="request"/>

<c:if test="${empty WCParam.categoryId && not empty RequestProperties}">
	<c:set target="${WCParam}" property="categoryId" value="${RequestProperties.categoryId}" />
</c:if>
<c:if test="${!empty WCParam.categoryId}">
	<%-- Get SEO data and canonical URL --%>
	<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="storeId" value="${storeId}" />
		<wcf:param name="catalogId" value="${catalogId}" />
		<wcf:param name="categoryId" value="${WCParam.categoryId}" />	
		<wcf:param name="urlLangId" value="${urlLangId}" />							
	</wcf:url>
	
	<c:set var="key1" value="categoryview/byId/${WCParam.categoryId}"/>
	<c:set var="catGroupDetailsView" value="${cachedCategoryViewMap[key1]}"/>
	<c:if test="${empty catGroupDetailsView}">
		<c:catch var="searchServerException">
		<wcf:rest var="catGroupDetailsView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${WCParam.categoryId}" >	
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="currency" value="${env_currencyCode}"/>
			<wcf:param name="responseFormat" value="json"/>		
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<c:forEach var="contractId" items="${env_activeContractIds}">
					<wcf:param name="contractId" value="${contractId}"/>
				</c:forEach>
			<wcf:param name="profileName" value="ECO_findCategoryByUniqueId"/>
		</wcf:rest>
		<wcf:set target = "${cachedCategoryViewMap}" key="${key1}" value="${catGroupDetailsView}"/>
		</c:catch>
	</c:if>

	<wcf:rest var="getPageResponse" url="store/{storeId}/page">
		<wcf:var name="storeId" value="${storeId}" encode="true"/>
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="q" value="byCategoryIds"/>
		<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
	</wcf:rest>
	<c:set var="page" value="${getPageResponse.resultList[0]}"/>
</c:if>

<c:set var="isCategoryPage" value="true" />
<c:set var="seoTitle" value="${page.title}" />
<c:set var="pageTitle" value="${seoTitle}" scope="request"/>
<c:set var="metaDescription" value="${page.metaDescription}" />
<c:set var="metaKeyword" value="${page.metaKeyword}" />
<c:set var="categoryName" value="${catGroupDetailsView.catalogGroupView[0].name}"/>
<c:set var="partNumber" value="${catGroupDetailsView.catalogGroupView[0].identifier}"/>
<c:set var="parentCatalogGroupID" value="${catGroupDetailsView.catalogGroupView[0].parentCatalogGroupID}" />
<%-- Target2Sell BEGIN : set pID and scope set to request so that we dont have to make the call twice --%>
<c:set var="partNumber" value="${catGroupDetailsView.catalogGroupView[0].identifier}" scope="request" />
<c:choose>
	<c:when test="${empty WCParam.categoryId}">
		<c:set var="pageGroup" value="Search" scope="request"/>
		<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_SEARCH %>" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="pageGroup" value="Category" scope="request"/>
		<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_CATEGORY %>" scope="request" />
	</c:otherwise>
</c:choose>
<%-- Target2Sell END --%>

<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="q" value="byObjectIdentifier"/>
	<c:choose>
		<c:when test="${empty WCParam.categoryId}">
			<wcf:param name="objectIdentifier" value="-1"/>
		</c:when>
		<c:otherwise>
			<wcf:param name="objectIdentifier" value="${WCParam.categoryId}"/>
		</c:otherwise>
	</c:choose>
	<wcf:param name="deviceClass" value="${deviceClass}"/>
	<wcf:param name="pageGroup" value="${pageGroup}"/>
	<c:catch>
	<c:forEach var="aParam" items="${WCParamValues}">
		<c:forEach var="aValue" items="${aParam.value}">
				<c:if test="${aParam.key !='langId' && aParam.key !='logonPassword' && aParam.key !='logonPasswordVerify' && aParam.key !='URL' && aParam.key !='currency' && aParam.key !='storeId' && aParam.key !='catalogId' && aParam.key !='logonPasswordOld' && aParam.key !='logonPasswordOldVerify' && aParam.key !='account' && aParam.key !='cc_cvc' && aParam.key !='check_routing_number' && aParam.key !='plainString' && aParam.key !='xcred_logonPassword'}">
			<wcf:param name="${aParam.key}" value="${aValue}"/>
				</c:if>
		</c:forEach>
	</c:forEach>
	</c:catch>
</wcf:rest>

<c:set var="emsNameLocalPrefix" value="${fn:replace(partNumber,' ','')}" scope="request"/>
<c:set var="emsNameLocalPrefix" value="${fn:replace(emsNameLocalPrefix,'\\\\','')}"/>

<wcf:url var="CategoryNavigationResultsViewURL" value="CategoryNavigationResultsView" type="Ajax">
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="pageSize" value="${pageSize}"/>
	<wcf:param name="sType" value="SimpleSearch"/>						
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>		
	<wcf:param name="searchType" value="${WCParam.searchType}"/>	
	<wcf:param name="metaData" value="${metaData}"/>	
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>	
	<wcf:param name="filterFacet" value="${WCParam.filterFacet}"/>
	<wcf:param name="manufacturer" value="${WCParam.manufacturer}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
	<wcf:param name="filterType" value="${WCParam.filterType}" />
	<wcf:param name="advancedSearch" value="${WCParam.advancedSearch}"/>
</wcf:url>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><c:out value="${seoTitle}"/></title>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keywords" content="<c:out value="${metaKeyword}"/>"/>
		<meta name="pageIdentifier" content="<c:out value="${categoryName}"/>"/>
		<meta name="pageId" content="<c:out value="${WCParam.categoryId}"/>"/>
		<meta name="pageGroup" content="<c:out value="${requestScope.pageGroup}"/>"/>
		<meta name="pageName" content="CategoryPage"/>
		<%-- <c:choose>
		<c:when test="${!empty WCParam.canonical}">
            <link rel="canonical" href="<c:out value="${fn:replace(WCParam.canonical, 'http://', 'https://')}"/>" />
		</c:when><c:otherwise>
            <link rel="canonical" href="<c:out value="${fn:replace(CategoryDisplayURL, 'http://', 'https://')}"/>" />
		</c:otherwise></c:choose>
		--%>
			    
	    <%-- SEO: URL Prev / Next pour les cat�gories multi-pages --%>
		<c:if test="${ not empty pageView and pageView eq 'grid'
						and not empty beginIndex
						and not empty pageSize
						and not empty top_category
						and not empty categoryId
						and pageDesign.layoutName eq 'FamilyPageLayout' }">
		    <wcf:rest var="recordSetNumberOfProductsInCategory" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byCategory/${WCParam.categoryId}">
				<wcf:param name="profileName" value="ECO_findNumberOfProductsInCategory" />
				<wcf:param name="responseFormat" value="json"/>
				<wcf:param name="langId" value="${WCParam.langId}"/>
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="categoryId" value="${categoryId}"/>
				<%-- 
				     Perform deep search to retrieve all products within the current category and all the subcategories. 
				     The default of this parameter in the expression is "N" for shallow search Navigation to return immediate products in the category.
				--%>
				<flow:ifEnabled feature="ExpandedCategoryNavigation">
					<wcf:param name="searchSource" value="E" />
				</flow:ifEnabled>
			</wcf:rest>
			<c:set var="numberOfProductsInCategory" value="${ recordSetNumberOfProductsInCategory.recordSetTotalMatches }" />
			<c:if test="${not empty numberOfProductsInCategory}">
				<c:if test="${ecocea:hasPageBefore(beginIndex, pageSize)}">
					<wcf:url var="prevPageUrl" patternName="CanonicalCategoryURL" value="Category3">
						<wcf:param name="langId" value="${WCParam.langId}" />
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />	
						<wcf:param name="top_category" value="${top_category}" />			
						<wcf:param name="categoryId" value="${categoryId}" />	
						<wcf:param name="pageView" value="grid" />
						<wcf:param name="beginIndex" value="${beginIndex - pageSize}" />
						<wcf:param name="urlLangId" value="-2" />
					</wcf:url>
					<link rel="prev" href="${prevPageUrl}" />
				</c:if>
				<c:if test="${ecocea:hasPageAfter(beginIndex, pageSize, numberOfProductsInCategory)}">
					<wcf:url var="nextPageUrl" patternName="CanonicalCategoryURL" value="Category3">
						<wcf:param name="langId" value="${WCParam.langId}" />
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />	
						<wcf:param name="top_category" value="${top_category}" />			
						<wcf:param name="categoryId" value="${categoryId}" />	
						<wcf:param name="pageView" value="grid" />
						<wcf:param name="beginIndex" value="${beginIndex + pageSize}" />
						<wcf:param name="urlLangId" value="-2" />
					</wcf:url>
					<link rel="next" href="${nextPageUrl}" />
				</c:if>
			</c:if>
		</c:if>

		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/category/categoryNavigationDisplay.css?${versionNumber}" type="text/css" media="screen">
		
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<link rel="stylesheet" href="${jspStoreImgDir}css/jquery.nstSlider.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${jspStoreImgDir}css/tooltipster.css" type="text/css"/>
		<!-- Include script files -->
		<%@include file="../../../Common/CommonJSToInclude_redesign.jspf" %>
		
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/nstSlider/jquery.nstSlider.js?${versionNumber}"></script>
		<!-- script type="text/javascript" src="${jsAssetsDir}javascript/nstSlider/jquery.nstSlider.min.js?${versionNumber}"></script-->
		<script type="text/javascript" src="${jsAssetsDir}javascript/tooltipster/jquery.tooltipster.min.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingList.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListServicesDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ShoppingList/javascript/WishList.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ECOCatalogEntry/javascript/ProductDisplay.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.PDP_FullImage/javascript/ProductFullImage.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.StandardProductDisplayWidget/javascript/StandardProductDisplayWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/Timer.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/TagManager.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.ItemAvailabilityInPhysicalStoresWidget/javascript/ItemAvailabilityInPhysicalStoresWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Stock/StockAvailability.js?${versionNumber}"></script>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}" />','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
				});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>

		</script>
		
		<%@ include file="../../../Common/SocialNetworksSetup.jspf" %>
		<%@ include file="../../../Common/JSTLEnvironmentSetupExtForSocialNetworks.jsp" %>
		
	</head>
		
	<body class="univers">
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
		
		<script type="text/javascript">
			<!-- Initializes the undo stack. This must be called from a <script>  block that lives inside the <body> tag to prevent bugs on IE. -->
			dojo.require("dojo.back");
			dojo.back.init();
			dojo.addOnLoad(function(){
				//shoppingActionsJS.initCompare('<c:out value="${param.fromPage}"/>');
			});
		</script>
		<!-- Begin Page -->
		<div id="IntelligentOfferMainPartNumber" style="display:none;"><c:out value="${partNumber}" /></div>
		<c:set var="layoutPageIdentifier" value="${WCParam.categoryId}"/>
		<c:set var="layoutPageName" value="${partNumber}"/>

		<%-- ECOCEA : get catalogGroup keyword  --%>
		<c:set var="keyword" value="${catGroupDetailsView.catalogGroupView[0].keyword}"/>

		<%-- ECOCEA : call CMS  --%>
		<c:choose>
			<c:when test="${pageDesign.layoutName == 'UniversePageLayout'}"><%-- catGroupDetailsView.catalogGroupView[0].parentCatalogGroupID --%>
		 		<c:import url="${env_jspStoreDir}/include/ContentContext.jsp">
	  				<c:param name="typePage" value="univers" />
					<c:param name="complement" value=""/>
					<c:param name="id" value="${layoutPageName}"/> <%-- layoutPageName ${catGroupDetailsView.catalogGroupView[0].uniqueID} --%>
				</c:import>
  			</c:when>
			<c:otherwise>
				<c:set var="tagKeyWord" value="${fn:replace(keyword,'&','%26')}"/>
				<c:set var="tagKeyWord" value="${fn:replace(tagKeyWord,'=','%3D')}"/>
				
 				<c:import url="${env_jspStoreDir}/include/ContentContext.jsp">
					<c:param name="typePage" value="famille" />
					<c:param name="complement" value="tags=${tagKeyWord}"/>
					<c:param name="id" value="${layoutPageName}"/>
				</c:import>
			</c:otherwise>
		</c:choose>
		
		<%@ include file="/Widgets/Common/ESpot/LayoutPreviewSetup.jspf"%>
	
		<div id="page">
			<%out.flush();%>
			<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
			<%out.flush();%>
			
			<div id="content" role="main">
				<c:set var="pageDesign" value="${getPageDesignResponse.resultList[0]}" scope="request"/>
				<c:set var="PAGE_DESIGN_DETAILS_JSON_VAR" value="pageDesign" scope="request"/>
				<wcpgl:jsInclude/>
				<c:set var="rootWidget" value="${pageDesign.widget}"/>
				<wcpgl:widgetImport uniqueID="${rootWidget.widgetDefinitionId}" debug=false/>
			</div>
			
			<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.CatalogEntryList/javascript/SearchBasedNavigationDisplay.js?${versionNumber}"></script>
			<script>
				SearchBasedNavigationDisplayJS.init('${widgetSuffix}','${ProductListingViewURL}');
				SearchBasedNavigationDisplayJS.refreshSliderRanges();
			</script>

			<%out.flush();%>
			<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
			<%out.flush();%>
		</div>

		
	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> 
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="${pageGroup}" />
	</c:import>
	</body>
<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutID}"/>		
<!-- END CategoryNavigationDisplay.jsp -->
</html>
