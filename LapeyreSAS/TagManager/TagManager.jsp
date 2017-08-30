<!--  Begin TagManager.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<c:if test="${!empty currentSessionOrder }">
	<c:set var="orderIdGTM" value="${currentSessionOrder.orderIdentifier.uniqueID}" scope="request"/>
</c:if>
<c:set var="pageGroup" value="${param.pageGroup}" />
<c:set var="tunnelStep" value="${param.tunnelStep}" />

<%@ include file="TagManager_Data.jspf" %>
<%@ include file="TagManager_UI.jspf" %>
<!--  End TagManager.jsp -->