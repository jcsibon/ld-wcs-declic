<%--
  *****
  * This JSP file displays the shopping cart page. It shows shopping cart details plus lets the shopper
  * initiate the checkout process either as a guest user, a registered user, or as a registered user
  * that has a quick checkout profile saved with the store.
  *****
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE HTML>
<!-- BEGIN TunnelCommandConfirmationDisplay.jsp -->
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

<c:set var="tunnelStep" value="${!empty WCParam.tunnelStep ? WCParam.tunnelStep : '5'}"/>

<!-- widgetText -->
<fmt:message var="tunnelRecapCmdBreadcrumbLabel" key="tunnelRecapCmdBreadcrumbLabel" bundle="${widgetText}" />
<fmt:message var="tunnelIdentificationBreadcrumbLabel" key="tunnelIdentificationBreadcrumbLabel" bundle="${widgetText}" />
<fmt:message var="tunnelLivraisonBreadcrumbLabel" key="tunnelLivraisonBreadcrumbLabel" bundle="${widgetText}" />
<fmt:message var="tunnelPaiementBreadcrumbLabel" key="tunnelPaiementBreadcrumbLabel" bundle="${widgetText}" />
<fmt:message var="tunnelConfirmationBreadcrumbLabel" key="tunnelConfirmationBreadcrumbLabel" bundle="${widgetText}" />

<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#" xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><fmt:message bundle="${storeText}" key="SHOPPINGCART_TITLE_5"/></title>
		<META NAME="robots" CONTENT="noindex,nofollow" />
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}css/print-lapeyre.css?${versionNumber}"/>" type="text/css"/>
		<c:if test="${isOnMobileDevice}">
<%-- 			<link rel="stylesheet" type="text/css" href="${jspStoreImgDir}css/tunnel_mobile.css" /> --%>
		</c:if>
		<!--[if IE 8]>
		    <link rel="stylesheet" type="text/css" href="${jspStoreImgDir}css/tunnel_ie8.css" />
		<![endif]-->
		
		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../Common/CommonJSToInclude_redesign.jspf"%>
		
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"/>"></script>
		
		<%-- CommonContexts must come before CommonControllers --%>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>

		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingList.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListServicesDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ECOCatalogEntry/javascript/ProductDisplay.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.PDP_FullImage/javascript/ProductFullImage.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.StandardProductDisplayWidget/javascript/StandardProductDisplayWidget.js?${versionNumber}"></script>

		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/TagManager.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.ItemAvailabilityInPhysicalStoresWidget/javascript/ItemAvailabilityInPhysicalStoresWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Stock/StockAvailability.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/tooltipster/jquery.tooltipster.min.js?${versionNumber}"></script>

		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/PhysicalStoreCookie.js?${versionNumber}"/>"></script>
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeafWC.js?${versionNumber}"></script>
		<c:if test="${env_Tealeaf eq 'true' && env_inPreview != 'true'}">
			<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeaf.js?${versionNumber}"></script>
		</c:if>
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/jScrollbar/jquery.scrollbar.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/Timer.js?${versionNumber}"></script>
		
		
		
              
		<script type="text/javascript">
              
			dojo.addOnLoad(initGetTimeZone);
              
			function initGetTimeZone() {
				// get the browser's current date and time
				var d = new Date();
				
				// find the timeoffset between browser time and GMT
				var timeOffset = -d.getTimezoneOffset()/60;
              
				// store the time offset in cookie
				var gmtTimeZone;
				if (timeOffset < 0)
					gmtTimeZone = "GMT" + timeOffset;
				else if (timeOffset == 0)
					gmtTimeZone = "GMT";
				else
					gmtTimeZone = "GMT+" + timeOffset;                    
				dojo.cookie("WC_timeoffset", gmtTimeZone, {path: "/"});
			}
		</script>
	</head>

	<body>
		<div id="page">
			<!-- Header Widget -->
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp"/>
				<%out.flush();%>
		
			<div class="content_wrapper_position" role="main">
				<div class="tunnelShopCartHeaderConfirmation">
					<%@ include file="TunnelShopCartHeader_UI.jspf" %>
				</div>
				<div id="contentWrapper" class="contentWrapperConfirmation ${isOnMobileDevice?'noUnderSearch':''}">
					<div id="content" role="main">
						<div class="rowContainer">
							<%@ include file="TunnelConfirmation_UI.jspf" %>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Footer Widget -->
		<div class="footer_wrapper_position print-hidden">
			<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
			<%out.flush();%>
		</div>                                   
<flow:ifEnabled feature="Analytics">
<cm:pageview/>                                   
</flow:ifEnabled>
	<%@ include file="../../Common/JSPFExtToInclude.jspf"%> 
	<c:import url="../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="tunnel" />
		<c:param name="tunnelStep" value="${tunnelStep}" />
	</c:import>
</body>
</html>     
<!-- END TunnelCommandConfirmationDisplay.jsp -->
