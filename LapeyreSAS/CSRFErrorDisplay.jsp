
<%-- 
  *****
  * This JSP displays error message when trying to execute some URL that is found to be
  * harmful to the server.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="Common/EnvironmentSetup.jspf" %>
<%@ include file="Common/nocache.jspf" %>

<c:set var="pageCategory" value="Error" scope="request"/>

<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2006, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<html lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><fmt:message bundle="${storeText}" key="CSRF_ERROR_TITLE"/></title>
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<%@ include file="Common/CommonJSToInclude.jspf"%>
		<%@ include file="Common/CommonJSPFToInclude.jspf"%>
		
	</head>

	<body>
	
		<div id="page">
		
			<!-- Header Nav Start -->
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
				<%out.flush();%>
			<!-- Header Nav End -->
		
			<!--MAIN CONTENT STARTS HERE-->
			<div class="content_wrapper_position" role="main">
				<div class="content_wrapper">
					<div class="content_left_shadow">
						<div class="content_right_shadow">
							<div class="main_content">
								<div class="container_full_width">
									<div id="box" class=" my_account generic_error_container">
										<div id="errorPage">
											<h1 class="myaccount_header"><fmt:message bundle="${storeText}" key="CSRF_ERROR_TITLE" /></h1>
										</div>
										<div id="WC_CSRFErrorDisplay_4" class="content">
											<div id="WC_CSRFErrorDisplay_5" class="info">
												<fmt:message bundle="${storeText}" key="CSRF_ERROR_DESC" />
												<br /><br />
												<fmt:message bundle="${storeText}" key="PROHIBITEDCHAR_ERROR_BACK_DESC" />
												<br /><br />
												<div class="ctaContainer">
													<a href="#" class="button red" id="WC_CSRFError_Link_1" tabindex="0" onclick="javascript:history.back(1);return false;">
														<fmt:message bundle="${storeText}" key="PROHIBITEDCHAR_ERROR_BACK" />
													</a>
												</div>
												<br />
											</div>
										</div>
					
										<div id="WC_CSRFErrorDisplay_6" class="footer">
											<div id="WC_CSRFErrorDisplay_7" class="left_corner"></div>
											<div id="WC_CSRFErrorDisplay_8" class="left"></div>
											<div id="WC_CSRFErrorDisplay_9" class="right_corner"></div>
										</div>
									</div>
								</div>
								<!-- MAIN CONTENT END -->
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Footer Start -->
			<div class="footer_wrapper_position">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
				<%out.flush();%>
			</div>
			<!-- Footer End -->
		</div>
		<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="Common/JSPFExtToInclude.jspf"%> 
	</body>
</html>
