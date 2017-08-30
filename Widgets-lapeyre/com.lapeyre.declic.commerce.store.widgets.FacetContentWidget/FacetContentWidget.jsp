<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN FacetContentWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<c:if test="${!empty param.sortBy && !(param.sortBy == '0' && empty WCParam.orderBy) &&( param.sortBy != WCParam.orderBy) }">
	<c:remove var="includedSearchCrossContentJSPF" />
</c:if>


<c:if test="${(!empty param.pgl_widgetSlotId) && (!empty param.pgl_widgetDefId) && (!empty param.pgl_widgetId)}">
	<c:set var="widgetSuffix" value="_${param.pgl_widgetSlotId}_${param.pgl_widgetDefId}_${param.pgl_widgetId}" scope="request" />
</c:if>
<%@include file="FacetContentWidget_Data.jspf"%>


<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>


<%-- Default to Vertical view... --%>
<%@ include file="FacetContentWidget_UI.jspf" %>


<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<jsp:useBean id="cacheTimeStamp" class="java.util.Date" scope="request"/>
<wcpgl:pageLayoutWidgetCache/>

<%-- END FacetContentWidget.jsp --%>
