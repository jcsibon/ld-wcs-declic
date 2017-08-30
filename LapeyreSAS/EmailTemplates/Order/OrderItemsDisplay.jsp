<tr>
	<td width="100%">		
		<c:forEach var="itemDetails" items="${orderItemsDetailsList}" varStatus="status">

			<table border="0" cellpadding="0" cellspacing="0" style="display:inline;min-width:254px;max-width:290px" width="48%" align="left">
				<tr>
					<td align="left" style="vertical-align:top;">				
						<c:remove var="imageProduct"/>
						<c:remove var="productURL"/>
						<c:remove var="labelProduct"/>
						<c:remove var="skut"/>
						<c:remove var="qtyProduct" />
						<c:remove var="priceFormated" />
						<c:remove var="itemDiscounts"/>
						<c:remove var="couponRateItemDescription"/>
						<c:remove var="typeProduct"/>
						<c:remove var="isAvailable" />
						<c:remove var="willBeAvailable" />
						<c:remove var="willBeAvailableDateFormatted" />
						
							
						<c:set var="imageProduct" value="${itemDetails['productImage']}" />
						<c:set var="productURL" value="${ecocea:replaceHost(itemDetails['productURL'],hostPath)}" />
						<c:set var="labelProduct" value="${itemDetails['productLabel']}" />
						<c:set var="sku" value="${itemDetails['productSKU']}" />
						<c:set var="qtyProduct" value="${itemDetails['productQty']}" />
						<c:choose>
							<c:when test="${extendedUserContext.isPro}">
								<c:set var="priceFormated" value="${itemDetails['productPrice']}${env_CurrencySymbolToFormat} HT" />
							</c:when>
							<c:otherwise>
								<c:set var="priceFormated" value="${itemDetails['productPrice']}${env_CurrencySymbolToFormat}" />
							</c:otherwise>
						</c:choose>
						<c:set var="itemDiscounts" value="${itemDetails['discountReferences']}" />
						
						<!-- COUPON -->
						<c:if test="${!empty orderExternalAdjusts}">
							<c:forEach var="orderExternalAdjust" items="${orderExternalAdjusts}">
								<c:if test="${orderExternalAdjust.displayLevel eq '0' && orderExternalAdjust.orderItemId eq itemDetails['orderItemId']}" >
										<fmt:message var="couponRateItemDescription" key="coupon_RATE_ITEM_Description" bundle="${widgetText}" >
											<fmt:param value="${orderExternalAdjust.value}%"/>
										</fmt:message>
								</c:if>
							</c:forEach>
						</c:if>
						
						<c:set var="couponRateItemDescription" value="${couponRateItemDescription}" />
						<c:set var="typeProduct" value="${itemDetails['typeProduct']}" />
						<c:set var="isAvailable" value="${itemDetails['isAvailable']}" />
						<c:set var="willBeAvailable" value="${itemDetails['willBeAvailable']}" />
						<fmt:formatDate var="willBeAvailableDateFormatted" value="${itemDetails['dateAvailability']}" pattern="dd/MM/yyyy"/>
						<%@include file="OrderItemDisplay.jsp" %>					
					</td>
				</tr>
				<!-- separateur horizontal -->
				<tr>
					<td height="20" width="100%"></td>
				</tr>
			</table>
	    	<c:if test="${status.index%2 == 0}">
	    		<table border="0" cellpadding="0" cellspacing="0" style="display:inline;" width="4%" height="1" align="left">
					<tr>
						<td></td>
					</tr>
				</table>
			</c:if>
		</c:forEach>
	</td>
</tr>