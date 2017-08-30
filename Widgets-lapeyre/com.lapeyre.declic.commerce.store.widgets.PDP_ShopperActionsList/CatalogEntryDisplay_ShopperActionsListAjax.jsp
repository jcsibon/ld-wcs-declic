<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="catalogEntryID" value="${param.catalogEntryID}" />
<c:set var="productId" value="${param.productId}" />
<c:set var="pageloaded_addToShopListPopupJSPF" value="${param.alreadyLoaded}" scope="request"/>

<%@ include file="CatalogEntryDisplay_ShopperActionsList.jsp" %>

