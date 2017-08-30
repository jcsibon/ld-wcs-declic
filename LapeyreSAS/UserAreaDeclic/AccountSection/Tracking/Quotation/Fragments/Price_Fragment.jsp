<c:remove var="priceString"/>

<%--On définit le prix présent dans le devis, en tant que fall back --%>
<%-- <c:if test="${ quotationDetail.priceHT >0 && quotationDetail.priceTTC >0}"> --%>
	<c:choose>		
		<c:when test="${extendedUserContext.isPro}">
			<c:set var="thePrice" value="${quotationDetail.priceHT}"/>
		</c:when>
		<c:otherwise>
			<c:set var="thePrice" value="${quotationDetail.priceTTC}"/>
		</c:otherwise>
	</c:choose>
	<fmt:formatNumber var="priceString" value="${thePrice}" pattern="####" />
<%-- </c:if> --%>

<%--calcul du prix total, affiché pour les items non transformables --%>
<c:choose>
	<c:when test="${extendedUserContext.isPro}">
		<c:choose>
			<c:when test="${ !empty thePrice  }">
				<c:set var="totalPriceValue" value="${quotationDetail.quantity * thePrice}" />
				<fmt:formatNumber var="formattedPriceString" value="${totalPriceValue}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}<sup class='vatFree'>HT</sup>" maxFractionDigits="${env_currencyDecimal}"/>
			</c:when>
			<c:otherwise>
				 <fmt:message bundle="${widgetText}" var="formattedPriceString" key="noPriceLabel" />
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${ !empty thePrice  }">
				<c:set var="totalPriceValue" value="${quotationDetail.quantity * thePrice}" />
				<fmt:formatNumber var="formattedPriceString" value="${totalPriceValue}" type="currency" currencySymbol="<sup class='currency'>${env_CurrencySymbolToFormat}</sup>" maxFractionDigits="${env_currencyDecimal}"/>
			</c:when>
			<c:otherwise>
				 <fmt:message bundle="${widgetText}" var="formattedPriceString" key="noPriceLabel" />
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>


<c:catch var="exc"> 
	<c:remove var="itemTotalPrice" />
	<c:set var="itemTotalPrice" value="${quotationDetail.quantity * thePrice}" />
	<c:set var="totalAmt" value="${totalAmt+itemTotalPrice}" scope="request"/>
</c:catch>



<c:if test="${!buyableItem}">
	<c:if test="${detailMissingSKUS!=''}">
		<c:set var="detailMissingSKUS" value="${detailMissingSKUS}," scope="request"/>
	</c:if>
	<c:set var="detailMissingSKUS"
		value="${detailMissingSKUS} {\"image\":\"${productFullImage}\",\"price\":\" ${formattedPriceString}\",\"name\":\"${highlightedName}\",\"quantity\":\"${quotationDetail.quantity}\"}" scope="request"/>
</c:if>
										
<c:if test="${!isOnMobileDevice}">
    <%-- If the price is unavailable, print out quotation Price --%>
	<div class="offerprice ">
		<c:if test="${!empty thePrice }">
			<fmt:formatNumber value="${thePrice}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
			<c:if test="${extendedUserContext.isPro}"><sup class="vat-free">HT</sup></c:if>
		</c:if>
	</div>

	
	<c:remove var="priceString" />
	<c:remove var="minimumPriceString" />
	<c:remove var="maximumPriceString" />
	<c:remove var="priceHighlightable" />
</c:if>

<c:remove var="offerPrice"/>
<c:remove var="listPrice"/>