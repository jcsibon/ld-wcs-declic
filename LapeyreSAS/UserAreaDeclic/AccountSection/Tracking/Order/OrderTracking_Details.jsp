<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../../Common/nocache.jspf" %>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/MapStoreLocator.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/SearchShopsJS.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/ShopsController.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/ContentArea/Contrib.js?${versionNumber}"></script>

<wcf:url var="Logon_LogoutURLNearestShop" value="LogonForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="myAcctMain" value="1" />
</wcf:url>

<c:set var="orderId" value="${WCParam.orderId}" />
<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="orderInCart" expressionBuilder="findByOrderId" scope="request">
	<wcf:param name="accessProfile" value="IBM_Details" />
	<wcf:param name="orderId" value="${orderId}" />
</wcf:getData>
<%@include file="../../../../ShoppingArea/ShopcartSection/OrderItemDetail_Data.jspf" %>
<c:set var="suiviCom" value="true" scope="request"/>
<fmt:message var="puhtColumnLabel" key="puhtColumnLabel" bundle="${widgetText}" />
<fmt:message var="puttcColumnLabel" key="puttcColumnLabel" bundle="${widgetText}" />
<fmt:message var="quantityColumnLabel" key="quantityColumnLabel" bundle="${widgetText}" />
<fmt:message var="tvaRateColumnLabel" key="tvaRateColumnLabel" bundle="${widgetText}" />
<fmt:message var="prixTtcColumnLabel" key="prixTtcColumnLabel" bundle="${widgetText}" />
<fmt:message var="prixHtColumnLabel" key="prixHtColumnLabel" bundle="${widgetText}" />
<fmt:message var="panierTotalAmountLabel1" key="panierTotalAmountLabel1" bundle="${widgetText}" />
<fmt:message var="panierTotalAmountLabel2" key="panierTotalAmountLabel2" bundle="${widgetText}" />

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

<wcf:url var="orderTrackingListURL" value="OrderTrackingListView">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />			
</wcf:url>

<script>
	dojo.addOnLoad(function(){
		refreshControllerFavoritesShops.url = '<c:out value="${FavoritesShopsDisplayViewURL}" />';
		SearchShopsJS.favoritesOperationURL = '<c:out value="${FavoritesShopsOperationCmdURL}" />';
	})
</script>

<div id="suiviCommandeHeader">
	<div class="backButton mobile-hidden">
		<a href="${orderTrackingListURL}" class="button back">
			<fmt:message bundle="${storeText}" key="orderdetailReturnButtonLabel" />
		</a>
	</div>
	<div class="orderTitleArea">
		<h2 class="titleBlock">
		    <%-- Escape unwanted XML tags for display --%>
			<c:set var="orderNumberEscape"><c:out value="${!empty WCParam.cdnb ? WCParam.cdnb:orderId}" /></c:set>
			<fmt:message bundle="${storeText}" key="orderBlockTitle">
				<fmt:param value="${orderNumberEscape}" />	
			</fmt:message>
		</h2>
		<div class="statuscontainer">
			<div class="statuscontainerContent">
				<c:set var="orderStatus" value="${shopOrderStatus}"/>
				<c:if test="${empty shopOrderStatus && !empty webOrderStatus}">
					<c:set var="orderStatus" value="${webOrderStatus}"/>
				</c:if>
				<span class="row" title="${orderStatus.description}">
					<span class="dispo orderStatus${orderStatus.color}">${orderStatus.label}<c:if test="${!empty orderStatus.labelDate}"> ${ orderStatus.labelDate}</c:if></span>
				</span>
			</div>
		</div>
	</div>
	<div class="paginationControls mobile-hidden">
		<c:if test="${!empty paginatePrevious}">
		    <wcf:url var="OrderDetailPreviousURL" value="OrderTrackingDetailsView">
		        <wcf:param name="storeId" value="${storeId}" />
		        <wcf:param name="langId" value="${langId}" />
		        <wcf:param name="catalogId" value="${catalogId}" />
		        <wcf:param name="orderId" value="${paginatePrevious.webCommandNumber}" />
		        <wcf:param name="cdnb" value="${paginatePrevious.commandNumber}" />
		        <wcf:param name="storeEntity" value="${paginatePrevious.shopEntity.identifier}" />
		    </wcf:url>
		    <a href="${OrderDetailPreviousURL}" class="paginationActionsLinks">&lt;</a>
		</c:if>
		<c:if test="${!empty paginateCurrent.dateCreation}">
			<fmt:formatDate var="dateCreationFormatted" value='${paginateCurrent.dateCreation}' type='date' pattern='dd MMMM yyyy' /> 
			<span class="suividate">
				<fmt:message bundle="${storeText}" key="detailWebOrderPaginationCurrentLabel" >
					<fmt:param value="${dateCreationFormatted}" />
				</fmt:message>	
			</span>
		</c:if>
		<c:if test="${!empty paginateNext}">
			<wcf:url var="OrderDetailNextURL" value="OrderTrackingDetailsView">
		        <wcf:param name="storeId" value="${storeId}" />
		        <wcf:param name="langId" value="${langId}" />
		        <wcf:param name="catalogId" value="${catalogId}" />
		        <wcf:param name="orderId" value="${paginateNext.webCommandNumber}" />
		        <wcf:param name="cdnb" value="${paginateNext.commandNumber}" />
		        <wcf:param name="storeEntity" value="${paginateNext.shopEntity.identifier}" />
		    </wcf:url>
		    <a href="${OrderDetailNextURL}" class="paginationActionsLinks">&gt;</a>
		</c:if>
	</div>
</div>
<c:if test="${!empty webOrderStatus.step}">
	<%@include file="OrderTracking_Breadcrumb.jsp" %>
</c:if>
<div class="row tunnel suiviCom order tracking" id="suiviCommandeDetail">
	<div class="shippingCost">
		<p>
			<fmt:message bundle="${storeText}" key="webOrderNumberLabel" /><br /><strong>${orderId}</strong>
		</p>
		<p>
			<fmt:message bundle="${storeText}" key="ShippingModeLabel" /><br />
			<strong>
				<c:choose>
					<c:when test="${shippingMode.delivery}">
						<fmt:message bundle="${storeText}" key="ShippingAtHomeLabel"/>
					</c:when>
					<c:when test="${shippingMode.drive}">
						<fmt:message bundle="${storeText}" key="ShippingAtStoreDriveLabel"/>
					</c:when>
					<c:otherwise>
						<fmt:message bundle="${storeText}" key="ShippingAtStoreLabel"/>
					</c:otherwise>
				</c:choose>
			</strong>
		</p>
		<div class="clearFloat"></div>
	</div>
	
	<%-- ENTETE COMMANDE --%>
	<div class="orderHeaderWrapper">
		<div class="orderHeader">
			<div class="row">
				<div class="quantityTotal bold">
					<c:choose>
						<c:when test="${orderQuantity <= 1}">
							<span>${orderQuantity} <fmt:message bundle="${storeText}" key="productLabel"/></span>
						</c:when>
						<c:otherwise>
							<span>${orderQuantity} <fmt:message bundle="${storeText}" key="productsLabel"/></span>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="quantity">
					${quantityColumnLabel}
				</div>
				<%-- <div class="vat">
					<c:if test="${!extendedUserContext.isPro}">${tvaRateColumnLabel}</c:if>
				</div> --%>
				<div class="unitPrice">
					<c:choose>
						<c:when test="${extendedUserContext.isPro}">
							${puhtColumnLabel}
						</c:when>
						<c:otherwise>
							${puttcColumnLabel}
						</c:otherwise>
					</c:choose>
				</div>
				<div class="totalPrice white-background">
					<c:choose>
						<c:when test="${extendedUserContext.isPro}">
							${prixHtColumnLabel}
						</c:when>
						<c:otherwise>
							${prixTtcColumnLabel}
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	
	<%-- LIGNES COMMANDE --%>
	<div class="orderBodyWrapper">
		<div class="orderBody">
			<c:choose>
				<c:when test="${isOnMobileDevice}">
					<jsp:include page="../../../../ShoppingArea/ShopcartSection/mobile/OrderItemDetail.jsp" />
				</c:when>
				<c:otherwise>
					<jsp:include page="../../../../ShoppingArea/ShopcartSection/OrderItemDetail.jsp"/>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<%-- RECAP COMMANDE --%>
	<%--  X_ORDER DETAILS  --%>
	<ecocea:xOrderSummary orderDetails="${xOrderDetails}" pro="${extendedUserContext.isPro}" var="xOrderSummary" pageType="SUIVI" scope="2"/>
	<div class="orderSummaryWrapper">
		<div class="paymentMethod">
			<img alt="${xOrderSummary.paymentMethod}" src="${jspStoreImgDir}/images/card_${fn:toLowerCase(xOrderSummary.paymentMethod)}.png">
		</div>
		<%@ include file="../../../../ShoppingArea/ShopcartSection/Common/OrderSummary/OrderSummaryView_UI.jspf" %>
	</div>
	
</div>
<c:if test="${!empty noticeMontageNumber && noticeMontageNumber gt 0 }">
	<c:if test="${noticeMontageNumber gt 1 }">
		<c:set var="plural" value="Plural"/>
	</c:if>
	<div id="noticeMontageSection" class="collapsible" aria-expanded="true">
		<div id="noticeMontageSectionLabelContener" class="col12">
			<span class="divider" aria-hidden="true"> </span>
			<span id="noticeMontageSectionLabel" class="toggle"><fmt:message key="ficheProduitStdNavigationNoticeMontageLabel${plural }" bundle="${widgetText}" /></span>
		</div>
		<div class="content">		
			<c:forEach var="orderItemsDetails" items="${orderItemsDetailsList }">
				<c:forEach var="noticeMontageItem" items="${orderItemsDetails.userManual}">
					<div class="col12 acol12 noticeMontageContainer">
						<astpush:assetPushUrl var="noticeMontageURL" scope="request" urlRelative="${noticeMontageItem.value.attachmentAssetPath}" type="" source="" device="" format=""/>
						<div class="column_67 bcolumn_100 left">
							<a class="hover_underline fileName pdfIcon" href="${noticeMontageURL }" target="_blank" title="${noticeMontageItem.value.shortdesc}">${noticeMontageItem.value.name}</a>
						</div>
						<div class="gutter mobile-hidden"></div>
						<div class="column_30 bcolumn_100 left emailShare"><a id="${noticeMontageItem.key }" class="button mailShareLink right" href="${noticeMontageURL}" target="_blank"><fmt:message key="voirNoticeMontage" bundle="${widgetText}" /></a></div>
					</div>
				</c:forEach>
			</c:forEach>
		</div>
		
	</div>
</c:if>
<div class="suiviComShopArea whiteBackground">
	<p class="titleBlock"><fmt:message bundle="${storeText}" key="orderStoreSectionTitle" /></p>
	<div class="shopContainer">	
		<%@ include file="../../../../StoreLocatorArea/ShopDisplay.jsp" %>
	</div>
	<%@include file="/LapeyreSAS/StoreLocatorArea/FavoriteShopsPopup.jspf" %>
</div>

<c:if test="${displayCancelLink}">
	<wcf:url var="contactSuiviComURL" value="contact">
		<wcf:param name="formName" value="contactSuiviCommande" />
	</wcf:url>
	<div class="cancelOrderContainer">
		<a href="${contactSuiviComURL}" class="delete_account button button--minor column_30 bcolumn_90"><fmt:message bundle="${storeText}" key="cancelOrderLinkLabel" /></a>
	</div>
</c:if>