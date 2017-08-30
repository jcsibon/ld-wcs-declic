<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/RNVPErrorMessageSetup.jspf"%>

<c:set var="country" value="${CommandContext.country}" scope="request" />
<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>

<wcf:url var="OrderStatusTableDetailsDisplayURL" value="OrderStatusTableDetailsDisplay" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<c:if test="${WCParam.isQuote eq true}">
		<wcf:param name="isQuote" value="true" />
	</c:if>
</wcf:url>

<wcf:url var="RecurringOrderTableDetailsDisplayURL" value="RecurringOrderTableDetailsDisplay" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<wcf:url var="SubscriptionTableDetailsDisplayURL" value="SubscriptionTableDetailsDisplay" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="MYACCOUNT_TITLE" /></title>
<META NAME="robots" CONTENT="noindex,nofollow" />
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css" />
<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css?${versionNumber}" type="text/css" />

<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>

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
<wcf:url var="zipByCityURL" value="GetZipByCityRNVP" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
       <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<script>

var countryTagID = "countryField";
	$() .ready( function() {
		//Disable the submit by default
		$('#submitRegistration').prop('disabled', true).removeClass('green');
							RNVPService.init('<c:out value="${cityByZipURL}" escapeXml="false"/>','<c:out value="${zipByCityURL}" escapeXml="false"/>');
							RNVPService.elementZip = document.RegisterUpdate.zipCode;
							RNVPService.elementCity = document.RegisterUpdate.city;
							RNVPService.onblurCity(document.RegisterUpdate.city);
							RNVPService.onblurZip(document.RegisterUpdate.zipCode);
							RNVPService.elementStreet = document.RegisterUpdate.address1;
							RNVPService.elementCitySelector = document.getElementById('citySelector');
							RNVPService.elementZipSelector = document.getElementById('zipCodeSelector');
							RNVPService.elementStreetSelector = document.getElementById('streetSelector');
							RNVPService.onchangedCitySelector(RNVPService.elementCitySelector);
							RNVPService.onchangedStreetSelector(RNVPService.elementStreetSelector);
							RNVPService.onchangedZipSelector(RNVPService.elementZipSelector);
							
							RNVPService.addErrorMessage(1000,document.RegisterUpdate.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1001,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1002,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1002,document.RegisterUpdate.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1003,document.RegisterUpdate.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1007,document.RegisterUpdate.city,"<fmt:message key='missingCityErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1007,document.RegisterUpdate.zipCode,"<fmt:message key='missingZipcodeErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1009,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1010,document.RegisterUpdate.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1010,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1010,document.RegisterUpdate.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1024,document.RegisterUpdate.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1024,document.RegisterUpdate.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1024,document.RegisterUpdate.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1024,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1024,document.RegisterUpdate.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1025,document.RegisterUpdate.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1025,document.RegisterUpdate.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1025,document.RegisterUpdate.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1025,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1025,document.RegisterUpdate.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1026,document.RegisterUpdate.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1026,document.RegisterUpdate.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1026,document.RegisterUpdate.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1026,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1026,document.RegisterUpdate.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1030,document.RegisterUpdate.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1050,document.RegisterUpdate.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1050,document.RegisterUpdate.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1050,document.RegisterUpdate.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1050,document.RegisterUpdate.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(1050,document.RegisterUpdate.address1,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");

							RNVPService.addErrorMessage(9991,document.RegisterUpdate.zipCode,"<fmt:message key='selectZipcodeErrorMessage' bundle='${storeText}' />");
							RNVPService.addErrorMessage(9992,document.RegisterUpdate.city,"<fmt:message key='selectCityErrorMessage' bundle='${storeText}' />");

							<c:if test="${!empty rnvpErrorCode}" >
									RNVPService.showErrorByCode('<c:out value="${rnvpErrorCode}" />');		
							</c:if>
							<c:if test="${rnvpIsBreak eq 'true'}" >
									var choices = <c:out value='${rnvpChoices}' escapeXml="false" />;
									<c:if test="${rnvpIsCitySelection eq 'true'}" >
										RNVPService.showCitySelection(choices);
										showErrorMessageForElement(document.RegisterUpdate.city,"<fmt:message key='selectCityErrorMessage' bundle='${storeText}' />");
									</c:if>
									<c:if test="${rnvpIsStreetSelection eq 'true'}" >
										RNVPService.showStreetSelection(choices);
										showErrorMessageForElement(document.RegisterUpdate.address1,"<fmt:message key='selectStreetErrorMessage' bundle='${storeText}' />");
									</c:if>	
							</c:if>
						// validate signup form on keyup and submit
						$("#RegisterUpdate")
								.validate(
										{
											rules : {
												personTitle: "required",
												zipCode : {
													required : true,
													maxlength : 5,
													minlength : 4,
													number : true
												},
												city: {
													required: true,
													maxlength:100
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
												logonId : {
													required : true,
													email : true,
													maxlength : 100
												},
												phone1 : {
													maxlength : 20,
													require_from_group: [1, ".phone-group"],
													validatePhoneFR : [ countryTagID ]
												},
												phone2 : {
													maxlength : 20,
													require_from_group: [1, ".phone-group"],
													validatePhoneFR : [ countryTagID ]
												},
												mobilePhone1 : {
													maxlength : 20,
													require_from_group: [1, ".phone-group"],
													validatePhoneFR : [ countryTagID ]
												},
												fax1 : {
													maxlength : 20,
													validatePhoneFR : [ countryTagID ]
												},
									<%--			dayInput : {
													skip_or_fill_minimum: [3, ".birthdate"]
												},
												monthInput : {
													skip_or_fill_minimum: [3, ".birthdate"]
												},
												yearInput : {
													skip_or_fill_minimum: [3, ".birthdate"]
												},
									--%>
												oldLogonPassword : {
													required: false,
													requiredIfOtherFilled: "#WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1"
												},
												logonPassword : {
													required: false,
													passwordTest : true,
													maxlength : 100,
													minlength : 6
												},
												logonPasswordVerify : {
													required: false,
													equalTo: "#WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1"
												},
												tva : {
													skip_or_fill_minimum: [5, ".tvaNum"]
												}
											},
											messages : {
												personTitle: "<fmt:message bundle='${widgetText}' key='missingPersontitleErrorMessage' />",
												firstName : {
													required : "<fmt:message bundle='${widgetText}' key='missingFirstnameFieldErrorMessage' />",
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthFirstnameFieldErrorMessage' />"
												},
												lastName : {
													required : "<fmt:message bundle='${widgetText}' key='missingLastameFieldErrorMessage' />",
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthFirstnameFieldErrorMessage' />"
												},
												logonId : {
													required : "<fmt:message bundle='${widgetText}' key='missingEmailErrorMessage' />",
													email : "<fmt:message bundle='${widgetText}' key='InvalidEmailErrorMessage' />",
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthEmailErrorMessage' />"
												},
												zipCode : {
													required : "<fmt:message bundle='${widgetText}' key='missingZipCodeMessage' />",
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthZipCodeMessage' />",
													number : "<fmt:message bundle='${widgetText}' key='nonNumericErrorMessage' />"
												},
												address1: {
													required: "<fmt:message bundle='${widgetText}' key='missingStreetErrorMessage' />",
													maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthStreetErrorMessage' />"
												},
												address2: {
													maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />"
												},
												city: {
													required: "<fmt:message bundle='${widgetText}' key='missingCityErrorMessage' />",
													maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthCityErrorMessage' />"
												},
												phone1 : {
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />",
													require_from_group: "<fmt:message bundle='${widgetText}' key='missingPhoneErrorMessage' />",
													validatePhoneFR : "<fmt:message bundle='${widgetText}' key='InvalidPhoneFormatErrorMessage' />"
												},
												phone2 : {
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />",
													require_from_group: "<fmt:message bundle='${widgetText}' key='missingPhoneErrorMessage' />",
													validatePhoneFR : "<fmt:message bundle='${widgetText}' key='InvalidPhoneFormatErrorMessage' />"
												},
												mobilePhone1 : {
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />",
													require_from_group: "<fmt:message bundle='${widgetText}' key='missingPhoneErrorMessage' />",
													validatePhoneFR : "<fmt:message bundle='${widgetText}' key='InvalidPhoneFormatErrorMessage' />"
												},
												fax1 : {
													maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />",
													validatePhoneFR : "<fmt:message bundle='${widgetText}' key='InvalidPhoneFormatErrorMessage' />"
												},
												<%--				dayInput : {
													skip_or_fill_minimum: "<fmt:message bundle='${storeText}' key='unvalidBirthdateErrorMessage' />",
													minimumAge : "<fmt:message bundle='${storeText}' key='under18ErrorMessage' />"
												},
												monthInput : {
													skip_or_fill_minimum: "<fmt:message bundle='${storeText}' key='unvalidBirthdateErrorMessage' />",
													minimumAge : "<fmt:message bundle='${storeText}' key='under18ErrorMessage' />"
												},
												yearInput : {
													skip_or_fill_minimum: "<fmt:message bundle='${storeText}' key='unvalidBirthdateErrorMessage' />",
													minimumAge : "<fmt:message bundle='${storeText}' key='under18ErrorMessage' />"
												},
												--%>
												oldLogonPassword :{
													requiredIfOtherFilled: "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />"
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
												},
												tva :{
													skip_or_fill_minimum: "<fmt:message bundle='${storeText}' key='missingNumTvaErrorMessage' />"
												}
											},
										<%--	groups: {
										        birthdate: "dayInput monthInput yearInput"
										    },
										   --%>
											errorPlacement : function(error, element) {
											<%--	if (element.attr("name") == "dayInput" || element.attr("name") == "monthInput" || element.attr("name") == "yearInput" ) {
											    	error.appendTo($("#BirthDateContainer"));
											    } else
											   --%>
											     if (element.is("select")) {
													//For select inputs, insert at the parent
													error.insertAfter(element.parent());
												} else if (element.attr("type") == "radio") {
													//for radio button, insert at the end of the grandparent
													error.appendTo(element.parent().parent());
												} else {
													error.insertAfter(element);
												}
											},
											submitHandler : function(form) {
												if(form.propart.value == '1'){
													form.isPro.value = 'true';
													form.demographicField5.value = concateName("siret");
													form.taxPayerId.value = concateName("tva");
													
												} else {
													form.isPro.value = 'false';
													form.demographicField5.value = '';
													form.taxPayerId.value = '';
												<%--	if (form.yearInput.value && form.monthInput.value && form.dayInput.value) { 
														form.dateOfBirth.value = form.yearInput.value + '-' + form.monthInput.value + '-' + form.dayInput.value;
													}
													--%>
												}
												
												if (form.logonPassword.value.length == 0 || form.logonPasswordVerify.value.length == 0){
													form.logonPassword.name = 'notLogonPassword';
													form.logonPasswordVerify.name = 'notLogonPasswordVerify';
												}
												
												if (!submitRequest()) {
													return false;
												}
												cursor_wait();
												
											
												//disable submit button
												$('#submitRegistration').attr('disabled','disabled');
												$('#submitRegistration').addClass('disabled').removeClass('green'); 
												form.submit();
											}
										});
					});
</script>
<script type="text/javascript">
	function popupWindow(URL) {
		window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
	}
	var itemsChanged =[];
	function EnableUpdate(element, value){		
		if($(element).val() != value){
			itemsChanged.push(element.id);
		} else {
			var index = itemsChanged.indexOf(element.id);
			if(index != -1) itemsChanged.splice( element.id, 1 );				
		}
		if(itemsChanged.length>0){
			$('#submitRegistration').prop('disabled', false).addClass('green');
		}else{
			$('#submitRegistration').prop('disabled', true).removeClass('green');
		}
	}
	function EnableUpdateCilivity(element, value){
		if($(element).find('option:selected').val() != value){
			itemsChanged.push(element.id);
		} else {
			var index = itemsChanged.indexOf(element.id);
			if(index != -1) itemsChanged.splice( element.id, 1 );				
		}
		if(itemsChanged.length>0){
			$('#submitRegistration').prop('disabled', false).addClass('green');
		}else{
			$('#submitRegistration').prop('disabled', true).removeClass('green');
		}
	}
</script>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

</head>
<body>
<wcf:url var="MyAccountURL" value="AjaxLogonForm" type="Ajax">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<wcf:url var="UserRegistrationUpdateURL" value="UserRegistrationUpdate">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<flow:ifEnabled feature="Analytics">
	<cm:registration personType="${person}"/>
</flow:ifEnabled>

 
<c:choose>
	<c:when test="${extendedUserContext.isPro eq true}">
		<c:set var="lockPro" value="true"/>
	</c:when>
	<c:otherwise>
		<c:set var="lockPro" value="false"/>
	</c:otherwise>
</c:choose>
  
<c:set var="userFields" value="${person.personalProfile}"/>

<c:set var="firstName" value="${userFields.attributes['userProfileField2']}"/>
<c:if test="${!empty WCParam.firstName}">
	<c:set var="firstName" value="${WCParam.firstName}"/>
</c:if>
<c:set var="lastName" value="${userFields.displayName}"/>
<c:if test="${!empty WCParam.lastName}">
	<c:set var="lastName" value="${WCParam.lastName}"/>
</c:if>
<c:set var="personTitle" value="${userFields.attributes['demographicField3']}"/>
<c:if test="${!empty WCParam.personTitle}">
	<c:set var="personTitle" value="${WCParam.personTitle}"/>
</c:if>

<c:set var="email1" value="${person.contactInfo.emailAddress1.value}"/>
<c:if test="${!empty WCParam.email1}">
	<c:set var="email1" value="${WCParam.email1}"/>
</c:if>

<c:set var="logonId" value="${person.credential.logonID}"/>
<c:if test="${!empty WCParam.logonId}">
	<c:set var="logonId" value="${WCParam.logonId}"/>
</c:if>

<c:set var="phone1" value="${person.contactInfo.telephone1.value}"/>
<c:if test="${!empty WCParam.phone1}">
	<c:set var="phone1" value="${WCParam.phone1}"/>
</c:if>
<c:set var="mobilePhone1" value="${person.contactInfo.mobilePhone1.value}"/>
<c:set var="mobilePhone1Country" value="${person.contactInfo.mobilePhone1.country}" />
<c:if test="${!empty WCParam.mobilePhone1}">
	<c:set var="mobilePhone1" value="${WCParam.mobilePhone1}"/>
</c:if>
<c:set var="phone2" value="${person.contactInfo.telephone2.value}"/>
<c:if test="${!empty WCParam.phone2}">
	<c:set var="phone2" value="${WCParam.phone2}"/>
</c:if>
<c:set var="fax1" value="${person.contactInfo.fax1.value}"/>
<c:if test="${!empty WCParam.fax1}">
	<c:set var="fax1" value="${WCParam.fax1}"/>
</c:if>

<c:choose>
	<c:when test="${not empty person.contactInfo.address.city && person.contactInfo.address.city == 'defaultCity' }">
        <c:set var="city" value=""/>
	</c:when>
    <c:otherwise>
		<c:set var="city" value="${person.contactInfo.address.city}"/>
		<c:if test="${!empty WCParam.city}">
			<c:set var="city" value="${WCParam.city}"/>
		</c:if>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty person.contactInfo.address.addressLine || person.contactInfo.address.addressLine[0] == 'defaultStreet' }">
        <c:set var="address1" value=""/>
	</c:when>
    <c:otherwise>
		<c:set var="address1" value="${person.contactInfo.address.addressLine[0]}"/>
		<c:if test="${!empty WCParam.address1}">
			<c:set var="address1" value="${WCParam.address1}"/>
		</c:if>
	</c:otherwise>
</c:choose>

<c:set var="state" value="${person.contactInfo.address.stateOrProvinceName}" scope="request"/>

<c:set var="address2" value="${person.contactInfo.address.addressLine[1]}"/>
<c:if test="${!empty WCParam.address2}">
	<c:set var="address2" value="${WCParam.address2}"/>
</c:if>
<c:set var="address3" value="${person.contactInfo.address.addressLine[2]}"/>
<c:if test="${!empty WCParam.address3}">
	<c:set var="address3" value="${WCParam.address3}"/>
</c:if>

<c:set var="country" value="${person.contactInfo.address.country}"/>
<c:if test="${!empty WCParam.country}">
	<c:set var="country" value="${WCParam.country}"/>
</c:if>
<c:set var="zipCode" value="${person.contactInfo.address.postalCode}"/>
<c:if test="${!empty WCParam.zipCode}">
	<c:set var="zipCode" value="${WCParam.zipCode}"/>
</c:if>
<%--
<c:set var="dateBirth" value="${person.personalProfile.dateOfBirth}"/>

<fmt:parseDate value="${dateBirth}" var="dateBirth" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" timeZone="GMT"/>
<c:if test="${!empty WCParam.dateOfBirth}">
	<fmt:parseDate value="${WCParam.dateOfBirth}" var="dateBirth" pattern="yyyy-MM-dd" />
</c:if>
<fmt:formatDate value="${dateBirth}" var="dayAccount" pattern="d"/>
<fmt:formatDate value="${dateBirth}" var="monthAccount" pattern="M"/>
<fmt:formatDate value="${dateBirth}" var="yearAccount" pattern="yyyy"/>
--%>


<c:set var="organizationName" value="${person.contactInfo.organizationName}"/>
<c:if test="${!empty WCParam.organizationName}">
	<c:set var="organizationName" value="${WCParam.organizationName}"/>
</c:if>
<c:set var="demographicField5" value="${userFields.attributes['demographicField5']}"/>
<c:if test="${!empty WCParam.demographicField5}">
	<c:set var="demographicField5" value="${WCParam.demographicField5}"/>
</c:if>


<%-- 	MOVE TO USERPROF.FIELD1 --%>
<%-- <wcbase:useBean classname="com.ibm.commerce.user.beans.MemberAttributeValueListDataBean" id="memberAttrAB"> --%>
<%-- 	<c:set property="attributeName" target="${memberAttrAB}" value="companySize"/> --%>
<%-- 	<c:set property="memberId" target="${memberAttrAB}" value="${person.personIdentifier.uniqueID}"/> --%>
<%-- </wcbase:useBean> --%>
<%--<% --%>
<%--	request.setAttribute("codeEffectif",memberAttrAB.getValue(request.getAttribute("storeId").toString())); --%>
<%--  %>  --%>
<c:set var="codeEffectif" value="${userFields.attributes['userProfileField1']}"/>
<c:if test="${!empty WCParam.codeEffectif}">
	<c:set var="codeEffectif" value="${WCParam.codeEffectif}"/>
</c:if>
<c:set var="demographicField7" value="${userFields.attributes['demographicField7']}"/>
<c:if test="${!empty WCParam.demographicField7}">
	<c:set var="demographicField7" value="${WCParam.demographicField7}"/>
</c:if>
<c:set var="taxPayerId" value="${userFields.attributes['taxPayerId']}"/>
<c:if test="${!empty WCParam.taxPayerId}">
	<c:set var="taxPayerId" value="${WCParam.taxPayerId}"/>
</c:if>

<!-- Page Start -->
<div id="page">
		<%--
		  ***
		  * If an error occurs, the page will refresh and the entry fields will be pre-filled with the previously entered value.
		  * The entry fields below use e.g. paramSource.logonId to get the previously entered value.
		  * In this case, the paramSource is set to WCParam.  
		  ***
		--%>
		<c:set var="paramSource" value="${WCParam}"/>  
		<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
			<wcf:param name="accessProfile" value="IBM_All" />
		</wcf:getData>
	<%out.flush();%>
		<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
	<%out.flush();%>
	
	<div id="contentWrapper">
		<div id="content" role="main">
			<div class="rowContainer">
                <div class="row">
                       <div data-slot-id="1" class="col12 slot1 mobile-hidden">
						<%out.flush();%>
						<fmt:message var="lastBreadCrumbItem" key="myAccountBreadcrumbLabel" bundle="${widgetText}" />
						<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
							<c:param name="pageName" value="CompteClient" />
							<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
						</c:import>
						<%out.flush();%>
                   	</div>
               	 </div>
               	 <c:set var="navMonCompteCurrentPage" value="myAccount"/>
				
				
				<div class="row" id="myAccountPage">
					<div id="navCompteClient" class="col3 mobile-hidden">
						<%@ include file="../navClient.jspf" %>
					</div>
					<div class="col9 bcol12 mainContentWrapper">
						<div class="row">
							<div class="monCompte">
								<h2 class="titleBlock"><fmt:message bundle="${storeText}" key="myAccountPageTitle"/></h2>
								<p><fmt:message bundle="${storeText}" key="mandatoryFieldsLabel"/></p>
							</div>
						</div>
						<div class="row">
							<div class="sign_in_registration userData" id="WC_UserRegistrationUpdateForm_div_1">
								<form name="RegisterUpdate" method="post" action="${UserRegistrationUpdateURL}" id="RegisterUpdate">
									<input type="hidden" name="myAcctMain" value="1" autocomplete="off">
									<input type="hidden" name="demographicField5" value="${demographicField5}" />
									<input type="hidden" name="taxPayerId" value="${taxPayerId}" />
									<input type="hidden" name="email1" value="${email1}" />
									<%--<input type="hidden" name="dateOfBirth" value="<fmt:formatDate value='${dateBirth}' pattern="yyyy-MM-dd"/>" /> --%>
									<input type="hidden" name="mobilePhone1Country" value="${mobilePhone1Country}" />
									<input type="hidden" name="storeId" value="10101" id="WC_UserRegistrationUpdateForm_FormInput_storeId_In_Register_1" autocomplete="off">
									<input type="hidden" name="catalogId" value="10151" id="WC_UserRegistrationUpdateForm_FormInput_catalogId_In_Register_1" autocomplete="off">
									<input type="hidden" name="langId" value="-2" id="WC_UserRegistrationUpdateForm_FormInput_langId" autocomplete="off">
									<input type="hidden" name="URL" value="AjaxLogonForm" id="WC_UserRegistrationUpdateForm_FormInput_URL_In_Register_1" autocomplete="off">
									<input type="hidden" name="errorViewName" value="AjaxLogonForm" id="WC_UserRegistrationUpdateForm_FormInput_errorViewName_In_Register_1" autocomplete="off">
									<input type="hidden" name="isPro" value="${extendedUserContext.isPro eq true}" />
									<div class="form" id="WC_UserRegistrationUpdateForm_div_3">
										<c:if test="${!empty errorMessage && empty rnvpErrorCode && rnvpIsBreak eq 'false'}">									
											<fmt:message bundle="${storeText}" key="changePasswordErrorMessage" var="changePasswordErrorMessage"/>
											<c:if test="${changePasswordErrorMessage ne errorMessage}">
												<div class="error">
													<span class="error"><c:out value="${errorMessage}" /></span>
												</div>
											</c:if>
										</c:if><a id="changePassBlock"/>
										<div class="content" id="WC_UserRegistrationUpdateForm_div_6">
											<div class="align" id="WC_UserRegistrationUpdateForm_div_7">
												<div class="form_3column" id="WC_UserRegistrationUpdateForm_div_8">
												
												
													<c:choose>
														<c:when test="${extendedUserContext.isPro}">
														
															<%-- Entité juridique --%>
															<div class="column column_20 bcolumn_100" id="LegalEntityContainer">
																<div class="column_label" id="LegalEntityLabel">
																	<span class="spanacce">
																		<label for="legalEntity">
																			<fmt:message bundle="${storeText}" key="addressLegalEntityFieldLabel" />
																		</label>
																	</span>
																	<fmt:message bundle="${storeText}" key="addressLegalEntityFieldLabel" />
																</div>
																<input type="hidden" name="legalEntity" value="${personTitle}" />
																<input type="hidden" name="legalEntityLabel" value="<fmt:message bundle="${storeListe}" key="Civilite_${personTitle}" />" />
																<input type="text" value="<fmt:message bundle="${storeListe}" key="Civilite_${personTitle}" />" disabled />
															</div>
															<div class="gutter mobile-hidden"></div>
															
															<%-- Raison sociale --%>
															<div class="column column_77 bcolumn_100" id="raisonSocialeContainer">
																<div class="column_label" id="raisonSocialeContainerLabel">
																	<span class="spanacce">
																		<label for="organizationName">
																			<fmt:message bundle="${storeText}" key="raisonSocialeFieldLabel" /> 
																		</label>
																	</span>
																	<fmt:message bundle="${storeText}" key="raisonSocialeFieldLabel" />
																</div>
																<input type="hidden" name="organizationName" value="${organizationName}" />
																<input type="text" value="${organizationName}" disabled />
															</div>
															<div class="clearAll"></div>
															
														</c:when>
														<c:otherwise>
														
															<%-- Civilité --%>
															<div class="column column_20 bcolumn_30" id="CiviliteContainer">
																<div class="column_label" id="CiviliteLabel">
																		<span class="spanacce">
																			<label for="personTitle">
																				<fmt:message bundle="${storeText}" key="addressCiviliteFieldLabel" />
																			</label>
																		</span>
																		<fmt:message bundle="${storeText}" key="addressCiviliteFieldLabel" />
																		<span class="required-field"> *</span>
																	</div>
																<div class="dropdownLP">
																	<select id="personTitle" name="personTitle" value="" required onchange="EnableUpdateCilivity(this,'${personTitle}')"> 
																		<option value="">-</option>
																		<c:forTokens items="${listCivilitePart}" delims="," var="token">
																		    <option value="<c:out value='${token}'/>" <c:if test="${token==personTitle}">selected</c:if> >
																				<fmt:message bundle="${storeListe}" key="Civilite_${token}" />
																			</option>
																		</c:forTokens>
																		<c:if test="${extendedUserContext.isPro}">
																			<c:forTokens items="${listCivilitePro}" delims="," var="token">
																			    <option value="<c:out value='${token}'/>" <c:if test="${token==personTitle}">selected</c:if> >
																					<fmt:message bundle="${storeListe}" key="Civilite_${token}" />
																				</option>
																			</c:forTokens>
																		</c:if>
																	</select>
																</div>
															</div>
															<div class="gutter"></div>
															
															<%-- Prénom --%>
															<div class="column column_25-5 bcolumn_67" id="FirstNameContainer">
																<div id="FirstNameLabel" class="column_label">
																	<span class="spanacce">
																		<label for="WC_UserRegistrationUpdateForm_NameEntryForm_FormInput_firstName_1">
																				<fmt:message bundle="${storeText}" key="addressFirstnameFieldLabel" />
																		</label>
																	</span>
																	<fmt:message bundle="${storeText}" key="addressFirstnameFieldLabel" />
																	<span class="required-field" id="WC_AddressEntryForm__div_17"> *</span>
																</div>
																<input type="text" maxlength="60" size="20" id="WC_UserRegistrationUpdateForm_NameEntryForm_FormInput_firstName_1" name="firstName" value="${firstName}" required="" onchange="EnableUpdate(this, '${firstName}')">
															</div>
															<div class="gutter mobile-hidden"></div>
															
															<%-- Nom --%>
															<div class="column column_48-5 bcolumn_100" id="LastNameContainer">
																<div id="LastNameLabel" class="column_label">
																	<span class="spanacce">
																		<label for="WC_UserRegistrationUpdateForm_NameEntryForm_FormInput_lastName_1">
																			<fmt:message bundle="${storeText}" key="addressLastnameFieldLabel" />
																		</label>
																	</span>
																	<fmt:message bundle="${storeText}" key="addressLastnameFieldLabel" />
																	<span class="required-field" id="WC_AddressEntryForm__div_20"> *</span>
																</div>
																<input type="text" maxlength="40" size="35" aria-required="true" id="WC_UserRegistrationUpdateForm_NameEntryForm_FormInput_lastName_1" name="lastName" value="${lastName}" required="" onchange="EnableUpdate(this, '${lastName}')">
															</div>
															<div class="clearAll"></div>
															
														</c:otherwise>
													</c:choose>
												
													<%-- Email --%>
													<div class="column column_48-5 bcolumn_100" id="EmailLogonContainer">
														<div class="column_label" id="EmailLogonLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_logonId_In_Register_1">
																	<fmt:message bundle="${storeText}" key="loginFieldlabel" />
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="loginFieldlabel" />
															<span class="required-field" id="WC_UserRegistrationUpdateForm_div_21"> *</span>
														</div>
														<input type="email" size="40" maxlength="100" aria-required="true" name="logonId" id="WC_UserRegistrationUpdateForm_FormInput_logonId_In_Register_1" value="${logonId}" required="" onchange="EnableUpdate(this, '${logonId}')">
													</div>
													<div class="gutter"></div>
													
													<c:if test='${empty phone1 or empty mobilePhone1 or empty phone2 or empty fax1}'>
														<a id="addPhone" onclick="affPhonesInput();" class="button"><fmt:message bundle="${storeText}" key="addPhonesButton"/></a>
													</c:if>
													<div class="clearAll"></div>
													
													<div class="column column_48-5 bcolumn_100 phones" id="PhoneFixContainer" style="<c:if test='${empty phone1}'>display:none;</c:if>">
														<div class="column_label" id="PhoneFixLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_phone1Num_In_Register_2">
																		<fmt:message bundle="${storeText}" key="addressPhoneNumber1FieldLabel" /> 
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="addressPhoneNumber1FieldLabel" />
															<span class="required-field">**</span>
														</div>
														<input type="tel" size="25" maxlength="20" class="phone-group" id="WC_UserRegistrationUpdateForm_FormInput_phone1Num_In_Register_2" name="phone1" value="${phone1}" onchange="EnableUpdate(this, '${phone1}')">
													</div>
													<div class="gutter mobile-hidden phones" style="<c:if test='${empty phone1}'>display:none;</c:if>"></div>
													
													<div class="column column_48-5 bcolumn_100 phones" id="PhoneMobileContainer" style="<c:if test='${empty mobilePhone1}'>display:none;</c:if>">
														<div class="column_label" id="PhoneMobileLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_mobiePhoneNum_In_Register_2">
																		<fmt:message bundle="${storeText}" key="addressPhoneNumber2FieldLabel" /> 
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="addressPhoneNumber2FieldLabel" />
															<span class="required-field">**</span>
														</div>
														<input type="tel" size="25" maxlength="20" class="phone-group" id="WC_UserRegistrationUpdateForm_FormInput_mobiePhoneNum_In_Register_2" name="mobilePhone1" value="${mobilePhone1}" onchange="EnableUpdate(this, '${mobilePhone1}')" onchange="document.RegisterUpdate.mobilePhone1Country.value=document.RegisterUpdate.country.value">
													</div>
													<div class="clearAll"></div>
													
													<div class="column column_48-5 bcolumn_100 phones" id="PhoneProContainer" style="<c:if test='${empty phone2}'>display:none;</c:if>">
														<div class="column_label" id="PhoneProLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_phone2Num_In_Register_2">
																		<fmt:message bundle="${storeText}" key="addressFaxNumber1FieldLabel" /> 
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="addressFaxNumber1FieldLabel" />
															<span class="required-field">**</span>
														</div>
														<input type="tel" size="25" maxlength="20" class="phone-group" id="WC_UserRegistrationUpdateForm_FormInput_phone2Num_In_Register_2" name="phone2" value="${phone2}" onchange="EnableUpdate(this, '${phone2}')">
													</div>
													<div class="gutter mobile-hidden phones" style="<c:if test='${empty phone2}'>display:none;</c:if>"></div>
													
													<div class="column column_48-5 bcolumn_100 phones" id="FaxContainer" style="<c:if test='${empty fax1}'>display:none;</c:if>">
														<div class="column_label" id="FaxLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_fax1Num_In_Register_2">
																		<fmt:message bundle="${storeText}" key="addressFaxNumber2FieldLabel" /> 
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="addressFaxNumber2FieldLabel" />
														</div>
														<input type="tel" size="25" maxlength="20" id="WC_UserRegistrationUpdateForm_FormInput_fax1Num_In_Register_2" name="fax1" value="${fax1}" onchange="EnableUpdate(this, '${fax1}')">
													</div>
													<div class="clearAll"></div>
													
													<%-- mantis 3397 : suuprimer champ date de naissance
													<c:if test="${not extendedUserContext.isPro}">
														Date de naissance
														<div class="column column_50 bcolumn_100" id="BirthDateContainer">
															<div class="column_label" id="BirthDateContainer">
																<span class="spanacce">
																	<label for="WC_UserRegistrationUpdateForm_FormInput_phoneNum_In_Register_2">
																		<fmt:message bundle="${storeText}" key="birthdateFieldlabel" /> 
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="birthdateFieldlabel" />
															</div>
															
															input date
															<jsp:useBean id="now" class="java.util.Date"/>
															<fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />
															<div id="daySelecter" class="left column_30 bcolumn_30">
																<div class="dropdownLP">
																	<select name="dayInput" class="birthdate">
																		<option value="">-</option>
																		<c:forEach var="day" begin="1" end="31">
																			<fmt:parseDate value='${day}' var="parsedDateDay" pattern="d"/>
																			<option value="<fmt:formatDate value='${parsedDateDay}' pattern="dd"/>" <c:if test="${day eq dayAccount}">selected</c:if>><fmt:formatDate value='${parsedDateDay}' pattern="dd"/></option>
																		</c:forEach>
																	</select>
																</div>
															</div>
															<div class="gutter"></div>
															
															<div id="monthSelecter" class="left column_30 bcolumn_30">
																<div class="dropdownLP">
																	<select name="monthInput" class="birthdate capitalize">
																		<option value="">-</option>
																		<c:forEach var="month" begin="1" end="12">
																			<fmt:parseDate value='${month}' var="parsedDateMonth" pattern="M"/>
																			<option value="<fmt:formatDate value='${parsedDateMonth}' pattern="MM"/>" <c:if test="${month eq monthAccount}">selected</c:if>>
																				<fmt:formatDate value='${parsedDateMonth}' pattern="MMMM"/>
																			</option>
																		</c:forEach>
																	</select>
																</div>
															</div>
															<div class="gutter"></div>
															Calcul nécessaire pour afficher par ordre décroissant (contrainte : step<=0 )
															<div id="yearSelecter" class="left column_30 bcolumn_30">
																<div class="dropdownLP">
																<select name="yearInput" class="birthdate">
																	<option value="">-</option>
																	<c:forEach var="year" begin="1900" end="${currentYear - 18}">
																		<c:set var="yearOptionValue" value="${1900 + currentYear - 18 - year}"/>
																		<c:set var="yearOptionSelected" value="${yearOptionValue eq yearAccount ? 'selected' : ''}"/>
																		<option value="${yearOptionValue}" ${yearOptionSelected}/>${yearOptionValue}</option>
																	</c:forEach>
																</select>
																</div>
															</div>
														</div>
														<div class="clearAll"></div>
													</c:if> --%>
<%--													
													<input type="hidden" maxlength="38" id="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_address1_1" name="address1" value="${ecocea:escapeHTML(address1)}" />
													<input type="hidden" maxlength="38" id="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_address2_1" name="address2" value="${ecocea:escapeHTML(address2)}" />
													<input type="hidden" maxlength="2"  id="etageField" name="address3" value="${empty address3 ? '-1' : address3}" />
--%>
														<div class="column column_48-5 bcolumn_100" id="Address1Container">
															<div id="Address1Label" class="column_label">
																<span class="spanacce">
																	<label for="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_address1_1">
																		<fmt:message bundle="${storeText}" key="addressStreetFieldLabel" />
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="addressStreetFieldLabel" />
																<span class="required-field" id="WC_AddressEntryForm__div_3"> *</span>
															</div>
															<div class="dropdownLP" style="display: none;" id="streetSelectorDropDown">
																<select class="dropDownStreet" aria-required="true" id="streetSelector" name="streetSelector" required onchange="document.RegisterUpdate.address1.value=document.RegisterUpdate.streetSelector.value;">
																</select>
															</div>
															<input type="text" maxlength="38" size="40" aria-required="true" id="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_address1_1" name="address1" value="${ecocea:escapeHTML(address1)}" required="" onchange="EnableUpdate(this, '${ecocea:escapeHTML(address1)}')">
														</div>
														<div class="gutter mobile-hidden"></div>
														
														<div class="column column_25-5 bcolumn_67" id="Address2Container">
															<div id="Address2Label" class="column_label">
																<span class="spanacce">
																	<label for="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_address1_10">
																		<fmt:message bundle="${storeText}" key="addressBatimentFieldLabel" />
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="addressBatimentFieldLabel" />
															</div>
															<input type="text" maxlength="38" size="10" id="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_address2_1" name="address2" value="${ecocea:escapeHTML(address2)}" onchange="EnableUpdate(this, '${ecocea:escapeHTML(address2)}')">
														</div>
														<div class="gutter"></div>
														
														<div class="column column_20 bcolumn_30" id="StageContainer">
																<div id="StageLabel" class="column_label">
																	<span class="spanacce">
																		<label for="WC_UserAddressForm_AddressEntryForm_FormInput_address1_1">
																			<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" />
																		</label>
																	</span>
																	<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" />
																</div>
																<div class="dropdownLP">
																	<select name="address3" id="etageField" onchange="EnableUpdate(this, '${ecocea:escapeHTML(address3)}')">
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
														<div class="clearAll"></div>
													
													<div class="column column_20 bcolumn_33" id="ZipCodeContainer">
														<div id="ZipCodeLabel" class="column_label">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_zipCode_1">
																	<fmt:message bundle="${storeText}" key="addressZipcodeFieldLabel" />
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="addressZipcodeFieldLabel" />
															<span class="required-field" id="WC_AddressEntryForm__div_15"> *</span>
														</div>
														<div class="dropdownLP" style="display: none;" id="zipCodeSelectorDropDown">
															<select class="dropDownZipCode" aria-required="true" id="zipCodeSelector" name="zipCodeSelector" required onchange="EnableUpdate(this,'${zipCode}');document.RegisterUpdate.zipCode.value=document.RegisterUpdate.zipCodeSelector.value;">
															</select>
														</div>
														<input type="text" maxlength="20" size="10" aria-required="true" id="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_zipCode_1" name="zipCode" value="${zipCode}" required="" onchange="EnableUpdate(this, '${zipCode}')">
														<img src="/wcsstore/LapeyreSAS/images/loading.gif" width="20" height="20" class="loading" style="display: none"/>
													</div>
<%--													<input type="text" maxlength="100" id="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_city_1" name="city" value="${city}" required="" />
													<input type="hidden" value="${country}" name="country" />
--%>
														<div class="gutter"></div>
														<div class="column column_54 bcolumn_64" id="CityContainer">
															<div id="CityLabel" class="column_label">
																<span class="spanacce"> 
																	<label for="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_city_1">
																		<fmt:message bundle="${storeText}" key="addressCityFieldLabel" /> 
																	</label> 
																</span>
																<fmt:message bundle="${storeText}" key="addressCityFieldLabel" />
																<span class="required-field" id="WC_AddressEntryForm__div_6"> *</span>
															</div>
															<div class="dropdownLP" style="display: none;" id="citySelectorDropDown"><%-- TODO JCL : verifier les listes RNVP --%>
																<select class="dropDownCity" aria-required="true" id="citySelector" name="citySelector" required onchange="EnableUpdate(this,document.RegisterUpdate.citySelector.value);document.RegisterUpdate.city.value=document.RegisterUpdate.citySelector.value;">
																</select>
															</div><%-- TODO JCL : gerer EnableUpdate sur city --%>
															<input type="text" maxlength="100" size="20" aria-required="true" id="WC_UserRegistrationUpdateForm_AddressEntryForm_FormInput_city_1" name="city" value="${city}" required="" onchange="EnableUpdate(this, '${ecocea:escapeHTML(city)}')">
															<img src="/wcsstore/LapeyreSAS/images/loading.gif" width="20" height="20" class="loading" style="display: none"/>
														</div>
														<div class="gutter mobile-hidden"></div>
														
																											
														<wcbase:useBean id="countryBeanList" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
															<c:set target="${countryBeanList}" property="countryCode" value="${country}" />
														</wcbase:useBean>
														
														<div class="column column_20 bcolumn_100 relative" id="Contact_Country_Container">
															<div id="Contact_Country_Label" class="column_label">
																<fmt:message bundle="${widgetText}" key="CONTACT_COUNTRY" />
																<span class="required-field" id="Contact_Country_Required">*</span>
															</div>
															<c:set var="countrySelectedDisplay" value="" />
															<div class="dropdownLP" style="display: none;" id="countryDiv">
																<select class="dropDownCountry" aria-required="true" id="countryField" name="country" required onchange="EnableUpdate(this,document.RegisterUpdate.country.value);document.RegisterUpdate.mobilePhone1Country.value=document.RegisterUpdate.country.value">
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
															<input type="text" value="${countrySelectedDisplay}" id="textCountry" disabled="disabled" name="countryInputField">
															<div class="editCountry" style="display: inline;" id="editCountry">
																<a href="#" onClick="selectCountry();return false;">
																	<img src="${jspStoreImgDir}images/editCountry.png" alt="">
																</a>
															</div>
														</div>
													
													<div class="clearAll"></div>
													
													
													<input type="hidden" name="propart" value="${extendedUserContext.isPro ? 1 : 0}" />
													
													<%-- <div class="column column_100" id="isProContainer">
														<div class="column_label" id="isProLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_logonId_In_Register_1">
																	<fmt:message bundle="${storeText}" key="isProFieldLabel" />
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="isProFieldLabel" />
														</div>
														<label class="radioButtonContainer" for="pro"> 
															<input type="radio" class="radioLP" name="propart" id="pro" value="1" <c:if test="${WCParam.isPro || lockPro}">checked</c:if> onclick="document.getElementById('iampro').style.display = 'block';" <c:if test="${lockPro}"> disabled</c:if>>
																<div></div> 
																<fmt:message bundle="${storeText}" key="confirm" />
														</label> 
														<div class="gutter"></div>
														<label class="radioButtonContainer" for="part"> 
															<input type="radio" class="radioLP" name="propart" id="part" value="0" <c:if test="${(empty WCParam.isPro || !WCParam.isPro) && !lockPro}">checked</c:if> onclick="document.getElementById('iampro').style.display = 'none';" <c:if test="${lockPro}"> disabled</c:if>>
															<div></div>
															<fmt:message bundle="${storeText}" key="unconfirm" /> 
														 </label>
													</div>
													<div class="clearAll"></div>
													--%>
													
													<c:if test="${extendedUserContext.isPro}">
														
														<%-- Code APE --%>
														<div class="column column_20 bcolumn_100" id="CodeApeContainer">
															<div class="column_label" id="CodeApeLabel">
																<span class="spanacce">
																	<label for="demographicField7">
																		<fmt:message bundle="${storeText}" key="apeFieldLabel" />
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="apeFieldLabel" />
															</div>
															<input size="4" maxlength="5" aria-required="true" name="demographicField7" id="demographicField7" type="text" value="${demographicField7}" disabled />
														</div>
														<div class="gutter"></div>
													
														<%-- Activité principale --%>
														<div class="column column_77 bcolumn_100" id="MainActiviteContainer">
															<div class="column_label" id="MainActiviteLabel">
																<span class="spanacce"> 
																	<label>
																		<fmt:message bundle="${storeText}" key="activitePrincipaleFieldLabel" /> 
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="activitePrincipaleFieldLabel" />
															</div>
															<input list="demographicField7LabelList" type="text" id="demographicField7Label" value="<fmt:message bundle="${storeListe}" key="Activite_${demographicField7}" />" disabled />
														</div>
														<div class="clearAll"></div>
														
														<%-- Effectif --%>
														<div class="column column_48-5 bcolumn_100" id="EffectifContainer">
															<div class="column_label" id="EffectifLabel">
																<span class="spanacce">
																	<label for="WC_UserRegistrationUpdateForm_FormInput_logonPassworderify_In_Register_1">
																		<fmt:message bundle="${storeText}" key="effectifFieldLabel" />
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="effectifFieldLabel" />
															</div>
															<div class="dropdownLP">
																<select name="codeEffectif">
																	<option value="" disabled selected>
																		<fmt:message bundle="${storeText}" key="chooseListBoxValue" />
																	</option>
																	<c:forTokens items="${listEffectif}" delims="," var="token">
																		<option value="<c:out value='${token}'/>" <c:if test="${token == codeEffectif}">selected</c:if>>
																			<fmt:message bundle="${storeListe}" key="Effectif_${token}" />
																		</option>
																	</c:forTokens>
																</select>
															</div>
														</div>
														<div class="clearAll"></div>
														
														<%-- Siret --%>
														<div class="column column_44 bcolumn_100" id="SiretContainer">
															<div class="column_label" id="SiretLabel">
																<span class="spanacce">
																	<label for="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1">
																		<fmt:message bundle="${storeText}" key="siretFieldLabel" />
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="siretFieldLabel" />
																<span class="required-field"
																	id="WC_UserRegistrationUpdateForm_div_18"> *</span>
															</div>
															<div class="column column_20 ">
																<input size="3" maxlength="3" aria-required="true" name="siret" id="" type="text" value="${fn:substring(demographicField5, 0,3)}" class="siretNum" onblur="verifNames(this);" <c:if test="${lockPro}"> disabled</c:if>>
															</div>
															<div class="gutterDash"></div>
															<div class="column column_20">
																<input size="3" maxlength="3" aria-required="true" name="siret" id="" type="text" value="${fn:substring(demographicField5, 3,6)}" class="siretNum" onblur="verifNames(this);" <c:if test="${lockPro}"> disabled</c:if>>
															</div>
															<div class="gutterDash"></div>
															<div class="column column_20">
																<input size="3" maxlength="3" aria-required="true" name="siret" id="" type="text" value="${fn:substring(demographicField5, 6,9)}" class="siretNum" onblur="verifNames(this);" <c:if test="${lockPro}"> disabled</c:if>>
															</div>
															<div class="gutterDash"></div>
															<div class="column column_20">
																<input size="5" maxlength="5" aria-required="true" name="siret" id="" type="text" value="${fn:substring(demographicField5, 9,14)}" class="siretNum" onblur="verifNames(this);"<c:if test="${lockPro}"> disabled</c:if>>
															</div>
														</div>
														<div class="gutter mobile-hidden"></div>
														<div class="gutter mobile-hidden"></div>
														
														<%-- TVA --%>
														<div class="column column_50 bcolumn_100" id="TvaNumContainer">
															<div class="column_label" id="TvaNumLabel">
																<span class="spanacce">
																	<label for="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1">
																		<fmt:message bundle="${storeText}" key="numeroTVAFieldLabel" />
																	</label>
																</span>
																<fmt:message bundle="${storeText}" key="numeroTVAFieldLabel" />
															</div>
															<div class="column column_15 bcolumn15">
																<input size="2" maxlength="2" name="tva" id="" type="text" placeholder="FR" class="tvaNum" style="text-transform:uppercase;" onblur="verifNames(this);" value="${fn:substring(taxPayerId, 0,2)}" class="siretNum" onblur="verifNames(this);">
															</div>
															<div class="gutterDash"></div>
															<div class="column column_15 bcolumn15">
																<input size="2" maxlength="2" name="tva" id="" type="text" placeholder="00" class="tvaNum" onblur="verifNames(this);" value="${fn:substring(taxPayerId, 2,4)}" class="siretNum" onblur="verifNames(this);">
															</div>
															<div class="gutterDash"></div>
															<div class="column column_15 bcolumn15">
																<input size="2" maxlength="3" name="tva" id="" type="text" placeholder="000" class="tvaNum" onblur="verifNames(this);" value="${fn:substring(taxPayerId, 4,7)}" class="siretNum" onblur="verifNames(this);">
															</div>
															<div class="gutterDash"></div>
															<div class="column column_15 bcolumn15">
																<input size="2" maxlength="3" name="tva" id="" type="text" placeholder="000" class="tvaNum" onblur="verifNames(this);" value="${fn:substring(taxPayerId, 7,10)}" class="siretNum" onblur="verifNames(this);">
															</div>
															<div class="gutterDash"></div>
															<div class="column column_15 bcolumn15">
																<input size="2" maxlength="3" name="tva" id="" type="text" placeholder="000" class="tvaNum" onblur="verifNames(this);" value="${fn:substring(taxPayerId, 10,14)}" class="siretNum" onblur="verifNames(this);">
															</div>
														</div>
														<div class="clearAll"></div>
														<span id="errorTva" class="error" style="display: none;"><fmt:message bundle="${storeText}" key="InvalidNumTvaErrorMessage"/></span>
														<div class="clearAll"></div>
													</c:if>
												
												<div class="sep"></div>
												
												<h2 class="titleBlock"><fmt:message bundle="${storeText}" key="changePasswordSectionTitle"/></h2>
												<div class="column column_48-5 bcolumn_100" id="oldPasswordContainer">
														<div class="column_label" id="oldPasswordLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_oldlogonPassword_In_Register_1">
																	<fmt:message bundle="${storeText}" key="formerPasswordFieldlabel" />
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="formerPasswordFieldlabel" />
															<span class="required-field" id="WC_UserRegistrationUpdateForm_div_15"> **</span>
														</div>
														<c:set var="isChangePassError" value="${!empty errorMessage && changePasswordErrorMessage eq errorMessage}" />
														<input size="35" maxlength="100" aria-required="true" name="oldLogonPassword" id="WC_UserRegistrationUpdateForm_FormInput_oldlogonPassword_In_Register_1" type="password" value="" onchange="EnableUpdate(this, '')" required="" <c:if test="${isChangePassError}">class="error"</c:if>>
														<c:if test="${isChangePassError}">
															<label id="WC_UserRegistrationUpdateForm_FormInput_oldlogonPassword_In_Register_1-error" class="error" for="WC_UserRegistrationUpdateForm_FormInput_oldlogonPassword_In_Register_1">${errorMessage}</label>
															<script> window.location = '#changePassBlock';</script>
														</c:if>
												</div>
												<div class="clearAll"></div>
												<div class="column column_48-5 bcolumn_100" id="PasswordContainer">
														<div class="column_label" id="PasswordLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1">
																	<fmt:message bundle="${storeText}" key="newPasswordFieldLabel" />
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="newPasswordFieldLabel" />
															<span class="required-field" id="WC_UserRegistrationUpdateForm_div_15"> **</span>
														</div>
														<input size="35" maxlength="100" aria-required="true" name="logonPassword" id="WC_UserRegistrationUpdateForm_FormInput_logonPassword_In_Register_1" type="password" value="" required="">
												</div>
												<div class="gutter"></div>
												<div class="column column_48-5 bcolumn_100" id="ConfirmPasswordContainer">
														<div class="column_label" id="ConfirmPasswordLabel">
															<span class="spanacce">
																<label for="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1">
																	<fmt:message bundle="${storeText}" key="confirmNewPasswordFieldLabel" />
																</label>
															</span>
															<fmt:message bundle="${storeText}" key="confirmNewPasswordFieldLabel" />
															<span class="required-field" id="WC_UserRegistrationUpdateForm_div_18"> **</span>
														</div>
														<input size="35" maxlength="100" aria-required="true" name="logonPasswordVerify" id="WC_UserRegistrationUpdateForm_FormInput_logonPasswordVerify_In_Register_1" type="password" value="" required="">
												</div>
												<div class="clearAll"></div>
												<div class="column_100">
													<fmt:message bundle="${storeText}" key="changePasswordMandatoryFieldLabel" />
												</div>
												<div class="clearAll"></div>
												<div class="ml">
													<fmt:message bundle="${storeText}" key="inscriptionPageCNILMessage" />
												</div>
												<div class="clear_float"></div>
											</div>
											<div class="button_footer_line no_float">							
												<input onclick="dijit.byId('deleteAccountConf').show();" type="button" class="delete_account button button--minor column_30 bcolumn_90" value="<fmt:message bundle="${storeText}" key="myAccountDeletionLinklabel"/>">
												<%-- Add an authentication token to avoid CSRF attacks --%>
												<input type="hidden" name="authToken" value="${authToken}" id="WC_UserRegistrationUpdateForm_FormInput_authToken_1"/>
												<input id="submitRegistration" type="submit" value='<fmt:message bundle="${storeText}" key="myAccountSubmitButtonlabel"/>'  disabled  class="column_30 bcolumn_90 button green">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						<%@ include file="../../PopIn/deleteAccount.jspf"%>
						<%@ include file="../../PopIn/updateAccount.jspf"%>
						<c:if test="${!empty AccountUpdated && AccountUpdated[0] eq true}">
							<script>
								$() .ready( function() {
									dijit.byId('updateAccountPopin').show();
								});
							</script>
						</c:if>
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
		<c:param name="pageName" value="compteClient" />
	</c:import>
</body>
</html>
