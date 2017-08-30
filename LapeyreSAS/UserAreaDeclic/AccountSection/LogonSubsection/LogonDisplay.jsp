<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../../Common/nocache.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message bundle="${storeText}" key="SI_SIGNIN"/></title>
	<META NAME="robots" CONTENT="noindex,nofollow"/>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
	
	<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/logon/logonDisplay.css?${versionNumber}" type="text/css" />
	
	<%@ include file="../../../Common/CommonJSToInclude_redesign.jspf"%>
	
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
	<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/additional-methods.js?${versionNumber}"></script>
	<script>
		$().ready(function() {
			errPlace = function(error,
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
			};
			// validate signup form on keyup and submit
			$("#LogonControlForm").validate({
				rules : {
					connectLogin : {
						required : true,
						email : true
					},
					connectPassword : {
						required: true
					}
				},
				messages : {
					connectLogin : {
						required : "<fmt:message bundle='${storeText}' key='missingLoginErrorMessage' />",
						email : "<fmt:message bundle='${storeText}' key='InvalidLoginErrorMessage' />"
					},
					connectPassword : {
						required: "<fmt:message bundle='${storeText}' key='missingPasswordErrorMessage' />"
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
			$("#CreateControlForm").validate({
				rules : {
					creationLogin : {
						required : true,
						email : true
					},
				},
				messages : {
					creationLogin : {
						required : "<fmt:message bundle='${storeText}' key='missingLoginErrorMessage' />",
						email : "<fmt:message bundle='${storeText}' key='InvalidLoginErrorMessage' />"
					},
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
	<c:set var="country" value="${CommandContext.country}" scope="request" />
</head>
<body>

	<wcf:url var="MyAccountURL" value="AjaxLogonForm" type="Ajax">
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	</wcf:url>
	
	<%--Mantis  0001855 et 0001856 : on redirige vers la page de confirmation de cr�ation de compte quand on cr�e son compte en dehors du tunnel--%>
	<wcf:url var="NewUserDisplayFromCreation" value="NewUserDisplay" type="Ajax">
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<wcf:param name="syncRequestByUser" value="false" />
	</wcf:url>
	<wcf:url var="NewUserDisplayFromSynchro" value="NewUserDisplay" type="Ajax">
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<wcf:param name="syncRequestByUser" value="true" />
	</wcf:url>
	
	
	
	<%--Calculate returnURL --%>
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
			<c:set var="returnURL" value="${MyAccountURL}"/>
		</c:otherwise>
	</c:choose>
	
	<!--returnURL=${returnURL } -->
	<!--returnPage=${returnPage}-->
	
	<wcf:url var="ReLogonForm" value="LogonForm">
	  <wcf:param name="langId" value="${langId}" />
	  <wcf:param name="storeId" value="${storeId}" />
	  <wcf:param name="catalogId" value="${catalogId}" />
	  <wcf:param name="myAcctMain" value="1" />
	  <wcf:param name="returnURL" value="${returnURL}" />
		<wcf:param name="returnPage" value="${WCParam.returnPage}" />
	</wcf:url>
	
	<wcf:url var="ForgetPasswordURL" value="ResetPasswordGuestErrorView">
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<wcf:param name="state" value="forgetpassword" />
	</wcf:url>
	
	<wcf:url var="SynchroUrl" value="UserSynchronisationForm">
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<%--Mantis  0001855 et 0001856 : on redirige vers la page de confirmation de cr�ation de compte quand on cr�e son compte en dehors du tunnel--%>
		<c:choose >
			<c:when test="${!empty WCParam.returnPage && WCParam.returnPage == 'Tunnel'}">
				<wcf:param name="returnURL" value="${returnURL}" />
			</c:when>
			<c:otherwise>
				<wcf:param name="returnURL" value="${NewUserDisplayFromSynchro}" />
			</c:otherwise>
		</c:choose>
		<wcf:param name="returnPage" value="${WCParam.returnPage}" />
	</wcf:url>
	<wcf:url var="UserRegistrationFormUrl" value="UserRegistrationForm">
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<%--Mantis  0001855 et 0001856 : on redirige vers la page de confirmation de cr�ation de compte quand on cr�e son compte en dehors du tunnel--%>
		<c:choose >
	        <c:when test="${!empty WCParam.returnPage && (WCParam.returnPage == 'Tunnel' || WCParam.returnPage == 'wishlist')}">
				<wcf:param name="returnURL" value="${returnURL}" />
			</c:when>
			<%--On redirige vers le configurator si on en vient. --%>
			<c:when test="${!empty WCParam.fromConfigurator && WCParam.fromConfigurator == 'true'}">
				<wcf:param name="returnURL" value="${returnURL}" />
			</c:when>
			<c:otherwise>
				<wcf:param name="returnURL" value="${NewUserDisplayFromCreation}" />
			</c:otherwise>
		</c:choose>	
		<wcf:param name="returnPage" value="${WCParam.returnPage}" />
	
		<%-- Mantis 0003700 : on affiche la cr�ation de compte compl�te si on est dans le tunnel, la version light sinon  --%>
		<c:choose >
			<c:when test="${!empty WCParam.returnPage && WCParam.returnPage == 'Tunnel'}">
				<wcf:param name="isLightSubscription" value="full" />
			</c:when>
			<c:when test="${!empty WCParam.fromConfigurator && WCParam.fromConfigurator == 'true'}">
	<!-- 			TODO : a tester une fois le configurateur en place -->
				<wcf:param name="isLightSubscription" value="lightPhone" />
			</c:when>
			<c:otherwise>
				<!-- Cas de la wishlist, ou autre -->
				<wcf:param name="isLightSubscription" value="light" />
			</c:otherwise>
		</c:choose>
	</wcf:url>
	
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
		<c:set var="hideConnectPopup" value="true" scope="request" />
		<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp">
				<c:param name="loadHeaderLight" value="${(WCParam.returnPage eq 'Tunnel' && !isOnMobileDevice) ? true:false}"></c:param>
		</c:import>
		<c:if test="${WCParam.returnPage eq 'Tunnel' }">
			<script>
				dojo.addOnLoad(function() {
					var orderQuantity = '0';
					var cookieCartOrderId = getCookie('WC_CartOrderId_${storeId}');
					if(cookieCartOrderId != null) {
						var cookieOrderTotal = getCookie('WC_CartTotal_' + cookieCartOrderId);
						if(cookieOrderTotal != null) {
							orderQuantity = cookieOrderTotal.split(';')[0];
						}
					}
					
					var ordQtyHeaderLight = document.getElementById('minishopcart_total_headerLight');
					if(ordQtyHeaderLight != null) {
						ordQtyHeaderLight.innerHTML = orderQuantity;
					}
				});
			</script>
		</c:if>
		<%out.flush();%>
		<div id="LogonPageContent">
			<div id="content" role="main" class="logonContainer">
				<div class="rowContainer">
					<c:choose>
						<c:when test="${WCParam.returnPage eq 'Tunnel'}">
		                    <c:set var="tunnelStep" value="2"/>
		                    <wcf:url var="tunnelRecapShopCartLink" value="TunnelShopCartView" type="Ajax">
								<wcf:param name="storeId"   value="${WCParam.storeId}"  />
								<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
								<wcf:param name="langId" value="${WCParam.langId}" />
							</wcf:url>
							<%-- Do Not Show tunnelShopCartHeader mantis-0000126 --%>
							<%-- <%@ include file="../../../ShoppingArea/ShopcartSection/TunnelShopCartHeader_UI.jspf" %> --%>
						</c:when>
						<c:otherwise>
							<div class="row">
		                        <div data-slot-id="1" class="col12 slot1 mobile-hidden">
									<%out.flush();%>
									<fmt:message var="lastBreadCrumbItem" key="IdentificationBreadcrumbLabel" bundle="${widgetText}" />
									<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
										<c:param name="pageName" value="CompteClient" />
										<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
									</c:import>
									<%out.flush();%>
								</div>
		                    </div>
						</c:otherwise>
					</c:choose>
					<div id="logonFormContainer" class="row <c:if test="${WCParam.returnPage eq 'Tunnel'}">tunnelSignInPage</c:if>">
						<div class="col s12 m12 l8 offset-l2">
							<form name="Logon" method="post" action="RedirectView?URL=${UserRegistrationFormUrl}" id="Logon">
								<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="WC_AccountDisplay_FormInput_storeId_In_Logon_1"/>
								<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="WC_AccountDisplay_FormInput_catalogId_In_Logon_1"/>
								<input type="hidden" name="reLogonURL" value="${ReLogonForm}" id="WC_AccountDisplay_FormInput_reLogonURL_In_Logon_1"/>
								<c:choose>
									<c:when test="${(!empty WCParam.logonId) && (!empty WCParam.validationCode) && (empty errorMessage)}">
									        <input type="hidden" name="myAcctMain" value="<c:out value="1"/>"/>
									</c:when>
									<c:otherwise>
											<input type="hidden" name="myAcctMain" value="<c:out value="${WCParam.myAcctMain}"/>"/>
									</c:otherwise>
								</c:choose>
								<c:if test="${WCParam.returnPage eq 'Tunnel'}">
									<input type="hidden" name="fromOrderId" value="*" id="WC_AccountDisplay_FormInput_fromOrderId_In_Logon_1"/>
									<input type="hidden" name="toOrderId" value="." id="WC_AccountDisplay_FormInput_toOrderId_In_Logon_1"/>
									<input type="hidden" name="deleteIfEmpty" value="*" id="WC_AccountDisplay_FormInput_deleteIfEmpty_In_Logon_1" />
									<input type="hidden" name="createIfEmpty" value="1" id="WC_AccountDisplay_FormInput_createIfEmpty_In_Logon_1" />
									<input type="hidden" name="calculationUsageId" value="-1" id="WC_AccountDisplay_FormInput_calculationUsageId_In_Logon_1" />
									<input type="hidden" name="updatePrices" value="0" id="WC_AccountDisplay_FormInput_updatePrices_In_Logon_1"/>
									<input type="hidden" name="errorViewName" value="TunnelShopCartView" id="WC_AccountDisplay_FormInput_errorViewName_In_Logon_1"/>                                                 
								</c:if>

								<input type="hidden" name="continue" value="1" id="WC_AccountDisplay_FormInput_continue_In_Logon_1" />								
								<input type="hidden" name="previousPage" value="logon" id="WC_AccountDisplay_FormInput_previousPage_In_Logon_1"/>								
								<input type="hidden" name="returnPage" value="<c:out value="${WCParam.returnPage}"/>" id="WC_AccountDisplay_FormInput_returnPage_In_Logon_1"/>
								
								<input type="hidden" name="fromConfigurator" value="<c:out value="${WCParam.fromConfigurator}"/>" id="fromConfigurator"/>
								
								<c:if test="${!empty WCParam.nextUrl}">
									<input type="hidden" name="nextUrl" value="<c:out value="${WCParam.nextUrl}"/>"/>
								</c:if>
								
								<%--ReturnURL est calcul� en d�but de page --%>
								<input type="hidden" name="URL" value="${returnURL}" id="WC_AccountDisplay_FormInput_URL_In_Logon_3" />				

								<input type="hidden" name="logonId" id="WC_AccountDisplay_FormInput_logonId_In_Logon_1" /><%-- WC_UserRegistrationAddForm_FormInput_email1_In_Register_1  --%>
								<input type="hidden" name="logonPassword" id="WC_AccountDisplay_FormInput_logonPassword_In_Logon_1" />				
							</form>
							<%@ include file="LogonForm.jsp" %>
							<form id="GoToSynchroForm" name="GoToSynchroForm" action="RedirectView?URL=${SynchroUrl}" method="POST">
								<input type="hidden" name="logonId" value="${WCParam.logonId}" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:if test="${WCParam.returnPage eq 'Tunnel' }">
		<!--  ZONE MEA -->
		<div class="tunnelEngageBlock ">
			<c:import url="${env_jspStoreDir}/include/ContentContext.jsp">
				<c:param name="typePage" value="/tunnel" />
				<c:param name="id" value="etape${tunnelStep}"/>
				<c:param name="complement" value=""/>
			</c:import>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget.jsp">
				<c:param name="emplacement" value="Bottom" />
			</c:import>
		</div>
	</c:if>
	
	<%out.flush();%>
	<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
	<%out.flush();%>
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="identification" />
	</c:import>
</body>
</html>	
