<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.ibm.commerce.member.facade.client.MemberFacadeClient" %>
<%@ page import="com.ibm.commerce.member.facade.datatypes.PersonType" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>



<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>


<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<wcbase:useBean id="usrRcvBean" classname="com.ibm.commerce.emarketing.beans.EmailUserReceiveDataBean">
	<c:set target="${usrRcvBean}" property="usersId" value="${person.personIdentifier.uniqueID}" />
</wcbase:useBean>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="myNewsletterMenuLinkLabel" /></title>
<META NAME="robots" CONTENT="noindex,nofollow" />
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css" />
<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css?${versionNumber}" type="text/css" />


<%@ include file="../../../Common/CommonJSToInclude.jspf"%>

<%-- CommonContexts must come before CommonControllers --%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js?${versionNumber}"/>"></script>
	
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>


<wcf:url var="ToggleNewsletterForm" value="NewsletterToggleCmd">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>


</head>
<body>
<!-- Page Start -->
<div id="page">
	<%out.flush();%>
	<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
	<%out.flush();%>

	<div id="contentWrapper">
		<div id="content" role="main">
			<div class="rowContainer">
				<div class="row">
                       <div data-slot-id="1" class="col12 slot1 mobile-hidden">
						<%out.flush();%>
						<fmt:message var="lastBreadCrumbItem" key="myNewslettersBreadcrumbLabel" bundle="${widgetText}" />
						<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
							<c:param name="pageName" value="CompteClient" />
							<c:param name="breadCrumbMonCompte" value="true" />
							<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
						</c:import>
						<%out.flush();%>
                   	</div>
               	</div>
                	
               	<c:set var="navMonCompteCurrentPage" value="myNewsletter"/>
				
				<div class="row" id="myNewsletterPage">
					<div id="navCompteClient" class="col3 mobile-hidden">
						<%@ include file="../../AccountSection/navClient.jspf" %>
					</div>
					<div class="col9 bcol12 mainContentWrapper">
						<h2 class="titleBlock"><fmt:message bundle="${storeText}" key="myNewslettersPageTitle"/></h2>
						<c:if test="${!empty errorMessage}">
							<div class="error">
								<span  class="error">${errorMessage}</span>
							</div>
						</c:if>
						<div class="aboNL">
							<form name="Subscribe" method="post" action="${ToggleNewsletterForm}" id="Subscribe" class="sign_in_registration" style="text-align: center;">
								<p style="text-align: center;"><fmt:message bundle="${storeText}" key="myNewslettersContent"/></p>
								<br clear="all">
								<div class="onoffswitch">
									<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" <c:if test="${usrRcvBean.userReceive}">checked="true""</c:if> onchange="document.Subscribe.newsletterOn.value=document.Subscribe.onoffswitch.checked"/>
									<label class="onoffswitch-label" for="myonoffswitch">
										<span class="onoffswitch-inner"></span>
										<span class="onoffswitch-switch"></span>
									</label>
								</div>
								<input type="hidden" name="newsletterOn" value="${usrRcvBean.userReceive}" autocomplete="off">
								<input type="hidden" name="URL" value="UserNewsletterView" autocomplete="off">
								<input type="hidden" name="errorViewName" value="UserNewsletterView" autocomplete="off">
								<input type="submit" class="button green" value ="<fmt:message bundle='${storeText}' key='myNewslettersSubmitButtonLabel'/>">
							</form>
						</div>
					</div>
				</div>							
			</div>
		</div>
	</div>
</div>

<% out.flush(); %>
	<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
<% out.flush(); %>
</div>
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="espaceClient" />
		<c:param name="pageName" value="userNewsletters" />
	</c:import>
</body>
</html>