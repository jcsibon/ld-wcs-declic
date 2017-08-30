<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="FORGET_PASS_TITLE" /></title>
<META NAME="robots" CONTENT="noindex,nofollow" />
<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/logon/passwordReset.css?${versionNumber}" type="text/css" />

<%@ include file="../../../Common/CommonJSToInclude_redesign.jspf"%>
<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/additional-methods.js?${versionNumber}"></script>

<script>
var countryTagID = "countryField";
$().ready( function() {
	// validate signup form on keyup and submit
	$("#errorMessage").hide();
	$("#ResetPasswordForm").validate({
		rules : {
			logonId : {
				required : true,
				email : true,
				maxlength : 100
			}
		},
		messages : {
			logonId : {
				required : "<fmt:message bundle='${widgetText}' key='missingEmailErrorMessage' />",
				email : "<fmt:message bundle='${widgetText}' key='InvalidEmailErrorMessage' />",
				maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthEmailErrorMessage' />"
			}
		},
		submitHandler: function(form) {
			displayProgressBar();
			dojo.xhrPost({
				form: form,
				handleAs: "text",
				load: function(data){ <%-- cet appel a ete ajaxise, or IBM renvoie une page HTML, on parse pour recuperer l'eventuel message d erreur --%>
					hideProgressBar();

					var el =$( '<div></div>' ); el.html(data);
					errMsg=$("#ErrorMessageText",el).html();
					if(errMsg !=undefined && errMsg!=""){
						displayError(form, errMsg);
					}else{
						resetForm(form);
						dijit.byId('popinForgottenPassword').show();
					}
				},
				error: function(err){
                	hideProgressBar();
					resetForm(form);
                	displayError(form, err);
				}
		    });
		}
	});
});

function resetForm(form) {
	$(form).get(0).reset();
}

function displayError(form, error) {
	$(form).find('#errorMessage .error').html(error);
	$("#errorMessage").show();
}
			 
</script>


<wcf:url var="LogonURL" value="LogonForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="new" value="Y" />
	<wcf:param name="myAcctMain" value="1" />
</wcf:url>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
<!-- Page Start -->
<div id="page">
		<!-- Header Widget -->
	
		<%out.flush();%>
			<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>
	
		<!-- Main Content Start -->
		<div id="resetPasswordPage">
			<div id="resetPasswordContent" role="main">
				<div class="rowContainer">
					<div class="container">
						<div class="row">
							<div class="col s12 l6 offset-l3 m10 offset-m1" id="resetPassworPanel">
								<div class="resetMainTitle resetTitle">
									<h1><fmt:message bundle="${storeText}" key="forgottenPasswordPageTitle"/></h1>
								</div>
								<div class="col s12 resetTitle" id="forgottenPasswordPageIntroMessage">
									<p>
										<fmt:message bundle="${storeText}" key="forgottenPasswordPageIntroMessage" />
									</p>
								</div>
								<div class="reset_password" id="WC_UserRegistrationAddForm_div_1">
									<script>function tolower(){
										$("#WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1").val($("#WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1").val().toLowerCase());
										return true;
									}</script>
									<form name="ResetPasswordForm" method="post" action="AjaxPersonChangeServicePasswordReset" id="ResetPasswordForm" onsubmit="javascript:tolower();">
										<input type="hidden" name="challengeAnswer" value="-" id="WC_PasswordResetForm_FormInput_challengeAnswer_In_ResetPasswordForm_1"/>
										<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_PasswordResetForm_FormInput_storeId_In_ResetPasswordForm_1"/>
										<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}" />' id="WC_PasswordResetForm_FormInput_catalogId_In_ResetPasswordForm_1"/>
										<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_PasswordResetForm_FormInput_langId_In_ResetPasswordForm_1"/>
										<input type="hidden" name="state" value="passwdconfirm" id="WC_PasswordResetForm_FormInput_state_In_ResetPasswordForm_1"/>
										<input type="hidden" name="URL" value="ResetPasswordForm" id="WC_PasswordResetForm_FormInput_URL_In_ResetPasswordForm_1"/>
										<input type="hidden" name="errorViewName" value="ResetPasswordErrorView" id="WC_PasswordResetForm_FormInput_errorViewName_In_ResetPasswordForm_1"/>
										<input type="hidden" name="authToken" value="${authToken}"  id="WC_PasswordResetForm_FormInput_authToken_In_ResetPasswordForm_1"/>
										<div class="form col s12" id="WC_UserRegistrationAddForm_div_3">
											<c:set var="msg" value=""/>
											<c:set var="styl" value=""/>
											<c:if test="${!empty errorMessage }">
												<c:set var="msg" value="${errorMessage}"/>
												<c:set var="styl" value="display:none;"/>
											</c:if>
											<div id="errorMessage" style="${styl}">
												<span class="error">${msg}</span>
											</div>
											<div class="content" id="WC_ResetPasswordForm_div_6">
												<div class="align" id="WC_UserRegistrationAddForm_div_7">
													<div id="WC_UserRegistrationAddForm_div_8" >
										
														<div id="EmailLogonContainer">
															<div class="col s8 leftResetContainer">
																<input type="email" placeholder="<fmt:message bundle="${storeText}" key="loginFieldlabel" />" class="resetInputText" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" <c:out value="${aria_invalid}"/> aria-required="true" aria-describedby="error_msg"  maxlength="100" required name="logonId" id="WC_PasswordResetForm_FormInput_logonId_In_ResetPasswordForm_1"/>
															</div>
															<div class="col s4 rightResetContainer">
																<input type="submit" value='<fmt:message bundle="${storeText}" key="forgottenPasswordFormSubmitLabel"/>' class="hide-on-small-only button button-primary resetButton">
																<input type="submit" value='OK' class="hide-on-med-and-up button button-primary resetButton">
															</div>
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

<div dojoType="lapeyre/widget/Dialog" id="popinForgottenPassword" title="<fmt:message key="forgottenPasswordConfirmationPopinTitle" bundle="${storeText}" />">
	<div class="widget_site_popup">
		<div class="content">
			<div class="header">
				<span><span><fmt:message key="forgottenPasswordConfirmationPopinTitle" bundle="${storeText}" /></span></span>
				<a class="close" href="javascript:void(0);" onclick="dijit.byId('popinForgottenPassword').hide();" title="<fmt:message key="CLOSE" bundle="${storeText}" />"></a>
				<div class="clear_float"></div>
			</div>
			<div class="body">
				<fmt:message key="forgottenPasswordConfirmationMessage" bundle="${storeText}" />
			</div>
			<div class="footer">
				<div class="ctaContainer">
					<a class="button green" href="javascript:void(0);" onclick="dijit.byId('popinForgottenPassword').hide();" title="OK"><fmt:message key="forgottenPasswordConfirmationPopinOk" bundle="${storeText}" /></a>
				</div>
			</div>
			<div class="clear_float"></div>
		</div>
	</div>
</div>

<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
<%@ include file="../../../Common/JSPFExtToInclude.jspf"%>
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="espaceClient" />
		<c:param name="pageName" value="resetPassword" />
	</c:import>
 </body>
</html>
<!-- END PasswordResetForm.jsp -->
