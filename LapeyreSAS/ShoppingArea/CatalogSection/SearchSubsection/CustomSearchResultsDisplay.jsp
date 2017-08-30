<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN CustomSearchResultsDisplay.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>

<%@ taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl" %>

<c:set var="pageGroup" value="Search" scope="request"/>
<%@ include file="/Widgets-lapeyre/Common/CustomSearchSetup.jspf" %>
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<c:set var="titleName" value="" />
		<c:if test="${CustomSearchTermFieldName eq 'collectionSearch'}" >
			<fmt:message var="titleName" bundle="${storeText}" key="listeMeublesCollectionPagetitlePrefix" />
			<c:set var="titleName" value="${titleName} ${productName}" />
		</c:if>
		<c:if test="${CustomSearchTermFieldName eq 'promotionSearch'}" >
			<fmt:message var="titleName" bundle="${storeText}" key="LAP016_PROMOTIONS_PAGE_TILE" />
		</c:if>
		<c:if test="${CustomSearchTermFieldName eq 'saleSearch'}" >
			<fmt:message var="titleName" bundle="${storeText}" key="LAP_SALE_PAGE_TILE" />
		</c:if>
	
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${titleName}</title>
		<meta name="description" content=""/>
		<meta name="keywords" content=""/>
		<meta name="pageName" content="${titleName}"/>
		
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/category/categoryNavigationDisplay.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/product/productDisplay.css" type="text/css" media="screen">
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


<c:set var="searchTabSubText1" value="${totalCount}" scope="request"/>
<c:set var="searchTabSubText2" value="${totalContentCount}" scope="request"/>

<%-- If we have only one search result, then redirect shopper to the page directly instead of showing the results --%>
<c:choose>
	<c:when test="${totalContentCount == 0 && totalCount == 1 && !searchMissed && empty WCParam.categoryId && empty WCParam.manufacturer}">
		<c:forEach var="breadcrumb" items="${globalbreadcrumbs.breadCrumbTrailEntryView}">
			<c:if test="${breadcrumb.type_ == 'FACET_ENTRY_CATEGORY'}">
				<c:if test="${empty searchTopCategoryId}">
					<c:set var="searchTopCategoryId" value="${breadcrumb.value}" scope="request"/>
				</c:if>
				<c:set var="searchParentCategoryId" value="${breadcrumb.value}" scope="request"/>
			</c:if>
		</c:forEach>

		<%-- Global Results will contain only one element --%>
		<c:forEach var="catEntry" items="${globalresults}" varStatus="status">
			<c:set var="catEntryIdentifier" value="${catEntry.uniqueID}"/>
		</c:forEach>

		<c:choose>
			<%-- Use the context parameters if they are available; usually in a subcategory --%>
			<c:when test="${!empty searchParentCategoryId && !empty searchTopCategoryId}">
				<%-- both parent and top category are present.. display full product URL --%>
				<c:set var="parent_category_rn" value="${searchTopCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
				<c:set var="categoryId" value="${searchParentCategoryId}" />
			</c:when>
			<c:when test="${!empty searchParentCategoryId}">
				<%-- parent category is not empty..use product URL with parent category --%>
				<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
				<c:set var="categoryId" value="${WCParam.categoryId}" />
			</c:when>
			<%-- In a top category; use top category parameters --%>
			<c:when test="${WCParam.top == 'Y'}">
				<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
				<c:set var="categoryId" value="${WCParam.categoryId}" />
			</c:when>
			<%-- Store front main page; usually eSpots, parents unknown --%>
			<c:otherwise>
				<c:set var="parent_category_rn" value="${searchParentCategoryId}" />
				<c:set var="top_category" value="${searchTopCategoryId}" />
			</c:otherwise>
		</c:choose>

		<wcf:url var="catEntryDisplayUrl" patternName="ProductURL" value="Product2">
			<wcf:param name="catalogId" value="${catalogId}"/>
			<wcf:param name="storeId" value="${storeId}"/>
			<wcf:param name="productId" value="${catEntryIdentifier}"/>
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
			<wcf:param name="categoryId" value="${WCParam.categoryId}" />
			<wcf:param name="parent_category_rn" value="${searchParentCategoryId}" />
			<wcf:param name="top_category" value="${searchTopCategoryId}" />
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
		<%-- 
			Set redirect == true.. Since we have only one result, we will display the product page directly instead of search results page.. 
			do not do <c:redirect here.. SearchTermHistroy cookie will be updated at client browser and then redirect happens
		--%>
		<c:set var="redirect" value="true"/>
		<%-- Nothing to update in cookie.. redirect from here itself --%>
	</c:when>
	<c:otherwise>
		<%-- If we are here, then we have either 0 results or more than 1 result --%>
		<c:set var="pageView" value="${WCParam.pageView}" scope="request"/>
		<c:if test="${empty pageView}" >
			<c:set var="pageView" value="${env_defaultPageView}" scope="request"/>
		</c:if>


		<%-- Get SEO data and canonical URL --%>
		<wcf:url var="CategoryDisplayURL" patternName="CanonicalCategoryURL" value="Category3">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${storeId}" />
			<wcf:param name="catalogId" value="${catalogId}" />
			<wcf:param name="categoryId" value="${WCParam.categoryId}" />	
			<wcf:param name="urlLangId" value="${urlLangId}" />							
		</wcf:url>

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
			<wcf:param name="searchForContent" value="false"/>
		</wcf:url>

		<wcf:url var="CategoryNavigationResultsViewContentURL" value="CategoryNavigationResultsContentView" type="Ajax">
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
		
		<%-- Use only HTTPS URL for canonical --%>
		<%-- <link rel="canonical" href="<c:out value="${fn:replace(CategoryDisplayURL, 'http://', 'https://')}"/>" /> --%>
	</c:otherwise>
</c:choose>


	<c:if test="${!redirected}">
		<%-- No redirection happend at server side.. But we may still redirect from client side, if redirect = true --%>
		<c:if test="${empty redirect}">
			<c:choose>
				<c:when test="${CustomSearchTermFieldName == 'saleSearch'}">
					<c:set var="searchTermToDetermineLayout" value="promotionSearch"/>
				</c:when>
				<c:otherwise>
					<c:set var="searchTermToDetermineLayout" value="${CustomSearchTermFieldName}"/>
				</c:otherwise>
			</c:choose>
			
			<%-- We are not redirecting at client side using script method.. So get page design to display the page.. --%>
			<wcf:getData type="com.ibm.commerce.pagelayout.facade.datatypes.PageDesignType" var="pageDesign" scope="request" expressionBuilder="getPageDesign">
				<wcf:contextData name="storeId" data="${storeId}" />
				<wcf:contextData name="catalogId" data="${catalogId}" />
				<wcf:param name="deviceClass" value="${deviceClass}"/>
				<wcf:param name="pageGroup" value="${requestScope.pageGroup}"/>
				<c:choose>
					<c:when test="${empty searchTermToDetermineLayout}">
						<wcf:param name="ObjectIdentifier" value="-1"/>
					</c:when>
					<c:otherwise>
						<wcf:param name="ObjectIdentifier" value="${searchTermToDetermineLayout}"/>
					</c:otherwise>
				</c:choose>
			</wcf:getData>
			<c:set var="PAGE_DESIGN_DETAILS_VAR" value="pageDesign" scope="request"/>
		</c:if>
				<c:if test="${empty redirect}">
					<wcpgl:jsInclude varPageDesignDetails="pageDesign"/>
				</c:if>
				<c:if test="${!empty redirect}" >
					<script type="text/javascript">
						dojo.addOnLoad(function() { 
									document.location.href = "${catEntryDisplayUrl}";										
							});
					</script>
				</c:if>
			</head>
				
			<c:if test="${empty redirect}">
				<body class="univers">
					<%-- This file includes the progressBar mark-up and success/error message display markup --%>
					<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
					<c:set var="layoutPageIdentifier" value="${CustomSearchTermFieldName}"/>
					<c:set var="layoutPageName" value="${CustomSearchTermFieldName}"/>
					
					<c:import url="${env_jspStoreDir}/include/ContentContext.jsp">
						<c:param name="typePage" value="${contentTypePage}" />
					</c:import>
					
					
					
					<%@ include file="/Widgets/Common/ESpot/LayoutPreviewSetup.jspf"%>
						
					<div id="page">
						<%out.flush();%>
						<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
						<%out.flush();%>
					
					
					
						<div id="content" role="main">
							<c:set var="rootWidget" value="${pageDesign.widget}"/>
							<wcpgl:widgetImport uniqueID="${rootWidget.widgetDefinitionIdentifier.uniqueID}" debug=true/>
						</div>
					
						<%out.flush();%>
						<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
						<%out.flush();%>
					</div>		
				<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> 
				
				<c:import url="../../../TagManager/TagManager.jsp" >
					<c:param name="pageGroup" value="${pageGroup}" />
				</c:import>
				</body>
			
				<!--Start: Contents after page load-->
				<c:if test="${env_fetchMarketingDetailsOnLoad}">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}Widgets/PageLoadContent/PageLoadContent.jsp">
						<c:param name="doubleContentAreaESpot" value="true"/>
					</c:import>
				<%out.flush();%>
				</c:if>
				<!--End: Contents after page load-->
				<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutID}"/>				
				<!-- END CustomSearchResultsDisplay.jsp -->
			</c:if>

			<flow:ifEnabled feature="Analytics">
				<script type="text/javascript">
					dojo.addOnLoad(function() {
						analyticsJS.registerSearchResultPageView("catalogSearchResultDisplay_Controller","catalog_search_result_information", true, "Advanced_Search_Form_div");
					});
				</script>
			</flow:ifEnabled>

		</html>

</c:if>
