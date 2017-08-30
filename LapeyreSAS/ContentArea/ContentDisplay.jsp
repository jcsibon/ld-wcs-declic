<!doctype HTML>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@include file="../Common/nocache.jspf" %>
<%-- Target2Sell BEGIN --%>
<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_CONTENT %>" scope="request" />
<%-- Target2Sell END --%>

<%-- TODO : determiner les meta et pageGroup --%>
<c:set var="isPageEdito" value="true" scope="request" />
<c:set var="isMobile" scope="request" value="${EC_deviceAdapter.deviceFormatId == -21}" />
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}${portUsed}" var="hostPath" />

<%-- SendForm endpoint url --%>
<wcf:url var="SendFormURL" value="SendFormCmd" type="Ajax">
	<wcf:param name="storeId" value="${WCParam.storeId}" />
</wcf:url>

<%-- selon le type, inclure la bonne JSP --%>
<c:choose>
	<c:when test="${content.template == '-1'}">
		<title><fmt:message key="pageIntrouvableLabel" bundle="${storeText}" /></title>
		<% response.setStatus(404); %>
	</c:when>
	<c:when test="${content.template == '3' || content.template == '2'}">
		<c:set var="pageTitle" value="${content.dossier.seo.titre}" scope="request"/>
		<c:set var="metaDescription" value="${content.dossier.seo.description}" />
		<c:set var="metaKeyword" value="${content.dossier.seo.keywords}" />
		<c:set var="urlToShare" value="${ecocea:concatUrls(hostPath,fn:trim(content.dossier.seo.url))}" />
		<c:set var="metarobots" value="${content.dossier.seo.index?'index':'noindex'},${content.dossier.seo.follow?'follow':'nofollow'}" />
		<%-- TODO follow et index --%>
	</c:when>
	<c:otherwise>
		<c:set var="pageTitle" value="${content.page.seo.titre}" scope="request"/>
		<c:set var="metaDescription" value="${content.page.seo.description}" />
		<c:set var="metaKeyword" value="${content.page.seo.keywords}" />
		<c:set var="urlToShare" value="${ecocea:concatUrls(hostPath,fn:trim(content.page.seo.url))}" />
		<c:set var="metarobots" value="${content.page.seo.index?'index':'noindex'},${content.page.seo.follow?'follow':'nofollow'}" />
	</c:otherwise>
</c:choose>

<fmt:setBundle basename="/Widgets/Properties/widgettext" var="widgetText" />
<c:set var="widgetSuffix" value="" />

<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
<flow:ifEnabled feature="FacebookIntegration">
	<%-- Facebook requires this to work in IE browsers --%>
	xmlns:fb="http://www.facebook.com/2008/fbml" 
	xmlns:og="http://opengraphprotocol.org/schema/"
</flow:ifEnabled>
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><c:out value="${pageTitle}"/></title>
		<meta name="viewport" content="<c:out value="${viewport}"/>"/>
		<meta name="description" content="<c:out value="${metaDescription}"/>"/>
		<meta name="keywords" content="<c:out value="${metaKeyword}"/>"/>
		<meta name="pageName" content="${pageTitle}"/>
		<c:if test = "${metarobots ne 'index,follow' }" >
			<meta name="robots" content="${metarobots}">
		</c:if>
		<%-- Use only HTTPS URL for canonical --%>		
	    <link rel="canonical" href="<c:out value="${fn:replace(urlToShare, 'http://', 'https://')}"/>" />
		<!--Main Stylesheet for browser -->
		<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/product/productDisplay.css" type="text/css">
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}" type="text/css" media="screen"/>
		<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/common.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/common-media.css" type="text/css">

		<!-- Style sheet for print -->
		<link rel="stylesheet" href="${jspStoreImgDir}${env_vfileStylesheetprint}?${versionNumber}" type="text/css" media="print"/>
		<link rel="stylesheet" href="${jspStoreImgDir}css/styles_edito.css?${versionNumber}" type="text/css" media="screen"/>
		
		<!-- Include script files -->
		<%@include file="../Common/CommonJSToInclude.jspf" %>
		<script type="text/javascript" src="${jsAssetsDir}javascript/StoreCommonUtilities.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/ContentArea/Contrib.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/collapsible.js?${versionNumber}"></script>
		<script type="text/javascript" src="${jsAssetsDir}javascript/Miscellaneous/YoutubePlayer.js?${versionNumber}"></script>
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
					shoppingActionsServicesDeclarationJS.setCommonParameters('<c:out value="${langId}" />','<c:out value="${storeId}" />','<c:out value="${catalogId}" />');
					Contrib.setEndpoint('${SendFormURL}');
				});
			<c:if test="${!empty requestScope.deleteCartCookie && requestScope.deleteCartCookie[0]}">					
				document.cookie = "WC_DeleteCartCookie_${requestScope.storeId}=true;path=/";				
			</c:if>
		</script>
		
		<%-- wcpgl:jsInclude varPageDesignDetails="pageDesign"/ --%>
		
		<jsp:useBean id="contentHelper" class="com.lapeyre.declic.cms.ContentHelper" scope="request"></jsp:useBean>
		<c:set var="imageUrl" scope="request" value="${contentHelper.imageUrl}" />
		
		<%@ include file="../Common/SocialNetworksSetup.jspf" %>
		<%@ include file="../Common/JSTLEnvironmentSetupExtForSocialNetworks.jsp" %>
	</head>
		

<body class="edito" id="page">

		<%-- This file includes the progressBar mark-up and success/error message display markup --%>
		<%@ include file="../Common/CommonJSPFToInclude.jspf"%>
			
		<%-- Envoi de formulaire par mail : popup succ�s / �chec --%>
		<%@ include file="../../Widgets-lapeyre/Common/ContactPage/ContactMailSentPopup.jspf"%>
		<%@ include file="../../Widgets-lapeyre/Common/ContactPage/ContactMailNotSentPopup.jspf"%>

			<%out.flush();%>
			<c:import url = "${env_jspStoreDir}Widgets/Header/Header.jsp">
				<c:param name="isPageEdito" value="true"/>
				<c:param name="omitHeader" value="${WCParam.omitHeader}" />
			</c:import>
			<%out.flush();%>
		
		<div id="contentWrapper">
			<div id="content" role="main">
				<div class="rowContainer" id="containerMain">
				<!-- Begin Page -->						
				<%-- 
				<c:set var="layoutPageIdentifier" value="${productId}"/>
				<c:set var="layoutPageName" value="${catalogNavigationView.catalogEntryView[0].partNumber}"/>
				<%@ include file="/Widgets/Common/ESpot/LayoutPreviewSetup.jspf"%>
				<c:set var="rootWidget" value="${pageDesign.widget}"/>
				<wcpgl:widgetImport uniqueID="${rootWidget.widgetDefinitionIdentifier.uniqueID}" debug=false/>
				--%>
				<c:if test="${WCParam.omitHeader != 1}">
					<div class="row">
						<div class="col12 slot1">
							<%@include file="Content_BreadcrumbTrail_UI.jspf" %>
						</div>
					</div>
				</c:if>
				

<c:set var="carouselIdx" value="1" scope="request" />
				
<%-- selon le type, inclure la bonne JSP --%>
	<c:choose>
		<c:when test="${content.template == '-1'}">
		<%out.flush();%>
			<c:import url = "/error404_content.jsp">
			</c:import>
			<%out.flush();%>
		</c:when>
		<c:when test="${content.template == '3'}">
			<%@include file="Page_HomeEditorial.jsp" %>
		</c:when>
		<c:when test="${content.template == '0'}">
			<%@include file="Page_ArticleEditorial.jsp" %>
		</c:when>
		<c:when test="${content.template == '2'}"> 
			<%@include file="Page_FolderEditorial.jsp" %>
		</c:when>
		<c:otherwise> <%-- empty content.template ||  --%>
			<%@include file="Page_ArticleFree.jsp" %>
		</c:otherwise>
	</c:choose>	


				</div>
			</div>
		</div>
			
<%-- 		<div id="footerWrapper"> --%>
			<%out.flush();%>
			<c:import url="${env_jspStoreDir}Widgets/Footer/Footer.jsp">
				<c:param name="omitHeader" value="${WCParam.omitHeader}" />
			</c:import>
			<%out.flush();%>
<%-- 		</div> --%>
		
		<%-- flow:ifEnabled feature="Analytics">
			<%@include file="../AnalyticsFacetSearch.jspf" %>
			<cm:product catalogNavigationViewJSON="${catalogNavigationView}" extraparms="null, ${analyticsFacet}"/>
			<cm:pageview/>
		</flow:ifEnabled>
		 --%>
	<%--@ include file="../Common/JSPFExtToInclude.jspf"--%>
	<c:import url="../TagManager/TagManager.jsp" >
		<c:param name="pageGroup" value="contentCMS" />
	</c:import>
</body>

<%--wcpgl:pageLayoutCache pageLayoutId="${pageDesign.layoutID}"/  --%>
<!-- END Editorial.jsp -->		
</html>
