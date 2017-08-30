<%--
  *****
  * This JSP file displays the shopping cart page. It shows shopping cart details plus lets the shopper
  * initiate the checkout process either as a guest user, a registered user, or as a registered user
  * that has a quick checkout profile saved with the store.
  *****
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- LAPEYRE_PANIER -->
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

<c:set var="isStoreLocatorEnabled" value="false"/>
<c:set var="tunnelStep" value="${param.tunnelStep }"/>
<%-- Check if store locator feature is enabled. --%>
<flow:ifEnabled feature="BOPIS">
	<c:set var="isBOPISEnabled" value="true"/>
</flow:ifEnabled>

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
		<title><fmt:message bundle="${storeText}" key="SHOPPINGCART_TITLE_${tunnelStep }"/></title>
		<META NAME="robots" CONTENT="noindex,nofollow" />

		<link rel="stylesheet" type="text/css" href="${jspStoreImgDir}css/redesign/checkout.css" />
		<link rel="stylesheet" type="text/css" href="${jspStoreImgDir}css/redesign/checkout-media.css" />
		<%@ include file="../../Common/CommonJSToInclude_redesign.jspf"%>
		
		<!--[if IE 8]>
		    <link rel="stylesheet" type="text/css" href="${jspStoreImgDir}css/tunnel_ie8.css" />
		<![endif]-->
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingList.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/ShoppingList/ShoppingListServicesDeclaration.js?${versionNumber}"/>"></script>
		
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"/>"></script>
		
		<%-- CommonContexts must come before CommonControllers --%>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>

		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/LogonForm.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js?${versionNumber}"/>"></script>
		<c:if test="${b2bStore}">
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Vector.js?${versionNumber}"/>"></script>
			<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/SavedOrders.js?${versionNumber}"/>"></script>
		</c:if>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/ShipmodeSelectionExt.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/PhysicalStoreCookie.js?${versionNumber}"/>"></script>
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeafWC.js?${versionNumber}"></script>
		<c:if test="${env_Tealeaf eq 'true' && env_inPreview != 'true'}">
			<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeaf.js?${versionNumber}"></script>
		</c:if>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.ItemAvailabilityInPhysicalStoresWidget/javascript/ItemAvailabilityInPhysicalStoresWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Stock/StockAvailability.js?${versionNumber}"></script>
		<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&language=fr${googleAuth}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/MapStoreLocator.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/SearchShopsJS.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/ShopsController.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/jScrollbar/jquery.scrollbar.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/Timer.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/TagManager.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/ShopcartSection/TunnelCommonUtility.js?${versionNumber}"></script>

		
		
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				categoryDisplayJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>','<c:out value='${userType}'/>');
				CheckoutHelperJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
				ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
				ShipmodeSelectionExtJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
				ShipmodeSelectionExtJS.setBOPISEnabled(<c:out value="${isBOPISEnabled}"/>);
                    	 
			});
		</script>
		
		<c:set var="AjaxAddToCart" value="false"/>
		<flow:ifEnabled feature="AjaxAddToCart"> 
			<c:set var="AjaxAddToCart" value="true"/>
		</flow:ifEnabled>
		
		<c:set var="isAjaxCheckOut" value="true"/>
		<flow:ifDisabled feature="AjaxCheckout"> 
			<c:set var="isAjaxCheckOut" value="false"/>
		</flow:ifDisabled>

		<script type="text/javascript">
			dojo.addOnLoad(shopCartPageLoaded);
			
			function shopCartPageLoaded() {
				categoryDisplayJS.setAjaxShopCart(<c:out value='${AjaxAddToCart && isAjaxCheckOut}'/>);
				CheckoutHelperJS.setAjaxCheckOut(<c:out value="${isAjaxCheckOut}"/>);
				CheckoutHelperJS.shoppingCartPage="true";
			}
		</script>
              
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
              
		<wcf:url var="ShopCartDisplayViewURL" value="ShopCartDisplayView" type="Ajax">
			<wcf:param name="langId" value="${langId}" />                                          
			<wcf:param name="storeId" value="${WCParam.storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
			<wcf:param name="shipmentType" value="single" />
		</wcf:url>     
              
		<%-- This following section is only loaded and executed if the current page flow is non-AJAX --%>
		<c:if test="${!isAjaxCheckOut}">
			<script type="text/javascript">
				///////////////////////////////////////////////////
				// summary              : Set a dirty flag
				// description       : Set a dirty flag in CheckoutPayments.js when the user modifies order item quantities in a non-AJAX shopping cart
				//
				// event              : DOM/Dojo/Dijit event, e.g. onclick, onchange, etc.
				// assumptions       : Used in non-AJAX checkout flow
				// dojo API              : 
				// returns              : void
				///////////////////////////////////////////////////
				function setDirtyFlag(){
					CheckoutHelperJS.setFieldDirtyFlag(true);
					console.debug("Order item information on the Shopping Cart page was modified.");
				}
				
				/////////////////////////////////////////////////////////////////////////
				// On page load, add editable fields in the shipping information
				// section to Dojo event listener so that when they are changed by the
				// user, the user is required to to update the shopping cart before
				// proceeding to checkout.
				/////////////////////////////////////////////////////////////////////////
				dojo.addOnLoad(CheckoutHelperJS.initDojoEventListenerShoppingCartPage);
			</script>
		</c:if>
	</head>

	<body style="padding-top: 0px;">
		<c:set var="shoppingCartPage" value="true" scope="request"/>
		<c:set var="pageGroup" value="shoppingCart" scope="request"/>
		
		<div id="page">
			<%-- This file includes the progressBar mark-up and success/error message display markup --%>
			<%@ include file="../../Common/CommonJSPFToInclude.jspf"%>
			<%@ include file="/Widgets-lapeyre/Common/ProductConstants.jspf"%>
			<%@ include file="OrderItemDisplay_Data.jspf"%>
			<%@ include file="OrderItemDetail_MainData.jspf"%>
			<%@ include file="OrderItemDetail_Data.jspf"%>
			
			<!-- Header Widget -->
			<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp">
				<c:param name="loadHeaderLight" value="${(tunnelStep eq '2' || tunnelStep eq '3' || tunnelStep eq '4' || tunnelStep eq '5') ? true:false}"></c:param>
			</c:import>
			<%out.flush();%>
			
			<script type="text/javascript">
				dojo.addOnLoad(function() {
					CommonControllersDeclarationJS.setControllerURL('ShopCartDisplayController','<c:out value="${ShopCartDisplayViewURL}"/>');
					var ordQtyHeaderLight = document.getElementById('minishopcart_total_headerLight');
					if(ordQtyHeaderLight != null) {
						ordQtyHeaderLight.innerHTML = "${orderQuantity}";
					}
				});
				
				var isCatalogCommand = false;
				var isStandardCommand = false;
				<c:if test="${!empty isCatalogCommand}">
					isCatalogCommand = JSON.parse('${isCatalogCommand}');
				</c:if>
				<c:if test="${!empty isStandardCommand}">
					isStandardCommand = JSON.parse('${isStandardCommand}');
				</c:if>
			</script>

			
			<div id="content" role="main" class="checkout-wrapper">
				<c:choose>
					<c:when test="${!empty order && !empty order.orderItem }">
						<div id="fullBackground" class="full-background">
							<div class="container">
								<%@ include file="TunnelShopCartHeader_UI.jspf" %> 
							</div>
						</div>
						<div class="container">
							<c:if test="${tunnelStep > 1 && tunnelStep < 5}">
								<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
								<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
        						<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
        						<!-- Style sheet for print -->
        						<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
        						<link rel="stylesheet" href="${jspStoreImgDir}css/styles_edito.css?${versionNumber}" type="text/css" media="screen"/>
							</c:if>
							<c:choose>
								<c:when test="${tunnelStep eq '1'}">
									<%@ include file="TunnelShopCartDisplay_UI.jspf" %>
									<%-- Target2Sell Reco BEGIN --%>
									<% out.flush(); %>
									<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.EMarketingSpot/EMarketingSpot.jsp">
										<c:param name="emsName" value="T2SShopCart"/>
										<c:param name="widgetOrientation" value="horizontal"/>
										<c:param name="pageSize" value="4"/>
										<c:param name="t2sWidgetSuffix" value="T2SShopCart"/>
										<c:param name="displayPreference" value="1"/>
									</c:import>
									<% out.flush(); %>
									<%-- Target2Sell Reco END --%>
								</c:when>
								<c:when test="${tunnelStep eq '2'}">
									<%@ include file="TunnelLogonDisplay_UI.jspf" %>
								</c:when>
								<c:when test="${tunnelStep eq '3'}">
									<%@ include file="TunnelLivraison_UI.jspf" %>
								</c:when>
								<c:when test="${tunnelStep eq '4'}">
									<%@ include file="TunnelPayment_UI.jspf" %>
								</c:when>
								<c:when test="${tunnelStep eq '5'}">

								</c:when>
								<c:otherwise>
									<%@ include file="TunnelShopCartDisplay_UI.jspf" %>
								</c:otherwise>
							</c:choose>
					</c:when>
					<c:otherwise>
						<div class="container">
							<div class="row padding-bottom" id="emptyShopCartArea">
								<p class="emptyShopCart_label"><fmt:message bundle="${storeText}" key="apecuPanierNoProductLabel"/></p>
								<p class="emptyShopCart_image"><img alt="<fmt:message bundle="${storeText}" key="apecuPanierNoProductLabel"/>" src="${hostPath}${jspStoreImgDir}images/responsive/basketEmpty.png"/></p>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
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
		</div>
		
		<!-- Footer Widget -->
		<div class="footer_wrapper_position">
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
<!-- END OrderItemDisplay.jsp -->
