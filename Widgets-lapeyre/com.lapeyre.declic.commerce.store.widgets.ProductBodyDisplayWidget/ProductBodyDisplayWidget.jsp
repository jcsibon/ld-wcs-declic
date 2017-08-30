<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN ProductBodyDisplayWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>

<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>

<%@include file="ProductBodyDisplayWidget_Data.jspf"%>

<c:if test="${env_inPreview && !env_storePreviewLink}">	
	<jsp:useBean id="previewWidgetProperties" class="java.util.LinkedHashMap" scope="page" />
	<c:set target="${previewWidgetProperties}" property="productType" value="${param.productType}" />
</c:if>

<%@ page language="java"
  import="java.net.URLEncoder"
  contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%!
public String encodeURI(String value) throws Exception{
    return URLEncoder.encode(value, "UTF-8")
        .replace("+", "%20")
        .replace("%2F", "/")
        .replace("%3F", "?")
        .replace("%26", "&")
        .replace("%23", "#")
        .replace("%7C", "|")
        .replace("%3D", "=")
        .replace("%3A", ":")
        .replace("%21", "!")
        .replace("%27", "'")
        .replace("%28", "(")
        .replace("%2A", "*")
        .replace("%29", ")")
        .replace("%7E", "~");
}%> 
							
<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<%@ include file="ProductBodyDisplayWidget_UI.jspf"%>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<%-- END ProductBodyDisplayWidget.jsp --%>
