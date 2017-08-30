<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="../../../Common/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../../Common/nocache.jspf" %>
<%@ include file="../../../include/RNVPErrorMessageSetup.jspf"%>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message bundle="${storeText}" key="SYNCHRO_TITLE"/></title>
	<META NAME="robots" CONTENT="noindex,nofollow">
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
	<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css?${versionNumber}" type="text/css" />
	
	<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
	
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
<wcf:url var="RNVPAdjustmentURL" value="RNVPAdjustmentCmd" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<script>
	var countryTagID = "countryField";
	$().ready( function() {
		<c:if test="${!empty WCParam.personTitle}" >
			document.Synchro.personTitle.value = '<c:out value="${WCParam.personTitle}" />';
		</c:if>
		<c:if test="${!empty WCParam.isPro && WCParam.isPro eq 'true'}" >
			document.Synchro.propart.value = "1";
			<c:if test="${!empty WCParam.demographicField5}" >
				var siret = '<c:out value="${WCParam.demographicField5}" />';
				document.Synchro.siret[0].value = siret.substring(0,3);
				document.Synchro.siret[1].value = siret.substring(3,6);
				document.Synchro.siret[2].value = siret.substring(6,9);
				document.Synchro.siret[3].value = siret.substring(9);
				document.Synchro.demographicField5.value = siret;
			</c:if>
		</c:if>
		
		toggleProPart();
	
		// validate signup form on keyup and submit
		$("#Synchro").validate({
			rules : {
				personTitle: {
					required: true
				},
				firstName: {
					required: true,
					maxlength: 60
				},
				lastName: {
					required: true,
					maxlength: 40
				},
				organizationName : {
					required : "#pro:checked",
					maxlength : 40
				},
				email1 : {
					required: true,
					email: true,
					maxlength: 100
				},
				logonPassword: {
					required: true,
					passwordTest: true,
					maxlength: 100,
					minlength: 6,
				},
				logonPasswordVerify: {
					required: true,
					equalTo: "#logonPassword"
				},
				siret: {
					required: true,
					require_from_group: [4, ".siretNum"],
					checkLuhnKey: ".siretNum"
				},
				clientId : {
					required: true
				},
				documentType : {
					required : "#part:checked"
				},
				documentNumber: {
					required: "#part:checked"
				},
				shopId: {
					required: '#part:checked',
					digits: true
				}
			},
			messages: {
				personTitle: "<fmt:message bundle='${storeText}' key='missingPersontitleErrorMessage' />",
				firstName: {
					required: "<fmt:message bundle='${storeText}' key='missingFirstnameFieldErrorMessage' />",
					maxlength: "<fmt:message bundle='${storeText}' key='maxLengthFirstnameFieldErrorMessage' />"
				},
				lastName: {
					required: "<fmt:message bundle='${storeText}' key='missingLastameFieldErrorMessage' />",
					maxlength: "<fmt:message bundle='${storeText}' key='maxLengthLastnameFieldErrorMessage' />"
				},
				organizationName : {
					required : "<fmt:message bundle='${storeText}' key='missingRaisonSocialeErrorMessage' />",
					maxlength : "<fmt:message bundle='${storeText}' key='maxLengthraisonSocialeErrorMessage' />"
				},
				email1: {
					required: "<fmt:message bundle='${storeText}' key='missingLoginErrorMessage' />",
					email: "<fmt:message bundle='${storeText}' key='InvalidLoginErrorMessage' />",
					maxlength: "<fmt:message bundle='${storeText}' key='maxLengthLoginErrorMessage' />"
				},
				logonPassword: {
					required: "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />",
					passwordTest: "<fmt:message bundle='${storeText}' key='InvalidPasswordErrorMessage' />",
					maxlength: "<fmt:message bundle='${storeText}' key='maxlengthPasswordErrorMessage' />",
					minlength: "<fmt:message bundle='${storeText}' key='minlengthPasswordErrorMessage' />"
				},
				logonPasswordVerify: {
					required: "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />",
					equalTo: "<fmt:message bundle='${storeText}' key='invalidConfirmPasswordErrorMessage' />"
				},
				siret: {
					require_from_group: "<fmt:message bundle='${storeText}' key='missingSiretErrorMessage' />",
					required: "<fmt:message bundle='${storeText}' key='missingSiretErrorMessage' />",
					checkLuhnKey: "<fmt:message bundle='${storeText}' key='InvalidSiretErrorMessage' />"
				},
				clientId : {
					required: "<fmt:message bundle='${storeText}' key='missingIdCRMErrorMessage' />",
				},
				documentType : {
					required : "<fmt:message bundle='${storeText}' key='missingDocumentTypeErrorMessage' />"
				},
				documentNumber: {
					required : "<fmt:message bundle='${storeText}' key='missingDocumentNumberErrorMessage' />"
				},
				shopId: {
					digits: "<fmt:message bundle='${storeText}' key='missingShopErrorMessage' />"
				}
			},
			errorPlacement : function(error, element) {
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
				//Mantis 1057
				if(form.propart.value == '1'){
					form.demographicField5.value = concateName("siret");
					form.isPro.value = 'true';
				}
				else{
					form.demographicField5.value = '';
					form.isPro.value = 'false';
				}
				form.logonId.value = form.email1.value;
				clientSearchAndShowPopup(form);
			}
		});
	});
	
	$(document).ready(function() {
		$('input[name=propart]').on('change', toggleProPart);
	});
	
</script>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

<c:set var="country" value="${CommandContext.country}" scope="request" />
</head>

<c:choose>
	<%--Si on vient du tunnel on redirige vers le tunnel apres login --%>
	<c:when test="${WCParam.returnPage eq 'Tunnel'}">
		<wcf:url var="tunnelShippingLink" value="TunnelCommandShippingView">
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


<wcf:url var="MyAccountURL" value="AjaxLogonForm" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>
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
<wcf:url var="NewUserDisplayUrl" value="NewUserDisplay">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="syncRequestByUser" value="true" />
</wcf:url>
<wcf:url var="UserRegistrationFormUrl" value="UserRegistrationForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="returnURL" value="${returnURL}" />
	<wcf:param name="returnPage" value="${WCParam.returnPage}" />
</wcf:url>

<wcbase:useBean id="activeStoreLocationDB" classname="com.lapeyre.declic.commerce.storelocator.beans.FullActiveStoreLocationDataBean">
	<c:set value="${storeId}" target="${activeStoreLocationDB}" property="storeId" />
	<c:set value="${langId}" target="${activeStoreLocationDB}" property="languageId" />
</wcbase:useBean>

<c:set var="fullActiveStores" value="${activeStoreLocationDB.fullActiveStores}" />
<wcf:useBean var="activeShopsList" classname="java.util.ArrayList" />
<c:set var="defaultUserShops" value="${extendedUserContext.defaultStores}" />

<c:forEach var="activeshop" items="${fullActiveStores}">
	<c:if test="${ activeshop.retraitMagasin || activeshop.retraitDrive || activeshop.livraisonColissimo || activeshop.livraisonTransporteur}">
		<wcf:useBean var="activeShopMap" classname="java.util.HashMap" />
		<wcf:set target="${activeShopMap}" key="id" value="${activeshop.strLocId}" />
		<wcf:set target="${activeShopMap}" key="identifier" value="${activeshop.identifier}" />
		<wcf:set target="${activeShopMap}" key="name" value="${activeshop.name}" />
		<wcf:set target="${activeShopMap}" key="address1" value="${activeshop.address1}" />
		<wcf:set target="${activeShopMap}" key="address2" value="${activeshop.address2}" />
		<wcf:set target="${activeShopMap}" key="address3" value="${activeshop.address3}" />
		<wcf:set target="${activeShopMap}" key="address4" value="${activeshop.address4}" />
		<wcf:set target="${activeShopMap}" key="zipcode" value="${activeshop.cp}" />
		<wcf:set target="${activeShopMap}" key="city" value="${activeshop.city}" />
		<wcf:set target="${activeShopMap}" key="phone" value="${activeshop.mainPhone}" />
		<wcf:set target="${activeShopMap}" key="email" value="${activeshop.email}" />
		<wcf:set target="${activeShopsList}" value="${activeShopMap}" />
		<c:if test="${defaultUserShops[0] != null && defaultUserShops[0].id eq activeshop.strLocId}">
			<c:set var="firstDefaultShop" value="${activeShopMap}" />
		</c:if>
		<c:if test="${defaultUserShops[1] != null && defaultUserShops[1].id eq activeshop.strLocId}">
			<c:set var="secondDefaultShop" value="${activeShopMap}" />
		</c:if>
		<c:if test="${defaultUserShops[2] != null && defaultUserShops[2].id eq activeshop.strLocId}">
			<c:set var="thirdDefaultShop" value="${activeShopMap}" />
		</c:if>
		<c:remove var="activeShopMap" />
	</c:if>
</c:forEach>
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
		</script>
	</c:if>
	<%out.flush();%>
	
	<div id="contentWrapper">
		<div id="content" role="main">
			<div class="rowContainer registrationForm">
				<c:choose>
					<c:when test="${WCParam.returnPage eq 'Tunnel'}">
	                    <c:set var="tunnelStep" value="2"/>
	                    <%@ include file="../../../ShoppingArea/ShopcartSection/TunnelShopCartHeader_UI.jspf" %>
	                </c:when>
					<c:otherwise>
	                    <div class="row">
	                        <div data-slot-id="1" class="col12 slot1 mobile-hidden">
								<%out.flush();%>
								<fmt:message var="lastBreadCrumbItem" key="synchronisationBreadcrumbLabel" bundle="${widgetText}" />
								<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
									<c:param name="pageName" value="CompteClient" />
									<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
								</c:import>
								<%out.flush();%>
							</div>
	                    </div>
						<div class="row">
							<div class="blockPresentation">
								<div class="editoBackground"><img alt="Blouses" src="${jspStoreImgDir}images/synchroClient.jpg"></div>
								<div class="textContainer">
									<h1><fmt:message bundle="${storeText}" key="synchronisationPageTitle"/></h1>
									<div class="mobile-hidden textArticle quoteArticle">
										<p><fmt:message bundle="${storeText}" key="synchronisationPageIntroMessage"/></p>
									</div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="row">
					<div class="sign_in_registration">
						<c:if test="${userType == 'G'}">
							<div class="title">
								<p>
									<fmt:message bundle="${storeText}" key="inscriptionPageIdentificationBlockMessage" />
									<a href="${LogonUrl}"><fmt:message bundle="${storeText}" key="inscriptionPageIdentificationBlockLinkLabel" />  </a>
								</p>
							</div>
						</c:if>
						
						<form name="Synchro" method="post" action="${UserRegistrationAddURL}" id="Synchro">
							<input type="hidden" name="idCRM" value="" />
							<input type="hidden" name="sync" value="false" />
							<input type="hidden" name="syncRequestByUser" value="true" />
							<input type="hidden" name="isPro" value="${WCParam.isPro}" />
							<input type="hidden" name="legalEntity" value="${WCParam.legalEntity}" />
							<input type="hidden" name="legalEntityLabel" value="${WCParam.legalEntityLabel}" />
							<input type="hidden" name="demographicField5" value="${WCParam.demographicField5}" />
							<input type="hidden" name="demographicField7" value="${WCParam.demographicField7}" />
							<input type="hidden" name="mobilePhone1" value="${WCParam.mobilePhone1}" />
							<input type="hidden" name="phone1" value="${WCParam.phone1}" />
							<input type="hidden" name="phone2" value="${WCParam.phone2}" />
							<input type="hidden" name="address1" value="${WCParam.address1}" />
							<input type="hidden" name="address2" value="${WCParam.address2}" />
							<input type="hidden" name="address3" value="${WCParam.address3}" />
							<input type="hidden" name="city" value="${WCParam.city}" />
							<input type="hidden" name="country" value="${WCParam.country}" />
							<input type="hidden" name="zipCode" value="${WCParam.zipCode}" />
							<input type="hidden" name="logonId" value="${WCParam.logonId}" />
							<input type="hidden" name="myAcctMain" value="1" autocomplete="off">
							<input type="hidden" name="new" value="N" />
							<input type="hidden" name="storeId" value="${WCParam.storeId}" />
							<input type="hidden" name="catalogId" value="${WCParam.catalogId}" />
							<input type="hidden" name="errorViewName" value="UserSynchronisationForm" />
							<input type="hidden" name="returnPage" value="<c:out value="${WCParam.returnPage}"/>" />
							<input type="hidden" name="URL" value="${returnURL}" />
							
							<div class="form">
							
								<c:if test="${!empty errorMessage}">
									<div class="error">
										<%--Mantis 2451 --%>
										<span class="error">${errorMessage}</span>
									</div>
								</c:if>
								
								<div class="content">
								
									<div class="align">
									
										<div class="form_3column">
											
											<%-- �tes-vous un professionnel du b�timent ? --%>
											<div class="column column_100" id="isProContainer">
												<div class="column_label marginTop10" id="isProLabel">
													<span class="spanacce">
														<label for="">
															<fmt:message bundle="${storeText}" key="isProFieldLabel" />
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="isProFieldLabel" />
												</div>
												<label class="radioButtonContainer" for="pro"> 
													<input type="radio" class="radioLP" name="propart" id="pro" value="1" />
													<div></div> 
													<fmt:message bundle="${storeText}" key="confirm" />
												</label> 
												<div class="gutter"></div>
												
												<label class="radioButtonContainer"for="part"> 
													<input type="radio" class="radioLP" name="propart" id="part" value="0" checked />
													<div></div>
													<fmt:message bundle="${storeText}" key="unconfirm" />
												</label>
											</div>
											<div class="clearAll"></div>
											
											<div class="forPart marginTop10" style="display: none;">
											
												<%-- Civilit� --%>
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
														<select id="civilityField" name="personTitle">
															<c:forTokens items="${listCivilitePart}" delims="," var="token">
																<option value="<c:out value='${token}'/>"><fmt:message bundle="${storeListe}" key="Civilite_${token}"/></option>
															</c:forTokens>
														</select>
													</div>
												</div>
												<div class="gutter"></div>
												
												<%-- Prenom --%>
												<div class="column column_25-5 bcolumn_67" id="FirstNameContainer">
													<div id="FirstNameLabel" class="column_label">
														<span class="spanacce">
															<label for="firstName">
																<fmt:message bundle="${storeText}" key="addressFirstnameFieldLabel"/>
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="addressFirstnameFieldLabel"/>
														<span class="required-field"> *</span>
													</div>
													<input type="text" maxlength="60" size="20" id="firstName" name="firstName" value="${WCParam.firstName}" required />
												</div>
												<div class="gutter mobile-hidden"></div>
												
												<%-- Nom --%>
												<div class="column column_48-5 bcolumn_100" id="LastNameContainer">
													<div id="LastNameLabel" class="column_label">
														<span class="spanacce">
															<label for="lastName">
																<fmt:message bundle="${storeText}" key="addressLastnameFieldLabel"/>
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="addressLastnameFieldLabel"/>
														<span class="required-field"> *</span> 
													</div>
													<input type="text" maxlength="40" size="35" aria-required="true" id="lastName" name="lastName" value="${WCParam.lastName}" required />
												</div>
												<div class="clearAll"></div>
												
											</div>
												
											<div class="forPro marginTop10" style="display: none;">
											
												<%-- Entit� juridique --%>
												<datalist id="legalEntity" value="${WCParam.legalEntity}">
													<c:forTokens items="${listCivilitePro}" delims="," var="token">
														<option value="<c:out value='${token}'/>">
															<fmt:message bundle="${storeListe}" key="Civilite_${token}" />
														</option>
													</c:forTokens>
												</datalist>
											
												<%-- Raison sociale --%>
												<div class="column column_77 bcolumn_100" id="BusinessNameContainer">
													<div class="column_label" id="BusinessNameLabel">
														<span class="spanacce">
															<label for="organizationName">
																<fmt:message bundle="${storeText}" key="raisonSocialeFieldLabel" /> 
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="raisonSocialeFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<input size="25" maxlength="40" aria-required="true" name="organizationName" id="organizationName" type="text" value="${WCParam.organizationName}"  required />
												</div>
												<div class="clearAll"></div>
											
												<%-- Siret --%>
												<div class="column column_48-5 bcolumn_100" id="SiretContainer">
													<div class="column_label" id="SiretLabel">
														<span class="spanacce">
															<label>
																<fmt:message bundle="${storeText}" key="siretFieldLabel" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="siretFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<%--Mantis: 2295 ajout de WCParam. --%>
													<div class="column column_20 bcolumn20">
														<input size="3" maxlength="3" placeholder="000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 0,3)}" class="siretNum" onblur="verifNames(this);" />
													</div>
													<div class="gutterDash"></div>
													<div class="column column_20 bcolumn20">
														<input size="3" maxlength="3" placeholder="000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 3,6)}" class="siretNum" onblur="verifNames(this);" />
													</div>
													<div class="gutterDash"></div>
													<div class="column column_20 bcolumn20">
														<input size="3" maxlength="3" placeholder="000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 6,9)}" class="siretNum" onblur="verifNames(this);" />
													</div>
													<div class="gutterDash"></div>
													<div class="column column_20 bcolumn20">
														<input size="5" maxlength="5" placeholder="00000" aria-required="true" name="siret" id="" type="text" value="${fn:substring(WCParam.demographicField5, 9,14)}" class="siretNum" onblur="verifNames(this);" />
													</div>
												</div>
												<div class="clearAll"></div>
												
												<%-- N� client --%>
												<div class="column column_48-5 bcolumn_100" id="ClientNumberContainer">
													<div class="column_label" id="BusinessNameLabel">
														<span class="spanacce">
															<label for="idCRM">
																<fmt:message bundle="${storeText}" key="idCRMFieldLabel" /> 
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="idCRMFieldLabel" />
														<span class="required-field"> *</span>
													</div>
													<input size="25" maxlength="100" aria-required="true" name="clientId" id="clientId" type="text" value="${WCParam.idCRM}" required />
												</div>
												<div class="clearAll"></div>
												
											</div>
											<!-- FP -->
												
											<%-- Email --%>
											<div class="column column_48-5 bcolumn_100" id="EmailLogonContainer">
												<div class="column_label" id="EmailLogonLabel">
													<span class="spanacce">
														<label for="email1">
															<fmt:message bundle="${storeText}" key="loginFieldlabel"/>
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="loginFieldlabel"/>
													<span class="required-field"> *</span>
												</div>
												<input type="email" size="40" maxlength="100" aria-required="true" id="email1" name="email1" value="${WCParam.email1}" required />
											</div>
											<div class="clearAll"></div>
											
											<%-- Mot de passe --%>
											<div class="column column_48-5 bcolumn_100" id="PasswordContainer">
												<div class="column_label" id="PasswordLabel">
													<span class="spanacce">
														<label for="logonPassword">
															<fmt:message bundle="${storeText}" key="passwordFieldLabel"/>
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="passwordFieldLabel"/>
													<span class="required-field"> *</span>
												</div>
												<input size="35" maxlength="100" aria-required="true" id="logonPassword" name="logonPassword" type="password" value="" required>
											</div>
											<div class="gutter mobile-hidden"></div>
											
											<%-- Confirmation de mot de passe --%>
											<div class="column column_48-5 bcolumn_100" id="ConfirmPasswordContainer">
												<div class="column_label" id="ConfirmPasswordLabel">
													<span class="spanacce">
														<label for="logonPasswordVerify">
															<fmt:message bundle="${storeText}" key="confirmPasswordFieldLabel"/>
														</label>
													</span>
													<fmt:message bundle="${storeText}" key="confirmPasswordFieldLabel"/>
													<span class="required-field"> *</span>
												</div>
												<input size="35" maxlength="100" aria-required="true" id="logonPasswordVerify" name="logonPasswordVerify" type="password" value="" required>
											</div>
											<div class="clearAll"></div>
											
											<!-- FP -->
											<div class="forPart" style="display: none;">
											
												<%-- Magasin --%>
												<div class="column column_34 bcolumn_100" id="ListMagasinContainer">
													<div class="column_label" id="ListMagasinLabel">
														<span class="spanacce">
															<label for="listMag">
																<fmt:message bundle="${storeText}" key="synchroStoreFieldlabel"/>
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="synchroStoreFieldlabel"/>
														<span class="required-field"> *</span>
													</div>
													<div class="dropdownLP">
														<select class="contactForm-select" name="shopId" id="shopId">
															<option value="-1"><fmt:message key="LAP034_SELECT" bundle="${widgetText}" /></option>
															<c:forEach var="shop" items="${activeShopsList}" >
																<option value="${shop.identifier}">${shop.zipcode} - ${shop.name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="gutter mobile-hidden"></div>
												
												<%-- Type de document --%>
												<div class="column column_30 bcolumn_100" id="DocumentTypeContainer">
													<div class="column_label" id="PhoneTypeLabel">
														<span class="spanacce">
															<label for="documentType">
																<fmt:message bundle="${storeText}" key="synchroModeFieldLabelDocumentType" />
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="synchroModeFieldLabelDocumentType" />
														<span class="required-field"> *</span>
													</div>
													<div class="dropdownLP">
														<select name="documentType" id="documentType" required>
															<option value="">-</option>
															<c:forTokens items="${listDocument}" delims="," var="token">
																<option value="${token}">
																	<fmt:message bundle="${storeListe}" key="Document_${token}" />
																</option>
															</c:forTokens>
														</select>
													</div>
												</div>
												<div class="gutter mobile-hidden"></div>
												
												<%-- N� de document --%>
												<div class="column column_30 bcolumn_100" id="DocumentNumberContainer">
													<div id="DocumentLabel" class="column_label">
														<span class="spanacce">
															<label for="numDoc">
																<fmt:message bundle="${storeText}" key="synchroModeFieldLabelDocumentNumber"/>
															</label>
														</span>
														<fmt:message bundle="${storeText}" key="synchroModeFieldLabelDocumentNumber"/>
														<span class="required-field"> *</span>
													</div>
													<input type="text" maxlength="100" size="40" aria-required="true" id="documentNumber" name="documentNumber" value required /> 
													<br clear="all"> 
												</div>
												<div class="clearAll"></div>
												
											</div>
												
										</div>
										
										<div class="button_footer_line no_float">
											<input onclick="copyDataToRegistrationFormAndGoToRegistration();" type="button" value="<fmt:message bundle="${storeText}" key="synchronisationPageCancelButtonlabel"/>" class="button button--minor column_30 bcolumn_100" />
											<input type="submit" value='<fmt:message bundle="${storeText}" key="synchronisationPageSubmitButtonlabel"/>' class="column_30 bcolumn_100 button green">
										</div>
										
									</div>
									
								<%--</div> --%>
										
							</div>

						</form>
						<div class="ml">
							<p><fmt:message bundle="${storeText}" key="mandatoryFieldsLabelSingle"/></p>
							<p><fmt:message bundle="${storeText}" key="inscriptionPageCNILMessage" /></p>
						</div>
						<form id="GoToRegistrationForm" name="GoToRegistrationForm" action="RedirectView?URL=${UserRegistrationFormUrl}" method="POST">
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
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
<div dojoType="lapeyre/widget/Dialog"  id="popinSynchroOK" title="<fmt:message key="synchroPopinOkTitle" bundle="${storeText}" />">
	<div class="widget_site_popup">
		<!-- Main Content Area -->
		<div class="content">
			<div class="header">
				<span><span><fmt:message key="synchroPopinOkTitle" bundle="${storeText}" /></span></span>
				<a id="" class="close" href="javascript:void(0);" onclick="resetFormIdCRM(); dijit.byId('popinSynchroOK').hide();" title="<fmt:message var="lastBreadCrumbItem" key="synchronisationBreadcrumbLabel" bundle="${widgetText}" />"></a>
				<div class="clear_float"></div>
			</div>
			<div class="body">
				<fmt:message key="synchroPopinOkContent" bundle="${storeText}" />
				<dl class="infosSynchro" id="synchroPopContentInfos">
					<%--PART--%>
					<dt class="personTitle"><fmt:message key="synchroPopin_personTitle" bundle="${storeText}" /></dt><dd class="personTitle"></dd>
					<dt class="firstName"><fmt:message key="synchroPopin_firstName" bundle="${storeText}" /></dt><dd class="firstName"></dd>
					<dt class="lastName"><fmt:message key="synchroPopin_lastName" bundle="${storeText}" /></dt><dd class="lastName"></dd>
					<%--PRO--%>
					<dt class="legalEntity"><fmt:message key="synchroPopin_legalEntity" bundle="${storeText}" /></dt><dd class="legalEntity"></dd>
					<dt class="organizationName"><fmt:message key="synchroPopin_organizationName" bundle="${storeText}" /></dt><dd class="organizationName"></dd>
					<dt class="siret"><fmt:message key="synchroPopin_numSiret" bundle="${storeText}" /></dt><dd class="siret"></dd>
					<%--Commun--%>
					<dt class="email"><fmt:message key="synchroPopin_email" bundle="${storeText}" /></dt><dd class="email"></dd>
					<dt class="address1"><fmt:message key="synchroPopin_address1" bundle="${storeText}" /></dt><dd class="address1"></dd>
					<dt class="address3"><fmt:message key="synchroPopin_etage" bundle="${storeText}" /></dt><dd class="address3"></dd>
					<dt class="zipCode"><fmt:message key="synchroPopin_zipCode" bundle="${storeText}" /></dt><dd class="zipCode"></dd>
					<dt class="city"><fmt:message key="synchroPopin_city" bundle="${storeText}" /></dt><dd class="city"></dd>
					<dt class="country"><fmt:message key="synchroPopin_country" bundle="${storeText}" /></dt><dd class="country"></dd>
				</dl>
			</div>
			<div class="footer">
				<div class="ctaContainer">
					<a id="" class="button green" tabindex="0" href="javascript:void(0);" onclick="dijit.byId('popinSynchroOK').hide(); document.Synchro.sync.value = 'true'; submitSynchroFormOnValidSynchroPopin();" title="OK"><fmt:message key="synchroPopinOkConfirmButtonLabel" bundle="${storeText}" /></a>
					<a href="javascript:void(0);" onclick="resetFormIdCRM(); dijit.byId('popinSynchroOK').hide();" class="button"><fmt:message key="synchroPopinOkCancelButtonLabel" bundle="${storeText}" /></a>
				</div>
			</div>
			<div class="clear_float"></div>
			<!-- End content Section -->
		</div>
	</div>
</div>
	
<div id="popinSynchroKO" data-dojo-type="lapeyre/widget/Dialog" style="display: none;" title="<fmt:message key="synchroPopinKoTitle" bundle="${storeText}" />">
	<div class="widget_site_popup">
		<!-- Main Content Area -->
		<div class="content">
			<div class="header">
				<span><span><fmt:message key="synchroPopinKoTitle" bundle="${storeText}" /></span></span>
				<a id="ComparePopupClose" class="close" href="javascript:void(0);" onclick="resetFormIdCRM(); dijit.byId('popinSynchroKO').hide();" title="CLOSE"></a>
				<div class="clear_float"></div>
			</div>
			<div class="body">
				<fmt:message key="synchroPopinKoContent" bundle="${storeText}" />
			</div>
			<div class="footer">
				<div class="ctaContainer">
					<a id="" class="button green" tabindex="0" href="javascript:void(0);" onclick="dijit.byId('popinSynchroKO').hide(); copyDataToRegistrationFormAndGoToRegistration(); return false;" title="OK"><fmt:message key="synchroPopinKoAccountCreationButtonLabel" bundle="${storeText}" /></a>
					<a href="javascript:void(0);" onclick="resetFormIdCRM(); dijit.byId('popinSynchroKO').hide();" class="button"><fmt:message key="synchroPopinKoCancelButtonLabel" bundle="${storeText}" /></a>
				</div>
			</div>
			<div class="clear_float"></div>
			<!-- End content Section -->
		</div>
	</div>
</div>

<%out.flush();%>
<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
<%out.flush();%>
<c:import url="../../../TagManager/TagManager.jsp" >
	<c:param name="pageGroup" value="UserSynchronisation" />
</c:import>
