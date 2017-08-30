<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN mobile/OrderItemDetail.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="../../../Common/EnvironmentSetup.jspf"%>


<c:forEach var="itemDetails" items="${orderItemsDetailsList}" varStatus="status">

	<div class="row ${status.count % 2 == 1 ? 'odd' : 'even'}">
	 	
	 	<%-- IMAGE --%>
	 	<div class="productImage ${itemDetails['isOnSpecial'] ? 'promo' : ''} ${itemDetails['soldesFlagProduct'] == 1 ? ' soldes' : ${itemDetails['soldesFlagProduct'] == 1.0 ? ' soldes' :'' }">
	 		<a href="${itemDetails['productURL']}" title="${itemDetails['productName']}">
				<img alt="${itemDetails['productName']}" src="${itemDetails['productImage']}">										
			</a>
	 	</div>
	 	
		<%-- BOUTON SUPPRIMER --%>
 		<c:if test="${!suiviCom}">
		 	<div class="deleteAction">
				<a id="WC_OrderItemDetailsf_links_remove_item_<c:out value='${itemDetails["orderItemId"]}'/>" href="JavaScript:setCurrentId('WC_OrderItemDetailsf_links_remove_item_<c:out value='${itemDetails["orderItemId"]}'/>'); CheckoutHelperJS.deleteFromCart('<c:out value='${itemDetails["orderItemId"]}'/>');">
					<img alt="${codeAvantageRemoveSubmitButtonLabel}" src="${jspStoreImgDir}/images/delete.png">
				</a>
		 	</div>
		</c:if>
	 	
	 	<%-- RECAP PRODUIT --%>
	 	<div class="productSummary" id="divInfoOrderItem_${itemDetails["orderItemId"]}">
	 		<p class="productName">
	 			<a class="hover_underline" title ="${itemDetails['productLabel']}" href="${itemDetails['productURL']}">
					${itemDetails['productLabel']}
				</a>
	 		</p>
	 		<p class="productShortDesc">
	 			<a href="${itemDetails['productURL']}">
					${itemDetails['productDescription']}
				</a>
	 		</p>
	 		<p class="skuReference">
	 			<fmt:message bundle="${storeText}" key="ficheProduitSkuLabel"/> :
				<a href="${itemDetails['productURL']}">
					${itemDetails['productSKU']}
				</a>
	 		</p>
	 	</div>
		
		<%-- MONTANT TOTAL PRODUIT --%>
	 	<div class="totalPrice">
	 		<c:choose>
				<c:when test="${extendedUserContext.isPro}">
					<c:if test="${itemDetails['prixBarre']}">
						<p class="old_price total">
							${fn:trim(itemDetails['oldTotalPrice'])} <sup class="vatFree">HT</sup>
						</p>
					</c:if>
					<p class="price" id="orderItemTotalPrice_${itemDetails["orderItemId"]}">
						${fn:trim(itemDetails['productPrice'])} <sup class="currency">${env_CurrencySymbolToFormat} <sup class="vatFree">HT</sup></sup>
					</p>
				</c:when>
				<c:otherwise>
					<c:if test="${itemDetails['prixBarre']}">
						<p class="old_price total">
							${fn:trim(itemDetails['oldTotalPrice'])}
						</p>
					</c:if>
					<p class="price" id="orderItemTotalPrice_${itemDetails["orderItemId"]}">
						${fn:trim(itemDetails['productPrice'])} <sup class="currency">${env_CurrencySymbolToFormat}</sup>
					</p>
				</c:otherwise>
			</c:choose>
	 	</div>
		
	 	<%-- QUANTITE --%>
	 	<c:if test="${!suiviCom}">
	 	<div class="quantity">
	 		<div class="quantity_section">
				<span>${quantityColumnLabel}</span>
				<div class="qty_controls_container">
					<span class="qtyButton leftPosition" onclick="changeQuantityItemInCart(this, '${itemDetails["productSKU"]}', '${itemDetails["orderItemId"]}',-1,'${itemDetails['COEFF_CONVERSION']}');">-</span>
					<input onpaste="return false;"
					       onkeypress="return checkNumericInput(event);"
						   id="quantity_${itemDetails['productSKU']}_${itemDetails['orderItemId']}" type="tel" onchange="JavaScript:setCurrentId('quantity_<c:out value='${itemDetails["productSKU"]}_${itemDetails["orderItemId"]}'/>'); CheckoutHelperJS.updateCartWait(this, '<c:out value='${itemDetails["orderItemId"]}'/>',event);" placeholder="4" class="quantity_input" name="" value="${itemDetails['productQty']}">
					<span class="qtyButton rightPosition" onclick="changeQuantityItemInCart(this, '${itemDetails["productSKU"]}', '${itemDetails["orderItemId"]}',1,'${itemDetails['COEFF_CONVERSION']}');">+</span>
				</div>
			</div>
			<c:if test="${!empty itemDetails['UNITE_SECONDAIRE_CODE'] && !empty itemDetails['UNITE_VENTE_LEGALE_CODE'] && fn:toLowerCase(itemDetails['UNITE_SECONDAIRE_CODE']) ne fn:toLowerCase(itemDetails['UNITE_VENTE_LEGALE_LABEL']) && !empty itemDetails['COEFF_CONVERSION']}">
				<input type="hidden" id="surface_${itemDetails['productSKU']}_${itemDetails['orderItemId']}" value="${itemDetails['productQty']*(1/itemDetails['COEFF_CONVERSION'])}" />
				<%@ taglib uri="ecocea.tld" prefix="ecocea" %>
				<c:set var="libellesUnit" value="${ecocea:getLibelles(itemDetails['UNITE_VENTE_LEGALE_CODE'],itemDetails['COLISAGE'])}" scope="request" />
				
				<div class="quantity_label">
					<p><span id="surface_${itemDetails['productSKU']}_${itemDetails['orderItemId']}">
						<fmt:formatNumber var="qtyFormatted" value="${itemDetails['productQty']}" type="number" pattern="#####" maxFractionDigits="3"/>
						<fmt:formatNumber var="priceQtyFormatted" value="${itemDetails['productQty']*(1/itemDetails['COEFF_CONVERSION'])}" type="number"  maxFractionDigits="3"/>
						<c:choose>
							<c:when test="${qtyFormatted>1}">
								${fn:replace(fn:replace(fn:replace(libellesUnit.colisageQuantityPlurielLabel,'QUANTITY',qtyFormatted),'NBUNIT',priceQtyFormatted),'.',',')}
							</c:when>
							<c:otherwise>
								${fn:replace(fn:replace(fn:replace(libellesUnit.colisageQuantitySingulierLabel,'QUANTITY',qtyFormatted),'NBUNIT',priceQtyFormatted),'.',',')}
							</c:otherwise>
						</c:choose>
						<c:if test="${!empty itemDetails['COLISAGE'] && itemDetails['COLISAGE']=='true'}">
							<input type="hidden" id="colisage_${itemDetails['productSKU']}_${itemDetails['orderItemId']}" value="1" />
						</c:if>
					</span>
					</p>
				</div>
			</c:if>
	 	</div>
	 	</c:if>
		
	 	<%-- DISPO STOCK --%>
 		<c:choose>
			<c:when test="${isConfirmation}">
			 	<div class="availability">
			 		<c:remove var="orderitemBean" scope="page"/>
					<wcbase:useBean id="orderitemBean" classname="com.ibm.commerce.order.beans.OrderItemDataBean" scope="page">    
	  					<c:set value="${itemDetails['orderItemId']}" target="${orderitemBean}" property="orderItemId"/>
					</wcbase:useBean>
					<fmt:parseDate value="${orderitemBean.promisedAvailableTime}" var="dateAvail" pattern="yyyy-MM-dd HH:mm:ss.SSS" />
					<c:set var="now" value="<%=new java.util.Date()%>" />
					<c:choose>
						<c:when test="${empty dateAvail}">
							<div class="non">Non disponible</div>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${dateAvail>now}">
									<c:set var="styleDispo" value="dispo tard" />
									<fmt:formatDate value="${dateAvail}" var="strDateAvail" pattern="dd MMM yyyy" />
									<fmt:message var="dispo" bundle="${widgetText}" key="orderItemAvailabilityMessage">
										<fmt:param value="${strDateAvail}" />
									</fmt:message>
								</c:when>
								<c:otherwise>
									<c:set var="styleDispo" value="dispo" />
									<fmt:message var="dispo" bundle="${widgetText}" key="orderItemavailabilityInStockLabel"/>
								</c:otherwise>
							</c:choose>
							<div class="${styleDispo}">${dispo}</div>
						</c:otherwise>
					</c:choose>
			 	</div>
			</c:when>
	 		<c:when test="${!suiviCom}">
			 	<div class="availability">
					<div id='dispo_${itemDetails['productSKU']}_${itemDetails["orderItemId"]}'></div>
			 	</div>
			</c:when>
		</c:choose>
	
		<br class="clearFloat"/>
	</div>
	
	<%-- Promos WCS --%>
	<c:forEach var="discountsIterator" items="${itemDetails['discountReferences']}">
		<c:set var="discounts" value="${discountsIterator.value}" />			
		<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
			<c:param name="code" value="${discounts.code}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${WCParam.catalogId}" />
		</c:url>
			<c:set var="adjustmentDetail" value="${xOrderDetails.orderItems[itemDetails['orderItemId']].adjustments[discounts.code]}" />
			<c:set var="adjustValue">
				<c:choose>
					<c:when test="${extendedUserContext.isPro}">
						${adjustmentDetail.AMOUNT_HT}
					</c:when>
					<c:otherwise>
						${adjustmentDetail.AMOUNT_TTC}
					</c:otherwise>
				</c:choose>
			</c:set>
		<c:set var="discountAtOrderLine" value="${discounts.amount}" />			
		<fmt:formatNumber var="discountPrice" value="${adjustValue}" type="currency" currencyCode="${discountAtOrderLine.currency}" maxFractionDigits="${env_currencyDecimal}" />
		
		<div class="row promotionLine ${status.count % 2 == 1 ? 'odd' : 'even'}">
			<div class="productSummary">
				<p class="promo left clearAll">
					<a href="${DiscountDetailsDisplayViewURL}">${discounts.description.value}</a>
				</p>
			</div>
			
			<div class="totalPrice orderLineDiscountPrice">		
				<p class="price">
					${discountPrice} <c:if test="${extendedUserContext.isPro}"><sup class="vatFree">HT</sup></c:if>		
				</p>
			</div>
		</div>
	</c:forEach>
	<%-- Réductions --%>
	<c:if test="${suiviCom and !empty orderExternalAdjusts}">
		<c:forEach var="orderExternalAdjust" items="${orderExternalAdjusts}">
			<c:if test="${orderExternalAdjust.displayLevel eq '0' && orderExternalAdjust.orderItemId eq itemDetails['orderItemId']}" >
				<div class="row ${status.count % 2 == 1 ? 'odd' : 'even'}">
					<div class="productSummary">
						<p class="promo">
							<fmt:message key="coupon_RATE_ITEM_Description" bundle="${widgetText}" >
								<fmt:param value="${orderExternalAdjust.value}%"/>
							</fmt:message>
						</p>
					</div>
					<div class="totalPrice orderLineDiscountPrice">
						<p class="price">${discountPrice}</p>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</c:if>
	
	
</c:forEach>

<%-- dont change the name of this hidden input element. This variable is used in CheckoutHelper.js --%>
<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>
<!-- END mobile/OrderItemDetail.jsp -->
