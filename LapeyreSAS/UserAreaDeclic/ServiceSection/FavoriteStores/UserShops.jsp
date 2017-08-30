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

<c:set var="country" value="${CommandContext.country}" scope="request" />
<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>


<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="myStoresMenuLinkLabel" /></title>
<META NAME="robots" CONTENT="noindex,nofollow" />
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css" />
<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css?${versionNumber}" type="text/css" />
<%--Main Stylesheet for google map override style --%>
<link rel="stylesheet" href="${jspStoreImgDir}css/storelocmap.css?${versionNumber}" type="text/css" media="screen" />

<%@ include file="../../../Common/CommonJSToInclude.jspf"%>

	<%-- CommonContexts must come before CommonControllers --%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js?${versionNumber}"/>"></script>
	
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/lightSlider/jquery.lightSlider.min.js?${versionNumber}"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&language=fr${googleAuth}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/MapStoreLocator.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/SearchShopsJS.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/ShopsController.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/jScrollbar/jquery.scrollbar.js?${versionNumber}"></script>
<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>
<script type="text/javascript">
			dojo.addOnLoad(function() { 
					shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}" />','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
					SearchShopsJS.init();
					SearchShopsJS.initCountry("${CommandContext.country}");
					<c:set var="geoLocRequired" value="true" />
					<c:choose>
						<c:when test="${userType eq 'G'}">
							<c:set var="geoLocRequired" value="true" />
						</c:when>
						<c:otherwise>
							<wcbase:useBean id="addressDB" classname="com.lapeyre.declic.commerce.usermanagement.commands.SelfAddressDataBean" scope="page" />
							<c:if test="${!empty addressDB.selfAddress}">
								<c:set var="geoLocRequired" value="false" />
								<c:set var="address" value="${addressDB.selfAddress.address1}" />
								<c:set var="address" value="${address}+${addressDB.selfAddress.city}" />
								<c:set var="address" value="${address}+${addressDB.selfAddress.state}" />
								<c:set var="address" value="${address}+${addressDB.selfAddress.zipCode}" />
								SearchShopsJS.doSearchShopFromAddress('<c:out value="${address}" />');
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:if test="${geoLocRequired eq 'true'}">
						SearchShopsJS.geoLocSearch();
					</c:if>
			});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
					document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>
</script>

<script type="text/javascript">
	function popupWindow(URL) {
		window.open(URL, "mywindow", "status=1,scrollbars=1,resizable=1");
	}
</script>

<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>

<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>
<c:set var="addressBookBean" value="${person.addressBook}"/>

<wcf:url var="MyAccountURL" value="AjaxLogonForm">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>

<c:set var="firstName" value="${person.contactInfo.contactName.firstName}" scope="request"/>
<c:set var="lastName" value="${person.contactInfo.contactName.lastName}" scope="request"/>

</head>
<body>
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
							<fmt:message var="lastBreadCrumbItem" key="myStoresBreadcrumbLabel" bundle="${widgetText}" />
							<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
								<c:param name="pageName" value="CompteClient" />
								<c:param name="breadCrumbMonCompte" value="true" />
								<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
							</c:import>
							<%out.flush();%>
                    	</div>
                	 </div>
                	 <c:set var="navMonCompteCurrentPage" value="myStores"/>
					
					
					<div class="row" id="myStoresPage">
						<div id="navCompteClient" class="col3 mobile-hidden">
							<%@ include file="../../AccountSection/navClient.jspf" %>
						</div>
						<div class="col9 bcol12 mainContentWrapper">
							<c:if test="${!isOnMobileDevice}">
								<div class="row">
									<%@include file="../../../StoreLocatorArea/StoreLocator_SearchBar_UI.jspf" %>						
								</div>
							
								<div class="row" style="position:relative;" id="mapShopContainerRow">
									<%@include file="../../../StoreLocatorArea/StoreLocator_Map_UI.jspf" %>
								</div>
							</c:if>
							<div class="row greyBackground"  id="listShopContainerRow">
								<%@include file="../../../StoreLocatorArea/FavoritesShopsDisplay.jsp" %>
							</div>
							<div class="row greyBackground">
								<%@include file="../../../StoreLocatorArea/NearestShopsDisplay.jsp" %>
							</div>
							<c:if test="${!isOnMobileDevice}">
								<div class="row" style="position: relative">				
									<%@include file="../../../StoreLocatorArea/StoreLocator_ListShops_Data.jspf" %>
									<%@include file="../../../StoreLocatorArea/StoreLocator_ListShops_Script.jspf" %>
									<%@include file="../../../StoreLocatorArea/StoreLocator_ListShops_UI.jspf" %>
								</div>
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
		<c:param name="pageName" value="userShops" />
	</c:import>
</body>
</html>