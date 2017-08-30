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
<%@ page trimDirectiveWhitespaces="true" %>

<!-- BEGIN OrderItemDetail.jsp -->
<%@ include file="../../Common/EnvironmentSetup.jspf"%>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>

<c:set var="allItemsArePaperCatalogs" value="true" scope="request" />
<jsp:useBean id="catalogs" class="java.util.HashMap" />

<c:forEach var="itemDetails" items="${orderItemsDetailsList}" varStatus="status">
	 <div class="row shoppingcart-product">
	 	<%-- IMAGE --%>
	 	<div class="col s5 m3 l2 shoppingcart-product-image ${itemDetails['isOnSpecial'] ? 'promo' : ''} ${itemDetails['soldesFlagProduct'] == 1 ? ' soldes' : ${itemDetails['soldesFlagProduct'] == 1.0 ? ' soldes' :'' }">
	 		<a href="${itemDetails['productURL']}" title="${itemDetails['productName']}">
				<img alt="${itemDetails['productName']}" src="${itemDetails['productImage']}">										
			</a>
	 	</div>
	 	
	 	<div class="col s7 m9 l10">
	 		<div class="row">
	 		
	 			<%-- RECAP PRODUIT --%>
			 	<div class="col s12 m6 l6 shoppingcart-product-summary" id="divInfoOrderItem_${itemDetails["orderItemId"]}">
			 		<p class="shoppingcart-product-sku">
			 			<fmt:message bundle="${storeText}" key="ficheProduitSkuLabel"/>
						<a href="${itemDetails['productURL']}">
							${itemDetails['productSKU']}
						</a>
			 		</p>
			 		<p class="shoppingcart-product-name">
			 			<a class="hover_underline" title ="${itemDetails['productLabel']}" href="${itemDetails['productURL']}">
							${itemDetails['productLabel']}
						</a>
			 		</p>
			 		<%-- Attributs de définition --%>
					<c:if test="${!empty itemDetails['definingAttributes'] and !isOnMobileDevice}">
				 		<div class="shoppingcart-product-attributes">
							<c:forEach var="definingAttr" items="${itemDetails['definingAttributes']}">
								<span>${definingAttr.name} : ${definingAttr.values[0].value}</span>
							</c:forEach>
				 		</div>
					</c:if>
					
					<%-- Promotion on produit --%>
					<div class="shoppingcart-product-promo">
						<%-- Promo WCS --%>
						<c:forEach var="discountsIterator" items="${itemDetails['discountReferences']}">
							<c:set var="discounts" value="${discountsIterator.value}" />			
							<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
								<c:param name="code" value="${discounts.code}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
							</c:url>
							<c:set var="discountAtOrderLine" value="${discounts.amount}" />
					
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
					
							<fmt:formatNumber var="discountPrice" value="${adjustValue}" type="currency" currencyCode="${discountAtOrderLine.currency}" maxFractionDigits="${env_currencyDecimal}" />
							<%-- was discountAtOrderLine.value --%>
							<p class="promo">
								<a href="${DiscountDetailsDisplayViewURL}">${discounts.description.value}</a>
							</p>
						</c:forEach>
						
						<%-- Réductions --%>
						<c:if test="${suiviCom and !empty orderExternalAdjusts}">
							<c:forEach var="orderExternalAdjust" items="${orderExternalAdjusts}">
								<c:if test="${orderExternalAdjust.displayLevel eq '0' && orderExternalAdjust.orderItemId eq itemDetails['orderItemId']}" >
									<p class="promo">
										<fmt:message key="coupon_RATE_ITEM_Description" bundle="${widgetText}" >
											<fmt:param value="${orderExternalAdjust.value}%"/>
										</fmt:message>
									</p>
									<p class="price">${discountPrice}</p>
								</c:if>
							</c:forEach>
						</c:if>
								
						<%-- Checks if this product is a paper catalog --%>
						<wcbase:useBean id="itemBean" classname="com.ibm.commerce.order.beans.OrderItemDataBean" scope="page">    
						  	<c:set value="${itemDetails['orderItemId']}" target="${itemBean}" property="orderItemId"/>
						</wcbase:useBean>	
						<c:set var="isCatalog" value="${'CATALOGUE_PAPIER' eq itemBean.catalogEntry.field4}" />
						<c:set target="${catalogs}" property="${itemBean.catalogEntry.catalogEntryReferenceNumber}" value="${isCatalog}"/>
						<c:remove var="itemBean" />
					</div>
					
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
										<div class="non"><fmt:message bundle="${widgetText}" key="noStockInformationErrorMessage" /></div>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${dateAvail>now}">
												<c:set var="styleDispo" value="dispo tard" />
												<fmt:formatDate value="${dateAvail}" var="strDateAvail" pattern="dd MMMMM yyyy" />
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
			 	</div>
			 	
			 	<%-- PRIX UNITAIRE --%>
			 	<div class="col l2 shoppingcart-product-unitprice hide-on-med-and-down">
			 		<c:if test="${!empty itemDetails['prixBarre'] && itemDetails['prixBarre']}">
						<p class="old_price">${itemDetails['oldUnitPrice']}</p>	
					</c:if>
					<c:choose>
						<c:when test="${!empty itemDetails['UNITE_SECONDAIRE_CODE'] && !empty itemDetails['UNITE_VENTE_LEGALE_CODE'] && fn:toLowerCase(itemDetails['UNITE_SECONDAIRE_CODE']) ne fn:toLowerCase(itemDetails['UNITE_VENTE_LEGALE_CODE'])}">
							<c:if test="${!empty itemDetails['COEFF_CONVERSION']}">
								<fmt:formatNumber var="price1" value="${itemDetails['unitProductPriceWithEcoPartNumber']}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
								<fmt:formatNumber var="price2" value="${itemDetails['unitProductPriceWithEcoPartNumber']*itemDetails['COEFF_CONVERSION']}" type="number"  maxFractionDigits="${env_currencyDecimal}"/>
								
								<p>
									${price1}
								</p>
								<span>${fn:replace(fn:replace(libellesUnit.cartColisagePriceLabel,'PRICE',price2),'.',',')}
								</span>
							</c:if>
						</c:when>
						<c:otherwise>
							<p>${itemDetails['unitProductPriceWithEcoPart']}</p>
						</c:otherwise>
					</c:choose>
			 	</div>
			 	
				<c:set var="libellesUnit" value="${ecocea:getLibelles(itemDetails['UNITE_VENTE_LEGALE_CODE'],itemDetails['COLISAGE'])}" scope="request" />
			 	<%-- QUANTITE --%>
			 	<div class="col s12 m3 l2">
			 		<div class="row">
					 	<div class="col s9 m12 l12 shoppingcart-product-quantity">
					 		<c:choose>
								<c:when test="${suiviCom}">
									<c:choose>
										<c:when test="${!empty itemDetails['UNITE_SECONDAIRE_CODE'] && !empty itemDetails['UNITE_VENTE_LEGALE_CODE'] && fn:toLowerCase(itemDetails['UNITE_SECONDAIRE_CODE']) ne fn:toLowerCase(itemDetails['UNITE_VENTE_LEGALE_CODE']) && !empty itemDetails['COEFF_CONVERSION']}">
											<p>
												<span id="surface_${itemDetails['productSKU']}_${itemDetails['orderItemId']}">
													<fmt:formatNumber var="qtyFormatted" value="${itemDetails['productQty']}" type="number" pattern="#####" maxFractionDigits="3"/>
													<fmt:formatNumber var="priceQtyFormatted" value="${itemDetails['productQty']*(1/itemDetails['COEFF_CONVERSION'])}" type="number" maxFractionDigits="3"/>
													<c:choose>
													<c:when test="${qtyFormatted>1}">
														${fn:replace(fn:replace(fn:replace(libellesUnit.colisageQuantityPlurielLabel,'QUANTITY',qtyFormatted),'NBUNIT',priceQtyFormatted),'.',',')}
													</c:when>
													<c:otherwise>
														${fn:replace(fn:replace(fn:replace(libellesUnit.colisageQuantitySingulierLabel,'QUANTITY',qtyFormatted),'NBUNIT',priceQtyFormatted),'.',',')}
													</c:otherwise>
													</c:choose>
											</p>
										</c:when>
										<c:otherwise>
											<p>
												<fmt:formatNumber var="QtyFormatted" value="${itemDetails['productQty']}" type="number" maxFractionDigits="${env_currencyDecimal}"/>
												${QtyFormatted}
											</p>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<div class="quantity_section">
										<div class="qty_controls_container">
											<span class="qtyButton leftPosition" onclick="changeQuantityItemInCart(this, '${itemDetails["productSKU"]}', '${itemDetails["orderItemId"]}',-1,'${itemDetails['COEFF_CONVERSION']}');">-</span>
											<input onpaste="return false;"
											       onkeypress="return checkNumericInput(event);"
												   id="quantity_${itemDetails['productSKU']}_${itemDetails['orderItemId']}" type="tel" onchange="JavaScript:setCurrentId('quantity_<c:out value='${itemDetails["productSKU"]}_${itemDetails["orderItemId"]}'/>'); CheckoutHelperJS.updateCartWait(this, '<c:out value='${itemDetails["orderItemId"]}'/>',event);" placeholder="4" class="product-quantity-input" name="" value="${itemDetails['productQty']}">
											<span class="qtyButton rightPosition" onclick="changeQuantityItemInCart(this, '${itemDetails["productSKU"]}', '${itemDetails["orderItemId"]}',1,'${itemDetails['COEFF_CONVERSION']}');">+</span>
										</div>
									</div>
									<c:if test="${!empty itemDetails['UNITE_SECONDAIRE_CODE'] && !empty itemDetails['UNITE_VENTE_LEGALE_CODE'] && fn:toLowerCase(itemDetails['UNITE_SECONDAIRE_CODE']) ne fn:toLowerCase(itemDetails['UNITE_VENTE_LEGALE_CODE']) && !empty itemDetails['COEFF_CONVERSION']}">
										<div class="quantity_label">
											
											<p>
												<fmt:formatNumber var="qtyFormatted" value="${itemDetails['productQty']}" type="number" pattern="#####" maxFractionDigits="3"/>
												<fmt:formatNumber var="priceQtyFormatted" value="${itemDetails['productQty']*(1/itemDetails['COEFF_CONVERSION'])}" type="number" pattern="#####.###" maxFractionDigits="3"/>
												<input type="hidden" id="surface_${itemDetails['productSKU']}_${itemDetails['orderItemId']}" value="${itemDetails['productQty']*(1/itemDetails['COEFF_CONVERSION'])}" />
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
											</p>
										</div>
									</c:if>
								</c:otherwise>
							</c:choose>
						</div>
							
						<div class="col s3 m12 m12">
							<%-- BOUTON SUPPRIMER --%>
					 		<c:if test="${!suiviCom}">
							 	<div class="shoppingcart-product-delete">
									<a id="WC_OrderItemDetailsf_links_remove_item_<c:out value='${itemDetails["orderItemId"]}'/>" 
										href="JavaScript:setCurrentId('WC_OrderItemDetailsf_links_remove_item_<c:out value='${itemDetails["orderItemId"]}'/>'); CheckoutHelperJS.deleteFromCart('<c:out value='${itemDetails["orderItemId"]}'/>');"
										class="link-primary"	
									>
										<span class="hide-on-med-and-up"><img src="${jspStoreImgDir}images/picto/trash.png" alt="" /></span>
										<span class="hide-on-small-only"><fmt:message bundle="${storeText}" key="deleteColumnLabel" /></span>
											
									</a>
							 	</div>
							</c:if>
							
					 	</div>
				 	</div>
			 	</div>
			 	
			 	<%-- TVA --%>
			 	<%-- <div class="vat">
			 		<c:if test="${extendedUserContext.isPro eq false}">
			 			<fmt:formatNumber type="number" value="${itemDetails['TVA']}" />%
			 		</c:if>
			 	</div> --%>
				
				<%-- MONTANT TOTAL PRODUIT --%>
			 	<div class="col s12 m3 l2 shoppingcart-product-totalprice">
			 		<span class="totalprice-label hide-on-med-and-up"><fmt:message bundle="${storeText}" key="TOTAL_PRICE" /></span>
			 		<c:choose>
						<c:when test="${extendedUserContext.isPro}">
							<c:if test="${itemDetails['prixBarre']}">
								<span class="old_price total">
									${fn:trim(itemDetails['oldTotalPrice'])} <sup class="vatFree">HT</sup>
								</span>
							</c:if>
							<p class="price" id="orderItemTotalPrice_${itemDetails["orderItemId"]}">
								${fn:trim(itemDetails['productPrice'])} ${env_CurrencySymbolToFormat} <sup class="vatFree">HT</sup>
							</p>
						</c:when>
						<c:otherwise>
							<c:if test="${itemDetails['prixBarre']}">
								<span class="old_price total">
									${fn:trim(itemDetails['oldTotalPrice'])}
								</span>
							</c:if>
							<span class="price" id="orderItemTotalPrice_${itemDetails["orderItemId"]}">
								${fn:trim(itemDetails['productPrice'])} <sup class="currency">${env_CurrencySymbolToFormat}</sup>
							</span>
						</c:otherwise>
					</c:choose>
					
					<%-- Promotion on produit --%>
					<div class="shoppingcart-product-promo">
						<%-- Promo WCS --%>
						<c:forEach var="discountsIterator" items="${itemDetails['discountReferences']}">
							<c:set var="discounts" value="${discountsIterator.value}" />			
							<c:set var="discountAtOrderLine" value="${discounts.amount}" />
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
					
							<fmt:formatNumber var="discountPrice" value="${adjustValue}" type="currency" currencyCode="${discountAtOrderLine.currency}" maxFractionDigits="${env_currencyDecimal}" />
							<p class="price">
								${discountPrice} <c:if test="${extendedUserContext.isPro}"><sup class="vatFree">HT</sup></c:if>		
							</p>
						</c:forEach>
								
						<%-- Checks if this product is a paper catalog --%>
						<wcbase:useBean id="itemBean" classname="com.ibm.commerce.order.beans.OrderItemDataBean" scope="page">    
						  	<c:set value="${itemDetails['orderItemId']}" target="${itemBean}" property="orderItemId"/>
						</wcbase:useBean>	
						<c:set var="isCatalog" value="${'CATALOGUE_PAPIER' eq itemBean.catalogEntry.field4}" />
						<c:set target="${catalogs}" property="${itemBean.catalogEntry.catalogEntryReferenceNumber}" value="${isCatalog}"/>
						<c:remove var="itemBean" />
					</div>
					
			 	</div>
		 	</div>
	 	</div>
	</div>
</c:forEach>

<c:forEach var="entry" items="${catalogs}">
	<c:if test="${not entry.value}">
	    <c:set var="allItemsArePaperCatalogs" value="false" scope="request" />
	</c:if>
</c:forEach>

<%-- dont change the name of this hidden input element. This variable is used in CheckoutHelper.js --%>
<input type="hidden" id = "totalNumberOfItems" name="totalNumberOfItems" value='<c:out value="${totalNumberOfItems}"/>'/>

<!-- END OrderItemDetail.jsp -->
