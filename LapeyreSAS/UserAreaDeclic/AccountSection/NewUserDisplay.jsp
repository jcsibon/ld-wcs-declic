<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../Common/nocache.jspf" %>
<%@ include file="../../include/ErrorMessageSetup.jspf" %>

<c:set var="cookieNameFormLapeyre3D" value="registrationFromLapeyre3D" />

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title><fmt:message bundle="${storeText}" key="myAccountMenuLinkLabel"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		
	<link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css?${versionNumber}" type="text/css" />
	
	<%@ include file="../../Common/CommonJSToInclude.jspf"%>
	
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
</head>
<body>
<!-- Page Start -->
<div id="page">
	<c:set var="paramSource" value="${WCParam}"/>  
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
		<wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
	<%out.flush();%>
	<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
	<%out.flush();%>
	
	<div id="contentWrapper">
			<div id="content" role="main">
				<div class="rowContainer">
                    <div class="row">
                        <div data-slot-id="1" class="col12 slot1 mobile-hidden">
							<%out.flush();%>
							<fmt:message var="lastBreadCrumbItem" key="confirmationAccountCreationBreadcrumbLabel" bundle="${widgetText}" />
							<c:choose>
								<c:when test="${!empty WCParam.syncRequestByUser && WCParam.syncRequestByUser eq 'true'}">
									<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
									<c:param name="pageName" value="CompteClient" />
									<c:param name="breadCrumbSynchro" value="true" />
									<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
								</c:import>
								</c:when>
								<c:otherwise>
									<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
										<c:param name="pageName" value="CompteClient" />
										<c:param name="breadCrumbInscription" value="true" />
										<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
									</c:import>
								</c:otherwise>
							</c:choose>							
							<%out.flush();%>
						</div>
                	 </div>
                	 	<c:set var="navMonCompteCurrentPage" value="myAccount"/>
						<%--@ include file="headerClient.jspf" --%>
                	 
                	 <div class="row" id="myAccountConfirmationPage">
						<div id="navCompteClient" class="col3 mobile-hidden">
							<%@ include file="navClient.jspf" %>
						</div>
						<div class="col9 bcol12 mainContentWrapper">
							<div class="monCompteRedirection">
								<h1 class="title"><fmt:message bundle="${storeText}" key="${(!empty WCParam.syncRequestByUser && WCParam.syncRequestByUser eq 'true') ? 'confirmAccountSynchroPageTitle' : 'confirmAccountCreationPageTitle'}"/></h1>
								<c:choose>
									<c:when test="${cookie[cookieNameFormLapeyre3D] == null}">
										<c:set var="messageConfirmationKey" value="${(!empty WCParam.syncRequestByUser && WCParam.syncRequestByUser eq 'true') ? 'confirmAccountSynchroPageContent' : 'confirmAccountCreationPageContent'}" />
									</c:when>
									<c:otherwise>
										<c:set var="messageConfirmationKey" value="confirmAccountCreationFromLapeyre3D" />
									</c:otherwise>
								</c:choose>
								<p><fmt:message bundle="${storeText}" key="${messageConfirmationKey}"/></p>
							</div>

						</div>
					</div>
					<div class="row">
						<div class="col12">
							<%-- ECOCEA : call CMS --%>
						
							<c:import url="${env_jspStoreDir}/include/ContentContext.jsp">
								<c:param name="typePage" value="compteClient" />
								<c:param name="id" value="confirmation"/>
								<c:param name="complement" value=""/>
							</c:import>
							<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget.jsp">
								<c:param name="emplacement" value="Bottom" />
							</c:import>
						</div>
					</div>
             	</div>
    		 </div>
    </div>
    
    <%out.flush();%>
	<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
	<%out.flush();%>
	<c:import url="../../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="UserRegistration" />
	</c:import>