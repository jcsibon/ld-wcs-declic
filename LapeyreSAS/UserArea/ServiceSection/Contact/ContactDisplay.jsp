<%--
 =================================================================
  ContactDisplay.jsp
  
  Author: Ecocea
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE HTML>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>

<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>

<fmt:message key="CONTACT_PAGE_SEO_KEYWORDS" var="seoKeywords" bundle="${storeText}" />
<fmt:message key="CONTACT_PAGE_SEO_DESCRIPTION" var="seoDescription" bundle="${storeText}" />
<fmt:message key="SEO_BRAND" var="seoBrand" bundle="${storeText}" />
<fmt:message bundle="${storeText}" var="seoTitle" key="contactPageTitle" />
<c:if test="${!empty formName[0] }">
	<fmt:message var="seoTitle" bundle="${widgetText}" key='${formName[0] }ButtonLabel'/>
</c:if>


<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>${seoTitle}  ${seoBrand}</title>
	<META NAME="robots" CONTENT="noindex,nofollow" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="<c:out value="${viewport}"/>"/>
	<meta name="description" content="<c:out value="${seoDescription}"/>"/>
	<meta name="keywords" content="<c:out value="${seoKeywords}"/>"/>
	<meta name="pageName" content="${seoTitle}"/>
	<!--Main Stylesheet for browser -->
	<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
	<!-- Style sheet for print -->
	<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
	<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ContactDisplayJS.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/additional-methods.js?${versionNumber}"></script>
	
</head>

<body>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

<!-- BEGIN ContactDisplay.jsp -->

<div id="page">
	
	<!-- Start Header -->
	<%out.flush();%>
		<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
	<%out.flush();%>
	<!-- End Header -->

	<!-- Main Content Start -->
	<div id="contentWrapper">
	<!-- Widget Breadcrumb-->
	<div class="widget_breadcrumb_position">
			<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
				<c:param name="pageName" value="ContactPage"/>
				<c:param name ="formName" value="${param.formName}" />
			</c:import>
			<%out.flush();%>
	</div> 

	<%out.flush();%>
	<c:import url = "/Widgets-lapeyre/Common/ContactPage/ContactFormSelection.jsp" >
		<c:param name="formName" value="${WCParam.formName}" />
	</c:import>
	<%out.flush();%>
	
	</div>
	<!-- Main Content End -->
	
	<!--Start Footer Content-->
	<%out.flush();%>
		<c:import url = "${env_jspStoreDir}Widgets/Footer/Footer.jsp" />
	<%out.flush();%>
	<!--End Footer Content-->
</div>
   	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="contact" />
	</c:import>
<!-- END ContactDisplay.jsp -->
