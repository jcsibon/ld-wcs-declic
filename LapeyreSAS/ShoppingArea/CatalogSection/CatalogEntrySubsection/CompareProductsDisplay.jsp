<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN CompareProductsDisplay.jsp -->

<%@include file="../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../Common/nocache.jspf" %>

<c:set var="pageCategory" value="Browse" scope="request"/>

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><fmt:message bundle="${storeText}" key="CPG_PAGE_TITLE" /></title>
		<META NAME="robots" CONTENT="noindex,follow" />
		<meta name="pageName" content="ComparePage"/>
		
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/tooltipster.css" type="text/css"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />

		<!-- Include script files -->
		<%@include file="../../../Common/CommonJSToInclude.jspf" %>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/QuickInfo/QuickInfo.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/tooltipster/jquery.tooltipster.min.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/CompareProduct/CompareProduct.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ECOCatalogEntry/javascript/ProductDisplay.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ShoppingList/javascript/WishList.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.PDP_FullImage/javascript/ProductFullImage.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.StandardProductDisplayWidget/javascript/StandardProductDisplayWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.ItemAvailabilityInPhysicalStoresWidget/javascript/ItemAvailabilityInPhysicalStoresWidget.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Stock/StockAvailability.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/Timer.js?${versionNumber}"></script>
		
	</head>
		
	<body class="univers famille">

		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
	
		<!-- Begin Page -->
			<!-- Start Content -->

			<!-- Import Header Widget -->
			
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp" />
				<%out.flush();%>
			
			
			<!--Start Page Content-->
			<div class="content" role="main">
				<div class="content_wrapper">
					<!-- Main Content Area -->
					<div class="content">
						<!-- Start Main Content -->
						<div class="row">
							<br />
							<a href="javascript:history.back()" class="button back"><fmt:message bundle="${storeText}" key='retour'/></a>
							<!-- Widget Breadcrumb-->
							<%-- <div class="widget_breadcrumb_position">
									<%out.flush();%>
											<wcpgl:widgetImport useIBMContextInSeparatedEnv="${isStoreServer}" url = "${env_siteWidgetsDir}com.ibm.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
												<wcpgl:param name="pageName" value="ProductComparePage"/>
											</wcpgl:widgetImport>
									<%out.flush();%>
								</div> --%>
							<!-- Widget Breadcrumb -->
						</div>
								
						<!-- Content - Full Width Container -->
						<div class="row">
								<%out.flush();%>
									<c:import url = "${env_jspStoreDir}Widgets/CompareProduct/CompareProduct.jsp" />
								<%out.flush();%>
						</div>
						<!-- End Content - Full Width Container -->
						<!-- End Main Content -->				
					</div>
				</div>
			</div>
			<!--End Page Content-->
			
			<!--Start Footer Content-->
			<div class="footer_wrapper_position">
				<%out.flush();%>
					<c:import url = "${env_jspStoreDir}Widgets/Footer/Footer.jsp" />
				<%out.flush();%>
			</div>
			<!--End Footer Content-->
	<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
	<%@ include file="../../../Common/JSPFExtToInclude.jspf"%> </body>
<c:import url="../../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="compareProducts" />
	</c:import>
<!-- END CompareProductsDisplay.jsp -->	
	
</html>