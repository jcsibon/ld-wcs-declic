<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>

<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN WishListDisplay.jsp -->
<%-- used for wishlists list --%>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
	xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}"
	xml:lang="${shortLocale}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="WISHLISTS_TITLE" /></title>
<META NAME="robots" CONTENT="noindex,nofollow" />

<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css" />
<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />

<%@ include file="../../../Common/CommonJSToInclude.jspf"%>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>

<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingList.js?${versionNumber}"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListServicesDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListControllers.js?${versionNumber}"/>"></script>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Configurator/ConfiguratorServicesDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CompareProduct.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js?${versionNumber}"/>"></script>

<wcf:url var="WishListResultDisplayViewURL" value="WishListResultDisplayView">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<wcf:url var="WishListDisplayURL" value="WishListDisplayView">
	<wcf:param name="listId" value="." />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<c:set var="wishlistRootUrl" value="${fn:escapeXml(WishListDisplayURL)}" scope="request" />
<c:set value="${param.pageNumber}" var="pageNum" />
<c:set value="${param.projectPageNum}" var="projectPageNum" />

<script type="text/javascript">
		dojo.addOnLoad(function() { 
			categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
			ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
			
			<fmt:message bundle="${storeText}" key="WISHLIST_MISSINGNAME" var="WISHLIST_MISSINGNAME"/>
			<fmt:message bundle="${storeText}" key="WISHLIST_MISSINGEMAIL" var="WISHLIST_MISSINGEMAIL"/>
			<fmt:message bundle="${storeText}" key="WISHLIST_INVALIDEMAILFORMAT" var="WISHLIST_INVALIDEMAILFORMAT"/>
			<fmt:message bundle="${storeText}" key="REQUIRED_FIELD_ENTER" var="REQUIRED_FIELD_ENTER"/>
			<fmt:message bundle="${storeText}" key="WISHLIST_EMPTY" var="WISHLIST_EMPTY"/>
			<fmt:message bundle="${storeText}" key="SHOPCART_ADDED" var="SHOPCART_ADDED"/>
			<fmt:message bundle="${storeText}" key="SHOPCART_REMOVEITEM" var="SHOPCART_REMOVEITEM" />
			<fmt:message bundle="${storeText}" key="ERROR_MESSAGE_TYPE" var="ERROR_MESSAGE_TYPE"/>
			<fmt:message bundle="${storeText}" key="WISHLIST_ADDED" var="WISHLIST_ADDED"/>
			<fmt:message bundle="${storeText}" key="QUANTITY_INPUT_ERROR" var="QUANTITY_INPUT_ERROR"/>
			<%-- Missing message --%>
			<fmt:message bundle="${storeText}" key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER"/>
			<fmt:message bundle="${storeText}" key="GENERICERR_MAINTEXT" var="ERROR_RETRIEVE_PRICE">                                     
				<fmt:param><fmt:message bundle="${storeText}" key="GENERICERR_CONTACT_US" /></fmt:param>
			</fmt:message>
			<fmt:message bundle="${storeText}" key="ERR_RESOLVING_SKU" var="ERR_RESOLVING_SKU"/>
			MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
			MessageHelper.setMessage("WISHLIST_MISSINGNAME", <wcf:json object="${WISHLIST_MISSINGNAME}"/>);
			MessageHelper.setMessage("WISHLIST_MISSINGEMAIL", <wcf:json object="${WISHLIST_MISSINGEMAIL}"/>);
			MessageHelper.setMessage("WISHLIST_INVALIDEMAILFORMAT", <wcf:json object="${WISHLIST_INVALIDEMAILFORMAT}"/>);
			MessageHelper.setMessage("REQUIRED_FIELD_ENTER", <wcf:json object="${REQUIRED_FIELD_ENTER}"/>);
			MessageHelper.setMessage("WISHLIST_EMPTY", <wcf:json object="${WISHLIST_EMPTY}"/>);
			MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
			MessageHelper.setMessage("SHOPCART_REMOVEITEM", <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
			MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
			MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
			MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
			MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
			MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		});
		dojo.addOnLoad(AccountWishListDisplay.processBookmarkURL); 
		dojo.addOnLoad(function() { AccountWishListDisplay.initHistory("WishlistDisplay_Widget", '${WishListResultDisplayViewURL}') });
	</script>
	<c:set var="isWishlistPage" value="true"/>
	<%@ include file="../../../Common/JSTLEnvironmentSetupExtForSocialNetworks.jsp"%>

</head>

<body> 
	<%@ include file="../../../Common/MultipleWishListSetup.jspf"%>
	<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
	<%@ include file="../../../Widgets/ShoppingList/CreateShoppingListPopup.jspf" %>
	<%@ include file="../../../Widgets/ShoppingList/EditShoppingListPopup.jspf" %>
	<%@ include file="../../../Widgets/ShoppingList/DeleteShoppingListPopup.jspf" %>
	<%@ include file="../../../Widgets/ShoppingList/ShoppingListCreateSuccessPopup.jspf" %>

	<!-- Page Start -->
	<div id="page">

		<c:set var="myAccountPage" value="true" scope="request" />
		<c:set var="wishListPage" value="true" />
		<c:set var="hasBreadCrumbTrail" value="false" scope="request" />

		<!-- Import Header Widget -->

		<%out.flush();%>
		<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>

		<!-- Header Nav End -->
		<div id="contentWrapper">
			<div id="content" role="main">
				<div class="rowContainer">
					<!-- Main Content Start -->
			
			
					<%@ include
						file="../../../Snippets/MultipleWishList/GetDefaultWishList.jspf"%>
					<c:set var="pageSize" value="10" />
			
					<wcf:getData
						type="com.ibm.commerce.giftcenter.facade.datatypes.GiftListType[]"
						var="soaWishLists" expressionBuilder="findWishListsForUser">
						<wcf:contextData name="storeId" data="${WCParam.storeId}" />
						<wcf:param name="accessProfile" value="IBM_Store_Summary" />
					</wcf:getData>
			
			
					<wcf:url var="soaWishListBodyURL" value="WishListResultDisplayView"
						type="Ajax">
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="langId" value="${langId}" />
					</wcf:url>
			
					<c:set var="bHasWishList" value="true" />
					<c:set var="url" value="WishListDisplayView" />
					<c:set var="errorViewName" value="WishListDisplayView" />
			
					<div class="row">
						<div data-slot-id="1" class="col12 slot1 mobile-hidden">
							<%out.flush();%>
							<fmt:message var="lastBreadCrumbItem"
								key="myWishliststBreadcrumbLabel" bundle="${widgetText}" />
							<c:import
								url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
								<c:param name="pageName" value="CompteClient" />
								<c:param name="breadCrumbMonCompte" value="true" />
								<c:param name="lastBreadCrumbItemCompteClient"
									value="${lastBreadCrumbItem}" />
							</c:import>
							<%out.flush();%>
						</div>
					</div>
					<c:set var="navMonCompteCurrentPage" value="myWishlist" />
					<div class="row" id="myWishlistPage">
						<div id="navCompteClient" class="col3 mobile-hidden">
							<%@ include file="../../../UserAreaDeclic/AccountSection/navClient.jspf" %>
						</div>
						<div class="col9 bcol12 mainContentWrapper">									
<flow:ifEnabled feature="Configurateur">
							<%@ include file="./Configurateurs.jspf"%>
</flow:ifEnabled>
							<div class="row">
								<c:set var="catEntryParams" value="{}" />
								<c:set var="storeParams"
									value="{storeId: '${fn:escapeXml(storeId)}',catalogId: '${fn:escapeXml(catalogId)}',langId: '${fn:escapeXml(langId)}'}" />
					
								<c:choose>
									<c:when test="${fn:length(soaWishLists)<=0}">
										<script>
										dojo.addOnLoad(function() {
											var isAuthenticated = true;
											shoppingListJS = new ShoppingListJS({storeId: '10101',catalogId: '10151',langId: '-2'}, {}, {'YHYJKUY': 1},"shoppingListJS");
											shoppingListJS.refreshLinkState();
											dojo.topic.subscribe("ShoppingList_Changed", function(serviceResponse) {
												eval("shoppingListJS.updateShoppingListAndAddItem(serviceResponse);");
												});
											});
										</script>
										<%@ include file="WishListFirst.jspf"%>
									</c:when>
									<c:otherwise>
										<h2 class="titleBlock">
											<fmt:message key="myWishListsPageTitle" bundle="${storeText}" />
										</h2>
										<div class="addListButton">
											<a href="javascript:shoppingListJS.showPopup('create');"
												class="button green marge"> <fmt:message
													key="addWishlistButtonLabel" bundle="${storeText}" /> </a>
										</div>
										<div class="listesAchatHeader mobile-hidden">
											<div class="date">
												<fmt:message bundle="${storeText}" key="DateColumnLabel" />
											</div>
											<div class="nom">
												<fmt:message bundle="${storeText}" key="wishlistName" />
											</div>
											<div class="prix">
												<c:choose>
													<c:when test="${extendedUserContext.isPro}">
														<fmt:message bundle="${storeText}" key="htPriceColumnLabel" />
													</c:when>
													<c:otherwise>
														<fmt:message bundle="${storeText}" key="ttcPriceColumnLabel" />
													</c:otherwise>
												</c:choose>
											</div>
											<div class="share">
												<fmt:message bundle="${storeText}" key="ShareColumnLabel" />
											</div>
											<div class="supprime">
											</div>
										</div>
										<div class="listesAchat">
											<%-- start 0, default 0 --%>
											<input type="hidden" id="wishListId" /> <input type="hidden"
												id="wishListName" />
					
											<c:set var="shoppingListNames" value="" />
											<c:forEach var="shoppingList" items="${soaWishLists}">
												<c:if test="${!empty shoppingListNames}">
													<c:set var="shoppingListNames" value="${shoppingListNames}," />
												</c:if>
												<c:set var="shoppingListName"
													value="${fn:replace(shoppingList.description.name,'\\\\','\\\\\\\\')}" />
												<c:set var="shoppingListNames"
													value="${shoppingListNames}'${fn:escapeXml(shoppingListName)}': 1" />
											</c:forEach>
											<c:set var="shoppingListNames"
												value="${fn:toUpperCase(shoppingListNames)}" />
					
											<script type="text/javascript">
												dojo.addOnLoad(function() {
													var isAuthenticated = ${userType ne 'G'};
													shoppingListJS = new ShoppingListJS(${storeParams}, ${catEntryParams}, {${shoppingListNames}},"shoppingListJS");
													shoppingListJS.refreshLinkState();
													dojo.topic.subscribe("ShoppingList_Changed", function(serviceResponse) {
														eval("shoppingListJS.updateShoppingListAndAddItem(serviceResponse);");
													});
												});
											</script>
											<c:forEach var="shoppingList" items="${soaWishLists}"
												begin="${pageNum*pageSize}" end="${pageNum*pageSize+pageSize-1}">
												<c:set var="shoppingListId"
													value="${shoppingList.giftListIdentifier.uniqueID}" />
												<div class="row">
					
													<%-- price evaluation --%>
													<wcf:getData
														type="com.ibm.commerce.giftcenter.facade.datatypes.GiftListType"
														var="selectedSoaWishList"
														expressionBuilder="findGiftListItemsByExternalIdentifier"
														varShowVerb="ShowVerbWishList" maxItems="100"
														recordSetStartNumber="0">
														<wcf:param name="accessProfile" value="IBM_Store_GiftListItems" />
														<wcf:contextData name="storeId" data="${WCParam.storeId}" />
														<wcf:param name="externalIdentifier" value="${shoppingListId}" />
													</wcf:getData>
					
													<%--Obligé de faire cette vérification car si on appelle l'url rest sans paramètre "id" => ko --%>
													<c:if
														test="${selectedSoaWishList.item ne null and fn:length(selectedSoaWishList.item) > 0}">
														<wcf:rest var="catalogNavigationView"
															url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byIds">
															<c:forEach var="soaWishListItem"
																items="${selectedSoaWishList.item}" varStatus="status">
																<wcf:param name="id"
																	value="${soaWishListItem.catalogEntryIdentifier.uniqueID}" />
															</c:forEach>
															<wcf:param name="langId" value="${langId}" />
															<wcf:param name="currency" value="${env_currencyCode}" />
															<wcf:param name="responseFormat" value="json" />
															<wcf:param name="catalogId" value="${WCParam.catalogId}" />
															<%-- ECOCEA --%>
															<wcf:param name="profileName"
																value="ECO_findProductByIds_Details_Without_Attachment" />
															<wcf:param name="isProBTP"
																value="${extendedUserContext.isPro}" />
														</wcf:rest>
													</c:if>
					
													<c:set var="totalAmt" value="0" />
													<c:forEach var="catEntry"
														items="${catalogNavigationView.catalogEntryView}">
														<c:set var="catalogIdEntry" value="${catEntry}" />
														<%@ include
															file="../../../Snippets/Search/CatalogEntrySetPriceDisplay.jspf"%>
					
														<c:set var="totalAmt" value="${totalAmt + priceString}" />
														<c:choose>
															<c:when test="${extendedUserContext.isPro}">
																<fmt:formatNumber var="formattedPriceString"
																	value="${totalAmt}" type="currency"
																	currencySymbol="${env_CurrencySymbolToFormat}<sup class='vat-free'>HT</sup>"
																	maxFractionDigits="${env_currencyDecimal}" />
															</c:when>
															<c:otherwise>
																<fmt:formatNumber var="formattedPriceString"
																	value="${totalAmt}" type="currency"
																	currencySymbol="<sup class='currency'>${env_CurrencySymbolToFormat}</sup>"
																	maxFractionDigits="${env_currencyDecimal}" />
															</c:otherwise>
														</c:choose>
					
														<%-- end price eval --%>
													</c:forEach>
					
					
													<c:choose>
														<c:when test="${device=='desktop'}">
															<div class="date">
																<p>
																	<span class="desktop-hidden"><fmt:message
																			key="wishlistCreationLabel" bundle="${storeText}" />
																	</span>
																	<c:set var="dateonly"
																		value="${fn:substring(shoppingList.lastUpdate, 0, 10)}" />
																	<fmt:parseDate value="${dateonly}" var="parsedEmpDate"
																		pattern="yyyy-MM-dd" />
																	<fmt:formatDate value="${parsedEmpDate}"
																		pattern="dd/MM/yyyy" var="ladate" />
																	${ladate}
																</p>
															</div>
															<div class="nom">
																<%-- escape wishlist name for unwanted XML tags --%>
																<c:set var="escapeListName"><c:out value="${shoppingList.description.name}" /></c:set>
																<a
																	href="${WishListResultDisplayViewURL}&id=${shoppingListId}"
																	class="mobile-truncate"><ecocea:crop
																		value="${escapeListName}" length="50" />
																</a>
															</div>
															<div class="prix">
																<p>${formattedPriceString}</p>
															</div>
														</c:when>
														<c:otherwise>
															<div class="nom">
																<%-- escape wishlist name for unwanted XML tags --%>
																<c:set var="escapeListName"><c:out value="${shoppingList.description.name}" /></c:set>
																<a
																	href="${WishListResultDisplayViewURL}&id=${shoppingListId}"
																	class="mobile-truncate"><ecocea:crop
																		value="${escapeListName}" length="50" />
																</a>
															</div>
															<div class="date">
																<p>
																	<span class="desktop-hidden inline-block"><fmt:message
																			key="wishlistCreationLabel" bundle="${storeText}" />
																	</span>
																	<c:set var="dateonly"
																		value="${fn:substring(shoppingList.lastUpdate, 0, 10)}" />
																	<fmt:parseDate value="${dateonly}" var="parsedEmpDate"
																		pattern="yyyy-MM-dd" />
																	<fmt:formatDate value="${parsedEmpDate}" pattern="dd/MM/yy"
																		var="ladate" />
																	${ladate}
																</p>
															</div>
					
															<div class="nbProducts">
																<wcf:getData
																	type="com.ibm.commerce.giftcenter.facade.datatypes.GiftListType"
																	var="selectedSoaWishList"
																	expressionBuilder="findGiftListItemsByExternalIdentifier"
																	varShowVerb="ShowVerbWishList" maxItems="100"
																	recordSetStartNumber="0">
																	<wcf:param name="accessProfile"
																		value="IBM_Store_GiftListItems" />
																	<wcf:contextData name="storeId" data="${WCParam.storeId}" />
																	<wcf:param name="externalIdentifier"
																		value="${shoppingListId}" />
																</wcf:getData>
					
																<p>
																	<c:choose>
																		<c:when test="${fn:length(selectedSoaWishList.item) < 2}">
																			<span class="nbProducts desktop-hidden">${fn:length(selectedSoaWishList.item)}
																				<fmt:message key="wishlistProductLabel"
																					bundle="${storeText}" /> </span>
																		</c:when>
																		<c:otherwise>
																			<span class="nbProducts desktop-hidden">${fn:length(selectedSoaWishList.item)}
																				<fmt:message key="wishlistProductsLabel"
																					bundle="${storeText}" /> </span>
																		</c:otherwise>
																	</c:choose>
																</p>
															</div>
															<div class="prix">${formattedPriceString}</div>
														</c:otherwise>
													</c:choose>
													<div class="share">
														<div class="socialNetworks">
															<c:set var="titleToShare" value="Wishlist " scope="page" />
															<c:set var="metaDescriptionToShare" value="${metaDescription}" scope="page" />
					
															<wcf:getData
																type="com.ibm.commerce.giftcenter.facade.datatypes.GiftListType"
																var="myWishList"
																expressionBuilder="findGiftListByExternalIdentifiers">
																<wcf:param name="accessProfile" value="IBM_Store_Summary" />
																<wcf:contextData name="storeId" data="${WCParam.storeId}" />
																<wcf:param name="ExternalIdentifier"
																	value="${selectedSoaWishList.giftListIdentifier.giftListExternalIdentifier.externalIdentifier}" />
															</wcf:getData>
															<c:set var="guestAccessKey" value="${myWishList.accessSpecifier.guestAccessKey}" />
															<c:set var="wishListIdentifier" value="${selectedSoaWishList.giftListIdentifier.uniqueID}" />
															<wcf:url var="sharedWishListViewURL" value="SharedWishListView" scope="request">
																<wcf:param name="langId" value="${langId}" />
																<wcf:param name="storeId" value="${storeId}" />
																<wcf:param name="catalogId" value="${catalogId}" />
																<wcf:param name="wishListEMail" value="true" />
																<wcf:param name="externalId" value="${wishListIdentifier}" />
																<wcf:param name="guestAccessKey" value="${guestAccessKey}" />
															</wcf:url>
					
															<c:set var="isNoMail" value="true" scope="request" />
					
															<%@ include file="../../../Common/SocialNetworksSetup.jspf" %>
															<ecocea:widgetPath var="socialNetworksWidgetPath" identifier="SocialNetworks" storeId="${storeId}" />
															<%out.flush(); %>
															<c:import url="${socialNetworksWidgetPath}">
																<c:param name="classToApply" value="wishlistSocialNetwork ficheSocialNetworks shareSocialNetwork" />
																<c:param name="rootPath" value="${jspStoreImgDir}" />
																<c:param name="widgetText" value="${widgetText}" />
															</c:import>
															<%out.flush(); %>
														</div>
													</div>
					
													<div class="supprime">
														<span>
															<a href="#"
																onclick="javascript: dojo.byId('wishListId').value='${shoppingListId}';dojo.byId('wishListName').value='${shoppingList.description.name}';dojo.byId('deleteListName').innerHTML=dojo.byId('wishListName').value; shoppingListJS.showPopup('delete');">
																<img
																src="${jspStoreImgDir}images/delete.png" alt="Supprimer"
																onmouseover="this.src='${jspStoreImgDir}images/deleteRed.png';"
																onmouseout="this.src='${jspStoreImgDir}images/delete.png';">
															</a>
														</span>
													</div>
												</div>
					
					
												<c:remove var="catalogNavigationView" />
					
											</c:forEach>
					
					
					
											<%--Pagination --%>
											<c:set var="numberOfWishListsPage"
												value="${fn:length(soaWishLists)/pageSize+1}" />
											<fmt:parseNumber var="numberOfWishListsPage" integerOnly="true"
												type="number" value="${numberOfWishListsPage}" />
					
											<c:if test="${numberOfWishListsPage > 1}">
												<div class="paging_controls">
					
													<%-- Bouton "Plus récents" --%>
													<a role="button"
														class="button <c:if test="${pageNum <= 0 || empty pageNum}">hidden</c:if>"
														id="WC_SearchBasedNavigationResults_pagination_link_left_categoryResults"
														href='${wishlistRootUrl}&pageNumber=${pageNum-1}'
														title="Show previous page"> <span class=""><fmt:message
																key="paginationPreviousButtonLabel" bundle="${storeText}" />
													</span> </a>
					
													<%-- Pagination --%>
													<div class="pages pageControlMenu" role="combobox">
														<div class="header">
															<div class="controlBar">
																<div class="pageControlWrapper">
																	<div id="pageControlMenu_6_-1011_3074457345618259714"
																		class="pageControlMenu"
																		data-dojo-attach-point="pageControlMenu"
																		data-parent="header">
																		<div class="pageControl number">
																			<c:forEach var="pageIdx" begin="1"
																				end="${numberOfWishListsPage}">
																				<c:choose>
																					<c:when test="${pageIdx==pageNum+1}">
																						<a class="active selected" href="#" role="button"
																							aria-disabled="true"
																							aria-label="Move to page ${pageIdx}"
																							tabindex="${pageIdx-1}">${pageIdx}</a>
																					</c:when>
																					<c:otherwise>
																						<a class="hoverover" role="button"
																							href="${wishlistRootUrl}&pageNumber=${pageIdx-1}"
																							aria-label="Move to page ${pageIdx}"
																							title="Move to page ${pageIdx}">${pageIdx}</a>
																					</c:otherwise>
																				</c:choose>
																			</c:forEach>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
					
													<%-- Bouton "Plus anciennes" --%>
													<a role="button"
														class="button <c:if test="${pageNum+1 >= numberOfWishListsPage}">hidden</c:if>"
														id="WC_SearchBasedNavigationResults_pagination_link_right_categoryResults"
														href="${wishlistRootUrl}&pageNumber=${pageNum+1}"
														title="Show next page"> <span class=""><fmt:message
																key="paginationNextButtonLabel" bundle="${storeText}" />
													</span> </a>
												</div>
											</c:if>
										</div>
									</c:otherwise>
					
								</c:choose>
							</div>
						</div>
					</div>				
				</div>
			</div>
		</div>
		<!-- Main Content End -->
		<!-- Footer Start -->
		<div class="footer_wrapper_position">
			<%out.flush();%>
			<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
			<%out.flush();%>
		</div>
		<!-- Footer End -->

	</div>
	</div>
	<flow:ifEnabled feature="Analytics">
		<cm:pageview />
	</flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%>

	<c:import url="../../../TagManager/TagManager.jsp">
		<c:param name="pageGroup" value="wishlist" />
		<c:param name="pageName" value="myWishList" />
	</c:import>
</body>
</html>
<!-- END WishListDisplay.jsp -->
