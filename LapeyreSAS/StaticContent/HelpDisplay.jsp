<%--
 =================================================================
  HelpDisplay.jsp
  
  Author: Ecocea
 =================================================================
--%>

<!DOCTYPE HTML>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@include file="../Common/nocache.jspf" %>

<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>

<fmt:message key="HELP_PAGE_SEO_KEYWORDS" var="seoKeywords" bundle="${storeText}" />
<fmt:message key="HELP_PAGE_SEO_DESCRIPTION" var="seoDescription" bundle="${storeText}" />
<fmt:message key="SEO_BRAND" var="seoBrand" bundle="${storeText}" />
<fmt:message bundle="${storeText}" var="seoTitle" key="HELP_PAGE_TITLE" />

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<title>${seoTitle}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<meta name="description" content="<c:out value="${seoDescription}"/>"/>
	<meta name="keywords" content="<c:out value="${seoKeywords}"/>"/>
	<meta name="pageName" content="${seoTitle}"/>
	<!--Main Stylesheet for browser -->
	<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
	<!-- Style sheet for print -->
	<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
	<%@ include file="../Common/CommonJSToInclude.jspf"%>
</head>

<body>

<%@ include file="../Common/CommonJSPFToInclude.jspf"%>

<!-- BEGIN HelpDisplay.jsp -->

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
					<c:param name="pageName" value="HelpPage"/>
				</c:import>
				<%out.flush();%>
		</div> 
		<!-- Widget Breadcrumb -->
		<c:set var="contactImage" value="${isOnMobileDevice ? 'contact_mobile.png' : 'contact_dektop_960x147.png'}" />
		
		<div class="faqPresentation">
			<div class="contactBackground">
				<img class="full-width" alt="ContactHeader" src="${jspStoreImgDir}images/${contactImage}">
			</div>
			<div class="textContainer">
				<span class="surTitre"></span>
				<br clear="all">
				<h1 id="contactPresentation-details"><fmt:message key="faqPageTitle" bundle="${widgetText}" /></h1>
			</div>
		</div>
		<fmt:message key="FAQ_URL_DESKTOP" var="DesktopFAQUrl" bundle="${storeText}" />
		<fmt:message key="FAQ_URL_MOBILE" var="MobileFAQUrl" bundle="${storeText}" />
		
		<%
			String FAQUrl = ConfigTool.getConnectionPropertiesResource().getProperty("faq.lapeyre.url");
		%>
		
		<iframe id="inbenta" style="width: 100%; min-height: 800px; border: 0px none; overflow: hidden;" src="<%=FAQUrl%>" frameborder="0"></iframe>			

	</div>	
	<!-- Main Content End -->
	
	<!--Start Footer Content-->
	<div class="footer_wrapper_position">
		<%out.flush();%>
			<c:import url = "${env_jspStoreDir}Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div>
	<!--End Footer Content-->
</div>
   	<c:import url="../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="faq" />
	</c:import>

</body>
</html>
   
<!-- END HelpDisplay.jsp -->
