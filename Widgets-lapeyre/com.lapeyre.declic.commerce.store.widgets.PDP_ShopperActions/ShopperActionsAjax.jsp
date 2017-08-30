<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- use a c:out to escape unwanted XML characters --%>
<c:set var="catalogEntryID"><c:out value="${catalogEntryID[0]}" /></c:set>
<c:set var="productId"><c:out value="${productId[0]}" /></c:set>
<c:set var="isItem"><c:out value="${isItem[0]}" /></c:set>

<%@include file="ShopperActions.jsp"%>
