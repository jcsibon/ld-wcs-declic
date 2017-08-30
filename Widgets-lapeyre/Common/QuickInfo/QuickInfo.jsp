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

<!-- BEGIN QuickInfo.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%@ include file="/Widgets-lapeyre/Common/ProductConstants.jspf" %>

<%-- Mantis 1502 --%>
<c:if test="${!empty productId}">
	<%--ECOCEA perf: on utilise le profile light. On a besoin uniquement du parentID ici --%>
	<wcf:rest var="xcatalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${productId[0]}" >	
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="currency" value="${env_currencyCode}"/>
		<wcf:param name="responseFormat" value="json"/>		
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="isProBTP" value="${extendedUserContext.isPro}" />
		<%--ECOCEA perf --%>
		<wcf:param name="profileName" value="ECO_findProductByIds_Light" />
	</wcf:rest>
	
	<c:set var="parentCatEntryId" value="${xcatalogNavigationView.catalogEntryView[0].parentCatalogEntryID}" scope="request"/>
	<c:set var="itemSelectedId" value="${productId[0]}" scope="request"/>
</c:if>
<%@include file="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.StandardProductDisplayWidget/StandardProductDisplayWidget_Data.jspf"%>

<%@ include file="ext/QuickInfo_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="QuickInfo_Data.jspf" %>
</c:if>

<%@ include file="ext/QuickInfo_UI.jspf" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="QuickInfo_UI.jspf" %>
</c:if>
<jsp:useBean id="QuickInfo_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END QuickInfo.jsp -->