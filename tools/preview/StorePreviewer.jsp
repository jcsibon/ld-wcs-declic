<!DOCTYPE html>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@include file="BrowserCacheControl.jsp"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<c:set var="tool_locale" value="${WCParam.locale}" scope="request"/>
<c:if test="${fn:contains(WCParam.redirectstoreurl, 'JQuery')}">
	<c:set var="useJQuery" value="true"/>
</c:if>

<%
Cookie tool_locale = new Cookie("WC_TOOLLOCALE", (String) request.getAttribute("tool_locale"));
tool_locale.setPath("/");
response.addCookie(tool_locale);
%>

<fmt:setLocale value="${WCParam.locale}"/>
<fmt:setBundle basename="com.ibm.commerce.stores.preview.properties.StorePreviewer" var="resources"/>

<%-- Add param to clear minicart cookie so contents of cart are cleared between preview sessions. --%>
<c:choose>
	<c:when test="${fn:contains(WCParam.redirectstoreurl, '?')}">
		<c:url var="previewstoreurl" value="${fn:replace(WCParam.redirectstoreurl, '~~amp~~', '&')}&deleteCartCookie=true"/>
	</c:when>
	<c:otherwise>
		<%-- Since there are no params, no need to search and replace & --%>
		<c:url var="previewstoreurl" value="${WCParam.redirectstoreurl}?deleteCartCookie=true"/>
	</c:otherwise>
</c:choose>
<c:url var="headerurl" value="PreviewStoreHeader" >
	<c:if test="${!(empty WCParam.start)}">
		<c:param name="start" value="${WCParam.start}"/>
	</c:if>
	<c:param name="status" value="${WCParam.status}"/>
	<c:param name="invstatus" value="${WCParam.invstatus}"/>
	<c:param name="locale" value="${WCParam.locale}"/>
	<c:param name="timeZoneId" value="${WCParam.timeZoneId}"/>	
	<c:param name="dateFormat" value="${WCParam.dateFormat}"/>	
	<c:param name="timeFormat" value="${WCParam.timeFormat}"/>	
	<c:param name="includedMemberGroupIds" value="${WCParam.includedMemberGroupIds}"/>
	<c:param name="previewstoreurl" value="${previewstoreurl}"/>
	<c:if test="${!(empty WCParam.workspaceId)}">
	<c:param name="workspaceId" value="${WCParam.workspaceId}"/>
	</c:if>
	<c:if test="${useJQuery}">
		<c:param name="JQuery" value="1"/>
	</c:if>
</c:url>

<fmt:message key="storePreviewHeaderFrameTitle" bundle="${resources}" var="storePreviewHeaderFrameTitle"/>
<fmt:message key="storePreviewBodyFrameTitle" bundle="${resources}" var="storePreviewBodyFrameTitle"/>

<c:choose>
	<c:when test="${useJQuery}">
	</c:when>
	<c:otherwise>
		<c:set var="dojoDir" value="${staticIBMAssetAliasRoot}/dojo110"/>
		<c:set var="dojoFile" value="${dojoDir}/dojo/dojo.js"/>
		<c:set var="dojoLocale" value="${fn:replace(pageContext.request.locale, '_' , '-')}" />
		<c:set var="dojoLocale" value="${fn:toLowerCase(dojoLocale)}" />
		<c:set var="dojoConfig" value="locale:'${dojoLocale}',parseOnLoad:true"/>	
	</c:otherwise>
</c:choose>

<html lang="${pageContext.request.locale.language}">
<head>
<title><fmt:message key="storePreviewTopFrameTitle" bundle="${resources}"/></title>
<c:choose>
	<c:when test="${useJQuery}">
		<link href="${staticIBMAssetAliasRoot}/tools/preview/css/StorePreviewerJQuery.css" rel="stylesheet"/>
	</c:when>
	<c:otherwise>
		<link href="${dojoDir}/dojox/layout/resources/ResizeHandle.css" rel="stylesheet"/>
		<link href="${staticIBMAssetAliasRoot}/tools/preview/css/StorePreviewer.css" rel="stylesheet"/>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${useJQuery}">
		<script type="text/javascript" src="<c:out value='${staticIBMAssetAliasRoot}/JQuery/vendor.js'/>"></script>
		<script src="${staticIBMAssetAliasRoot}/tools/preview/javascript/StorePreviewerJQuery.js"></script>
	</c:when>
	<c:otherwise>
		<script src="${dojoFile}" data-dojo-config="${dojoConfig}"></script>
		<script src="${staticIBMAssetAliasRoot}/tools/preview/javascript/StorePreviewer.js"></script>
	</c:otherwise>
</c:choose>

<script>
var isChrome = (navigator.userAgent.indexOf("Chrome") != -1) ? true : false;
function callManagementCenter(url) {
	if (isChrome) {
		var cmcWindow = window.open("", "${WCParam.cmcWindow}");
		if (cmcWindow != null) {
			cmcWindow.focus();
		}
	}
	if (url.indexOf("/") == 0) {
		url = '${WCParam.cmcPath}' + url;
	}
	window.frames['hiddenFrame'].location.replace(url);
}
function loadHeaderFrame() {
	document.getElementById("headerFrame").src = "${headerurl}";
}
var refreshAction = false;
var min_height_popup = 600;
var min_width_popup = 600;
function checkPopupAllowed(){
	<c:choose>
		<c:when test="${useJQuery}">
			var width = $("#previewFrameWrapper").width();
			var height = $("#previewFrameWrapper").height();
		</c:when>
		<c:otherwise>
			var width = dojo.style("previewFrameWrapper",'width');
			var height = dojo.style("previewFrameWrapper",'height');
		</c:otherwise>
	</c:choose>
	if(width>=min_width_popup&&height>=min_height_popup){
		return true;
	}else{
		<fmt:message key="storePreviewNoPopupInLowResolutionError" bundle="${resources}" var="storePreviewNoPopupInLowResolutionError"/>
		window.frames['previewFrame'].MessageHelper.displayErrorMessage(<wcf:json object="${storePreviewNoPopupInLowResolutionError}"/>);
		return false;
	}
}
</script>
</head>
<body>
	<div id="header">
		<iframe id="headerFrame" name="headerFrame" src="" title="${storePreviewHeaderFrameTitle}"></iframe>
	</div>
	<div id="content">
		<div id="skin" class="fit">
			<div id="previewFrameWrapper">
				<iframe id="previewFrame" name="previewFrame" src="${fn:escapeXml(previewstoreurl)}" title="${storePreviewBodyFrameTitle}" onload="loadHeaderFrame()"></iframe>
				<c:choose>
					<c:when test="${useJQuery}">
					</c:when>
					<c:otherwise>
						<div id="resizeHandleX" data-dojo-type="dojox/layout/ResizeHandle" data-dojo-props="targetId:'previewFrameWrapper',minWidth:320,minHeight:320,resizeAxis:'x'"></div>
						<div id="resizeHandleY" data-dojo-type="dojox/layout/ResizeHandle" data-dojo-props="targetId:'previewFrameWrapper',minWidth:320,minHeight:320,resizeAxis:'y'"></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<iframe id="hiddenFrame" name="hiddenFrame"></iframe>
</body>
</html>
