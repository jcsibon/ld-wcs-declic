<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN ItemAvailabilityInPhysicalStoresWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<%@ page trimDirectiveWhitespaces="true" %>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>
<c:choose>
	<c:when test="${empty displayTypeAjax}">
		<c:set var="displayType" value="${param.displayType}" />
	</c:when>
	<c:otherwise>
		<c:set var="displayType" value="${displayTypeAjax}" />
	</c:otherwise>
</c:choose>

<!-- Boolean used to print only the select -->
<c:set var="onlySelect" value="${param.onlySelect}" />

<%@include file="ItemAvailabilityInPhysicalStoresWidget_Data.jspf"%>

<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>
</c:if>

<c:choose>
	<c:when  test="${(!empty pageType && pageType eq 'TunnelPanier') || (!empty param.pageType && param.pageType eq 'TunnelPanier')}">
		<%@ include file="ItemAvailabilityInPhysicalStoresWidgetForShopCart_UI.jspf"%>
	</c:when>	
	<c:when  test="${(!empty pageType && pageType eq 'TunnelLivraison') || (!empty param.pageType && param.pageType eq 'TunnelLivraison')}">
		<%@ include file="ItemAvailabilityInPhysicalStoresWidgetForTunnelLivraison_UI.jspf"%>
	</c:when>	
	<c:when test="${displayType eq '_popup'}">
		<%@ include file="ItemAvailabilityInPhysicalStoresWidgetPopin_UI.jspf"%>
	</c:when>
	<c:otherwise>
		<%@ include file="ItemAvailabilityInPhysicalStoresWidget_UI.jspf"%>
	</c:otherwise>
</c:choose>

<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
</c:if>

<%-- END ItemAvailabilityInPhysicalStoresWidget.jsp --%>
