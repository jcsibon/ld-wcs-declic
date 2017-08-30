<fmt:message var="puhtColumnLabel" key="puhtColumnLabel" bundle="${widgetText}" />
<fmt:message var="puttcColumnLabel" key="puttcColumnLabel" bundle="${widgetText}" />
<fmt:message var="quantityColumnLabel" key="quantityColumnLabel" bundle="${widgetText}" />
<fmt:message var="tvaRateColumnLabel" key="tvaRateColumnLabel" bundle="${widgetText}" />
<fmt:message var="prixTtcColumnLabel" key="prixTtcColumnLabel" bundle="${widgetText}" />
<fmt:message var="prixHtColumnLabel" key="prixHtColumnLabel" bundle="${widgetText}" />
<fmt:message var="panierTotalAmountLabel1" key="panierTotalAmountLabel1" bundle="${widgetText}" />
<fmt:message var="panierTotalAmountLabel2" key="panierTotalAmountLabel2" bundle="${widgetText}" />



<%-- ENTETE DEVIS --%>
<div class="orderHeaderWrapper">
	<div class="orderHeader">
		<div class="row">
			<div class="quantityTotal bold">
				<c:choose>
					<c:when test="${totalItemsNumber <= 1}">
						<span>${totalItemsNumber} <fmt:message bundle="${storeText}" key="productLabel"/></span>
					</c:when>
					<c:otherwise>
						<span>${totalItemsNumber} <fmt:message bundle="${storeText}" key="productsLabel"/></span>
					</c:otherwise>
				</c:choose>
			</div>
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
			<div class="quantity">
				${quantityColumnLabel}
			</div>
			<div class="vat">
				<c:if test="${extendedUserContext.isPro eq false}">
					${tvaRateColumnLabel}
				</c:if>
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


<%-- LIGNES DEVIS --%>
<div class="orderBodyWrapper">
	<div class="orderBody" id="detailDevisListProduits">
		<jsp:include page="Fragments/QuotationItemDetail.jsp"/>
	</div>
</div>

<%-- RECAP DEVIS --%>
<div class="orderSummaryWrapper">
	<div class="orderSummary">
		<dl class="main line">
			<dt class="label">
				<c:choose>
					<c:when test="${extendedUserContext.isPro}">
						<fmt:message bundle="${widgetText}" key="htTotalAmountLabelStrong" />
					</c:when>
					<c:otherwise>
						<fmt:message bundle="${widgetText}" key="ttcTotalAmountLabelStrong" />
					</c:otherwise>
				</c:choose>
			</dt>
			<dd class="value">
				<c:choose>
					<c:when test="${!empty totalAmt && totalAmt > 0}">
						<span class="price">
							<c:choose>
								<c:when test="${extendedUserContext.isPro}">
									<fmt:formatNumber value="${totalAmt}" type="currency"  maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat} <sup class='vatFree'>HT</sup></sup>"/>
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${totalAmt}" type="currency"  maxFractionDigits="${env_currencyDecimal}" currencySymbol="<sup class=currency>${env_CurrencySymbolToFormat}</sup>"/>
								</c:otherwise>
							</c:choose>
						</span>	
					</c:when>
					<c:otherwise>
						&nbsp;
					</c:otherwise>
				</c:choose>
			</dd>
		</dl>
	</div>
</div>
