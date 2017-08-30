<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<!-- BEGIN FamilyCategoryNavigationWidget.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>

<%@include file="FamilyCategoryNavigationWidget_Data.jspf"%>

<%@ include file="/Widgets-lapeyre/Common/CategoryNavigationSetup.jspf" %>
<%@ include file="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.CategoryNavigation/CategoryNavigation_Data.jspf" %>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<%@ include file="FamilyCategoryNavigationWidget_UI.jspf"%>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<!-- END FamilyCategoryNavigationWidget.jsp -->
