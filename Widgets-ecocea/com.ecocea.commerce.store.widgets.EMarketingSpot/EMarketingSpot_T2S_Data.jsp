<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Target2SellReco BEGIN --%>
<%-- only set values once --%>
<c:if test="${empty t2sCookie}">
	<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
	<%@ taglib uri="http://commerce.ibm.com/foundation-fep/stores" prefix="wcst" %>
	<wcst:storeconf var="t2sMerchantId" name="target2sell.merchantId" scope="request" /> 
	<c:forEach items="${cookie}" var="currentCookie">
		<c:if test="${currentCookie.key == 't2s-p'}">
			<c:set var="t2sCookie" value="${currentCookie.value.value}" scope="request" />
		</c:if>
	</c:forEach>
	<%-- if first page, set unknown --%>
	<c:if test="${empty t2sCookie}">
		<c:set var="t2sCookie" value="UNKNOWN" scope="request" />
	</c:if>
	<c:set var="t2sLocale" value="${locale}" scope="request" />
	<c:set var="t2sUserAgent" value="${header['user-agent']}" scope="request" />
	
	<c:set var="t2sCategory" value="${partNumber}" scope="request" />
	
	<%-- basket --%>
	<c:set var="t2sbasket" value="" scope="request" />
	<c:set var="t2sQuantities" value="" scope="request" />
	<c:forEach items="${orderItemsDetailsList}" var="t2sOrderitem">
		<c:if test="${! empty t2sbasket}">
			<c:set var="t2sbasket" value="${t2sbasket}|" scope="request"/>
			<c:set var="t2sQuantities" value="${t2sqty}" scope="request"/> 
		</c:if>
		<c:set var="t2sbasket" value="${t2sbasket}${t2sOrderitem.productPartnumber}" scope="request" />
		<c:set var="t2sQuantities" value="${t2sQuantities}${t2sOrderitem.productQty}" scope="request" />
	</c:forEach>
	<c:set var="t2sTotalAmount" value="${orderAmountValue_TTC}" scope="request" />

	<%-- Product partnumber for product page --%>
	<c:set var="key1" value="${productId}+getCatalogEntryViewAllByID"/>
	<c:set var="t2SPartnumber" value="${cachedCatalogEntryDetailsMap[key1].partNumber}" scope="request" />
	
	<%--  wishlist --%>
	<c:set var="t2swishlist" value="" scope="request" /> 
	<c:if test="${! empty selectedSoaWishList.item}">
		<c:forEach var="soaWishlistItem" items="${selectedSoaWishList.item}" >
			<c:if test="${! empty t2swishlist}">
				<c:set var="t2swishlist" value="${t2swishlist}|"/>
			</c:if>
			<c:set var="t2swishlist" value="${t2swishlist}${soaWishlistItem.catalogEntryIdentifier.externalIdentifier.partNumber}" scope="request" />
		</c:forEach>
	</c:if>
	
	<%-- order id for post payment --%>
	<c:set var="t2sOrderId" value="${orderId}" scope="request" />	

	<%--  item list (for search and category)  --%>
	<c:set var="t2spageitems" value="" scope="request" /> 
	<c:if test="${! empty globalresults}">
		<c:forEach items="${globalresults}" var="resultitem">
			<c:if test="${! empty t2spageitems}">
				<c:set var="t2spageitems" value="${t2spageitems}|"/>
			</c:if>
			<c:set var="t2spageitems" value="${t2spageitems}${resultitem.partNumber}" scope="request" />
		</c:forEach>
	</c:if>
	
	<%-- added products --%>
	<c:set var="t2saddeditems" value="" scope="request" />
	<c:forEach var="orderItemRecentlyAddedMap" items="${t2sorderItemsRecentlyAddedList}">
		<c:if test="${! empty t2saddeditems}">
			<c:set var="t2saddeditems" value="${orderItemRecentlyAddedMap['productSKU']}|"/>
		</c:if>
		<c:set var="t2saddeditems" value="${t2saddeditems}${orderItemRecentlyAddedMap['productSKU']}" scope="request" />
	</c:forEach>
	<c:set var="t2sSearchquery" value="${searchTerm}" scope="request" />
	<c:set var="t2sUrl" value="${requestScope['javax.servlet.forward.request_uri']}" scope="request" />
	
	<%-- customer data --%>
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
	       <wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
	<c:if test="${person != null}" >	
		<c:if test="${person.attributes != null}">
			<c:set var="t2sUserID" value="${person.attributes['userField1']}" scope="request" />	
		</c:if>
		<c:set var="t2sUserEmail" value="${person.credential.logonID}" scope="request" />
	</c:if>
</c:if>
<%-- Target2SellReco END --%>