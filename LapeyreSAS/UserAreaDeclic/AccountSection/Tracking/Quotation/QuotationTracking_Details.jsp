<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../../Common/nocache.jspf" %>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp${googleAuth}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/MapStoreLocator.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/SearchShopsJS.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/ShopsController.js?${versionNumber}"></script>

<wcf:url var="Logon_LogoutURLNearestShop" value="LogonForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="myAcctMain" value="1" />
</wcf:url>

<wcf:url var="FavoritesShopsDisplayViewURL" value="FavoritesShopsDisplayView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
</wcf:url>

<wcf:url var="FavoritesShopsOperationCmdURL" value="FavoritesShopsOperationCmd" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
</wcf:url>

<wcf:url var="ShoppingCartURL" value="AjaxCheckoutDisplayView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />						
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<c:set var="suiviCom" value="true" scope="request"/>
<c:set var="someBuyable" value="0" scope="request"/>
<c:set var="cookieOrderIdKey" value="WC_CartOrderId_${storeId}"/>
<c:set var="storeParams" value="{storeId: '${fn:escapeXml(storeId)}',catalogId: '${fn:escapeXml(catalogId)}',langId: '${fn:escapeXml(langId)}'}"/>
<c:set var="catEntryParams" value="{}"/>
<c:set var="shoppingListNames" value="{}" />

<script>
	var buyableItems = new Array();

	dojo.addOnLoad(function(){
		refreshControllerFavoritesShops.url = '<c:out value="${FavoritesShopsDisplayViewURL}" />';
		SearchShopsJS.favoritesOperationURL = '<c:out value="${FavoritesShopsOperationCmdURL}" />';
		categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
		
		shoppingListJS = new ShoppingListJS(${storeParams}, ${catEntryParams}, ${shoppingListNames},"shoppingListJS");
		shoppingListJS.refreshLinkState();
		dojo.topic.subscribe("ShoppingList_Changed", function(serviceResponse) {
			eval("shoppingListJS.updateShoppingListAndAddItem(serviceResponse);");
		});
	})
</script>


<div class="col6 bcol12 centered padding-bottom-2">
	<%-- use a c:out to escape unwanted XML tags --%>
	<h2 class="titleBlock padding-bottom-1"><fmt:message bundle="${storeText}" key="quotationPageTitle" /><span><c:out value="${documentNumber}" /></span></h2>
	<c:if test="${devisFound}">
		<div class="statuscontainer">
			<div class="statuscontainerContent">
				<span class="row">
					<span class="dispo orderStatus${expirationStyle}">
						<fmt:message bundle="${storeText}" key="quotationEndDateLabel" /><fmt:formatDate type="date" value="${expirationDate}" pattern="dd MMMM yyyy" />
					</span>
				</span>
			</div>
		</div>
	</c:if>
</div>

<c:set var="totalAmt" value="0" scope="request"/>
<c:set var="detailMissingSKUS" value="" scope="request"/>

<div class="row" id="detailDevisPage">
	<div class="col12 quotation tracking">
		<c:choose>
			<c:when test="${devisFound}">
				<%@ include file="QuotationTracking_Details_UI.jsp" %>
			</c:when>
			<c:otherwise>
				<div class="errorOrderNotFoundContainer clearAll">
					<fmt:message bundle="${storeText}" key="quotationNotFoundErrorMessage"></fmt:message>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>


<jsp:useBean id="nowDate" class="java.util.Date"/>
<fmt:formatDate var ="expirationDate" value="${expirationDate}" pattern="yyyy-MM-dd HH:mm:ss" type="date" />
<fmt:formatDate var ="now" value="${nowDate}" pattern="yyyy-MM-dd HH:mm:ss" type="date" />
<c:if test="${devisFound}">
	<div class="row marginTop10">
		<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" scope="request" var="order" expressionBuilder="findCurrentShoppingCart">
			<wcf:param name="accessProfile" value="IBM_Details" />
		</wcf:getData>
		<div class="col5 push1">
			<a class="button full_width mobile-hidden" href="javascript:window.print();"><fmt:message bundle="${storeText}" key="printButtonLabel" /></a>
		</div>
		<div class="bcol12 col5">
			<a class="button full_width green ${someBuyable > 0 && now<=expirationDate ?'':'disabled'}" <c:choose><c:when test="${someBuyable > 0  && now<=expirationDate }">href="javascript:shoppingListJS.replaceOrAddToCart(${fn:length(order.orderItem)},'${ShoppingCartURL}');"</c:when><c:otherwise>aria-disabled="true"</c:otherwise></c:choose>><fmt:message bundle="${storeText}" key="quotationAddToCartButtonLabel"/></a>
		</div>
	</div>
	<div class="suiviComShopArea whiteBackground">
		<p class="titleBlock"><fmt:message bundle="${storeText}" key="orderStoreSectionTitle" /></p>
		<div class="shopContainer">	
			<%@ include file="../../../../StoreLocatorArea/ShopDisplay.jsp" %>
		</div>
		<%@include file="/LapeyreSAS/StoreLocatorArea/FavoriteShopsPopup.jspf" %>
	</div>
	
	<c:set var="numberMissing" value="${!devisFound? 0 : fn:length(detailDevis) - someBuyable}"/>
	<%@ include file="../../../../UserArea/ServiceSection/InterestItemListSubsection/AddToCartPopup.jspf" %>
</c:if>
