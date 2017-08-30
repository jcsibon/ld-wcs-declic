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
<%@ include file="ResaDriveDisplay_Data.jspf" %>

<%@ include file="../../../include/ErrorMessageSetup.jspf"%>


<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#" xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><fmt:message bundle="${storeText}" key="reservationCreneauDriveStep1Title"/></title>
		<meta name="robots" content="nondex,nofollow"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
		<%@ include file="../../../Common/CommonJSToInclude.jspf"%>

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
	
	<script>
	
	<c:if test="${!empty errorMessage}">
		dojo.addOnLoad(function(){
 			MessageHelper.displayErrorMessage("${ecocea:escapeJS(errorMessage)}");
 		});
	</c:if>
		var locale = '${locale}';
		var localeDojo = locale.replace('_','-');localeDojo = localeDojo.toLowerCase();
		
		var driveScheduleNbDays = parseInt('${driveScheduleNbDays}');
		var driveScheduleStepDays = parseInt('${driveScheduleStepDays}');
		
		dojo.topic.subscribe('DriveTime_Selected',function(driveTimeSelect){
			dojo.removeClass(dojo.byId('submitResaDrive'),'disabled');
			dojo.byId('submitResaDrive').removeAttribute('disabled');
			dojo.byId('RequestDriveTimeForm').driveSchedule.value = driveTimeSelect;
		});
		
		dojo.subscribe("ErrorOnGetDriveSchedule",function(data){
			$('#resaDrivePlageHoraire').css('visibility','hidden');
			$('#resaDrivePlageHoraire').hide();
			$('#zoneAlertErrorMessage').html('${reservationCreneauDriveError}');
			$('#zoneAlertErrorMessage').show();
		});
		
		dojo.subscribe("SuccessOnGetDriveSchedule",function(data){
			$('#zoneAlertErrorMessage').html('');
			$('#zoneAlertErrorMessage').hide();
			$('#resaDrivePlageHoraire').css('visibility','visible');
			$('#resaDrivePlageHoraire').show();
		});
	</script>
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
							<c:if test="${!empty c}">
								<div class="row resaDrive">
									<h1 class="titleBlock">
										${reservationCreneauDriveStep1PageTitle}
									</h1>
									<p>
										${reservationCreneauDriveStep1Status}
									</p>
								</div>
								<div id="zoneAlertErrorMessage" class="col12 error alignCenter"></div>
								<div class="row tunnel">
									<div class="col12 plagesHoraire" id="resaDrivePlageHoraire" style="visibility: hidden;">
										<%out.flush(); %>
										<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.DriveScheduleWidget/DriveScheduleWidget.jsp" >
											<c:param name="dateDebut" value="${dateDebut}" />
											<c:param name="dateFin" value="${dateFinStep}" />
											<c:param name="startDateDriveSchedule" value="${dateDebut}" />
											<c:param name="endDateDriveSchedule" value="${dateFinTotal}" />
											<c:param name="step" value="${driveScheduleStepDays}" />
											<c:param name="shopId" value="${m}" />
										</c:import>
										<%out.flush(); %>
									</div>
									<script>
										dojo.addOnLoad(function(){
											wc.render.updateContext("DriveSchedule_Context",{'shopId':'${m}','dateDebut':'${dateDebut}','dateFin':'${dateFinStep}','startDateDriveSchedule':'${dateDebut}','endDateDriveSchedule':'${dateFinTotal}','step':'${driveScheduleStepDays}'});
										});
									</script>
								</div>
								<div class="row resaDrive">
									<div class="button_footer_line">		
										<form action="${URLToReserveDriveTime}" method="POST" id="RequestDriveTimeForm">		
											<input type="hidden" value="${c}" name="c" />			
											<input type="hidden" value="${m}" name="m" />			
											<input type="hidden" value="" name="driveSchedule" />						
											<input type="hidden" value="Drive" name="errorViewName" />												
											<input id="submitResaDrive" type="submit" value="${reservationCreneauDriveStep1SubmitButtonLabel}" class="button green disabled" disabled="true">
										</form>
									</div>
								</div>
							</c:if>
							<c:if test="${empty c}">
								<div class="row resaDrive">
									<h1 class="titleBlock">
										${reservationCreneauDriveStep1PageTitle}
									</h1>
									<p>
										${reservationCreneauDriveTechnicalErrorMessage}
									</p>
								</div>
							</c:if>
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