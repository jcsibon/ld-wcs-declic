<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN Header.jsp -->

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>
<%@ include file="/Widgets-lapeyre/Common/ShoppingList/ItemAddedPopup.jspf" %>
<%@ include file="/Widgets-lapeyre/Common/ShoppingList/ShoppingList_Data.jspf" %>
<%@ include file="/Widgets-lapeyre/Common/ShoppingList/AddToShoppingListPopup.jspf" %> 
<%@ include file="/Widgets-lapeyre/Common/SocialNetworks/MailSharingPopup.jspf" %>
		
		<%--ECOCEA Mantis 1425: on r�cup�re le orderId de la session pour mettre � jour si besoin le cookie WC_CartTotal_storeId --%>
		<c:if test="${empty findCurrentShoppingCartCalled}">
			<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType"
				       var="currentSessionOrder" expressionBuilder="findCurrentShoppingCart" scope="request">
			       <wcf:param name="accessProfile" value="IBM_Summary" />
			</wcf:getData>
			<c:set var="findCurrentShoppingCartCalled" value="true" scope="request"/>
			
			<script type="text/javascript">
				document.cookie = 'WC_CartOrderId_10101=${currentSessionOrder.orderIdentifier.uniqueID}; path=/';
			</script>
		</c:if>
		
		<%--ECOCEA: si le user est Guest (G), on supprime le cookie de data client si il existe --%>
		<c:if test="${userType eq 'G'}">
			<script type="text/javascript">
				document.cookie = "CONFIGURATEUR_CLIENT_DATA=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
			</script>
		</c:if>
		
		<c:if test="${WCParam.omitHeader != 1}">
			<%@ include file="ext/Header_Data.jspf" %>
			<c:if test = "${param.custom_data ne 'true'}">
				<%@ include file="Header_Data.jspf" %>
			</c:if>
			<%-- check if loadHeaderLight attribute is set in parent JSP or if request parameter --%>
			<c:if test="${empty loadHeaderLight}">
				<c:set var="loadHeaderLight" value="${param.loadHeaderLight}"/>
			</c:if>
			
			
			
			<%-- determiner la liste des univers --%>
			<c:set var="isFirst" value="true"/>
			<c:set var="listeUnivers" value=""/>
			<c:forEach var="univers" items="${categoryHierarchy.catalogGroupView}">
				<c:if test="${not isFirst}">
					<c:set var="listeUnivers" value="${listeUnivers},"/>
				</c:if>
				<c:set var="listeUnivers" value="${listeUnivers}${univers.identifier}"/>
				<c:set var="isFirst" value="false"/>
			</c:forEach>
			
			<%--ECOCEA: cette partie est cach� par dynacache: appel au CMS pour r�cup�rer les infos header/footer meme si headerlight --%>
			<%out.flush();%>
				<c:import url="${env_jspStoreDir}/Widgets/Header/ext/HeaderContent_Data_Container.jsp">
					<c:param name="listeUnivers" value="${listeUnivers}"/>
				</c:import>
			<%out.flush();%>
			
			<%@ include file="ext/Header_UI.jspf" %>
			<c:if test = "${param.custom_view ne 'true'}">
					<c:choose>
						<c:when test="${!empty loadHeaderLight && loadHeaderLight == 'true'}">
							<%@ include file="Header_Light_UI.jspf" %>
						</c:when>
						<c:otherwise>
							<%@ include file="Header_UI.jspf" %>
						</c:otherwise>
					</c:choose>
			</c:if>
		</c:if>
		<jsp:useBean id="Header_TimeStamp" class="java.util.Date" scope="request"/>
		
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		//Set requestedSubmitted to false
		requestSubmitted = false;
	}); 	
</script>		
<!-- END Header.jsp -->