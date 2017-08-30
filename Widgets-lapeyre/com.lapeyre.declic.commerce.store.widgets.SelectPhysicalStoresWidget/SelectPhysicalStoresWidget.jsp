<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN SelectPhysicalStoresWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<%@ page trimDirectiveWhitespaces="true" %>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>

<%@include file="SelectPhysicalStoresWidget_Data.jspf"%>
<%@ include file="SelectPhysicalStoresWidget_UI.jspf"%>

<%-- END SelectPhysicalStoresWidget.jsp --%>
