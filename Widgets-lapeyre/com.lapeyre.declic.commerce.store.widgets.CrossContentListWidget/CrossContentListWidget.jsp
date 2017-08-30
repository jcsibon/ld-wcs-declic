<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN CrossContentListWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>

<c:if test="${!empty param.sortBy && !(param.sortBy == '0' && empty WCParam.orderBy) &&( param.sortBy != WCParam.orderBy) }">
	<c:remove var="includedSearchCrossContentJSPF" />
</c:if>


<c:if test="${(!empty param.pgl_widgetSlotId) && (!empty param.pgl_widgetDefId) && (!empty param.pgl_widgetId)}">
	<c:set var="widgetSuffix" value="_${param.pgl_widgetSlotId}_${param.pgl_widgetDefId}_${param.pgl_widgetId}" scope="request" />
</c:if>



	
<%@include file="CrossContentListWidget_Data.jspf"%>


<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<span class="spanacce" id="searchBasedNavigation_content_widget_ACCE_Label"><fmt:message key="ACCE_Region_Content_List"  bundle="${widgetText}"/></span>
<div dojoType="wc.widget.RefreshArea" widgetId="searchBasedNavigation_content_widget" objectId="${widgetSuffix}" id="searchBasedNavigation_content_widget" controllerId="searchBasedNavigation_content_controller" ariaMessage="<fmt:message key="ACCE_Status_Content_List_Updated"  bundle="${widgetText}"/>" ariaLiveId="${ariaMessageNode}" role="region" aria-labelledby="searchBasedNavigation_content_widget_ACCE_Label">
	<%@ include file="CrossContentListWidget_UI.jspf"%>
</div>



<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<%-- END CrossContentListWidget.jsp --%>
