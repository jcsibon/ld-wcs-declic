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
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>


<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>


<fmt:setBundle basename="/${sdb.jspStoreDir}/storelist" var="storeListe" scope="request"/>

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

<%-- CommonContexts must come before CommonControllers --%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js?${versionNumber}"/>"></script>
	
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>


<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<c:set var="addressBookBean" value="${person.addressBook}"/>

<wcf:url var="AddressBookURL" value="AddressBookForm" scope="request">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<wcf:url var="AddressFormURL" value="AjaxAccountAddressForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="URL" value="${AddressBookURL}" />
</wcf:url>

<wcf:url var="SetAddressPrimaryURL" value="AddressToPrimarySwitchCmd" scope="request">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="URL" value="${AddressBookURL}" />
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
						<fmt:message var="lastBreadCrumbItem" key="myAddressBreadcrumbLabel" bundle="${widgetText}" />
						<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
							<c:param name="pageName" value="CompteClient" />
							<c:param name="breadCrumbMonCompte" value="true" />
							<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
						</c:import>
						<%out.flush();%>
                   	</div>
               	 </div>
               	 <c:set var="navMonCompteCurrentPage" value="myAddresses"/>

				<c:set var="contact" value="${person.contactInfo}"/>
				<c:if test="${not empty contact && not empty contact.address && not empty contact.address.addressLine && contact.address.addressLine[0] eq 'defaultStreet' }">
					<c:set var="lightAddress" value="true" scope="request"/>
				</c:if>
				
				<div class="row" id="myAddressBookPage">
					<div id="navCompteClient" class="col3 mobile-hidden">
						<%@ include file="../navClient.jspf" %>
					</div>
					<div class="col9 bcol12 mainContentWrapper">
						<h1 class="titleBlock">
						<c:choose><c:when test="${lightAddress}">
							<fmt:message bundle="${storeText}" key="tunnelAddAddressPageTitle"/>
						</c:when><c:otherwise>
							<fmt:message bundle="${storeText}" key="myAddressesPageTitle"/>
						</c:otherwise></c:choose></h1>
						<c:if test="${!empty errorMessage}">
							<div class="error">
								<span  class="error"><c:out value="${errorMessage}" /></span>
							</div>
						</c:if>
						<c:if test="${empty lightAddress }">
						<div class="addListButton">
							<a href="${AddressFormURL}" class="button marge"><fmt:message bundle="${storeText}" key="addAddressButton"/></a>
						</div>
						</c:if>
						<div class="myAdressesContainer"> 
							<c:set var="isSelfAdress" value="true"/>						
							<!-- On teste si on a une adresse dans les infos pour afficher le formulaire de "creation" d'adresse dans le cas compte light -->
							<c:choose>
								<c:when test="${!empty lightAddress }">
 									<c:set var="selectedAddressId" value="${contact.contactInfoIdentifier.uniqueID}" scope="request"/>
 									<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script> 									 
 									<script type="text/javascript" src="${jspStoreImgDir}UserAreaDeclic/javascript/RNVPService.js?${versionNumber}"></script> 
									
									<%@ include file="AddressFormLight.jsp" %>
								</c:when>
								<c:otherwise>
									<%-- affichage de l'adresse principale --%>
									<%@ include file="AddressDisplay.jspf" %>
									
									<%-- affichage des autres adresses --%>
									<c:set var="isSelfAdress" value="false"/>
									<c:forEach items="${addressBookBean.contact}" var="contact"> 
										<%@ include file="AddressDisplay.jspf" %>
									</c:forEach>
									
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<%@ include file="../../PopIn/deleteAddress.jspf"%>
				<form action="${SetAddressPrimaryURL}" name="AddressSwitchToPrimary" id="AddressSwitchToPrimary" method="POST">
					<input type="hidden" name="addressId" value="" />
					<input type="hidden" name="URL" value="${AddressBookURL}" />
					<input type="hidden" name="errorViewName" value="AddressBookForm" />
				</form>
			</div>
		</div>
	</div>

	<% out.flush(); %>
		<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
	<% out.flush(); %>
</div>
	<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="espaceClient" />
		<c:param name="pageName" value="AddressBook" />
	</c:import>
</body>
</html>