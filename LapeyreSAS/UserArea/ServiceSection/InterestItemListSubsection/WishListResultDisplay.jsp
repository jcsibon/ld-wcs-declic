<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN WishlistResultDisplay.jsp -->
<%-- Target2Sell BEGIN --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_WISHLIST %>" scope="request" />
<%-- Target2Sell END --%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="WishListResultDisplay_Data.jspf" %>
<%@ include file="WishListResultDisplay_UI.jspf" %>
<!-- END WishlistResultDisplay.jsp -->