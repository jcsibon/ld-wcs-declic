<%@ page trimDirectiveWhitespaces="true" %>

<%-- 
  *****
  * This JSP will display the ResetPassword form with the following fields:
  *  - Current password
  *  - New password
  *  - New Verify password
  * If the user password expired, this page will be displayed after the user logs on.
  *****
--%>



<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../../Common/nocache.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN PasswordUpdateForm.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message bundle="${storeText}" key="CHANGE_PWORD_TITLE"/></title>
	<META NAME="robots" CONTENT="noindex,nofollow" />
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
	<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css?${versionNumber}" type="text/css" />
	
	<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
	
	
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
	<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/additional-methods.js?${versionNumber}"></script>
	<script>
		$() .ready( function() {
			$("#ChangePassword").validate(
										{
											rules : {
												logonPasswordOld : {
													required: true,
												},
												logonPassword : {
													required: true,
													passwordTest : true,
													maxlength : 100,
													minlength : 6
												},
												logonPasswordVerify : {
													required: true,
													equalTo: "#WC_PasswordUpdateForm_FormInput_logonPassword_In_Register_1"
												}
											},
											messages : {
												logonPasswordOld :{
													required: "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />"
												},
												logonPassword : {
													required: "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />",
													passwordTest: "<fmt:message bundle='${storeText}' key='InvalidPasswordErrorMessage' />",
													maxlength: "<fmt:message bundle='${storeText}' key='maxlengthPasswordErrorMessage' />",
													minlength: "<fmt:message bundle='${storeText}' key='minlengthPasswordErrorMessage' />"
												},
												logonPasswordVerify : {
													required: "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />",
													equalTo: "<fmt:message bundle='${storeText}' key='invalidConfirmPasswordErrorMessage' />"
												}

											},
											errorPlacement : function(error,
													element) {
												if (element.is("select")) {
													//For select inputs, insert at the parent
													error.insertAfter(element
															.parent());
												} else if (element.attr("type") == "radio") {
													//for radio button, insert at the end of the grandparent
													error.appendTo(element
															.parent().parent());
												} else {
													error.insertAfter(element);
												}
											}
										});
					});
	
	
	
	</script>
</head>
<body>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

<wcf:url var="LogonURL" value="LogonForm">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>


<!-- Page Start -->
<div id="page">
	<!-- Header Widget -->
	
	<%out.flush();%>
	<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
	<%out.flush();%>
	<wcf:url var="MyAccountURL" value="AjaxLogonForm" type="Ajax">
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	</wcf:url>

	<!-- Main Content Start -->
	<div id="contentWrapper">
			<div id="content" role="main">
				<div class="rowContainer">
                    <div class="row">
                        <div data-slot-id="1" class="col12 slot1 mobile-hidden">
							<%out.flush();%>
							<fmt:message var="lastBreadCrumbItem" key="changePasswordBreadcrumbLabel" bundle="${widgetText}" />
							<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
								<c:param name="pageName" value="CompteClient" />
								<c:param name="breadCrumbIdentification" value="true" />
								<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
							</c:import>
							<%out.flush();%>
						</div>
                	 </div>
                	<div class="row">
						<div class="blockPresentation small">
							<div class="editoBackground"><img width="960px" height="160px" alt="Login Client" src="${jspStoreImgDir}images/loginClient.jpg"></div>
							<div class="textContainer">
								<h1><fmt:message bundle="${storeText}" key="changePasswordSectionTitle"/></h1>
							</div>
						</div>
					</div>
					<div class="row" >
						<div class="sign_in_registration bcol11 col5 hCentered" id="WC_PasswordUpdateForm_FormInput_div_1">
							<div class="title" id="WC_PasswordUpdateForm_FormInput_div_2">
								<p>
									<fmt:message bundle="${storeText}" key="changePasswordSectionContent" />
								</p>
							</div>
							<form name="ChangePassword" method="post" action="PersonChangeServicePasswordReset" id="ChangePassword">
								<input type="hidden" name="storeId" value="${WCParam.storeId}" id="WC_PasswordUpdateForm_FormInput_storeId_In_Logon_1"/>
								<input type="hidden" name="catalogId" value="${WCParam.catalogId}" id="WC_PasswordUpdateForm_FormInput_catalogId_In_Logon_1"/>
								<input type="hidden" name="langId" value="${langId}" id="WC_PasswordUpdateForm_FormInput_langId_In_Logon_1"/>
								<input type="hidden" name="logonId" value="${WCParam.logonId}" id="WC_PasswordUpdateForm_FormInput_logonId_In_Logon_1"/>
								<input type="hidden" name="reLogonURL" value="ChangePassword" id="WC_PasswordUpdateForm_FormInput_reLogonURL_In_Logon_1"/>
								<input type="hidden" name="Relogon" value="Update" id="WC_PasswordUpdateForm_FormInput_Relogon_In_Logon_1"/>
								<input type="hidden" name="errorViewName" value="ChangePassword" id="WC_PasswordUpdateForm_FormInput_Error_In_Logon_1"/>
								<input type="hidden" name="fromOrderId" value="*" id="WC_PasswordResetForm_FormInput_fromOrderId_In_Logon_1"/>
								<input type="hidden" name="toOrderId" value="." id="WC_PasswordResetForm_FormInput_toOrderId_In_Logon_1"/>
								<input type="hidden" name="deleteIfEmpty" value="*" id="WC_PasswordResetForm_FormInput_deleteIfEmpty_In_Logon_1" />
								<input type="hidden" name="continue" value="1" id="WC_PasswordResetForm_FormInput_continue_In_Logon_1" />
								<input type="hidden" name="createIfEmpty" value="1" id="WC_PasswordResetForm_FormInput_createIfEmpty_In_Logon_1" />
								<%-- the parameter 'calculationUsageId' and 'updatePrices' are used by the OrderCalculate command --%>
								<input type="hidden" name="calculationUsageId" value="-1" id="WC_PasswordResetForm_FormInput_calculationUsageId_In_Logon_1" />
								<input type="hidden" name="updatePrices" value="0" id="WC_PasswordResetForm_FormInput_updatePrices_In_Logon_1"/>
								<input type="hidden" name="URL" value="<c:out value="${MyAccountURL}"/>" id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1"/>
								<input type="hidden" name="myAcctMain" value="1" id="WC_PasswordUpdateForm_FormInput_myAcctMain_In_Logon_1"/>
								<input type="hidden" name="authToken" value="${authToken}"  id="WC_PasswordUpdateForm_FormInput_authToken_In_Logon_1"/>
								<div class="form" id="WC_PasswordUpdateForm_FormInput_div_3">
									<c:if test="${!empty errorMessage }">
										<div class="error">
											<span  class="error">${errorMessage}</span>
										</div>
									</c:if>
									<div class="content" id="WC_PasswordUpdateForm_FormInput_div_6">
										<div class="align" id="WC_PasswordUpdateForm_FormInput_div_7">
											<div class="form_3column" id="WC_PasswordUpdateForm_FormInput_div_8" >
												<div class="column column_100 bcolumn_100" id="oldPasswordContainer">
													<div class="column_label" id="oldPasswordLabel">
														<span class="spanacce">
															<label for="WC_PasswordUpdateForm_FormInput_oldlogonPassword_In_Register_1">
																<fmt:message bundle="${storeText}" key="formerPasswordFieldlabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="formerPasswordFieldlabel" />
														<span class="required-field" id="WC_UserRegistrationUpdateForm_div_15"> *</span>
													</div>
													<input size="35" maxlength="100" aria-required="true" name="logonPasswordOld" id="WC_PasswordUpdateForm_FormInput_oldlogonPassword_In_Register_1" type="password" value="" required="">
												</div>
												<br clear="all">
												<div class="column column_100 bcolumn_100" id="PasswordContainer">
														<div class="column_label" id="PasswordLabel">
															<span class="spanacce">
																<label for="WC_PasswordUpdateForm_FormInput_logonPassword_In_Register_1">
																	<fmt:message bundle="${storeText}" key="newPasswordFieldLabel" />
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="newPasswordFieldLabel" />
															<span class="required-field" id="WC_UserRegistrationUpdateForm_div_15"> *</span>
														</div>
														<input size="35" maxlength="100" aria-required="true" name="logonPassword" id="WC_PasswordUpdateForm_FormInput_logonPassword_In_Register_1" type="password" value="" required="">
												</div>
												<div class="column column_100 bcolumn_100" id="ConfirmPasswordContainer">
													<div class="column_label" id="ConfirmPasswordLabel">
														<span class="spanacce">
															<label for="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_Register_1">
																<fmt:message bundle="${storeText}" key="confirmNewPasswordFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="confirmNewPasswordFieldLabel" />
														<span class="required-field" id="WC_UserRegistrationUpdateForm_div_18"> *</span>
													</div>
													<input size="35" maxlength="100" aria-required="true" name="logonPasswordVerify" id="WC_PasswordUpdateForm_FormInput_logonPasswordVerify_In_Register_1" type="password" value="" required="">
												</div>
												<br clear="all">
												<div class="submitChamp button_footer_line no_float">
													<input type="submit" value='<fmt:message bundle="${storeText}" key="changePasswordSubmitButtonlabel"/>' class="button green">
													<%-- <br clear="all">
													<a class="button ajoutListeAchatBtn" href="${LogonURL}"><fmt:message bundle="${storeText}" key="changePasswordCancelButtonLabel"/></a> --%>
												</div>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- Footer Start Start -->
			<div class="footer_wrapper_position">
				<%out.flush();%>
				<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
				<%out.flush();%>
			</div> 
		    <!-- Footer Start End -->
		</div>
	</div>
</div>

<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> 
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="espaceClient" />
		<c:param name="pageName" value="updatePassword" />
	</c:import>

</body>
</html>
<!-- END PasswordUpdateForm.jsp -->
