<!-- BEGIN TunnelRecapPanier.jspf -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>


<fmt:message var="recapPanierProduitLabel" key="recapPanierProduitTitle" bundle="${widgetText}" />
<c:if test="${orderQuantity gt 1}">
	<fmt:message var="recapPanierProduitLabel" key="recapPanierProduitsTitle" bundle="${widgetText}" />
</c:if>
<h2 class="titleBlock"><span><fmt:message key="recapPanierBlockTitle" bundle="${widgetText}" /></span><br><span class="subtitle">${orderQuantity} ${recapPanierProduitLabel}</span></h2>
<div class="orderBody condensed">
	<c:forEach var="itemDetails" items="${orderItemsDetailsList}" varStatus="status">
		<div class="row">
		
			<%-- VISUEL PRODUIT --%>
			<div class="productImage">
				<a href="${itemDetails['productURL']}" title="${itemDetails['productName']}">
					<img  alt="${itemDetails['productLabel']}" src="${itemDetails['productImage']}">										
				</a>
			</div>
			
			<%-- RECAP PRODUIT --%>
			<div class="productSummary" id="divInfoOrderItem_${itemDetails["orderItemId"]}">
				<p class="productName">
					<a class="hover_underline" href="${itemDetails['productURL']}">
						${itemDetails['productLabel']}
					</a>
				</p>
				<p class="skuReference">
		 			<fmt:message bundle="${storeText}" key="ficheProduitSkuLabel"/> :
					<a href="${itemDetails['productURL']}">
						${itemDetails['productSKU']}
					</a>
	 			</p>
				<p class="productQuantity">
					<fmt:message key="quantityColumnLabel" bundle="${widgetText}" /> : ${itemDetails['productQty']}
				</p>
				<c:if test="${extendedUserContext.isPro}"> <c:set var="vatFree"><sup class="vatFree"><fmt:message key="HTLabel" bundle="${widgetText}"/></sup></c:set></c:if>
				
				<p class="price">
					${itemDetails['productPrice']} <sup class="currency">${env_CurrencySymbolToFormat}${vatFree}</sup> 
				</p>
					<!-- DISCOUNT -->
					<c:forEach var="discountsIterator" items="${itemDetails['discountReferences']}">										
						<c:set var="discounts" value="${discountsIterator.value}" />						
						<c:set var="adjustmentDetail" value="${xOrderDetails.orderItems[itemDetails['orderItemId']].adjustments[discounts.code]}" />	
						
						<c:choose>
							<c:when test="${extendedUserContext.isPro}">
								<c:set var="adjustValue" value="${adjustmentDetail.AMOUNT_HT}" />
							</c:when>
							<c:otherwise>
								<c:set var="adjustValue" value="${adjustmentDetail.AMOUNT_TTC}" />
							</c:otherwise>
						</c:choose>

						<fmt:formatNumber var="discountPrice" value="${adjustValue}" type="currency" currencyCode="${discounts.amount.currency}" maxFractionDigits="${env_currencyDecimal}" />

						<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
							<c:param name="code" value="${discounts.code}" />
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${WCParam.catalogId}" />
						</c:url>
						<p>					
							<p class="promo promoRecap"><a href="${DiscountDetailsDisplayViewURL}">
								<span class="left">${discounts.description.value}</span>
								<span class="right">${discountPrice}${vatFree}</span></a>
							</p>
						</p>
					</c:forEach>
					<!-- COUPON -->
					<c:if test="${!empty orderExternalAdjusts}">
						<c:forEach var="orderExternalAdjust" items="${orderExternalAdjusts}">
							<c:if test="${orderExternalAdjust.displayLevel eq '0' && orderExternalAdjust.orderItemId eq itemDetails['orderItemId']}" >
								<p class="promo">
									<fmt:message key="coupon_RATE_ITEM_Description" bundle="${widgetText}" >
										<fmt:param value="${orderExternalAdjust.value}%"/>
									</fmt:message>
								</p>
							</c:if>
						</c:forEach>
					</c:if>
					<c:choose>
						<c:when test="${param.tunnelStep eq '4' && !empty dispoProductMapJson && !empty dispoProductMapJson[itemDetails['productSKU']]}">
							<c:choose>
								<c:when test="${dispoProductMapJson[itemDetails['productSKU']] eq 'today'}">
									<div id='dispo_${itemDetails['productSKU']}_${itemDetails["orderItemId"]}' class="dispo">
										<fmt:message key="orderItemavailabilityInStockLabel" bundle="${widgetText}" />
									</div>
								</c:when>
								<c:otherwise>
									<div id='dispo_${itemDetails['productSKU']}_${itemDetails["orderItemId"]}' class="dispo tard">
										<fmt:message key="orderItemAvailabilityMessage" bundle="${widgetText}">
											<fmt:param value="${dispoProductMapJson[itemDetails['productSKU']]}"/>
										</fmt:message>
									</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div id='dispo_${itemDetails['productSKU']}_${itemDetails["orderItemId"]}'></div>
						</c:otherwise>
					</c:choose>
			</div>
		</div>
	</c:forEach>
</div>

<wcf:url var="orderSummaryViewAjaxURL" value="OrderSummaryViewAjax" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="orderId" value="${orderId}" />
	<wcf:param name="pageType" value="${param.pageType}" />
</wcf:url>

<script>
	require(["dojo/ready", "dojo/require!wc/render/Context"], function(ready){
		ready(function(){
			var orderSummaryController = wc.render.getRefreshControllerById("OrderSummaryController");
		    orderSummaryController.url = '<c:out value="${orderSummaryViewAjaxURL}" />';
		    wc.render.updateContext('OrderSummaryContext');
		});
	});
</script>

<div dojoType="wc.widget.RefreshArea" id="orderSummaryRefreshArea" objectId="orderSummaryRefreshArea" controllerId="OrderSummaryController"></div>

<!-- END TunnelRecapPanier.jspf -->