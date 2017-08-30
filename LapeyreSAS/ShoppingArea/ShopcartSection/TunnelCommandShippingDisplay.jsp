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
<%@ page trimDirectiveWhitespaces="true" %>
<%--
  *****
  * This JSP file displays the shopping cart details. It shows an empty shopping cart page accordingly.
  *****
--%>                    
<!-- BEGIN TunnelCommandShippingDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="tunnelStep" value="3"/>

<%@ include file="../../Common/EnvironmentSetup.jspf"%>

<c:choose>
	<c:when test="${isOnMobileDevice}">
		<%out.flush();%>
			<c:import url = "mobile/OrderItemDisplay.jsp">
				<c:param name="tunnelStep" value="${tunnelStep}"></c:param>
				<c:param name="pageTitle" value="SHOPPINGCART_TITLE_${tunnelStep}"></c:param>
			</c:import>
		<%out.flush();%>
	</c:when>
	<c:otherwise>
		<%out.flush();%>
			<c:import url = "OrderItemDisplay.jsp">
				<c:param name="tunnelStep" value="${tunnelStep}"></c:param>
				<c:param name="pageTitle" value="SHOPPINGCART_TITLE_${tunnelStep}"></c:param>
			</c:import>
		<%out.flush();%>
	</c:otherwise>
</c:choose>
<!-- END TunnelCommandShippingDisplay.jsp -->
