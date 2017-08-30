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

<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="ConfirmationResaDriveDisplay_Data.jspf" %>



<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#" xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><fmt:message bundle="${storeText}" key="reservationCreneauDriveStep2Title"/></title>
		<META NAME="robots" CONTENT="noindex,nofollow"/>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
		<%@ include file="../../../Common/CommonJSToInclude.jspf"%>


		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ShopcartSection/TunnelLivraison.js?${versionNumber}"/>"></script>
		
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"/>"></script>
		
		<%-- CommonContexts must come before CommonControllers --%>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>

		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js?${versionNumber}"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/PhysicalStoreCookie.js?${versionNumber}"/>"></script>
		
		<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeafWC.js?${versionNumber}"></script>
		<c:if test="${env_Tealeaf eq 'true' && env_inPreview != 'true'}">
			<script type="text/javascript" src="${jsAssetsDir}javascript/Tealeaf/tealeaf.js?${versionNumber}"></script>
		</c:if>

		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreLocatorArea/ShopsController.js?${versionNumber}"></script>		
		<script type="text/javascript" src="${jsAssetsDir}javascript/jScrollbar/jquery.scrollbar.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/Timer.js?${versionNumber}"></script>
		
		
		
		
	</head>
	
	<body>
		<div id="page">
			<%-- This file includes the progressBar mark-up and success/error message display markup --%>
			<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
			<!-- Header Widget -->
			<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp">
				<c:param name="loadHeaderLight" value="${isOnMobileDevice?false:true}"></c:param>
			</c:import>
			<%out.flush();%>
			<div class="content_wrapper_position" role="main">
				<div id="contentWrapper" class="${isOnMobileDevice?'noUnderSearch':''}">
					<div id="content" role="main">
						<div class="rowContainer">
							<c:choose>
								<c:when test="${isOnMobileDevice}">
									<%@ include file="mobile/ResaDriveHeader_UI.jspf" %>
								</c:when>
								<c:otherwise>
									<%@ include file="ResaDriveHeader_UI.jspf" %>
								</c:otherwise>
							</c:choose>
							<div class="row confirmationResaDrive">
								${reservationCreneauDriveStep2Body}
							</div>
							<div class="row confirmationResaDrive">
								<a href="${env_TopCategoriesDisplayURL}" class="button greenSmall right">
									${reservationCreneauDriveStep2SubmitButtonLabel}
								</a>
							</div>
							<div id="resaDriveMEABottomArea">
								<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget.jsp">
									<c:param name="emplacement" value="Bottom" />
								</c:import>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>