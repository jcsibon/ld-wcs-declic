function affPhonesInput() {
	$('.phones + br').css('display','block');
	$('.phones').css('display','block');
	$('#addPhone').css('display','none');
}

function concateName(name){
	return [].map.call(document.getElementsByName(name), function(e) { return e.value }).join('');
}

function selectCountry(){
	document.getElementById("countryField").disable=false;
	document.getElementById("countryDiv").style.display="block";
	document.getElementById("textCountry").style.display="none";
	document.getElementById("editCountry").style.display="none";
	return false;
}

function DeleteAddressView(idAddress) {
	var form = document.deleteAddressForm;
	form.addressId.value = idAddress;
	dijit.byId('deleteAddressConf').show();
}

function switchAddress(idAddress){
	var form = document.AddressSwitchToPrimary;
	form.addressId.value = idAddress;
	form.submit();
}

function validSiretTva(siret,tva){
	if(tva.substring(0,2).toUpperCase()=="FR"){
		var compSiret = siret.substring(0,9);
		var compTva = tva.substring(4);
		if (compTva==compSiret) {
			document.getElementById('errorTva').style.display="none";
			return true;
		} else {
			document.getElementById('errorTva').style.display="block";
			return false;
		}
	}
	document.getElementById('errorTva').style.display="none";
}

function verifNames(num){
	var TVA="";
	var SIRET="";
	if(num.name=="tva"){
		TVA = concateName(num.name);
		if(TVA.length==13){
			SIRET = concateName("siret");
			if(SIRET.length==14){
				validSiretTva(SIRET,TVA);
			}
		}
	}
	else if(num.name=="siret"){
		SIRET = concateName(num.name);
		if(SIRET.length==14){
			TVA = concateName("tva");
			if(TVA.length==13){
				validSiretTva(SIRET,TVA);
			}
		}
	} 
}
function clearErrorForElement(element){
	var oldLabelElementError = document.getElementById(element.getAttribute('id')+'-error');
	if(oldLabelElementError != undefined){
		element.parentNode.removeChild(oldLabelElementError);
	}	
}
function showErrorMessageForElement(element,message){
	var oldLabelElementError = document.getElementById(element.getAttribute('id')+'-error');
	if(oldLabelElementError != undefined){
		element.parentNode.removeChild(oldLabelElementError);
	}
	var labelElementError = document.createElement('label');
	labelElementError.setAttribute('id',element.getAttribute('id')+'-error');
	labelElementError.setAttribute('for',element.getAttribute('id'));
	labelElementError.setAttribute('class','error');
	labelElementError.innerHTML = message;
	element.parentNode.appendChild(labelElementError);
}

function toggleProPart() {
	if(is_Pro) {
		$('#pro-title').removeClass("disabled");		
		$('#pro-title').addClass("enabled");
		$('#part-title').removeClass("enabled");
		$('#part-title').addClass("disabled");
		$('.forPro').show();
		$('.forPart').hide();
	} else {
		$('#pro-title').removeClass("enabled");		
		$('#pro-title').addClass("disabled");
		$('#part-title').removeClass("disabled");
		$('#part-title').addClass("enabled");
		$('.forPro').hide();
		$('.forPart').show();
	}
}

function isPro() {
	return $("#pro-title").hasClass("enabled");
}

function copyDataToSyncFormAndGoToSync(){
	var formRegister = document.Register,
	    formGoToSynchro = document.GoToSynchroForm;
	formGoToSynchro.email1.value = formRegister.email1.value;
	formGoToSynchro.personTitle.value = formRegister.personTitle.value;
	formGoToSynchro.firstName.value = formRegister.firstName.value;
	formGoToSynchro.lastName.value = formRegister.lastName.value;
	formGoToSynchro.legalEntity.value = formRegister.legalEntity.value;
	formGoToSynchro.organizationName.value = formRegister.organizationName.value;
	formGoToSynchro.address1.value = formRegister.address1.value;
	formGoToSynchro.address2.value = formRegister.address2.value;
	formGoToSynchro.address3.value = formRegister.address3.value;
	formGoToSynchro.zipCode.value = formRegister.zipCode.value;
	formGoToSynchro.city.value = formRegister.city.value;
	formGoToSynchro.country.value = formRegister.country.value;
	formGoToSynchro.phoneNumber.value = formRegister.phoneNumber.value;
	formGoToSynchro.phoneType.value = formRegister.phoneType.value;
	if(formRegister.propart.value == '1'){
		formGoToSynchro.isPro.value = 'true';
		formGoToSynchro.demographicField5.value = concateName("siret");
		formGoToSynchro.demographicField7.value = formRegister.demographicField7.value;
	}
	formGoToSynchro.submit();
}


function computePostDataToSearchClientCallRegister() {
	var formRegister = document.Register;
	var postData = "storeId="+formRegister.storeId.value;
	if(formRegister.country.value) {
		postData += "&countryCode="+formRegister.country.value;
	}
	//FIXME:passer l'email. ne pas activer, car pour l'heure le score>90 n'est pas gere
	//if(formRegister.email1.value){ postData += "&email="+formRegister.email1.value; }
	
	if(formRegister.lastName.value) {
		postData += "&lastName="+formRegister.lastName.value;
	}
	if(isPro() && formRegister.organizationName.value) {
		postData += "&raisonSociale="+formRegister.organizationName.value;
	}
	if(formRegister.firstName.value) {
		postData += "&firstName="+formRegister.firstName.value;
	}
	if(formRegister.zipCode.value) {
		postData += "&zipCode="+formRegister.zipCode.value;
	}
	if(formRegister.city.value) {
		postData += "&city="+formRegister.city.value;
	}
	if(formRegister.personTitle.value) {
		postData += "&civilityCode="+formRegister.personTitle.value;
	}
	if(formRegister.address1.value) {//Bat. Imm. R�s.
		postData += "&address1="+formRegister.address2.value;
	}
	if(formRegister.address2.value) {//�tage
		postData += "&address2="+formRegister.address3.value;
	}
	if(formRegister.address3.value) {//num, type et nom de voie
		postData += "&address3="+formRegister.address1.value;
	}
	if(isPro()) {
		if(formRegister.demographicField5.value){
			postData += "&siret="+formRegister.demographicField5.value;
		}
		else if(formRegister.siret[0].value && formRegister.siret[1].value && formRegister.siret[2].value && formRegister.siret[3].value){
			postData += "&siret="+concateName("siret");
		}
		postData += "&isPro=true";
		
	} else {
		postData += "&isPro=false";
	}
	return postData;
}

function computePostDataToSearchClientCallSynchro() {
	var formSynchro = document.Synchro,
		postData = '';
	
	if(isPro()) {
		postData += "isPro=true";
		
		if (formSynchro.organizationName.value) {
			postData += "&lastName="+formSynchro.organizationName.value;
		}
		if (formSynchro.siret[0].value && formSynchro.siret[1].value && formSynchro.siret[2].value && formSynchro.siret[3].value) {
			postData += "&siret="+concateName("siret");
		}
		if (formSynchro.clientId.value) {
			postData += "&clientId="+formSynchro.clientId.value;
		} 
		
	} else {
		postData += "isPro=false";
		
		if (formSynchro.personTitle.value) {
			postData += "&civilityCode="+formSynchro.personTitle.value;
		}
		if (formSynchro.firstName.value) {
			postData += "&firstName="+formSynchro.firstName.value;
		}
		if (formSynchro.lastName.value) {
			postData += "&lastName="+formSynchro.lastName.value;
		}
		if (formSynchro.shopId.value) {
			postData += "&idMag="+formSynchro.shopId.value;
		}
		if (formSynchro.documentType.value) {
			postData += "&typeDoc="+formSynchro.documentType.value;
		}
		if (formSynchro.documentNumber.value) {
			postData += "&numeroDoc="+formSynchro.documentNumber.value;
		}
	}
	
	//FIXME:passer l'email. ne pas activer, car pour l'heure le score>90 n'est pas gere
	//if(formSynchro.email1.value){	postData += "&email="+formSynchro.email1.value;		}
	
	return postData;
}

function clientSearchAndSubmit(form) {
	var urlClientSearch = 'ClientCRMSearchCmd';
	var formRegister = document.Register;
	var pro = isPro();
	
	if ((!pro && formRegister.lastName.value) || (pro && formRegister.organizationName.value)) {
		
		if(!submitRequest()) {
			return false;
		}
		cursor_wait();
		
		//disable submit button
		$('#submitRegistration').attr('disabled','disabled');
		$('#submitRegistration').addClass('disabled').removeClass('green'); 
		
		$.ajax({
			url : urlClientSearch,
			type : 'POST',
			dataType : 'json',
			data : computePostDataToSearchClientCallRegister(),
			success : function(response, statut) {
				if (response.status == 'OK') {
					var idCRM = response.result.codeClient;
					formRegister.idCRM.value = idCRM;
					formRegister.sync.value = 'true';
				}else{
					formRegister.idCRM.value = '';
					formRegister.sync.value = 'false';
				}
				form.submit();
			},
			error : function(xhr, desc, err) {
				formRegister.idCRM.value = '';
				formRegister.sync.value = 'false';
				form.submit();
			}
		});
		return false;
	}
}

function clientSearchAndShowPopup(form){
	var urlClientSearch = 'ClientCRMSearchCmd';
	var formSynchro = document.Synchro;
	if($('#part:checked') != undefined && $('#part:checked').length > 0){
		urlClientSearch = 'ClientCRMSearchByDocCmd';
	}
	console.log('start calling:'+urlClientSearch);
	
	//r�initialise responseSearchClientJSON 
	responseSearchClientJSON = null;
	
	$.ajax({
		url : urlClientSearch,
		type : 'POST',
		dataType : 'json',
		data : computePostDataToSearchClientCallSynchro(),
		success : function(response, statut) {
			if (response.status == 'OK') {
				fillFormWithIdCRM(response.result.codeClient);
				//Mantis 1057
				if(response.result.informationsPro!=null){
					fillFormWithCodeAPE(response.result.informationsPro.codeAPEPrincipal)
				}
				fillPopupFromResponse(response);
				dijit.byId('popinSynchroOK').show();
			}
			else{
				resetFormIdCRM();
				dijit.byId('popinSynchroKO').show();
			}
		},
		error : function(xhr, desc, err) {
			resetFormIdCRM();
			dijit.byId('popinSynchroKO').show();
		}
	});
	return false;
}

var responseSearchClientJSON = null;

function copyDataToRegistrationFormAndGoToRegistration() {
	var formSynchro = document.Synchro,
	    formGoToRegistration = document.GoToRegistrationForm;
	
	formGoToRegistration.email1.value = formSynchro.email1.value;
	formGoToRegistration.personTitle.value = formSynchro.personTitle.value;
	formGoToRegistration.firstName.value = formSynchro.firstName.value;
	formGoToRegistration.lastName.value = formSynchro.lastName.value;
	formGoToRegistration.organizationName.value = formSynchro.organizationName.value;
	
	if(isPro()) {
		formGoToRegistration.isPro.value = 'true';
		formGoToRegistration.demographicField5.value = concateName("siret");
	} else {
		formGoToRegistration.isPro.value = 'false';
	}
	
	formGoToRegistration.submit();
}

function fillFormWithIdCRM(idCRM){
	document.Synchro.idCRM.value = idCRM;
}

function fillFormWithCodeAPE(codeAPE){
	document.Synchro.demographicField7.value = codeAPE;
}

function resetFormIdCRM(){
	document.Synchro.idCRM.value = '';
	document.Synchro.sync.value = 'false';
}

function fillPopupFromResponse(response){
	responseSearchClientJSON = response;
	var popupSynchro = $('#synchroPopContentInfos'),
	    result= response.result;
	
	
	if (result.informationsPro) {
		fillPopupField(popupSynchro, '.legalEntity', $('#legalEntity').find('option[value^="' + result.codeCivilite + '"]').html());
		fillPopupField(popupSynchro, '.organizationName', result.nom);
		fillPopupField(popupSynchro, '.siret', result.informationsPro.siret);
		hidePopupField(popupSynchro, '.personTitle, .lastName, .firstName');
		
	} else {
		fillPopupField(popupSynchro, '.personTitle', $('#civilityField').find('option[value^="' + result.codeCivilite + '"]').html());
		fillPopupField(popupSynchro, '.lastName', result.nom);
		fillPopupField(popupSynchro, '.firstName', result.prenom);
		hidePopupField(popupSynchro, '.siret, .organizationName, .legalEntity');
	}
	
	var primaryAddress = null;
	if(result.adresses && result.adresses.adresse && result.adresses.adresse.length > 0) {
		for(var i=0;i<result.adresses.adresse.length; i++) {
			var tmpAddress = result.adresses.adresse[i];
			if(tmpAddress.codeTypeAdresse && tmpAddress.codeTypeAdresse == 'PRI') {
				primaryAddress = tmpAddress;
				break;
			}
		}
	}
	
	fillPopupField(popupSynchro, '.email', document.Synchro.email1.value);
	
	if (primaryAddress) {
		fillPopupField(popupSynchro, '.address1', primaryAddress.adresse3);
		fillPopupField(popupSynchro, '.address2', primaryAddress.adresse1);
		fillPopupField(popupSynchro, '.address3', primaryAddress.etage);
		fillPopupField(popupSynchro, '.city',     primaryAddress.ville);
		fillPopupField(popupSynchro, '.country',  primaryAddress.codePays);
		fillPopupField(popupSynchro, '.zipCode',  primaryAddress.codePostal);
		
	} else {
		hidePopupField(popupSynchro, '.address1, .address2, .address3, .city, .country, .zipCode');
	}
}

function fillPopupField(popup, fieldSelector, value, defaultValue) {
	if (value || defaultValue) {
		popup.find(fieldSelector).show().filter('dd').html(value || defaultValue);
	} else {
		hidePopupField(popup, fieldSelector);
	}
}

function hidePopupField(popup, fieldSelector) {
	popup.find(fieldSelector).hide();
}

function submitSynchroFormOnValidSynchroPopin() {
	var formSynchro = document.Synchro;
	if(responseSearchClientJSON != null && responseSearchClientJSON.result != null) {
		var response = responseSearchClientJSON;
		//identite
		if(response.result.prenom && trim(response.result.prenom).length > 0) {
			formSynchro.firstName.value = response.result.prenom;
		}
		
		if(response.result.nom && trim(response.result.nom).length > 0) {
			formSynchro.lastName.value = response.result.nom;
		}
		
		if(response.result.numTelPortable && trim(response.result.numTelPortable).length > 0) {
			formSynchro.mobilePhone1.value = response.result.numTelPortable.replace('+33','0');
		}
		
		if(response.result.numTelPerso && trim(response.result.numTelPerso).length > 0) {
			formSynchro.phone1.value = response.result.numTelPerso.replace('+33','0');
		}
		
		//zone address
		var primaryAddress = null;
		if(response.result.adresses && response.result.adresses.adresse && response.result.adresses.adresse.length > 0) {
			for(var i=0;i<response.result.adresses.adresse.length; i++) {
				var tmpAddress = response.result.adresses.adresse[i];
				if(tmpAddress.codeTypeAdresse && tmpAddress.codeTypeAdresse == 'PRI') {
					primaryAddress = tmpAddress;
					break;
				}
			}
		}
		
		if(primaryAddress != null) {
			if(primaryAddress.adresse3) {
				if(formSynchro && formSynchro.address1) {
					formSynchro.address1.value = primaryAddress.adresse3;
				}
			}
			if(primaryAddress.adresse1) {
				if(formSynchro && formSynchro.address2) {
					formSynchro.address2.value = primaryAddress.adresse1;
				}
			}
			
			if(primaryAddress.etage){
				if(formSynchro && formSynchro.address3) {
					formSynchro.address3.value = primaryAddress.etage;
				}
			}
			if(primaryAddress.ville) {
				if(formSynchro && formSynchro.city) {
					formSynchro.city.value = primaryAddress.ville;
				}
			}
			if(primaryAddress.codePays) {
				if(formSynchro && formSynchro.country) {
					formSynchro.country.value = primaryAddress.codePays;
				}
			}
			if(primaryAddress.codePostal) {
				if(formSynchro && formSynchro.zipCode) {
					formSynchro.zipCode.value = primaryAddress.codePostal;
				}
			}
		}
		
		var infosPro = response.result.informationsPro; 
		if (infosPro) {
			
			formSynchro.isPro.value = 'true';
			
			if (response.result.nom && trim(response.result.nom).length > 0) {
				formSynchro.organizationName.value = response.result.nom;
			}
			if (response.result.numTelPro && trim(response.result.numTelPro).length > 0) {
				formSynchro.phone1.value = response.result.numTelPro.replace('+33','0');
			}
			if (response.result.codeCivilite && trim(response.result.codeCivilite).length > 0) {
				formSynchro.legalEntity.value = response.result.codeCivilite;
				formSynchro.legalEntityLabel.value = $('#legalEntity').find('option[value^="' + response.result.codeCivilite + '"]').html().trim();
			}
			if (infosPro.siret && trim(infosPro.siret).length > 0) {
				formSynchro.demographicField5.value = infosPro.siret;
			}
			if (infosPro.codeAPEPrincipal && trim(infosPro.codeAPEPrincipal).length > 0) {
				formSynchro.demographicField7.value = infosPro.codeAPEPrincipal;
			}
		}
	}
	
	formSynchro.submit();
}