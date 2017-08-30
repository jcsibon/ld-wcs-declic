<%-- BEGIN CrossContentListWidget.jsp --%>

<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>

<c:remove var="includedSearchCrossContentJSPF" />
	
<%@include file="CrossContentListWidget_Data.jspf"%>

<c:set var="widgetSuffix" value="${param.objectId}" scope="request" />

<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<%@ include file="CrossContentListWidget_UI.jspf"%>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<%-- END CrossContentListWidget.jsp --%>
