<%@ page trimDirectiveWhitespaces="true" %>


<%-- 
  *****
  * This JSP is called whenever a generic error occurs in the store and no specific errorViewName
  *  has been provided to redirect to.  This page handles 3 situations:
  *  - The store is set to closed or locked state
  *  - The customer is not authorized to access a page they requested
  *  - All other generic errors
  * If the store is closed or locked, a message is displayed to the customer telling them the store is closed.
  * If the user does not have authority to access a specific page, then page redirects to the stores logon page.
  * For all other errors, a generic error message is displayed.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%-- yurk --%>
<c:if test="${empty catalogId }">
	<c:set var="catalogId" value="10151" scope="request"/>
</c:if>

<%@ include file="Common/EnvironmentSetup.jspf" %>
<%@ include file="Common/nocache.jspf" %>
<%@ include file="include/ErrorMessageSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@page import="com.ibm.commerce.bi.BIConfigRegistry"%>
<%@ page import="com.ibm.commerce.datatype.WcParam" %>

<c:set var="pageCategory" value="Error" scope="request"/>

<%
	// Set error code.
	response.setStatus(400);

	// check to see if the wcparam is available; initialise it if it is not available
	if (null == request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM)) {
		request.setAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM, new WcParam(request));
	}
	WcParam wcParam = (WcParam) request.getAttribute(com.ibm.commerce.server.ECConstants.EC_INPUT_PARAM);
	CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
	Integer storeId = commandContext.getStoreId();
	
	//yurk
	if(!wcParam.containsKey("catalogId")) wcParam.put("catalogId",request.getAttribute("catalogId"));
%>

<c:if test="${empty storeId }">
	<c:set var="storeId" value="${WCParam.storeId}"/>
</c:if>
<c:if test="${empty catalogId }">
	<c:set var="catalogId" value="${WCParam.catalogId}"/>
</c:if>

<c:if test="${empty catalogId }">
	<wcf:rest var="storeDB" url="store/{storeId}/online_store" cached="true">

		<wcf:var name="storeId" value="${storeId}" encode="true"/>
		<wcf:param name="profileName" value="IBM_Admin_Summary" encode="true"/>
	</wcf:rest>
	<c:set var="catalogId" value="${storeDB.resultList[0].defaultCatalog[0].catalogIdentifier.uniqueID}"/>
</c:if>

<wcst:aliasBean id="errorBean" name="ErrorDataBean"/>
<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2016 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<title>
		<%--
		//  If the store is closed or suspended, we get the message state _ERR_BAD_STORE_STATE (CMN1072E).
		//  We should display the store is closed page.
		--%>
		<c:choose>
			<c:when test="${errorBean.messageKey eq '_ERR_CMD_CMD_NOT_FOUND' || errorBean.messageKey eq '_ERR_CAT_NOT_PUBLISHED' || errorBean.messageKey eq '_ERR_CATENTRY_NOT_EXISTING_IN_STORE' || errorBean.messageKey eq '_ERR_PROD_NOT_PUBLISHED' || errorBean.messageKey eq '_ERR_RETRIEVE_PRICE.1002' }">
				<%
					response.setStatus(HttpServletResponse.SC_NOT_FOUND);
				%>
				<fmt:message key="pageIntrouvableLabel" bundle="${storeText}" />
				<c:set var="errorCode" value="404" scope="request"/>
			</c:when>
			<c:when test="${(errorBean.messageKey eq '_ERR_CMS_USER_NOT_GRANTED' || errorBean.messageKey eq '_ERR_USER_AUTHORITY') && userType ne 'G'}">
				<%
					response.setStatus(HttpServletResponse.SC_FORBIDDEN);
				%>
				<fmt:message key="pageForbiddenLabel" bundle="${storeText}" />
				<c:set var="errorCode" value="403" scope="request"/>
			</c:when>
			<c:when test="${(errorBean.messageKey eq '_ERR_CMS_USER_NOT_GRANTED' || errorBean.messageKey eq '_ERR_USER_AUTHORITY') && userType eq 'G'}">
				<fmt:message bundle="${storeText}" key="LAP041_AUTHENTICATION_REQUIRED"/>
			</c:when>
			<c:when test="${errorBean.messageKey eq '_ERR_BAD_STORE_STATE'}">
				<fmt:message bundle="${storeText}" key="GENERICERR_TEXT3"/>
			</c:when>
			<c:when test="${errorBean.messageKey eq '_ERR_INVALID_COOKIE' }">
				<fmt:message bundle="${storeText}" key="sessionExpiredLabel" />
			</c:when>
			<c:otherwise>
				<fmt:message bundle="${storeText}" key="ERROR_TITLE"/>
			</c:otherwise>
		</c:choose>
	</title>
	<META NAME="robots" CONTENT="noindex,nofollow" />
	<!--Main Stylesheet for browser -->
	<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
	<!-- Style sheet for print -->
	<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
	
	<%@ include file="Common/CommonJSToInclude.jspf"%>
	
	<script>
		if(self!=top){
			<%-- 
				Preview_Window is the name given to the top most window if 
				CMC has launched the store in preivew mode 
			--%>
			if(!top || top.name != 'Preview_Window') {
				<%-- If not launched from Preview, then make the top window, this HREF --%>
				top.location.href = location.href;
			}else if  (top && top.name == 'Preview_Window' && top.frames["previewFrame"].location != location.href){
				<%-- The case of having this error message shown in an iframe, we want to jump out of it. --%>
				top.frames["previewFrame"].location.href = location.href;
			}
		}
	</script>
	<%@ include file="Common/CommonJSPFToInclude.jspf"%>
	
	<c:if test="${errorBean.messageKey eq '_ERR_CMD_CMD_NOT_FOUND'}">
		<wcf:url var="homePageUrl" patternName="HomePageURLWithLang" value="TopCategories1">
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${storeId}" />
			<wcf:param name="catalogId" value="${catalogId}" />
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url> 
		<!-- meta http-equiv="Refresh" content="0;URL=${homePageUrl}"/-->
    </c:if>
	
	<script type="text/javascript">
	  dojo.addOnLoad(function() {
			setDeleteCartCookie();
		});
	</script>

</head>
 
<%@ include file="Common/CommonJSPFToInclude.jspf"%>
 
<body>
<div id="page">
    <!-- Header Nav Start -->
	<c:choose>
		<c:when test="${!b2bStore}">
			<!-- Import Header Widget -->
			
			
				
				<c:if test="${CommandContext.commandName eq 'TunnelCommandShippingView' 
																|| CommandContext.commandName eq 'ValidateTunnelShipping'
																|| CommandContext.commandName eq 'TunnelCommandPaymentView'}">
					<c:set var="returnPage" value="Tunnel"/>
				
				</c:if>

				<%out.flush();%>
				<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp">
						<c:param name="loadHeaderLight" value="${(returnPage eq 'Tunnel' && !isOnMobileDevice) ? true:false}"></c:param>						
				</c:import>
				<%out.flush();%>
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
				
			
			<!-- Header Nav End -->
			<div class="content_wrapper_position">
				<div class="content_wrapper">
					<div class="content_left_shadow">
						<div class="content_right_shadow">
							<div class="main_content">
								<div class="container_full_width">
		</c:when>
		<c:otherwise>
			<div id="header">
				<div id="header_logo">
					<%out.flush();%>
						<c:import url= "/Widgets/com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
							<c:param name="langId" value="${langId}" />
							<c:param name="emsName" value="HeaderStoreLogo_Content" />
							<c:param name="linkId" value="WC_CachedHeaderDisplay_Link_2a" />
						</c:import>
					<%out.flush();%>
				</div>
			</div>
			<!-- Header Nav End -->
			<div class="content_wrapper">
				<div class="content_left_shadow">
					<div class="content_right_shadow">
						<div class="main_content">
							<div class="container_content_leftsidebar">													
							  	<div class="left_column">
							  		<%@ include file="include/LeftSidebarDisplay.jspf"%>
							  	</div>
							  	<div class="right_column"> 
		</c:otherwise>
	</c:choose>
	<%@ include file="GenericError_UI.jspf" %>
	</div>
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
<wcst:alias name="BIConfigRegistry" var="BIConfigRegistry" />
<wcst:mapper source="BIConfigRegistry" method="useHostedLibraries" var="BIConfigRegistryUseHostLibraries" />

<c:set var="useHostedLib" value="${BIConfigRegistryUseHostLibraries[storeId]}" />
<flow:ifEnabled feature="Analytics">
	<c:choose>
		<c:when test="${useHostedLib == true}">
			<cm:pageview category="ERROR" />
		</c:when>
		<c:otherwise>
			<cm:error />
		</c:otherwise>
	</c:choose>
</flow:ifEnabled>

<%@ include file="Common/JSPFExtToInclude.jspf"%>
	<c:import url="TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="error" />
	</c:import>
</body>
</html>
