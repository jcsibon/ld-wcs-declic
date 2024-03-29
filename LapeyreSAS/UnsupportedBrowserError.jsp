<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="Common/EnvironmentSetup.jspf" %>
<%@ include file="Common/nocache.jspf" %>

<c:set var="pageCategory" value="Error" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2012, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
-->
<html lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><fmt:message bundle="${storeText}" key="UnsupportedBrowserError_Title"/></title>
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<%@ include file="Common/CommonJSToInclude.jspf"%>
	</head>
		
	<body>
		
		<div class="ie6_Background" role="main">
			<div class="ie6_Position">
				<div class="ie6_Container">
					<div class="ie6_BrowserError">
						<div class="ie6_Content">

							<div class="ie6_Banner">
								<c:choose>
									<c:when test="${extendedUserContext.isPro eq true}">
										<a href="${env_TopCategoriesDisplayURL}"><img class="unsupportedBrowserImg" src="${jspStoreImgDir}images/logo_pro.png" /></a>
									</c:when>
									<c:otherwise>
										<a href="${env_TopCategoriesDisplayURL}"><img class="unsupportedBrowserImg" src="${jspStoreImgDir}images/logo.png"/></a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="ie6_Header" role="heading" aria-level="1"><fmt:message bundle="${storeText}" key="UnsupportedBrowserError_Title" /></div>
							<div class="ie6_Message"><fmt:message bundle="${storeText}" key="UnsupportedBrowserError_Text" /></div>
							<div class="clear_float"></div>
							
						</div>

						<div class="clear_float"></div>
					</div>
					<div class="box_shadow"></div>
				</div>
			</div>
		</div>
		
	
	
	
	<%@ include file="Common/JSPFExtToInclude.jspf"%> 
	</body>
	</html>