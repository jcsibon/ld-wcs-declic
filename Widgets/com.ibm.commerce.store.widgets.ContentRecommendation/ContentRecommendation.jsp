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

<!-- BEGIN ContentRecommendation.jsp -->

<!-- JSPs References: HomePage.jsp, BundleDisplay.jsp , CategoryNavigationDisplay.jsp, CompareProductsDisplay.jsp
					  DynamicKitDisplay.jsp, PackageDisplay.jsp, ProductDisplay.jsp, 
					  SearchResultDisplay.jsp, SubCategoryPage.jsp, TopCategoryPage.jsp
					   , Footer.jsp , OrderCancelNotify.jsp , OrderCreateNotify.jsp
					  OrderShipmentNotify.jsp, AccountActivationNotify.jsp, PasswordChangeNotify.jsp,
					  PasswordResetNotify.jsp, WishlistCreateNotify.jsp,  LandingPage.jsp, 	
					  ShippingDetailDisplay.jsp, ShopCartDisplay.jsp, StaticContent, 
					  Static JSPs, Footer_UI.jsp, Header_UI.jsp, ProductDescription_UI.jsp  
					  UserTime-->
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%@ include file="/Widgets/Common/JSTLEnvironmentSetupExtForRemoteWidgets.jspf"%>

<%@ include file="ContentRecommendation_Data.jspf" %>

<c:if test="${env_inPreview && !env_storePreviewLink && ( empty ignorePreview )}">
	<c:if test="${empty contentFormatMap}">
		<c:set var="eSpotHasNoSupportedDataToDisplay" value="true"/>
	</c:if>
	
  <!-- Special handling to exclude the rich text widget -->
	<c:if test="${!empty param.pgl_widgetDefName && param.pgl_widgetDefName == 'ContentRecommendation'}">
	  <jsp:useBean id="previewWidgetProperties" class="java.util.LinkedHashMap" scope="page" />
		<c:set target="${previewWidgetProperties}" property="widgetOrientation" value="${param.widgetOrientation}" />	
		<c:if test="${param.widgetOrientation eq 'vertical'}" >
			<c:set target="${previewWidgetProperties}" property="pageSize" value="${param.pageSize}" />
		</c:if>
		<c:if test="${param.widgetOrientation eq 'horizontal' }">
			<c:set target="${previewWidgetProperties}" property="displayPreference" value="${param.displayPreference}" />
		</c:if>
		<c:set target="${previewWidgetProperties}" property="showFeed" value="${param.showFeed}" />	
	</c:if>

	<c:set var="widgetManagedByMarketing" value="true" />
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>
</c:if>
<c:if test="${!empty contentFormatMap}">
	<c:if test = "${param.showFeed eq 'true'}">
		<c:url var="eMarketingFeedURL" value="${restURLScheme}://${pageContext.request.serverName}:${restURLPort}${restURI}/stores/${storeId}/MarketingSpotData/${emsName}">
			<c:param name="responseFormat" value="atom" />
			<c:param name="langId" value="${langId}" />
			<c:param name="currency" value="${env_currencyCode}"/>
		</c:url>
		<%-- 
			Set this key ${emsName} to true in this map, will tell EMarketingSpot.jsp to 
			set showFeed to false for the other widgets in the same espot. We only need to
			show one feed icon and url for one EMarketingSpot.
		--%>
		<c:if test="${eSpotRssFeedEnabled != null }" >
			<c:set target="${eSpotRssFeedEnabled }" property="${emsName}" value="true" />
		</c:if>
	</c:if>
	<c:choose>
		<c:when test="${!empty param.isEmail && param.isEmail == 'true'}">
			<%@ include file="ContentRecommendation_Email_UI.jspf" %>			
		</c:when>
		<c:when test="${!empty param.isURLLink && param.isURLLink eq 'true'}">
			<%@ include file="ContentRecommendation_URLLink_UI.jspf" %>			
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${param.widgetOrientation eq 'vertical'}">
					<%@include file="ContentRecommendation_Vertical_UI.jspf"%>
				</c:when>
				<c:otherwise>
					<%@ include file="ContentRecommendation_UI.jspf" %>
				</c:otherwise>
			</c:choose>
			<%-- 
			 A ESpot widget can have Content, CatlogEntry, and Category recommendations, the ${eSpotTitleIncluded} 
			 is used to make sure that the ESpost title only display once.
			 --%>
			<c:if test="${ eSpotTitleIncluded == null}" >
				<jsp:useBean id="eSpotTitleIncluded" class="java.util.LinkedHashMap" scope="request" />
			</c:if>
			<c:if test="${empty eSpotTitleIncluded[emsName] }" >
				<c:set target="${eSpotTitleIncluded }" property="${emsName}" value="true" />
			</c:if>
		</c:otherwise>
	</c:choose>
</c:if>	

<c:if test="${empty ignorePreview }">	
<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
</c:if>
<wcpgl:pageLayoutWidgetCache/>
<!-- END ContentRecommendation.jsp -->
