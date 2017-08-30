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
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN ProductDisplay.jsp : used in view Page-->

<%-- 
  *****
  * This JSP diplay the product details given a productId or partNumber. This page imports the following components
  * Header Component - Display header links, department widget, mini shop-cart widget and Search widget
  * Product Image Component - Display the product image
  * Product Description Component - Displays product short description, attributes, inventory component, price component etc.,
  * Merchandising Association Component
  * E-spots for Recently Viewed and Recommendations
  * Product TAB component
  * Footer Component - Display footer links
  *****
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>
<%@include file="/Widgets-lapeyre/Common/ProductConstants.jspf" %>
<%@include file="/Widgets-lapeyre/Common/ShoppingList/ShoppingList_Data.jspf" %>

<c:if test="${!empty param.top_category}">
	<c:set var="top_category" value="${param.top_category}"/>
</c:if>
<c:if test="${!empty WCParam.top_category}">
	<c:set var="top_category" value="${WCParam.top_category}"/>
</c:if>
<c:if test="${!empty param.parent_category_rn}">
	<c:set var="parent_category_rn" value="${param.parent_category_rn}"/>
</c:if>
<c:if test="${!empty WCParam.parent_category_rn}">
	<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}"/>
</c:if>

<c:set var="productWasRedirected" value="false" />
<c:if test="${!empty WCParam.redirect}" >
	<c:set var="productRedirected" value="true" scope="request"/>
	<c:set var="productRedirectedType" value="${WCParam.redirect}" scope="request"/>
	<fmt:parseNumber var="productRedirectedType" value="${productRedirectedType}" integerOnly="true" />
</c:if>

<wcf:url var="ProductDisplayURL" patternName="ProductURL" value="Product1" scope="request">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="productId" value="${productId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<c:if test="${!empty productId}">
	<%-- Since this is a product page, get all the details about this product and save it in internal cache, so that other components can use it... --%>
	<c:catch var="searchServerException">
		<wcf:rest var="catalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${productId}" >	
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="currency" value="${env_currencyCode}"/>
			<wcf:param name="responseFormat" value="json"/>		
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="isProBTP" value="${extendedUserContext.isPro}" />
			<c:forEach var="contractId" items="${env_activeContractIds}">
				<wcf:param name="contractId" value="${contractId}"/>
			</c:forEach>
		</wcf:rest>
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationViewBOD" 
			expressionBuilder="getCatalogEntryViewSummaryByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
			<wcf:param name="accessProfile" value="IBM_Store_Summary_SEO"/>
			<wcf:param name="searchProfile" value=""/>
			<wcf:param name="UniqueID" value="${productId}"/>
			<wcf:contextData name="storeId" data="${storeId}" />
			<wcf:contextData name="catalogId" data="${catalogId}" />
		</wcf:getData>
	</c:catch>
	<%-- Cache it in our internal hash map --%>
	<c:set var="key1" value="${productId}+getCatalogEntryViewAllByID"/>
	<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${catalogNavigationView.catalogEntryView[0]}"/>
	
	<wcf:rest var="getPageResponse" url="store/{storeId}/page">
		<wcf:var name="storeId" value="${storeId}" encode="true"/>
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="q" value="byCatalogEntryIds"/>
		<wcf:param name="catalogEntryId" value="${productId}"/>
	</wcf:rest>
	<c:set var="page" value="${getPageResponse.resultList[0]}"/>
	
	<c:if test="${!empty catalogNavigationView && !empty catalogNavigationView.catalogEntryView[0]}">
		<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
	</c:if>
	
	<c:set var="parentCatEntryId" value="${catalogNavigationView.catalogEntryView[0].parentCatalogEntryID}" scope="request"/>
	<%-- If parentCateEntryId is not empty, then this is an item and not a product --%>
	<c:if test="${not empty parentCatEntryId}">
		<%-- Since this is an item, get all the details about the parent product and save it in internal cache, so that other components can use it... --%>
		<c:catch var="searchServerException">
			<wcf:rest var="parentCatalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${parentCatEntryId}" >	
					<wcf:param name="langId" value="${WCParam.langId}"/>
					<wcf:param name="currency" value="${env_currencyCode}"/>
					<wcf:param name="responseFormat" value="json"/>		
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:forEach var="contractId" items="${env_activeContractIds}">
						<wcf:param name="contractId" value="${contractId}"/>
					</c:forEach>	
					<wcf:param name="isProBTP" value="${extendedUserContext.isPro}" />
	
			</wcf:rest>
		</c:catch>
		<wcf:url var="ProductDisplayURL" patternName="ProductURL" value="Product1" scope="request">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${storeId}" />
			<wcf:param name="catalogId" value="${catalogId}" />
			<wcf:param name="productId" value="${parentCatEntryId}" />
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
		
		<%-- Check if the parent is a product and not package or bundle --%>
		<c:if test="${parentCatalogNavigationView.catalogEntryView[0].catalogEntryTypeCode eq 'ProductBean'}">
			<%-- Keep all the defining attributes and its value in WCParam so that it will be selected by default --%>
			<c:forEach var="attribute" items="${catalogNavigationView.catalogEntryView[0].attributes}">
				<c:if test="${attribute.usage eq 'Defining'}">
					<c:set target="${WCParam}" property="${attribute.name}" value="${attribute.values[0].value}"/>
				</c:if>
			</c:forEach>
			
			<%-- So that the parent page can be displayed instead of item page and pre select the values correspoding to the item --%>
			<c:set var="catalogNavigationView" value="${parentCatalogNavigationView}" />
			<%--Save the itemID selected before changing productID. This var is used to preselect the item--%>
			<c:set var="itemSelectedId" value="${productId}" scope="request"/>
			<c:set var="itemId" value="${productId}" scope="request"/>
			<c:set var="productId" value="${parentCatEntryId}" scope="request"/>
			<c:set var="catalogEntryDetails" value="${catalogNavigationView.catalogEntryView[0]}"/>
			
			<%-- Cache parent catalog entry in our internal hash map --%>
			<c:set var="key1" value="${parentCatEntryId}+getCatalogEntryViewAllByID"/>
			<wcf:set target = "${cachedCatalogEntryDetailsMap}" key="${key1}" value="${parentCatalogNavigationView.catalogEntryView[0]}"/>
		</c:if>
	</c:if>
	
</c:if>

<c:set var="displaySKUContextData" value="false" scope="request" />
<c:set var="singleSKUProductWithoutDefiningAttribute" value="false" scope="request"/>
<c:set var="isProductPage" value="true" />
<c:set var="pageTitle" value="${catalogNavigationViewBOD.catalogEntryView[0].title}" scope="request"/>
<c:set var="metaDescription" value="${page.metaDescription}" />
<c:set var="metaKeyword" value="${page.metaKeyword}" />
<c:set var="fullImageAltDescription" value="${page.fullImageAltDescription}" scope="request" />
<c:set var="categoryId" value="${catalogNavigationView.catalogEntryView[0].parentCatalogGroupID}"/>
<c:set var="partNumber" value="${catalogNavigationView.catalogEntryView[0].partNumber}" scope="request"/>
<c:set var="productName" value="${catalogNavigationView.catalogEntryView[0].name}" scope="request"/>
<c:set var="productManufacturer" value="${catalogNavigationView.catalogEntryView[0].manufacturer}" scope="request"/>
<c:if test="${ empty partNumber}">
	<c:set var="partNumber" value="${page.partNumber}" scope="request"/>
</c:if>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>

<c:set var="type" value="${fn:toLowerCase(catalogEntryDetails.catalogEntryTypeCode)}" />
<c:set var="type" value="${fn:replace(type,'bean','')}" />
<c:choose>
	<c:when test="${type == 'item'}">
		<c:set var="pageGroup" value="Item" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="pageGroup" value="Product" scope="request"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<%-- Use the context parameters if they are available; usually in a subcategory --%>
	<c:when test="${!empty parent_category_rn && !empty top_category && parent_category_rn ne top_category}">
		<%-- both parent and top category are present.. display full product URL --%>
		<c:set var="parent_category_rn" value="${parent_category_rn}" />
		<c:set var="top_category" value="${top_category}" />
		<c:set var="categoryId" value="${categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
	</c:when>
	<c:when test="${!empty parent_category_rn}">
		<%-- parent category is not empty..use product URL with parent category --%>
		<c:set var="parent_category_rn" value="${parent_category_rn}" />
		<c:set var="top_category" value="${top_category}" />
		<c:set var="categoryId" value="${categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentCategory"/>
	</c:when>
	<%-- In a top category; use top category parameters --%>
	<c:when test="${!empty categoryId}">
		<c:set var="parent_category_rn" value="${parent_category_rn}" />
		<c:set var="top_category" value="${top_category}" />
		<c:set var="categoryId" value="${categoryId}" />
		<c:set var="patternName" value="ProductURLWithCategory"/>
	</c:when>
	<%-- Store front main page; usually eSpots, parents unknown --%>
	<c:otherwise>
		<c:set var="parent_category_rn" value="${parent_category_rn}" />
		<c:set var="top_category" value="${top_category}" />
		<%-- Just display productURL without any category info --%>
		<c:set var="patternName" value="ProductURL"/>
	</c:otherwise>
</c:choose>

<c:if test="${empty parentCatEntryId}">
	<c:set var="parentCatEntryId" value="${productId}"/>
</c:if>

<%-- Special case when part of both master and sales catalog, categoryId returned is an array --%>
<c:set var="numParentCategories" value="0" />
<c:forEach var="aParentCategory" items="${categoryId}">
	<c:set var="numParentCategories" value="${numParentCategories+1}" />
</c:forEach>
<c:if test="${numParentCategories>1}">
	<c:set var="categoryId" value="${fn:split(categoryId[0], '_')[1]}"/>
</c:if>

<wcf:url var="ProductDisplayURL" patternName="${patternName}" value="Product1" scope="request">
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="productId" value="${parentCatEntryId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="categoryId" value="${categoryId}" />
	<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
	<wcf:param name="top_category" value="${top_category}" />
</wcf:url>

<c:set var="productWithoutDefiningAttribute" value="true"/>

<c:if test="${!empty catalogEntryDetails.attributes}">
	<c:forEach var="attribute" items="${catalogEntryDetails.attributes}">
		<c:if test="${attribute.usage eq 'Defining'}">
			<c:set var="productWithoutDefiningAttribute" value="false"/>
		</c:if>
	</c:forEach>
</c:if>

<c:set var="redirectSKUUrl" value="" scope="request"/>

<c:if test="${productWithoutDefiningAttribute && catalogEntryDetails.numberOfSKUs eq 1 && !empty catalogEntryDetails.singleSKUCatalogEntryID}">
	<c:set var="singleSKUProductWithoutDefiningAttribute" value="true" scope="request"/>
	<wcf:url var="SkuURL" patternName="ProductURL" value="Product2">
		<wcf:param name="catalogId" value="${catalogId}"/>
		<wcf:param name="storeId" value="${storeId}"/>
		<wcf:param name="productId" value="${catalogEntryDetails.singleSKUCatalogEntryID}"/>
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="urlLangId" value="${urlLangId}" />
	</wcf:url>
	
	<c:if test="${ProductDisplayURL != SkuURL && displaySKUContextData == 'true' && empty itemId}">
		<c:set var="redirectSKUUrl" value="${SkuURL}" scope="request"/>
	</c:if>
</c:if>

<wcf:rest var="getPageDesignResponse" url="store/{storeId}/page_design">
	<wcf:var name="storeId" value="${storeId}" encode="true"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="q" value="byObjectIdentifier"/>
	<wcf:param name="objectIdentifier" value="${productId}"/>
	<wcf:param name="deviceClass" value="${deviceClass}"/>
	<wcf:param name="pageGroup" value="${pageGroup}"/>
</wcf:rest>

<c:catch var="searchServerException">
	<wcf:rest var="subCategory" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${categoryId}" >	
		<wcf:param name="langId" value="${WCParam.langId}"/>
		<wcf:param name="currency" value="${env_currencyCode}"/>
		<wcf:param name="responseFormat" value="json"/>		
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<c:forEach var="contractId" items="${env_activeContractIds}">
			<wcf:param name="contractId" value="${contractId}"/>
		</c:forEach>
	</wcf:rest>
</c:catch>
<c:set var="emsNameLocalPrefix" value="${fn:replace(subCategory.catalogGroupView[0].identifier,' ','')}" scope="request"/>
<%-- Uncomment to use CatalogEntry's partnumber as the emsNameLocalPrefix
<c:set var="emsNameLocalPrefix" value="${fn:replace(partNumber,' ','')}" scope="request"/>
--%>
<c:set var="emsNameLocalPrefix" value="${fn:replace(emsNameLocalPrefix,'\\\\','')}"/>

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
		<meta name="pageIdentifier" content="<c:out value="${partNumber}"/>"/>
		<meta name="pageId" content="<c:out value="${productId}"/>"/>
		<meta name="pageGroup" content="<c:out value="${pageGroup}"/>"/>
        <%-- Use only HTTPS URL for canonical --%>        
        <link rel="canonical" href="<c:out value="${fn:replace(ProductDisplayURL, 'http://', 'https://')}"/>" />
		
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/product/productDisplay.css?${versionNumber}" type="text/css" media="screen">
		
		<!-- Include script files -->
		<%@include file="../../../Common/CommonJSToInclude_redesign.jspf" %>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/Timer.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/lightSlider/jquery.lightSlider.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/tooltipster/jquery.tooltipster.min.js?${versionNumber}"></script>
		<c:if test="${!isOnMobileDevice }">
			<script type="text/javascript" src="${jsAssetsDir}javascript/sticky-kit/jquery.sticky-kit.min.js?${versionNumber}"></script>
		</c:if>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.ItemAvailabilityInPhysicalStoresWidget/javascript/ItemAvailabilityInPhysicalStoresWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Stock/StockAvailability.js?${versionNumber}"></script>
		<script type="text/javascript">
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";
			</c:if>
		</script>
		
		<%@ include file="../../../Common/SocialNetworksSetup.jspf" %>
		<%@ include file="../../../Common/JSTLEnvironmentSetupExtForSocialNetworks.jsp" %>
		<wcpgl:jsInclude varPageDesignDetails="pageDesign"/>
	</head>
		
	<body>
	<div>
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
<div id="IntelligentOfferMainPartNumber" style="display:none;"><c:out value="${partNumber}" /></div>
<div id="IntelligentOfferCategoryId" style="display:none;"><c:out value="${categoryId}" /></div>
<div id="displaySKUContextData" style="display:none;"><c:out value="${displaySKUContextData}" /></div>
<c:set var="catalogEntryID" value="${catalogEntryDetails.uniqueID}" />
<c:set var="entitledItems" value="${catalogEntryDetails.sKUs}"/>
<c:set var="numberOfSKUs" value="${catalogEntryDetails.numberOfSKUs}"/>
<c:set var="attributes" value="${catalogEntryDetails.attributes}"/>
<c:set var="productAttachments" value="${catalogEntryDetails.attachments}"/>

<c:set var="tagKeyWord" value="${fn:replace(catalogNavigationViewBOD.catalogEntryView[0].keyword,'&','%26')}"/>
<c:set var="tagKeyWord" value="${fn:replace(tagKeyWord,'=','%3D')}"/>


<c:import url="${env_jspStoreDir}/include/ContentContext.jsp">
	<c:param name="typePage" value="produit" />
	<c:param name="id" value="${partNumber}"/>
	<c:param name="complement" value='tags=${tagKeyWord}'/>
</c:import>

<div id="ProductDisplayURL" style="display:none;"><c:out value="${ProductDisplayURL}" /></div>
<div id="entitledItem_<c:out value='${catalogEntryID}'/>_AngleImages" style="display:none;">
	[
		<c:if test="${fn:length(productAttachments) > 0}">
			{
				"ItemAngleThumbnail" : {
				<c:set var="imageCount" value="0" />
				<c:forEach var="productAttachment" items="${productAttachments}" varStatus="status1">
					<c:if test="${productAttachment.usage == 'ANGLEIMAGES_THUMBNAIL'}">
						<c:if test='${imageCount gt 0}'>,</c:if>
						<c:set var="imageCount" value="${imageCount+1}" />
						<astpush:assetPushUrl var="resolvedPath" scope="page" urlRelative="${productAttachment.attachmentAssetPath}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="thumbnail"/>
						"image_${imageCount}" : "<c:out value='${resolvedPath}' />;${fn:replace(productAttachment.name,'"','')}"
					</c:if>
				</c:forEach>
				},				
				"ItemAngleFullImage" : {
				<c:set var="imageCount" value="0" />
				<c:forEach var="productAttachment" items="${productAttachments}" varStatus="status2">
					
					<c:if test="${productAttachment.usage == 'ANGLEIMAGES_FULLIMAGE'}">
						<c:if test='${imageCount gt 0}'>,</c:if>
						<c:set var="imageCount" value="${imageCount+1}" />
						<astpush:assetPushUrl var="imgSourceFull" scope="page" urlRelative="${productAttachment.attachmentAssetPath}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="full"/>
						<astpush:assetPushUrl var="imgSourceZoom" scope="page" urlRelative="${productAttachment.attachmentAssetPath}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="zoom"/>
						"image_${imageCount}" : "<c:out value='${imgSourceFull}' />;<c:out value='${imgSourceZoom}' />"
					</c:if>
				</c:forEach>
				}
			}
		</c:if>
	]
</div>
<div id="entitledItem_<c:out value='${catalogEntryID}'/>" style="display:none;">
		[
		<c:if test="${type == 'product'}">

				<c:forEach var='entitledItem' items='${entitledItems}' varStatus='outerStatus'>
					<c:if test="${entitledItem.buyable eq 'true' || buyablePurchasable eq 'true'}">
						<c:set var="sku" value="${entitledItem}"/>
						<c:set var="skuID" value="${entitledItem.uniqueID}"/>
						<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
							<wcf:param name="catalogId" value="${catalogId}"/>
							<wcf:param name="storeId" value="${storeId}"/>
							<wcf:param name="productId" value="${skuID}"/>
							<wcf:param name="langId" value="${langId}"/>
							<wcf:param name="urlLangId" value="${urlLangId}" />
							<wcf:param name="categoryId" value="${categoryId}" />
							<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
							<wcf:param name="top_category" value="${top_category}" />
						</wcf:url>
						<c:if test="${sku.isDefault eq '1'}">
								<c:set var="defaultProductSkuID" value="${sku.uniqueID}" scope="request"/>
								<c:set var="defaultSKUFullAttributes" value="${sku.attributes}" scope="request"/>
								<c:set var="defaultSKUNavigationView" value="${sku}" scope="request"/>
							</c:if>
						{
						"catentry_id" : "<c:out value='${skuID}' />",
						"seo_url" : "<c:out value='${catEntryDisplayUrl}' />",
						"displaySKUContextData" : "<c:out value='${displaySKUContextData}' />",
						"buyable" : "<c:out value='${entitledItem.buyable}' />",
						"Attributes" :	{
							<c:set var="hasAttributes" value="false"/>											
							<c:forEach var="definingAttrValue2" items="${sku.attributes}" varStatus="innerStatus">
								<c:if test="${definingAttrValue2.usage == 'Defining'}">
									<c:if test='${hasAttributes eq "true"}'>,</c:if>
									"<c:out value="${fn:replace(definingAttrValue2.identifier, search01, replaceStr01)}_${fn:replace(fn:replace(definingAttrValue2.values[0].identifier, search01, replaceStr01), search, replaceStr)}" />":"<c:out value='${innerStatus.count}' />"
									<c:set var="hasAttributes" value="true"/>
								</c:if>
							</c:forEach>
							},
							
							<%-- SwatchCode start --%>
																
							<c:set var="catalogEntryViewItemDetails" value="${catalogEntryDetails.sKUs}"/>
			
							<%--Mantis 1420: initialisation des variables en d�but de boucle --%>
							<c:set var="itemFullImagePath" value=""/>
							<c:set var="thumbnailImage" value=""/>
							<c:set var="itemZoomImagePath" value=""/>
							
							<c:if test="${!empty entitledItem.thumbnail}">
								<astpush:assetPushUrl var="thumbnailImage" scope="page" urlRelative="${entitledItem.thumbnail}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="thumbnail"/>
							</c:if>
							<c:if test="${!empty entitledItem.fullImage}">
								<astpush:assetPushUrl var="itemFullImagePath" scope="page" urlRelative="${entitledItem.fullImage}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="full"/>
								<astpush:assetPushUrl var="itemZoomImagePath" scope="page" urlRelative="${entitledItem.fullImage}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="zoom"/>
							</c:if>

							<c:if test="${empty itemFullImagePath}">
									<c:set var="keyDefaultImageMaps" value="${catalogEntryDetails.type}_main_full"/>
									<astpush:assetPushUrl var="itemFullImagePath" scope="page" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="full" defaultUrl="true"/>
							</c:if>
							

							"ItemImage" : "<c:out value='${itemFullImagePath}' />",
							"ItemImage467" : "<c:out value='${itemFullImagePath}' />",
							"ItemZoomImage" : "<c:out value='${itemZoomImagePath}' />",
							"ItemThumbnailImage" : "<c:out value='${thumbnailImage}' />"
							<%-- SwatchCode end --%>
						}<c:if test='${!outerStatus.last}'>,</c:if>
					</c:if>
				</c:forEach>
			
		</c:if>
		<c:if test="${type == 'package' || type == 'bundle' || type == 'item' || type == 'dynamickit'}">
			{
			"catentry_id" : "<c:out value='${catalogEntryID}'/>",
			"Attributes" :	{ }
			}
		</c:if>
		]
</div>

	
		<!-- Begin Page -->						
		<c:set var="layoutPageIdentifier" value="${productId}"/>
		<c:set var="layoutPageName" value="${partNumber}"/>
		<%@ include file="../../../Common/LayoutPreviewSetup.jspf"%>
				
		<div id="page">
			<div id="grayOut"></div>
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
				<%out.flush();%>
				<div class="separator"></div>
			<c:choose>
				<c:when test="${empty catalogEntryDetails}">
					<wcf:url var="GenericErrorURL" value="ProductDisplayErrorView">
						<wcf:param name="catalogId" value="${catalogId}"/>
						<wcf:param name="storeId" value="${storeId}"/>
						<wcf:param name="langId" value="${langId}"/>
						<wcf:param name="excMsgKey" value="_ERR_CATENTRY_NOT_EXISTING_IN_STORE"/>
					</wcf:url>
					<script type="text/javascript">
						dojo.addOnLoad(function() { 
							document.location.href = "<c:out value="${GenericErrorURL}" escapeXml="false"/>";
						});
					</script>
				</c:when>
				<c:otherwise>
					<c:set var="pageDesign" value="${getPageDesignResponse.resultList[0]}" scope="request"/>
					<c:set var="PAGE_DESIGN_DETAILS_JSON_VAR" value="pageDesign" scope="request"/>
					<wcpgl:jsInclude/>
					<c:set var="rootWidget" value="${pageDesign.widget}"/>
					<wcpgl:widgetImport uniqueID="${rootWidget.widgetDefinitionId}" debug=false/>
				</c:otherwise>
			</c:choose>			
			
			<c:if test="${isOnMobileDevice}">
					
				<script>
					shoppingListJS<c:out value="${param.parentPage}"/> = new ShoppingListJS(${storeParams}, ${catEntryParams}, {${shoppingListNames}}, "shoppingListJS<c:out value="${param.parentPage}"/>");
					
					dojo.topic.subscribe("DefiningAttributes_Resolved", function(catEntryId, productId) {
						eval("shoppingListJS<c:out value="${param.parentPage}"/>.setItemId(catEntryId, productId);");
					});
					
					dojo.topic.subscribe("QuickInfo_attributesChanged", function(catEntryAttributes) {
						eval("shoppingListJS<c:out value="${param.parentPage}"/>.setCatEntryAttributes(catEntryAttributes);");
					});
					
					dojo.topic.subscribe("ShoppingListItem_Added", function() {
						eval("shoppingListJS<c:out value="${param.parentPage}"/>.deleteItemFromCart();");
						eval("shoppingListJS<c:out value="${param.parentPage}"/>.setItemId(-1, null);");
					});
					
					dojo.topic.subscribe("Quantity_Changed", function(catEntryQuantityObject) {
						eval("shoppingListJS<c:out value="${param.parentPage}"/>.setCatEntryQuantity(catEntryQuantityObject);");
					});
					
					dojo.topic.subscribe("ShoppingList_Changed", function(serviceResponse) {
						eval("shoppingListJS<c:out value="${param.parentPage}"/>.updateShoppingListAndAddItem(serviceResponse);");
						if(dojo.byId('existingShoppingList')) {
							dojo.style('existingShoppingList', 'display', 'block');
						} 
					});
					
					dojo.topic.subscribe("ShopplinList_AttributesDefining_Changed", function(catentryId, productId) {
						eval("shoppingListJS<c:out value="${param.parentPage}"/>.setItemBufferId(catentryId, productId);");
					});
					
					dojo.topic.subscribe("/MiniShopCartDisplayRefresh", function(data) {
						var mobileCart = dojo.byId("minishopcart_button_total_mobile");
						if(!!mobileCart && !!data && !!data.total) {
							mobileCart.innerHTML = data.total;
						}
					});
					
				</script>
				
			
				<c:if test="${empty catalogEntryDetails || empty catalogEntryDetails.type}">
					<wcf:rest var="catalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${catEntryIdentifier}" >
						<wcf:param name="langId" value="${langId}" />
						<wcf:param name="currency" value="${env_currencyCode}" />
						<wcf:param name="responseFormat" value="json" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="isProBTP" value="${extendedUserContext.isPro}" />
					</wcf:rest>
					<c:set var = "catalogEntryDetails" value = "${catalogNavigationView.catalogEntryView[0]}"/>
					
				</c:if>
					<c:set var="catEntryType" value="${catalogEntryDetails.type}" />
				
			</c:if>

			<%out.flush();%>
			<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp"/>
			<%out.flush();%>
			
		</div>

		<flow:ifEnabled feature="Analytics">
			<%@include file="../../../AnalyticsFacetSearch.jspf" %>
			<cm:product catalogNavigationViewJSON="${catalogNavigationView}" extraparms="null, ${analyticsFacet}"/>
			<cm:pageview pageType="wcs-productdetail"/>
		</flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> 
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="${pageGroup}" />
	</c:import>
	</div>
	</body>

<wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutID}"/>


<!-- END ProductDisplay.jsp -->		
</html>