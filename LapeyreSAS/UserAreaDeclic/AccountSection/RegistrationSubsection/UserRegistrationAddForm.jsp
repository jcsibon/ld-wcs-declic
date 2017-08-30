<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>

<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/RNVPErrorMessageSetup.jspf"%>

<c:set var="country" value="${CommandContext.country}" scope="request" />

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="REGISTER_TITLE" /></title>
<META NAME="robots" CONTENT="noindex,nofollow" />

<%@ include file="../../../Common/CommonJSToInclude_redesign.jspf"%>
<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>

<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/logon/logonDisplay.css?${versionNumber}" type="text/css" />

<script>
	var is_Pro = false;
</script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/additional-methods.js?${versionNumber}"></script>
<script type="text/javascript" src="${jspStoreImgDir}UserAreaDeclic/javascript/RNVPService.js?${versionNumber}"></script>

<wcf:url var="cityByZipURL" value="GetCityByZipRNVP" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<wcf:url var="cityByZipLightURL" value="GetCityByZipRNVP" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<wcf:url var="zipByCityURL" value="GetZipByCityRNVP" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>
<c:set var="hideConnectPopup" value="true" scope="request" />
<script>


	var countryTagID = "countryField";
	
	$().ready(function() {
		var oldCodePostale = null;
		RNVPService.initLight('<c:out value="${cityByZipURL}" escapeXml="false"/>','<c:out value="${cityByZipLightURL}" escapeXml="false"/>','<c:out value="${zipByCityURL}" escapeXml="false"/>');
		RNVPService.elementZip = document.Register.zipCode;
		RNVPService.elementCity = document.Register.city;
		RNVPService.onblurCity(document.Register.city,oldCodePostale);
		RNVPService.onblurZip(document.Register.zipCode);
		
		RNVPService.elementCityHidden = document.Register.cityHidden;
		RNVPService.elementZipLight = document.Register.zipCodeLight; 
		if(document.Register.zipCodeLight !== undefined){
			RNVPService.onblurZipLight(document.Register.zipCodeLight);
		}
		
		RNVPService.elementStreet = document.Register.address1;
		RNVPService.elementCitySelector = document.getElementById('citySelector');
		RNVPService.elementZipSelector = document.getElementById('zipCodeSelector');
		RNVPService.elementStreetSelector = document.getElementById('streetSelector');
		
		RNVPService.elementCityHiddenSelector = document.getElementById('cityHiddenSelector');
		
		RNVPService.onchangedCitySelector(RNVPService.elementCitySelector);
		RNVPService.onchangedStreetSelector(RNVPService.elementStreetSelector);
		RNVPService.onchangedZipSelector(RNVPService.elementZipSelector);

		RNVPService.addErrorMessage(1000,document.Register.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1001,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1002,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		
		
		RNVPService.addErrorMessage(1002,document.Register.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1003,document.Register.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1007,document.Register.city,"<fmt:message key='missingCityErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1007,document.Register.zipCode,"<fmt:message key='missingZipcodeErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1009,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1010,document.Register.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1010,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1010,document.Register.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1024,document.Register.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1024,document.Register.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1024,document.Register.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1024,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1024,document.Register.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1025,document.Register.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1025,document.Register.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1025,document.Register.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1025,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1025,document.Register.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1026,document.Register.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1026,document.Register.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1026,document.Register.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1026,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1026,document.Register.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1030,document.Register.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1050,document.Register.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1050,document.Register.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1050,document.Register.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1050,document.Register.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(1050,document.Register.address1,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");

		RNVPService.addErrorMessage(1051,document.Register.zipCodeLight,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(9991,document.Register.zipCode,"<fmt:message key='selectZipcodeErrorMessage' bundle='${storeText}' />");
		RNVPService.addErrorMessage(9992,document.Register.city,"<fmt:message key='selectCityErrorMessage' bundle='${storeText}' />");
		
		$("#city").focus(function(){
			oldCodePostale = $("#zipCode").val();
			RNVPService.onblurCity(document.Register.city,oldCodePostale);
			RNVPService.onchangedZipSelector(RNVPService.elementZipSelector);
		}); 

		<c:if test="${!empty rnvpErrorCode}" >
			RNVPService.showErrorByCode('<c:out value="${rnvpErrorCode}" />');		
		</c:if>
		<c:if test="${rnvpIsBreak eq 'true'}" >
			var choices = <c:out value='${rnvpChoices}' escapeXml="false" />;
			<c:if test="${rnvpIsCitySelection eq 'true'}" >
				RNVPService.showCitySelection(choices);
				showErrorMessageForElement(document.Register.city,"<fmt:message key='selectCityErrorMessage' bundle='${storeText}' />");
			</c:if>
			<c:if test="${rnvpIsStreetSelection eq 'true'}" >
				RNVPService.showStreetSelection(choices);
				showErrorMessageForElement(document.Register.address1,"<fmt:message key='selectStreetErrorMessage' bundle='${storeText}' />");
			</c:if>	
		</c:if>
		<c:if test="${!empty WCParam.personTitle}" >
			document.Register.personTitle.value = ${ecocea:quote(ecocea:escapeJS(WCParam.personTitle))};
		</c:if>
		<c:if test="${!empty WCParam.address3}" >
			document.Register.address3.value = ${ecocea:quote(ecocea:escapeJS(WCParam.address3))};
		</c:if>
		<c:if test="${!empty WCParam.country}" >
			document.Register.country.value = ${ecocea:quote(ecocea:escapeJS(WCParam.country))};
			var countryLabel = $('#countryField').find('option[value^="'+document.Register.country.value+'"]').html();
			if(countryLabel !== undefined) {
				document.Register.countryInputField.value = countryLabel.trim();
			}
		</c:if>
		<c:if test="${!empty WCParam.isPro && WCParam.isPro eq 'true'}" >			
			<c:if test="${!empty WCParam.demographicField5}" >
				var siret = ${ecocea:quote(ecocea:escapeJS(WCParam.demographicField5))};
				document.Register.siret[0].value = siret.substring(0,3);
				document.Register.siret[1].value = siret.substring(3,6);
				document.Register.siret[2].value = siret.substring(6,9);
				document.Register.siret[3].value = siret.substring(9);
				document.Register.demographicField5.value = siret;
			</c:if>
			<c:if test="${!empty WCParam.demographicField7}" >
				document.Register.demographicField7.value = ${ecocea:quote(ecocea:escapeJS(WCParam.demographicField7))};
				<fmt:message bundle="${storeListe}" key="Activite_${WCParam.demographicField7}" var="activitePrincipale"/>
				document.Register.demographicField7Label.value = ${ecocea:quote(ecocea:escapeJS(activitePrincipale))};
			</c:if>
		</c:if>
		// validate signup form on keyup and submit 
		$("#Register").validate({
			rules : {
				personTitle : {
					required: true,
				},
				legalEntity : {
					required: true,
				},
				zipCode : {
					required : true,
					maxlength : {
						param : $("#countryField :selected")[0].value == 'FR' ? 5 : 20,
						depends : function(element) {
			    			return $("#countryField :selected")[0].value == 'FR';
						}
					},
					minlength : { 
						param : 4,
						depends : function(element) {
				    		return $("#countryField :selected")[0].value == 'FR';
						}
					},
					number : { 
						depends : function(element) {
				    		return $("#countryField :selected")[0].value == 'FR';
						}
					}
				},
				zipCodeLight : {
					required : true,
					maxlength : {
						param : $("#countryField :selected")[0].value == 'FR' ? 5 : 20,
						depends : function(element) {
			    			return $("#countryField :selected")[0].value == 'FR';
						}
					},
					minlength : { 
						param : 4,
						depends : function(element) {
				    		return $("#countryField :selected")[0].value == 'FR';
						}
					},
					number : { 
						depends : function(element) {
				    		return $("#countryField :selected")[0].value == 'FR';
						}
					}
				},
				city : {
					required : true,
					maxlength : 100
				},
				firstName : {
					required : true,
					maxlength : 60
				},
				lastName : {
					required : true,
					maxlength : 40
				},
				address1 : {
					required : true,
					maxlength : 38
				},
				address2 : {
					maxlength : 38
				},
				address3 : {
					required : true
				},
				email1 : {
					required : true,
					email : true,
					maxlength : 100
				},
				phoneNumber : {
					maxlength : 10,
					required : true,
					validatePhoneFR : [ countryTagID ]
				},
				logonPassword : {
					required : true,
					passwordTest : true,
					maxlength : 100,
					minlength : 6,
				},
				logonPasswordVerify : {
					required : true,
					equalTo : "#logonPassword"
				},
				organizationName : {
					required : true,
					maxlength : 40
				},
				demographicField7 : {
					required : true,
					isNaf : true
				},
				siret : {
					require_from_group : [4,".siretNum" ],
					checkLuhnKey : ".siretNum"
				}
			},
			messages : {
				personTitle : "<fmt:message bundle='${storeText}' key='missingPersontitleErrorMessage' />",
				legalEntity : "<fmt:message bundle='${storeText}' key='missingLegalEntityErrorMessage' />",
				firstName : {
					required : "<fmt:message bundle='${storeText}' key='missingFirstnameFieldErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthFirstnameFieldErrorMessage' />"
				},
				lastName : {
					required : "<fmt:message bundle='${storeText}' key='missingLastameFieldErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthLastnameFieldErrorMessage' />"
				},
				email1 : {
					required : "<fmt:message bundle='${storeText}' key='missingLoginErrorMessage' />",
					email : "<fmt:message bundle='${storeText}' key='InvalidLoginErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthLoginErrorMessage' />"
				},
				zipCode : {
					required : "<fmt:message bundle='${storeText}' key='missingZipCodeMessage' />",
					minlength : "<fmt:message bundle='${storeText}' key='minLengthZipCodeMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthZipCodeMessage' />",
					number : "<fmt:message bundle='${storeText}' key='nonNumericErrorMessage' />"
				},
				zipCodeLight : {
					required : "<fmt:message bundle='${storeText}' key='missingZipCodeMessage' />",
					minlength : "<fmt:message bundle='${storeText}' key='minLengthZipCodeMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthZipCodeMessage' />",
					number : "<fmt:message bundle='${storeText}' key='nonNumericErrorMessage' />"
				},
				address1 : {
					required : "<fmt:message bundle='${storeText}' key='missingStreetErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthStreetErrorMessage' />"
				},
				address2 : {
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthBatErrorMessage' />"
				},
				address3 : {
					required : "<fmt:message bundle='${storeText}' key='missingFloorErrorMessage' />"
				},
				city : {
					required : "<fmt:message bundle='${storeText}' key='missingCityErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthCityErrorMessage' />"
				},
				phoneNumber : {
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthPhoneNumberMessage' />",
					required : "<fmt:message bundle='${storeText}' key='missingPhoneNumberMessage' />",
					validatePhoneFR : "<fmt:message bundle='${storeText}' key='InvalidPhoneFormatErrorMessage' />"
				},
				logonPassword : {
					required : "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />",
					passwordTest : "<fmt:message bundle='${storeText}' key='InvalidPasswordErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxlengthPasswordErrorMessage' />",
					minlength : "<fmt:message bundle='${storeText}' key='minlengthPasswordErrorMessage' />"
				},
				logonPasswordVerify : {
					required : "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />",
					equalTo : "<fmt:message bundle='${storeText}' key='invalidConfirmPasswordErrorMessage' />"
				},
				organizationName : {
					required : "<fmt:message bundle='${storeText}' key='missingRaisonSocialeErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthraisonSocialeErrorMessage' />"
				},
				demographicField7 : {
					required : "<fmt:message bundle='${storeText}' key='missingCodeAPEErrorMessage' />",
					isNaf : "<fmt:message bundle='${storeText}' key='InvalidCodeNafErrorMessage' />"
				},
				siret : {
					require_from_group : "<fmt:message bundle='${storeText}' key='missingSiretErrorMessage' />",
					checkLuhnKey : "<fmt:message bundle='${storeText}' key='InvalidSiretErrorMessage' />"
				}
			},
			errorPlacement : function(error, element) {
				if (element.is("select")) {
					//For select inputs, insert at the parent
					error.insertAfter(element.parent());
				} else if (element.attr("type") == "radio") {
					//for radio button, insert at the end of the grandparent 
					error.appendTo(element.parent().parent().parent());
				} else {
					error.insertAfter(element);
				}
			},
			submitHandler : function(form) {
				if(isPro()){
					form.legalEntityLabel.value = $('#legalEntity :selected').text().trim();
					form.demographicField5.value = concateName("siret");
					form.isPro.value = 'true';
				} else {
					<c:choose>
					<c:when test="${!empty WCParam.isLightSubscription && (WCParam.isLightSubscription eq 'light' || WCParam.isLightSubscription eq 'lightPhone') }">
					form.address1.value = 'defaultStreet';
					form.address2.value = '';
					form.address3.value = '0';
					form.zipCode.value = form.zipCodeLight.value;
					if(RNVPService.elementCityHidden.value == "")
					{
						form.cityHidden.value = 'defaultCity';
						form.city.value = 'defaultCity';
					}
					else
					{
						form.cityHidden.value = RNVPService.elementCityHidden.value;
						form.city.value = RNVPService.elementCityHidden.value;
					}
					form.country.value = 'FR';
					</c:when>
					</c:choose>
					form.legalEntityLabel.value = '';
					form.demographicField5.value = '';
					form.isPro.value = 'false';
				}
				form.logonId.value = form.email1.value;
				clientSearchAndSubmit(form);
			}
		});
	});

	$(document).ready(function() {
		if($("input[name='isPro']").val() !== undefined) {
			is_Pro = ($("input[name='isPro']").val() === 'true');
		}
		
		$('#demographicField7').on('change', function() {
			var code = $(this).val(),
			    label = $('#demographicField7LabelList option[data-code-APE=' + code +']').val();
			$('#demographicField7Label').val(label);
		});
		
		/* Set the switch part/pro tab onLoad */
		toggleProPart();
		
		/* Set the switch part/pro tab on click */
		$('#registration-tab-header > div').on('click', function() {
			$('#registration-tab-header > div').removeClass("enabled");
			$('#registration-tab-header > div').addClass("disabled");
			
			$(this).removeClass("disabled");
			$(this).addClass("enabled");
			
			if(this.id === "pro-title") {
				$('.forPro').show();
				$('.forPart').hide();
			} else {
				$('.forPro').hide();
				$('.forPart').show();
			}
		});
		

		
	});
	
</script>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

</head>

<wcf:url var="NewUserDisplayUrl" value="NewUserDisplay">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="syncRequestByUser" value="false" />
	<wcf:param name="returnPage" value="${WCParam.returnPage}" />
</wcf:url>

<c:choose>
	<%--Si on vient du tunnel on redirige vers le tunnel apres login --%>
	<c:when test="${WCParam.returnPage eq 'Tunnel'}">
		<wcf:url var="tunnelShippingLink" value="TunnelCommandAddressValidation">
			<wcf:param name="storeId"   value="${WCParam.storeId}"  />
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="langId" value="${WCParam.langId}" />
		</wcf:url>
		<c:set var="returnURL" value="${tunnelShippingLink}"/>
	</c:when>
	<c:when test="${!empty WCParam.URL || !empty param.URL}">
		<c:set var="returnURL" value="${!empty WCParam.URL ? WCParam.URL : param.URL }"/>
	</c:when>
	<c:when test="${!empty WCParam.returnURL || !empty param.returnURL}">
		<c:set var="returnURL" value="${!empty WCParam.returnURL ? WCParam.returnURL : param.returnURL }"/>
	</c:when>
	<c:otherwise>
		<c:set var="returnURL" value="${NewUserDisplayUrl}"/>
	</c:otherwise>
</c:choose>

<wcf:url var="LogonUrl" value="LogonForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="returnURL" value="${returnURL}" />
	<wcf:param name="returnPage" value="${WCParam.returnPage}" />
</wcf:url>

<wcf:url var="UserRegistrationAddURL" value="UserRegistrationAdd">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="returnURL" value="${returnURL}" />
	<wcf:param name="returnPage" value="${WCParam.returnPage}" />
</wcf:url>

<wcf:url var="SynchroUrl" value="UserSynchronisationForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="returnURL" value="${returnURL}" />
	<wcf:param name="returnPage" value="${WCParam.returnPage}" />
</wcf:url>

<!-- BEGIN UserRegistrationAddForm.jsp -->
<div id="page" class="registrationPage">

	<%--
		  ***
		  * If an error occurs, the page will refresh and the entry fields will be pre-filled with the previously entered value.
		  * The entry fields below use e.g. paramSource.logonId to get the previously entered value.
		  * In this case, the paramSource is set to WCParam.  
		  ***
		--%>
	<c:set var="paramSource" value="${WCParam}" />
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
		<wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
	<%
	    out.flush();
	%>
	<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp">
			<c:param name="loadHeaderLight" value="${(WCParam.returnPage eq 'Tunnel' && !isOnMobileDevice) ? true:false}"></c:param>
	</c:import>
		<c:if test="${WCParam.returnPage eq 'Tunnel' }">
			<script>
				dojo.addOnLoad(function() {
					var cookieCartOrderId = getCookie('WC_CartOrderId_${storeId}');
					if(cookieCartOrderId != null) {
						var cookieOrderTotal = getCookie('WC_CartTotal_' + cookieCartOrderId);
						if(cookieOrderTotal != null) {
							var orderQuantity = cookieOrderTotal.split(';')[0];
							var ordQtyHeaderLight = document.getElementById('minishopcart_total_headerLight');
							if(ordQtyHeaderLight != null) {
								ordQtyHeaderLight.innerHTML = orderQuantity;
							}
						}
					}
					
				});
				
				$( document ).ready(function() {
					/* To delete after redesign */
					$('body, html').css('margin', '0 auto 0 auto');
					$('#content').css('background', 'none');
					$('#fullBackground').css('background', 'none');
					$('#page').css('background', 'none');
				});
				
			</script>
		</c:if>
	<%
	    out.flush();
	%>

	<div id="contentWrapper">
		<div id="content" role="main">
			<div class="rowContainer registrationForm">
				<c:choose>
					<c:when test="${WCParam.returnPage eq 'Tunnel'}">
	                    <c:set var="tunnelStep" value="2"/>
	                    <%@ include file="../../../ShoppingArea/ShopcartSection/TunnelShopCartHeader_UI.jspf" %>
					</c:when>
					<c:otherwise>
						<div id="first-slot"  class="row">
							<div data-slot-id="1" class="col s12 slot1 hide-on-small-only">
								<%out.flush();%>
								<fmt:message var="lastBreadCrumbItem" key="InscriptionBreadcrumbLabel" bundle="${widgetText}" />
								<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
									<c:param name="pageName" value="CompteClient" />
									<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
								</c:import>
								<%out.flush();%>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
				
				<div class="row">
					<div class="sign_in_registration col l8 offset-l2 <c:if test="${WCParam.returnPage eq 'Tunnel'}">intunnel</c:if>">
						<div class="row">
							<h1 class="col s12 form-title"><fmt:message bundle="${storeText}" key="inscriptionPageTitle" /></h1>
							<c:if test="${userType == 'G'}">
								<div class="col s12 subtitle">
									<p>
										<fmt:message bundle="${storeText}" key="inscriptionPageIdentificationBlockMessage" />
										<a href="${LogonUrl}">
											<fmt:message bundle="${storeText}" key="inscriptionPageIdentificationBlockLinkLabel" />
										</a>
									</p>
								</div>
							</c:if>
						</div>
						
						<form name="Register" method="post" action="${UserRegistrationAddURL}" id="Register">
							<input type="hidden" name="isLightSubscription" value="${WCParam.isLightSubscription}" />
							
							<input type="hidden" name="myAcctMain" value="1" autocomplete="off" />
							<input type="hidden" name="idCRM" value="" />
							<input type="hidden" name="sync" value="false" />
							<input type="hidden" name="syncRequestbyUser" value="false" />
							<input type="hidden" name="legalEntityLabel" value="" />
							<input type="hidden" name="demographicField5" value="${WCParam.demographicField5}" />
							<input type="hidden" name="isPro" value="${WCParam.isPro}" />
							<input type="hidden" name="logonId" value="${WCParam.logonId}" />
							<input type="hidden" name="new" value="Y" id="new" autocomplete="off" />
							<input type="hidden" name="storeId" value="10101" id="storeId" autocomplete="off" />
							<input type="hidden" name="catalogId" value="10151" id="catalogId" autocomplete="off" />
							<input type="hidden" name="langId" value="-1" id="langId" autocomplete="off" />
							<input type="hidden" name="errorViewName" value="UserRegistrationAddFormView" id="errorViewName" autocomplete="off" />
							<input type="hidden" name="profileType" value="C" id="profileType" autocomplete="off" />
							<input type="hidden" name="challengeQuestion" value="-" id="challengeQuestion" autocomplete="off" />
							<input type="hidden" name="challengeAnswer" value="-" id="challengeAnswer" autocomplete="off" />
							<input type="hidden" name="returnPage" value="<c:out value="${WCParam.returnPage}"/>" id="returnPage" />
							<input type="hidden" name="URL" value="${returnURL}" id="URL" autocomplete="off" />
								
							<div class="form-registration">
							
								<c:if test="${!empty errorMessage && empty rnvpErrorCode && rnvpIsBreak eq 'false'}">
									<div class="error">
										<span class="error">${errorMessage}</span>
									</div>
								</c:if>
								<div id="registration-tab-header">
									<div id="part-title">
										<fmt:message bundle="${storeText}" key="registrationTabPartLabel" />
									</div>
									<div id="pro-title">
										<fmt:message bundle="${storeText}" key="registrationTabProLabel" />
										<div class="ribbon">
											<span><fmt:message bundle="${storeText}" key="registrationTabProRibbonLabel" /></span>
										</div>
									</div>
								</div>
								<div class="content">										
									<div class="form-body"></div>
										<div class="forPart">
											<div class="row form-row">
												<%-- Begin Civilité --%>								
												<div id="CiviliteContainer" class="col s12 m12">
													<div class="column_label" id="CiviliteLabel">
														<span class="spanacce">
															<label for="personTitle">
																<fmt:message bundle="${storeText}" key="addressCiviliteFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="addressCiviliteFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													
													<div id="radioButtonsCivilite">
														<c:forTokens items="${listCivilitePart}" delims="," var="token">
															<label class="radioButtonContainer" for="personTitle_${token}"> 		
																<input type="radio" class="radio-big" <c:if test="${token == 1}">required</c:if> name="personTitle" id="personTitle_${token}" value="${token}" />		
																<fmt:message bundle="${storeListe}" key="Civilite_${token}" />
															</label> 
														</c:forTokens>
													</div>		
													
												</div>		
											</div>	
											<%-- End Civilité --%>
															
											<div class="row form-row">
												<%-- Begin Prénom --%>
												<div class="col s12 m6" id="FirstNameContainer">
													<div id="FirstNameLabel" class="column_label">
														<span class="spanacce">
															<label for="firstName">
																<fmt:message bundle="${storeText}" key="addressFirstnameFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="addressFirstnameFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<input class="input-text" type="text" maxlength="60" size="20" id="firstName" name="firstName" value="${WCParam.firstName}" required />
												</div>
												<%-- End  Prénom --%>
											
												<%-- Begin Nom --%>
												<div class="col s12 m6" id="LastNameContainer">
													<div id="LastNameLabel" class="column_label">
														<span class="spanacce">
															<label for="lastName">
																<fmt:message bundle="${storeText}" key="addressLastnameFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="addressLastnameFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<input class="input-text" type="text" maxlength="40" size="35" aria-required="true" id="lastName" name="lastName" value="${WCParam.lastName}" required />
												</div>
												<%-- End Nom --%>
											</div>
											
											<c:choose>
												<c:when test="${!empty WCParam.isLightSubscription && (WCParam.isLightSubscription eq 'light' || WCParam.isLightSubscription eq 'lightPhone')}">					
													<div class="row form-row">
														<!-- Code postal -->
														<div class="col s8 m6" id="ZipCodeContainer">
															<div id="ZipCodeLabel" class="column_label">
																<span class="spanacce">
																	<label for="zipCodeLight">
																		<fmt:message bundle="${storeText}" key="addressZipcodeFieldLabel" />
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="addressZipcodeFieldLabel" />
																<span class="required-field"> *</span>
															</div>													
															<input class="input-text" type="text" maxlength="20" size="10" aria-required="true" id="zipCodeLight" name="zipCodeLight" value="${WCParam.zipCode}" required />
															<img src="/wcsstore/LapeyreSAS/images/loading.gif" width="20" height="20" class="loading" style="display: none"/>
														</div>
																	
														<!-- Pays -->
														<wcbase:useBean id="countryBeanList" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
				                                        	<c:set target="${countryBeanList}" property="countryCode" value="${country}" />
				                                        </wcbase:useBean>
				                                                    
			                                            <div class="col s12 m6" id="Contact_Country_Container">
			                                                <div id="Contact_Country_Label" class="column_label">
			                                                    <fmt:message bundle="${widgetText}" key="CONTACT_COUNTRY" />
			                                                    <span class="required-field" id="Contact_Country_Required">*</span>
			                                                </div>
			                                                <c:set var="countrySelectedDisplay" value="" />
			                                                <div id="countryDiv">
			                                                    <select class="select-dropdown dropDownCountry" aria-required="true" id="countryField" name="country" required onchange="document.RegisterUpdate.mobilePhone1Country.value=document.RegisterUpdate.country.value">
			                                                        <c:forEach var="countryItem" items="${countryBeanList.countries}">
			                                                            <option value="<c:out value="${countryItem.code}"/>"
			                                                                <c:if test="${countryItem.code eq country || countryItem.displayName eq contact_country}">
			                                                            selected="selected"
			                                                            <c:set var="countrySelectedDisplay" value="${countryItem.displayName}" />
			                                                        </c:if>>
			                                                                <c:out value="${countryItem.displayName}" />
			                                                            </option>
			                                                        </c:forEach>
			                                                    </select>
			                                                </div>
				                                        </div>
				                                    </div>
		                                    	</c:when>
		                                    </c:choose>
		                                    
		                                </div>
											
										<div class="forPro" style="display: none;">
											<div class="row form-row">
												<%-- Entité juridique --%>
												<div class="col s12 m6" id="LegalEntityContainer">
													<div class="column_label" id="LegalEntityLabel">
														<span class="spanacce">
															<label for="legalEntity">
																<fmt:message bundle="${storeText}" key="addressLegalEntityFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="addressLegalEntityFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<div>
														<select class="select-dropdown" name="legalEntity" id="legalEntity" value="${WCParam.legalEntity}" required>
															<option value="">-</option>
															<c:set var="entityOptionValue" value="${empty WCParam.legalEntity ? '-1' : WCParam.legalEntity}" />
	
															<c:forTokens items="${listCivilitePro}" delims="," var="token">
																<c:set var="entityOptionSelected" value="${token eq entityOptionValue ? 'selected' : ''}"/>
																<option value="<c:out value='${token}'/>" ${entityOptionSelected}>
																	<fmt:message bundle="${storeListe}" key="Civilite_${token}" />
																</option>
															</c:forTokens>
														</select>
													</div>
												</div>
												
												<%-- Raison sociale --%>
												<div class="col s12 m6" id="BusinessNameContainer">
													<div class="column_label" id="BusinessNameLabel">
														<span class="spanacce">
															<label for="organizationName">
																<fmt:message bundle="${storeText}" key="raisonSocialeFieldLabel" /> 
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="raisonSocialeFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<input class="input-text" size="25" maxlength="40" aria-required="true" name="organizationName" id="organizationName" type="text" value="${WCParam.organizationName}" required />
												</div>
											</div>
										</div>
											
										<div class="row form-row">
											<%-- Begin email --%>
											<div class="col s12 m6" id="EmailLogonLabel">
												<div class="column_label">
													<span class="spanacce">
														<label for="email1">
															<fmt:message bundle="${storeText}" key="loginFieldlabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="loginFieldlabel" />
													<span class="required-field"> *</span>
												</div>
												<input class="input-text" type="email" size="40" maxlength="100" aria-required="true" name="email1" id="email1" value="${not empty WCParam.logonId ? WCParam.logonId : WCParam.email1}" required />
											</div>
											<%-- End email --%>
										</div>
											
										<div class="row form-row">
											<%-- Mot de passe --%>
											<div class="col s12 m6" id="PasswordContainer">
												<div class="column_label" id="PasswordLabel">
													<span class="spanacce">
														<label for="logonPassword">
															<fmt:message bundle="${storeText}" key="passwordFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="passwordFieldLabel" />
													<span class="required-field"> *</span>
												</div>
												<input class="input-text" size="35" maxlength="100" aria-required="true" name="logonPassword" id="logonPassword" type="password" value="" required />
											</div>
											<div class="gutter mobile-hidden"></div>
											
											<%-- Confirmation mot de passe --%>
											<div class="col s12 m6" id="ConfirmPasswordContainer">
												<div class="column_label" id="ConfirmPasswordLabel">
													<span class="spanacce">
														<label for="logonPasswordVerify">
															<fmt:message bundle="${storeText}" key="confirmPasswordFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="confirmPasswordFieldLabel" />
													<span class="required-field"> *</span>
												</div>
												<input class="input-text" size="35" maxlength="100" aria-required="true" name="logonPasswordVerify" id="logonPasswordVerify" type="password" value="" required />
											</div>
										</div>
										
										<c:choose>
											<c:when test="${!empty WCParam.isLightSubscription && (WCParam.isLightSubscription eq 'light' || WCParam.isLightSubscription eq 'lightPhone')}">
											<div class="forPro">
											</c:when>
										</c:choose>										

										<div class="row form-row">
											<%-- Addresse 1 --%>
											<div class="col s12 m6" id="Address1Container">
												<div id="Address1Label" class="column_label">
													<span class="spanacce">
														<label for="address1">
															<fmt:message bundle="${storeText}" key="addressStreetFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="addressStreetFieldLabel" />
													<span class="required-field"> *</span>
												</div>
												<div class="dropdownLP" style="display: none;" id="streetSelectorDropDown">
													<select class="dropDownStreet" aria-required="true" id="streetSelector" name="streetSelector" required onchange="document.Register.address1.value=document.Register.streetSelector.value;">
													</select>
												</div>
												<input class="input-text" type="text" maxlength="38" size="40" aria-required="true" id="address1" name="address1" value="<c:if test="${!empty WCParam.address1 && WCParam.address1 != 'defaultStreet'}">${WCParam.address1}</c:if>" required />
											</div>
											
											<%-- Addresse 2 --%>
											<div class="col s6 m3" id="Address2Container">
												<div id="Address2Label" class="column_label">
													<span class="spanacce">
														<label for="address2">
															<fmt:message bundle="${storeText}" key="addressBatimentFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="addressBatimentFieldLabel" />
												</div>
												<input class="input-text" type="text" maxlength="38" size="10" id="address2" name="address2" value="${WCParam.address2}" />
											</div>
											
											<%-- étage --%>
											<div class="col s6 m3" id="StageContainer">
												<div id="StageLabel" class="column_label">
													<span class="spanacce">
														<label for="address3">
															<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" />
													<span class="required-field" id="Contact_Floor_Required">*</span>
												</div>
												<div>
													<select class="select-dropdown" name="address3" id="address3">
														<c:set var="etageOptionValue" value="${empty address3 ? '-1' : address3}" />
														<c:forTokens items="${listEtage}" delims="," var="token">
															<c:set var="etageOptionSelected" value="${token eq etageOptionValue ? 'selected' : ''}"/>
															<option value="<c:out value='${token}'/>" ${etageOptionSelected}>
																<fmt:message bundle="${storeListe}" key="Etage_${token}" />
															</option>
														</c:forTokens>
													</select>
												</div>
											</div>
										</div>
											
										<div class="row form-row">
											<%-- Code postal --%>
											<div class="col s5 m3" id="ZipCodeContainer">
												<div id="ZipCodeLabel" class="column_label">
													<span class="spanacce">
														<label for="zipCode">
															<fmt:message bundle="${storeText}" key="addressZipcodeFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="addressZipcodeFieldLabel" />
													<span class="required-field"> *</span>
												</div>
												<div style="display: none;" id="zipCodeSelectorDropDown">
													<select class="select-dropdown dropDownZipCode" aria-required="true" id="zipCodeSelector" name="zipCodeSelector" required onchange="document.Register.zipCode.value=document.Register.zipCodeSelector.value;">
													</select>
												</div>
												<input class="input-text" type="text" maxlength="20" size="10" aria-required="true" id="zipCode" name="zipCode" value="${WCParam.zipCode}" required />
												<img src="/wcsstore/LapeyreSAS/images/loading.gif" width="20" height="20" class="loading" style="display: none"/>
											</div>
											
											<%-- Ville --%>
											<div class="col s7 m6" id="CityContainer">
												<div id="CityLabel" class="column_label">
													<span class="spanacce"> 
														<label for="city">
															<fmt:message bundle="${storeText}" key="addressCityFieldLabel" /> 
														</label> 
													</span>
													<fmt:message bundle="${storeText}" key="addressCityFieldLabel" />
													<span class="required-field"> *</span>
												</div>
												<div style="display: none;" id="citySelectorDropDown">
													<select class="select-dropdown dropDownCity" aria-required="true" id="citySelector" name="citySelector" required onchange="document.Register.city.value=document.Register.citySelector.value;">
													</select>
												</div>
												<input class="input-text" type="text" maxlength="100" size="20" aria-required="true" id="city" name="city" value="<c:if test="${!empty WCParam.city && WCParam.city != 'defaultCity'}">${WCParam.city}</c:if>" required />
												<img src="/wcsstore/LapeyreSAS/images/loading.gif" width="20" height="20" class="loading" style="display: none"/>
											</div>											
											
											<%-- Ville Cachée--%>
											<div class="col s7 m6" style="display:none;" id="CityContainerHidden">
												<div style="display: none;" id="cityHiddenSelectorDropDown">
													<select class="select-dropdown dropDownCity" aria-required="true" id="cityHiddenSelector" name="cityHiddenSelector"  onchange="document.Register.cityHidden.value=document.Register.cityHiddenSelector.value;">
													</select>
												</div>
												<input class="input-text" type="text" maxlength="100" size="20" aria-required="true" id="cityHidden" name="cityHidden" value="<c:if test="${!empty WCParam.city && WCParam.city != 'defaultCity'}">${WCParam.city}</c:if>"/>
											</div>
										</div>
											
										<div class="row form-row">
											<%-- Pays --%>
											<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
												<c:set target="${countryBean}" property="countryCode" value="${country}" />
											</wcbase:useBean>
											<div class="col s12 m6" id="Contact_Country_Container">
												<div id="Contact_Country_Label" class="column_label">
													<fmt:message bundle="${widgetText}" key="CONTACT_COUNTRY" />
													<span class="required-field" id="Contact_Country_Required">*</span>
												</div>
												<div id="countryDiv">
													<select class="select-dropdown dropDownCountry" aria-required="true" id="countryField" name="country" required>
														<c:forEach var="countryItem" items="${countryBean.countries}">
															<c:if test="${countryItem.code eq country || countryItem.displayName eq contact_country}">
																<c:set var="selectedCountryDisplayName" value="${countryItem.displayName}"/>
																<c:set var="optionSelected" value="selected" />
															</c:if>
															<option value="${countryItem.code}" ${optionSelected}>
																<c:out value="${countryItem.displayName}" />
															</option>
															<c:remove var="optionSelected" />
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
											
										<c:choose>
											<c:when test="${!empty WCParam.isLightSubscription && (WCParam.isLightSubscription eq 'light' || WCParam.isLightSubscription eq 'lightPhone')}">
											</div>
											</c:when>
										</c:choose>		
											
										<%-- Téléphone --%>
										<c:choose>
											<c:when test="${!empty WCParam.isLightSubscription && WCParam.isLightSubscription eq 'light'}">
											<div class="forPro">
											</c:when>
										</c:choose>		
										
										<div class="row form-row">
											<div class="col s7 m6" id="PhoneContainer">
												<div class="column_label" id="PhoneLabel">
													<span class="spanacce">
														<label for="phone">
															<fmt:message bundle="${storeText}" key="addressPhoneNumberFieldLabel" /> 
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="addressPhoneNumberFieldLabel" />
													<span class="required-field"> *</span>
												</div>
												<input class="input-text" type="tel" size="25" maxlength="20" id="phoneNumber" name="phoneNumber" value="${WCParam.phoneNumber}" required/>
											</div>

											<%-- Type téléphone --%>
											<div class="col s7 m4" id="PhoneTypeContainer">
												<div class="column_label" id="PhoneTypeLabel">
													<span class="spanacce">
														<label for="phoneType">
															<fmt:message bundle="${storeText}" key="addressPhoneNumberTypeFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="addressPhoneNumberTypeFieldLabel" />
													<span class="required-field"> *</span>
												</div>
												<div>
													<select class="select-dropdown" name="phoneType" id="phoneType">
													
														<c:set var="phoneTypeOptionValue" value="${empty WCParam.phoneType ? '-1' : WCParam.phoneType}" />
	
														<c:forTokens items="${listTelephone}" delims="," var="token">
															<c:set var="phoneTypeOptionSelected" value="${token eq phoneTypeOptionValue ? 'selected' : ''}"/>
															<option value="<c:out value='${token}'/>" ${phoneTypeOptionSelected}>
																<fmt:message bundle="${storeListe}" key="Telephone_${token}" />
															</option>
														</c:forTokens>
													</select>
												</div>
											</div>
										</div>
											
										<c:choose>
											<c:when test="${!empty WCParam.isLightSubscription && WCParam.isLightSubscription eq 'light'}">
											</div>
											</c:when>
										</c:choose>	
											
										<div class="forPro" style="display: none;">
											<div class="row form-row">
												<%-- Siret --%>
												<div class="col s12 m8" id="SiretContainer">
													<div class="column_label" id="SiretLabel">
														<span class="spanacce">
															<label>
																<fmt:message bundle="${storeText}" key="siretFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="siretFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<div class="row">
														<%--Mantis: 2295 ajout de WCParam. --%>
														<div class="col s3 m3">
															<input class="siretNum input-text" size="3" maxlength="3" placeholder="000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 0,3)}" class="siretNum" onblur="verifNames(this);" />
														</div>
														<div class="col s3 m3">
															<input class="siretNum input-text" size="3" maxlength="3" placeholder="000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 3,6)}" class="siretNum" onblur="verifNames(this);" />
														</div>
														<div class="col s3 m3">
															<input class="siretNum input-text" size="3" maxlength="3" placeholder="000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 6,9)}" class="siretNum" onblur="verifNames(this);" />
														</div>
														<div class="col s3 m3">
															<input class="siretNum input-text" size="5" maxlength="5" placeholder="00000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 9,14)}" class="siretNum" onblur="verifNames(this);" />
														</div>
													</div>
												</div>
											</div>
											
											<div class="row form-row">
												<%-- Code APE --%>
												<div class="col s5 m3" id="CodeAPEContainer">
													<div class="column_label" id="CodeAPELabel">
														<span class="spanacce">
															<label for="demographicField7">
																<fmt:message bundle="${storeText}" key="apeFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="apeFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<div>
														<select class="select-dropdown" name="demographicField7" id="demographicField7" value="${WCParam.demographicField7}" required>
															<option value="">-</option>
															<c:forTokens items="${listActivite}" delims="," var="token">
																<option value="${token}">
																	<c:out value="${token}" />
																</option>
															</c:forTokens>
														</select>
													</div>
												</div>
											
												<%-- Activité principale --%>
												<div class="col s7 m8" id="MainActiviteContainer">
													<div class="column_label" id="MainActiviteLabel">
														<span class="spanacce"> 
															<label>
																<fmt:message bundle="${storeText}" key="activitePrincipaleFieldLabel" /> 
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="activitePrincipaleFieldLabel" />
													</div>
													<input class="input-text" list="demographicField7LabelList" type="text" id="demographicField7Label" disabled />
													<datalist id="demographicField7LabelList">
														<c:forTokens items="${listActivite}" delims="," var="token">
															<option data-code-APE="${token}" value="<fmt:message bundle="${storeListe}" key="Activite_${token}" />">${token}</option>
														</c:forTokens>
													</datalist>
												</div>
											</div>
										</div>	
										<div class="row form-row">
											<label>
												<div class="col s12 m12 form-newsletter">
													<input type="checkbox" class="checkLP" name="optinCommunication" value="true" ${WCParam.optinCommunication ? "checked" : ""}>
													<div id="checkboxNewsletter"></div> <%-- Ne pas supprimer cet élément --%>
													<div class="col s11 m11"><fmt:message bundle="${storeText}" key="optinCommunicationLabel" /></div>
												</div>
											</label>
										</div>
										
										<div id="registration-footer" class="row"> 					
											<div class="col m4 offset-m8" id="submitRegistrationContainer">
												<input type="submit" id="submitRegistration" value='<fmt:message bundle="${storeText}" key="inscriptionPageSubmitButtonlabel"/>' class="button button-primary" />
											</div>
											<p class="col m12 form-note" id="formNoteContainer"><fmt:message bundle="${storeText}" key="mandatoryFieldsLabelSingle"/></p>
										</div>
								</div>
							</div>
						</form>
						<div class="row ml">
							<p class="col s12" id="cnil-paragraph"><fmt:message bundle="${storeText}" key="inscriptionPageCNILMessage" /></p>
						</div>	
						<form id="GoToSynchroForm" name="GoToSynchroForm" action="RedirectView?URL=${SynchroUrl}" method="POST">
							<input type="hidden" name="isPro" value="${WCParam.isPro}" />
							<input type="hidden" name="email1" value="${WCParam.email1}" />
							<input type="hidden" name="personTitle" value="${WCParam.personTitle}" />
							<input type="hidden" name="firstName" value="${ecocea:removeDoubleQuote(WCParam.firstName)}" />
							<input type="hidden" name="lastName" value="${ecocea:removeDoubleQuote(WCParam.lastName)}" />
							<input type="hidden" name="legalEntity" value="${WCParam.legalEntity}" />
							<input type="hidden" name="organizationName" value="${ecocea:removeDoubleQuote(WCParam.organizationName)}" />
							<input type="hidden" name="address1" value="${ecocea:removeDoubleQuote(WCParam.address1)}" />
							<input type="hidden" name="address2" value="${ecocea:removeDoubleQuote(WCParam.address2)}" />
							<input type="hidden" name="address3" value="${WCParam.address3}" />
							<input type="hidden" name="city" value="${WCParam.city}" />
							<input type="hidden" name="zipCode" value="${WCParam.zipCode}" />
							<input type="hidden" name="country" value="${WCParam.country}" />
							<input type="hidden" name="phoneNumber" value="${WCParam.phoneNumber}" />
							<input type="hidden" name="phoneType" value="${WCParam.phoneType}" />
							<input type="hidden" name="demographicField5" value="${WCParam.demographicField5}" />
							<input type="hidden" name="demographicField7" value="${WCParam.demographicField7}" />
							<input type="hidden" name="returnPage" value="${WCParam.returnPage}" />
							<input type="hidden" name="URL" value="${returnURL}" />
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END UserRegistrationAddForm.jsp -->
	
	<%
	    out.flush();
	%>
	<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
	<%
	    out.flush();
	%>
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="UserRegistration" />
	</c:import>