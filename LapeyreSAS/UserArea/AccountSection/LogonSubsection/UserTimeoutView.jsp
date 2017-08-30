

<%-- 
  *****
  * This JSP is called whenever the current session has timed out.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<%
	// Set error code.
	response.setStatus(400);
%>

<c:set var="pageCategory" value="MyAccount" scope="request"/>
<c:choose>
	<c:when test="${empty WCParam.catalogId}">
	 	<%-- The page will be reloaded with the selected catalogId --%>
		<wcf:url var="sWebAppPath" value="ReLogonFormView">
			<wcf:param name="catalogId" value="${sdb.masterCatalog.catalogId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="langId" value="${CommandContext.languageId}"/>
		</wcf:url>
		<meta http-equiv="Refresh" content="0;URL=<c:out value="${sWebAppPath}"/>"/>
	</c:when>
	<c:otherwise>

	<!DOCTYPE HTML>

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
	<!-- BEGIN UserTimeoutView.jsp -->
	
	<html lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><fmt:message bundle="${storeText}" key="USER_SESSION_TIMEOUT_TITLE"/></title>
		<META NAME="robots" CONTENT="noindex,nofollow" />
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
			<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>

		<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
		
		<script type="text/javascript">
		  dojo.addOnLoad(function() {
				setDeleteCartCookie();
			});
		</script>
				
	</head>
	
	<body>
		<!-- JSP File Name:  UserTimeoutView.jsp -->
		<div id="page">
		
			<%--Mantis 1436 --%>
			<c:set var="reloadUrl" value="/" />
			<if test="${!empty param.ddkey}">
				<c:set var="refreshUrls" value="${fn:split(param.ddkey, ':')}" />
				<c:set var="reloadUrl" value="/${refreshUrls[1]}" />
				
				<%--Si on vient du tunnel on redirige vers la page livraison --%>
				<c:if test="${refreshUrls[1] eq 'TunnelCommandShippingView' ||
								refreshUrls[1] eq 'TunnelCommandAddressValidation' ||
								refreshUrls[1] eq 'ValidateTunnelShipping' ||
								refreshUrls[1] eq 'TunnelCommandPaymentView'}">
								
					<wcf:url var="tunnelShippingLink" value="TunnelCommandAddressValidation">
						<wcf:param name="storeId"   value="${WCParam.storeId}"  />
						<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
						<wcf:param name="langId" value="${WCParam.langId}" />
					</wcf:url>
					
					<c:set var="returnPage" value="Tunnel" />	
					<c:set var="reloadUrl" value="${tunnelShippingLink}" />
				</c:if>
				
				<c:if test="${reloadUrl eq '/Logoff'}">
					<c:set var="reloadUrl" value="/" />	
				</c:if>
			</if>
			<!-- reloadUrl=${reloadUrl }-->
			<!-- returnPage=${returnPage} -->
    
		    <!-- Header Nav Start -->
					<!-- Import Header Widget -->
					
						<%out.flush();%>
						<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp">
								<c:param name="loadHeaderLight" value="${(returnPage eq 'Tunnel' && !isOnMobileDevice) ? true:false}"></c:param>
						</c:import>
						<c:if test="${returnPage eq 'Tunnel' }">
							<script>
								dojo.addOnLoad(function() {
									var orderQuantity = '0';
									var cookieCartOrderId = getCookie('WC_CartOrderId_${storeId}');
									if(cookieCartOrderId != null) {
										var cookieOrderTotal = getCookie('WC_CartTotal_' + cookieCartOrderId);
										if(cookieOrderTotal != null) {
											orderQuantity = cookieOrderTotal.split(';')[0];
										}
									}
									var ordQtyHeaderLight = document.getElementById('minishopcart_total_headerLight');
									if(ordQtyHeaderLight != null) {
										ordQtyHeaderLight.innerHTML = orderQuantity;
									}
									
								});
							</script>
						</c:if>
						<%out.flush();%>
					
					<!-- Header Nav End -->
					<div class="content_wrapper_position" role="main">
						<div class="content_wrapper">
							<div class="content_left_shadow">
								<div class="content_right_shadow">
									<div class="main_content">
										<div class="container_full_width">
			<!-- Header Nav End -->
		     
			 <!--MAIN CONTENT STARTS HERE-->
			<div id="content_wrapper_border">
				<div id="box" class="my_account generic_error_container">
					<div id="errorPage">			
						<h1 class="myaccount_header"><fmt:message bundle="${storeText}" key="USER_SESSION_TIMEOUT_TITLE"/></h1>
					</div>
					<wcf:url var="LogonFormURL" value="LogonForm">
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								<wcf:param name="myAcctMain" value="1" />
								<wcf:param name="returnURL" value="${reloadUrl}" />
								<wcf:param name="returnPage" value="${returnPage}" />
					</wcf:url>
					<div id="WC_UserTimeoutView_5" class="content">
						<div id="WC_UserTimeoutView_6" class="info">
							<fmt:message bundle="${storeText}" key="USER_SESSION_TIMEOUT_DETAILS"/>
							<br/>
							<br/>
							<div class="row col6 bcol12 centered">
								<div class="ctaContainer inline">
									<a href="#" class="button greenSmall left" id="WC_AjaxAddressBookForm_div_19" tabindex="0" onclick="javascript:setPageLocation('<c:out value="${LogonFormURL}"/>')">
										<fmt:message bundle="${storeText}" key="Logon_Title" />
									</a>
									<c:choose>
										<%--Si on vient du tunnel on pointe vers la home (page accessible non loggué) --%>
										<c:when test="${returnPage == 'Tunnel' }">
											<a href="/" class="left button">
												<span><fmt:message bundle="${storeText}" key="LAP045_IGNORE_AND_CONTINUE"/></span>
											</a>
										</c:when>
										<c:otherwise>
											<a href="${reloadUrl}" class="left button">
												<span><fmt:message bundle="${storeText}" key="LAP045_IGNORE_AND_CONTINUE"/></span>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="clearFloat"></div>
							</div>
							<br clear="all"/>					
						</div>
					</div>
				
					<div id="WC_UserTimeoutView_7" class="footer">
						<div id="WC_UserTimeoutView_8" class="left_corner"></div>
						<div id="WC_UserTimeoutView_9" class="left"></div>
						<div id="WC_UserTimeoutView_10" class="right_corner"></div>
					</div>
				</div>
			</div>	
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- MAIN CONTENT ENDS HERE -->

		<!-- Footer Start -->
		<div class="footer_wrapper_position">
			<%out.flush();%>
				<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
			<%out.flush();%>
		</div>
		<!-- Footer End -->
	</div>
	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> </body>
	</html>

	</c:otherwise>
</c:choose>
<!-- END UserTimeoutView.jsp -->
