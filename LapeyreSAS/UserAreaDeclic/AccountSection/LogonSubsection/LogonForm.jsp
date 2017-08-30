<wcf:url var="ForgotPassUrl" value="ResetPasswordForm">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<script type="text/javascript">
	function connecter(){
		$('#WC_AccountDisplay_FormInput_logonId_In_Logon_1').val($('#connectLogin').val());
		$('#WC_AccountDisplay_FormInput_logonPassword_In_Logon_1').val($('#connectPassword').val());
		soumettre('LogonControlForm','Logon');
	}
	
	function create(){
		 var $this = $(this);
 		if(!submitRequest()) {
			return false;
 		}
 		soumettre('CreateControlForm','RedirectView?URL=${UserRegistrationFormUrl}')
	}

	function soumettre(controlForm, action){
		var myForm = $("#"+controlForm);
		var logonForm = $('#Logon');
		var resp = $(myForm).valid();
		if(resp){
			logonForm.attr('action', action);
			setDeleteCartCookie();
			logonForm.submit();
		}
	}
	
	function addParamEmail(param){
		var oldUrl = param.href;
		var email = encodeURIComponent($("#connectLogin").val());
		param.href = oldUrl+"&email="+email;
		
		return true;
	}
</script>
<%-- <div id="socialMediaConnect" class="row">
	<div class="content col s12">		
			<div class="col s12">
				<h3 class="col s12"><fmt:message bundle="${storeText}" key="identificationPageHeaderLabel"/></h3>
				<p class="shortDesc col s12"><fmt:message bundle="${storeText}" key="identificationPageHeaderShortDescLabel"/></p>
			</div>
			
			<div class="col s6 m4 offset-m2">
				<div id="facebookConnect" class="button button-primary col s12 socialMediaConnectButton">
					<span class="socialNetworkLogo facebookLogo"></span><span><fmt:message bundle="${storeText}" key="identificationPageFacebookLabel"/></span>
				</div>
			</div>
			<div class="col s6 m4">
				<div id="googlePlusConnect" class="button button-primary col s12 socialMediaConnectButton">
					<span class="socialNetworkLogo googleLogo"></span><span><fmt:message bundle="${storeText}" key="identificationPageGoogleLabel"/></span>
				</div>
			</div>
	</div>
</div>

<div class="line-separator row">
	<span class="line-separator-text"><fmt:message bundle="${storeText}" key="identificationPageSeparatorLabel"/></span>
</div> --%>

<div class="form row" id="WC_UserRegistrationAddForm_div_3">

	<c:if test="${!empty errorMessage }">
		<div class="error">
			<span  class="error">${errorMessage}</span>
		</div>
	</c:if>
	
	<div class="content" id="WC_UserRegistrationAddForm_div_6">
			<div class="col s12 m6" id="panel-container-left-registration">
				<div class="col s12" id="userConnection">
					<h3 class="col s12"><fmt:message bundle="${storeText}" key="identificationPageDejaClientFieldTitle"/><div class="picto plusPicto hide-on-med-and-up"></div></h3>
					<form class="row" name="LogonControlForm" id="LogonControlForm">
						<div class="formContainer">
						<%-- <p class="shortDesc"><fmt:message bundle="${storeText}" key="identificationPageDejaClientDescription"/></p> --%>
							<div class="col s12 form-group">
								<div class="column_label">
									<label for="connectLogin"><fmt:message bundle="${storeText}" key="loginFieldlabel" /></label>
								</div>
								<c:set var="escapeLogin"><c:out value="${WCParam.logonId}"/></c:set>
								<input placeholder="<fmt:message bundle="${storeText}" key="identificationPagePlaceHolderMail"/>" class="input-text" type="email" size="40" maxlength="100" aria-required="true" id="connectLogin" name="connectLogin" value="${escapeLogin}" required="" onkeypress="if(event.keyCode==13){ javascript:setDeleteCartCookie(); $('#Logon').submit(); return false;}" />
							</div>
							<div class="col s12 form-group" id="Password">
								<div class="column_label">
									<label for="connectPassword"><fmt:message bundle="${storeText}" key="passwordFieldLabel" /></label>
								</div>
								<input class="input-text" size="35" maxlength="100" aria-required="true" name="connectPassword" id="connectPassword" type="password" required="true" onkeypress="if(event.keyCode==13){ connecter(); return false;}" /></p>
								<div class="right forgottenPwd"><a onclick="addParamEmail(this)" href="${ForgotPassUrl}"><fmt:message bundle="${storeText}" key="forgottenPasswordLinkLabel"/></a></div>
							</div>
							<div class="col s12 m8">
								<input id="SubmitButton" type="button" class="button button-primary submit-button" value="<fmt:message bundle="${storeText}" key="identificationPageSubmitLabel"/>" onclick="javascript:connecter();" />
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col s12 m6 panel-container-right" id="panel-container-right-registration">
				<div class="col s12" id="userCeation">
					<h3 class="col s12"><fmt:message bundle="${storeText}" key="identificationPageCreateAccountTitle"/><div class="picto plusPicto hide-on-med-and-up"></div></h3>
					<form name="CreateControlForm" id="CreateControlForm" class="row">
						<div class="formContainer">
							<p class="shortDesc col s12"><fmt:message bundle="${storeText}" key="identificationPageCreateAccountDescription"/></p>
							<div class="col s12 m8">
								<input id="SubmitButton" type="button" class="button button-primary submit-button" value="<fmt:message bundle="${storeText}" key="identificationPageCreateAccountLabel"/>" onclick="create();"/>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>

		<%--
		<div class="clearAll"></div>
		<div class="sep"></div>
		<span class="synchroSectionTitle"><fmt:message bundle="${storeText}" key="identificationPageSynchroBlockTitle"/></span>
		<p class="synchroSectionSubtitle"><fmt:message bundle="${storeText}" key="identificationPageSynchroBIockIntroMessage"/></p>
		<div class="button_footer_line no_float">
			<input id="SynchroSubmit" type="submit" class="button green" value="<fmt:message bundle="${storeText}" key="identificationFormSynchroSubmitLabel"/>" />
		</div>
		 --%>
	
</div>


<script type="text/javascript">
	$(document).ready(function() {
		    gotoSynchroForm = $('#GoToSynchroForm');
		    var logonForm = $('#Logon');
			logonForm.find('#SynchroSubmit').on('click', function(e) {
					var logonId = logonForm.find('input[name=logonId]').val();
					gotoSynchroForm.find('input[name=logonId]').val(logonId);
					gotoSynchroForm.submit();
					return false;
			});
			
			/* If on mobile, we need to set a slider to show or hide the forms */
			$("#WC_UserRegistrationAddForm_div_6 h3").on("click", function(){
				if(viewport().width < tabletBreakpoint) {
					var picto = $(".picto", $(this));
					if(picto != null && picto[0] != null){
						if(picto[0].className.search("plusPicto") != -1){
							picto.addClass("minusPicto").removeClass("plusPicto");
						} else {
							picto.addClass("plusPicto").removeClass("minusPicto");
						}
						
						var form = $(this).parent().find(".formContainer");
						form.slideToggle();
					}
				}
			});
	});
</script>