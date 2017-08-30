<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN UniverseCategoryGridWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>
	
<%@include file="UniverseCategoryGridWidget_Data.jspf"%>


<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<%@ include file="UniverseCategoryGridWidget_UI.jspf"%>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<%-- END UniverseCategoryGridWidget.jsp --%>
