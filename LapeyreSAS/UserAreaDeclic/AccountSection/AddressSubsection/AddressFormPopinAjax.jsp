<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>


<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css" type="text/css" />

<%-- Retrieve url for leMag and lapeyrePro CGV and storeLocatorURL--%>
<%
    String listCivilitePart = ConfigTool.getListValuePropertiesResource().getProperty("CivilitePart");
	String listCivilitePro = ConfigTool.getListValuePropertiesResource().getProperty("CivilitePro");
    String listEtage = ConfigTool.getListValuePropertiesResource().getProperty("Etage");

    request.setAttribute("listCivilitePart",listCivilitePart);
    request.setAttribute("listCivilitePro",listCivilitePro);
    request.setAttribute("listEtage",listEtage);
	
%>
<c:set var="country" value="${CommandContext.country}" scope="request" />
<c:set var="inPopin" value="true" scope="request" />
<%-- si on re�oit l'id de l'adresse : c'est une �dition --%>
<c:set var="AddressURLValue" value="AddressAdd" />
<c:set var="isAddAddress" value="true"/>
<c:if test="${!empty WCParam.addressId}">
	<c:set var="isAddAddress" value="false"/>
	<%-- On r�cup�re l'adresse --%>
	<wcbase:useBean classname="com.ibm.commerce.user.beans.AddressDataBean" id="addressAB">
		<c:set property="dataBeanKeyAddressId" target="${addressAB}" value="${WCParam.addressId}"/>
	</wcbase:useBean>
	<c:set var="AddressURLValue" value="AddressUpdate" />
	<c:set var="nickName" value="${addressAB.nickName}"/>
	<c:set var="firstName" value="${addressAB.firstName}"/>
	<c:set var="lastName" value="${addressAB.lastName}"/>
	<c:set var="personTitle" value="${addressAB.personTitle}"/>
	<c:set var="email1" value="${addressAB.email1}"/>
	<c:set var="phone1" value="${addressAB.phone1}"/>
	<c:set var="mobilePhone1" value="${addressAB.mobilePhone1}"/>
	<c:set var="phone2" value="${addressAB.phone2}"/>
	<c:set var="fax1" value="${addressAB.fax1}"/>
	<c:set var="address1" value="${addressAB.address1}"/>
	<c:set var="address2" value="${addressAB.address2}"/>
	<c:set var="address3" value="${addressAB.address3}"/>
	<c:set var="city" value="${addressAB.city}"/>
	<c:set var="country" value="${addressAB.country}"/>
	<c:set var="zipCode" value="${addressAB.zipCode}"/>
</c:if>
<%-- si on a des donn�es POST : on affiche les donn�es saisies --%>
<c:if test="${!empty WCParam.firstName}">
	<c:set var="firstName" value="${WCParam.firstName}"/>
</c:if>
<c:if test="${!empty WCParam.lastName}">
	<c:set var="lastName" value="${WCParam.lastName}"/>
</c:if>
<c:if test="${!empty WCParam.personTitle}">
	<c:set var="personTitle" value="${WCParam.personTitle}"/>
</c:if>
<c:if test="${!empty WCParam.email1}">
	<c:set var="email1" value="${WCParam.email1}"/>
</c:if>
<c:if test="${!empty WCParam.phone1}">
	<c:set var="phone1" value="${WCParam.phone1}"/>
</c:if>
<c:if test="${!empty WCParam.mobilePhone1}">
	<c:set var="mobilePhone1" value="${WCParam.mobilePhone1}"/>
</c:if>
<c:if test="${!empty WCParam.phone2}">
	<c:set var="phone2" value="${WCParam.phone2}"/>
</c:if>
<c:if test="${!empty WCParam.fax1}">
	<c:set var="fax1" value="${WCParam.fax1}"/>
</c:if>
<c:if test="${!empty WCParam.address1}">
	<c:set var="address1" value="${WCParam.address1}"/>
</c:if>
<c:if test="${!empty WCParam.address2}">
	<c:set var="address2" value="${WCParam.address2}"/>
</c:if>
<c:if test="${!empty WCParam.address3}">
	<c:set var="address3" value="${WCParam.address3}"/>
</c:if>
<c:if test="${!empty WCParam.city}">
	<c:set var="city" value="${WCParam.city}"/>
</c:if>
<c:if test="${!empty WCParam.country}">
	<c:set var="country" value="${WCParam.country}"/>
</c:if>
<c:if test="${!empty WCParam.zipCode}">
	<c:set var="zipCode" value="${WCParam.zipCode}"/>
</c:if>
<c:if test="${!empty WCParam.nickName}">
	<c:set var="nickName" value="${WCParam.nickName}"/>
</c:if>


<wcf:url var="AddressFormURL" value="${AddressURLValue}">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
<%-- 	<wcf:param name="URL" value="${WCParam.URL}" /> --%>
<%-- 	<wcf:param name="errorViewName" value="${WCParam.errorViewName}" /> --%>
</wcf:url>

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

<wcf:url var="LogonFormURL" value="LogonForm" scope="request" type="Ajax">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="URL" value="${tunnelShippingLink}" />
</wcf:url>

<script id="addressFormInTunnelScript">

var countryTagID = "countryField";
var oldCodePostale = null;

	RNVPService.init('<c:out value="${cityByZipURL}" escapeXml="false"/>','<c:out value="${zipByCityURL}" escapeXml="false"/>');
	RNVPService.elementZip = document.Address.zipCode;
	RNVPService.elementCity = document.Address.city;
	RNVPService.onblurCity(document.Address.city,oldCodePostale);
	
	RNVPService.onblurZip(document.Address.zipCode);
	RNVPService.elementStreet = document.Address.address1;
	RNVPService.elementCitySelector = document.getElementById('citySelector');
	RNVPService.elementZipSelector = document.getElementById('zipCodeSelector');
	RNVPService.elementStreetSelector = document.getElementById('streetSelector');
	RNVPService.onchangedCitySelector(RNVPService.elementCitySelector);
	RNVPService.onchangedStreetSelector(RNVPService.elementStreetSelector);
	RNVPService.onchangedZipSelector(RNVPService.elementZipSelector);	
	
	RNVPService.addErrorMessage(1000,document.Address.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1001,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1002,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1002,document.Address.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1003,document.Address.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1007,document.Address.city,"<fmt:message key='missingCityErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1007,document.Address.zipCode,"<fmt:message key='missingZipcodeErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1009,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1010,document.Address.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1010,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1010,document.Address.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1024,document.Address.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1024,document.Address.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1024,document.Address.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1024,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1024,document.Address.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1025,document.Address.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1025,document.Address.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1025,document.Address.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1025,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1025,document.Address.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1026,document.Address.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1026,document.Address.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1026,document.Address.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1026,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1026,document.Address.city,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1030,document.Address.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1050,document.Address.address1,"<fmt:message key='InvalidStreetErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1050,document.Address.address3,"<fmt:message key='InvalidFloorErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1050,document.Address.address2,"<fmt:message key='InvalidBatimentErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1050,document.Address.zipCode,"<fmt:message key='InvalidZipCodeMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(1050,document.Address.address1,"<fmt:message key='InvalidCityErrorMessage' bundle='${storeText}' />");

	RNVPService.addErrorMessage(9991,document.Address.zipCode,"<fmt:message key='selectZipcodeErrorMessage' bundle='${storeText}' />");
	RNVPService.addErrorMessage(9992,document.Address.city,"<fmt:message key='selectCityErrorMessage' bundle='${storeText}' />");

	$("#WC_UserAddressForm_AddressEntryForm_FormInput_city_1")
	.focus(function(){
		oldCodePostale = $("#WC_UserAddressForm_AddressEntryForm_FormInput_zipCode_1").val();
		RNVPService.onblurCity(document.Address.city,oldCodePostale);
		RNVPService.onchangedZipSelector(RNVPService.elementZipSelector); 
	}); 
	// validate signup form on keyup and submit
	$("#Address")
	.validate(
			{
				rules : {
					personTitle: "required",
					zipCode : {
						required : true,
						maxlength : 20
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
					nickName : {
						required : true,
						maxlength : 100
					},
					addressName : {
						required : true,
						maxlength : 100
					},
					address1 : {
						required : true,
						maxlength : 38
					},
					address2 : {
						maxlength : 38
					},
					email1 : {
						required : false, //0001570: [Formulaire cr�ation adresse] -Carnet adresse : Adresse email obligatoire
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
					nickName : {
						required : "<fmt:message bundle='${storeText}' key='missingAddressNameFieldError' />",
						maxlength : "<fmt:message bundle='${storeText}' key='maxLengthFirstnameFieldErrorMessage' />"
					},
					addressName : {
						required : "<fmt:message bundle='${storeText}' key='missingAddressNameFieldError' />",
						maxlength : "<fmt:message bundle='${storeText}' key='maxLengthFirstnameFieldErrorMessage' />"
					},
					email1 : {
						required : "<fmt:message bundle='${widgetText}' key='missingEmailErrorMessage' />",
						email : "<fmt:message bundle='${widgetText}' key='InvalidEmailErrorMessage' />",
						maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthEmailErrorMessage' />"
					},
					zipCode : {
						required : "<fmt:message bundle='${widgetText}' key='missingZipCodeMessage' />",
						maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthZipCodeMessage' />"
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
					fax : {
						maxlength : "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />",
						validatePhoneFR : "<fmt:message bundle='${widgetText}' key='InvalidPhoneFormatErrorMessage' />"
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

					

    $('#Address').on('submit', function(e) {
        e.preventDefault(); // J'emp�che le comportement par d�faut du navigateur, c-�-d de soumettre le formulaire
 
 		if(!$("#Address").valid()) {
 			return false;
 		}
 			
        var $this = $(this);
 		if(!submitRequest()) {
			return false;
 		}
		cursor_wait();	
		
	  	
	  	function addAddress() {
	  		return $.ajax({
		        url: $this.attr('action'),
		        type: $this.attr('method'),
		        data: $this.serialize(),
		        dataType: 'json'
	        });
	  	}
	  	
	  	function processAddAddressResponse(json) {
	  		cursor_clear();
	  		
	  		var deferred = $.Deferred();
	  		
	  		if (json.status == 'success') {
	  			deferred.resolve(json);
	  			
	  		} else {
	  			if(json.errorMessage != null && json.errorMessage != "") {
      	  			$('#WC_UserAddressForm_span_1').html(json.errorMessage);
      	  			if(json.sessionExpiredError != null && json.sessionExpiredError == true) {
          	  			document.location.href = '${LogonFormURL}';
          			}
      	  		} else {
      	  			$('#WC_UserAddressForm_span_1').html('');
      	  			if(json.rnvpErrorCode != "") {
      					RNVPService.showErrorByCode(json.rnvpErrorCode);		
      				}
      				if(json.rnvpIsBreak == true) {
						if(json.rnvpIsCitySelection == true) {
							RNVPService.showCitySelection(json.choices);
							showErrorMessageForElement(document.Address.city,"<fmt:message key='selectCityErrorMessage' bundle='${storeText}' />");
						}                  		
						if(json.rnvpIsStreetSelection == true) {
							RNVPService.showStreetSelection(json.choices);
							showErrorMessageForElement(document.Address.address1,"<fmt:message key='selectStreetErrorMessage' bundle='${storeText}' />");
						}                  		
      				}
      	  		}
	  			deferred.reject(json);
	  		}
	  		
	  		return deferred.promise();
	  	}
	  	
	  	function billingAddressUpdate(data) {
	  		if(${extendedUserContext.isPro eq false}){
				return changeFacturationAddress(data.addressId);
	  		}else{
	  			return true;
	  		}
	  	}
	  	
	  	function reloadPage() {
	  		window.location.reload();        	
	  	}
	  	
	  	addAddress()
	  		.then(processAddAddressResponse)
	  			.then(billingAddressUpdate)
	  				.done(reloadPage);
    });

</script> 
<%@ include file="AddressForm_UI.jspf" %>	

