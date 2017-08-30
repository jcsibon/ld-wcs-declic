<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN TunnelShopCartDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="tunnelStep" value="1"/>
<%-- Target2Sell BEGIN --%>
<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_SHOPCART %>" scope="request" />
<%-- Target2Sell END --%>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>
<%out.flush();%>
	<c:import url="OrderItemDisplay.jsp">
		<c:param name="tunnelStep" value="${tunnelStep}"></c:param>
	</c:import>
<%out.flush();%>

<!-- END TunnelShopCartDisplay.jsp -->
