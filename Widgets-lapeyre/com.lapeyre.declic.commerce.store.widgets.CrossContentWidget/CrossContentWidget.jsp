<!-- BEGIN CrossContentWidget.jsp -->

<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>

<c:if test="${!param.ignoreData}">
<%@include file="CrossContentWidget_Data.jspf"%>
</c:if>

<c:if test="${env_inPreview && !env_storePreviewLink}">	
	<jsp:useBean id="previewWidgetProperties" class="java.util.LinkedHashMap" scope="page" />
	<c:set target="${previewWidgetProperties}" property="format" value="${param.format}" />
</c:if>

<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>
</c:if>

<%@ include file="CrossContentWidget_UI.jspf"%>

<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
</c:if>

<!-- END CrossContentWidget.jsp -->
