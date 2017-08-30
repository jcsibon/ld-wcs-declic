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
<%@ include file="../../../include/RNVPErrorMessageSetup.jspf"%>

<fmt:setBundle basename="/${sdb.jspStoreDir}/storelist" var="storeListe" scope="request"/>

<c:set var="country" value="${CommandContext.country}" scope="request" />
<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>


<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="ADDRESSBOOK_TITLE" /></title>
<META NAME="robots" CONTENT="noindex,nofollow"/>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css" />
<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css?${versionNumber}" type="text/css" />

<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>

	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js?${versionNumber}"/>"></script>
	
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



<script>
var countryTagID = "countryField";
		
	$() .ready( function() {
						
						var oldCodePostale = null;
		
						RNVPService.init('<c:out value="${cityByZipURL}" escapeXml="false"/>','<c:out value="${zipByCityURL}" escapeXml="false"/>');
						RNVPService.elementZip = document.Address.zipCode;
						RNVPService.onblurCity(document.Address.city,oldCodePostale);
						
						RNVPService.onblurZip(document.Address.zipCode);
						RNVPService.elementCity = document.Address.city;
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
						
						<c:if test="${!empty rnvpErrorCode}" >
								RNVPService.showErrorByCode('<c:out value="${rnvpErrorCode}" />');		
						</c:if>
						<c:if test="${rnvpIsBreak eq 'true'}" >
								var choices = <c:out value='${rnvpChoices}' escapeXml="false" />;
								<c:if test="${rnvpIsCitySelection eq 'true'}" >
									RNVPService.showCitySelection(choices);
									showErrorMessageForElement(document.Address.city,"<fmt:message key='selectCityErrorMessage' bundle='${storeText}' />");
								</c:if>
								<c:if test="${rnvpIsStreetSelection eq 'true'}" >
									RNVPService.showStreetSelection(choices);
									showErrorMessageForElement(document.Address.address1,"<fmt:message key='selectStreetErrorMessage' bundle='${storeText}' />");
								</c:if>	
						</c:if>
						
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
													required : false, //0001570: [Formulaire création adresse] -Carnet adresse : Adresse email obligatoire
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
					});
</script>
<script type="text/javascript">
	function popupWindow(URL) {
		window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
	}
</script>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
       <wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>
<flow:ifEnabled feature="Analytics">
	<cm:registration personType="${person}"/>
</flow:ifEnabled>

<c:remove var="nickName"/>
<c:remove var="firstName"/>
<c:remove var="lastName"/>
<c:remove var="personTitle"/>
<c:remove var="email1"/>
<c:remove var="phone1"/>
<c:remove var="mobilePhone1"/>
<c:remove var="phone2"/>
<c:remove var="fax1"/>
<c:remove var="address1"/>
<c:remove var="address2"/>
<c:remove var="address3"/>
<c:remove var="city"/>
<c:remove var="country"/>
<c:remove var="zipCode"/>

<%-- si on reçoit l'id de l'adresse : c'est une édition --%>
<c:set var="AddressURLValue" value="AddressAdd" />
<c:set var="isAddAddress" value="true"/>
<c:if test="${!empty WCParam.addressId}">
	<c:set var="isAddAddress" value="false"/>
	<%-- On récupère l'adresse --%>
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
<%-- si on a des données POST : on affiche les données saisies --%>
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
</wcf:url>

<wcf:url var="AddressReturnFormURL" value="AjaxAccountAddressForm" type="Ajax">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="addressId" value="${WCParam.addressId}" />
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
							<c:choose>
								<c:when test="${empty WCParam.addressId}">
									<fmt:message var="lastBreadCrumbItem" key="addAddressBreadcrumbLabel" bundle="${widgetText}" />
								</c:when>
								<c:otherwise>
									<c:set var="lastBreadCrumbItem" value="${nickName}" />
								</c:otherwise>
							</c:choose>
							<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
									<c:param name="pageName" value="CompteClient" />
									<c:param name="breadCrumbMonCompte" value="true" />
									<c:param name="breadCrumbMesAdresses" value="true" />
									<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
							</c:import>
							<%out.flush();%>
                    	</div>
                	 </div>
                	 
					<!-- Menu client start -->
						<c:set var="navMonCompteCurrentPage" value="myAddresses"/>
						<c:set var="navMonCompteCurrentPageClass" value="current"/>
						<%--@ include file="../headerClient.jspf" --%>
					<!-- Menu client end-->
					<div class="row" id="myAddressFormPage">
						<div id="navCompteClient" class="col3 mobile-hidden">
							<%@ include file="../navClient.jspf" %>
						</div>
						<div class="col9 bcol12 mainContentWrapper">
							<div class="monCompte">
								<a id="addressReturnButton" href="${addressBookURL}" class="button back"><fmt:message bundle="${storeText}" key="addressReturnButtonLabel"/></a>
								<h2 class="titleBlock">
									<c:choose>
										<c:when test="${empty WCParam.addressId}">
											<fmt:message bundle="${storeText}" key="myAddressesAddPageTitle"/>
										</c:when>
										<c:otherwise>
											<fmt:message bundle="${storeText}" key="myAddressesEditPageTitle"/>
										</c:otherwise>
									</c:choose>
								</h2>
								<p><fmt:message bundle="${storeText}" key="mandatoryFieldsLabel"/></p>
							</div>
							<div class="row">
								<%@ include file="AddressForm_UI.jspf" %>	
							</div>
						</div>
					</div>
			</div>
			<% out.flush(); %>
				<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
			<% out.flush(); %>
		</div>
	</div>
</div>
<c:import url="../../../TagManager/TagManager.jsp" >
	<c:param name="pageGroup" value="espaceClient" />
	<c:param name="pageName" value="AddUpdateUserAddress" />
</c:import>
</body>
</html>