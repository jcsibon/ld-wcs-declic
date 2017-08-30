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
<!-- BEGIN QuotationItemDetail.jsp -->
<%@ include file="../../../../../Common/EnvironmentSetup.jspf"%>
<c:forEach var="quotationDetail" items="${detailDevis}" varStatus="status">
	<%@ include file="FetchData_Fragment.jsp" %>	
	<div class="row ${(status.index %  2 == 1) ? 'odd' : 'even'} ${not buyableItem or not quotationDetail.presentInDB ? 'light' : ''}">
	
		<%-- image --%>
		<div class="productImage">
			<c:choose>
				<c:when test="${isOnSpecial}">
					<div class="top promoBannerPanier"><span><fmt:message bundle="${storeText}" key="promoBannerText" /></span></div>
				</c:when>
				<c:otherwise>
					<div class="top"></div>
				</c:otherwise>
			</c:choose>
			<c:if test="${!empty catEntryDisplayUrl}">
				<a href="${catEntryDisplayUrl}" title="${productLabel}">
			</c:if>
				<img alt="${productName}" src="${productFullImage}"  onerror="this.src='${defaultProductImage}';"/>										
			<c:if test="${!empty catEntryDisplayUrl}">
				</a>
			</c:if>
		</div>
		
		<%-- detail --%>
		<div class="productSummary">
			<p class="productName">
				<c:if test="${!empty catEntryDisplayUrl}">
					<a class="hover_underline" href="${catEntryDisplayUrl}" title="${productLabel}">
				</c:if>
					${productLabel}									
				<c:if test="${!empty catEntryDisplayUrl}">
					</a>
				</c:if>
			</p>
			<c:if test="${!empty productShortDescription }">
				<p class="productShortDesc">	
					<c:out value="${productShortDescription}" escapeXml="false" />
				</p>
			</c:if>
			
			<p class="skuReference">
				<fmt:message bundle="${storeText}" key="ficheProduitSkuLabel"/> :
				<c:if test="${!empty catEntryDisplayUrl}">
					<a href="${catEntryDisplayUrl}" title="${productName}">
				</c:if>
					${quotationDetail.partNumber}
				<c:if test="${!empty catEntryDisplayUrl}">
					</a>
				</c:if>
			</p>
			<c:if test="${!empty definingAttributes and !isOnMobileDevice}">
				<dl class="definingAttributes">
					<c:forEach var="definingAttr" items="${definingAttributes}">
						<dt>${definingAttr.name}</dt>
						<dd>${definingAttr.values[0].value}</dd>
					</c:forEach>
				</dl>
			</c:if>
		</div>
		
		<%-- prix unitaire --%>
		<div class="unitPrice">
			<%@ include file="Price_Fragment.jsp" %>
		</div>
		
		<%-- quantité --%>
		<div class="quantity">
			<fmt:formatNumber value="${quotationDetail.quantityString}" type="number" pattern="#####" maxFractionDigits="2" />
		</div>
		
		<%-- tva --%>
		<div class="vat">
			<c:if test="${extendedUserContext.isPro eq false}">
				${quotationDetail.vat}
			</c:if>
		</div>
		
		<%-- prix total --%>
		<div class="totalPrice white-background">
			<c:choose>
				<c:when test="${!empty itemTotalPrice }">
					<c:choose>
						<c:when test="${extendedUserContext.isPro}">
							<p class="price">
								<fmt:formatNumber value="${itemTotalPrice}" type="currency" currencySymbol="${env_CurrencySymbolToFormat} <sup class='vat-free'>HT</sup>" maxFractionDigits="${env_currencyDecimal}"/>
							</p>
						</c:when>
						<c:otherwise>
							<p class="price">
								<fmt:formatNumber value="${itemTotalPrice}" type="currency" currencySymbol="<sup class=currency>${env_CurrencySymbolToFormat}</sup>" maxFractionDigits="${env_currencyDecimal}"/>
							</p>
						</c:otherwise>
					</c:choose>
					<c:if test="${!buyableItem}">
						<p  class="unsellable"><fmt:message bundle="${widgetText}" key="wishlistNotBuyable" /></p>
					</c:if>
				</c:when>
				<c:otherwise>
					<p class="unsellable"><fmt:message bundle="${widgetText}" key="noPriceLabel" /></p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</c:forEach>

<!-- END QuotationItemDetail.jsp -->
