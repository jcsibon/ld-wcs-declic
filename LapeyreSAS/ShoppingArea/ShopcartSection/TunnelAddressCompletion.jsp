<%--
  *****
  * This JSP file displays the shopping cart page. It shows shopping cart details plus lets the shopper
  * initiate the checkout process either as a guest user, a registered user, or as a registered user
  * that has a quick checkout profile saved with the store.
  *****
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN OrderItemDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../Common/nocache.jspf"%>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<c:set var="tunnelStep" value="2"/>
<wcf:url var="tunnelRecapShopCartLink" value="TunnelShopCartView" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>
<wcf:url var="tunnelShippingLink" value="TunnelCommandAddressValidation">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${WCParam.langId}" />
</wcf:url>

<!DOCTYPE HTML>
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#" xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><fmt:message bundle="${storeText}" key="SHOPPINGCART_TITLE_${tunnelStep }"/></title>
		<META NAME="robots" CONTENT="noindex,nofollow" />
		<link rel="stylesheet" type="text/css" href="${jspStoreImgDir}css/redesign/checkout.css" />
		<link rel="stylesheet" type="text/css" href="${jspStoreImgDir}css/redesign/checkout-media.css" />
		<%@ include file="../../Common/CommonJSToInclude_redesign.jspf"%>
		<%@ include file="../../Common/CommonJSToInclude.jspf"%>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script> 									 
		<script type="text/javascript" src="${jspStoreImgDir}UserAreaDeclic/javascript/RNVPService.js?${versionNumber}"></script> 
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<link rel="stylesheet" href="${jspStoreImgDir}css/styles_edito.css?${versionNumber}" type="text/css" media="screen"/>
	</head>

	<body style="margin:0;">
		<div id="page">
		<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp">
				<c:param name="loadHeaderLight" value="${!isOnMobileDevice}"></c:param>
			</c:import>
		<%out.flush();%>
				
		<div class="content_wrapper_position" role="main">
			<div id="contentWrapper" class="${isOnMobileDevice?'noUnderSearch':''}">			
				<div id="content" role="main">
				
					<div class="rowContainer tunnel">
						<%@ include file="TunnelShopCartHeader_UI.jspf" %>
						
						<h2 style="margin-top:20px;" class="titleBlock"><span><fmt:message key="tunnelAddAddressPageTitle" bundle="${storeText}" /></span></h2>
						<p><fmt:message key="tunnelAddAddressPageSubTitle" bundle="${storeText}" /></p>
				
						<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
							<wcf:param name="accessProfile" value="IBM_All" />
						</wcf:getData>						
						<c:set var="contact" value="${person.contactInfo}"/>
						<c:set var="selectedAddressId" value="${contact.contactInfoIdentifier.uniqueID}" scope="request"/>
 						<c:set var="lightAddress" value="true" scope="request"/>									
						<%@ include file="../../UserAreaDeclic/AccountSection/AddressSubsection/AddressFormLight.jsp" %>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Footer Widget -->
		<div class="footer_wrapper_position">
			<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
			<%out.flush();%>
		</div>
		</div>
	</body>
</html>