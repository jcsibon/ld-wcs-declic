<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>


<%-- Default values --%>
<c:set var="pageView" value="grid"/>
<c:if test="${!empty param.pageView}">
	<c:set var="pageView" value="${param.pageView}"/>
</c:if>
<c:set var="showFeed" value="false"/>
<c:if test="${!empty param.showFeed}">
	<c:set var="showFeed" value="${param.showFeed}"/>
</c:if>
<c:set var="errorViewName" value="AjaxOrderItemDisplayView"/>
<c:if test="${!empty param.errorViewName}">
	<c:set var="errorViewName" value="${param.errorViewName}"/>
</c:if>

<c:set var="displayOrder" value="${param.displayOrder }" />
<c:if test="${empty displayOrder }" >
	<c:set var="displayOrder" value="content,category,catalogEntry" />
</c:if>

<%@ include file="EMarketingSpot_Data.jspf" %>
<c:if test="${env_inPreview && !env_storePreviewLink }">
	<c:if test="${empty marketingSpotDatas.baseMarketingSpotActivityData}">
		<c:set var="eSpotHasNoSupportedDataToDisplay" value="true"/>
	</c:if>

	  <jsp:useBean id="previewWidgetProperties" class="java.util.LinkedHashMap" scope="page" />
		<c:set target="${previewWidgetProperties}" property="widgetOrientation" value="${param.widgetOrientation}" />	
		<c:if test="${param.widgetOrientation eq 'vertical' }"	>
			<c:set target="${previewWidgetProperties}" property="pageSize" value="${param.pageSize}" />
		</c:if>
		<c:if test="${param.widgetOrientation eq 'horizontal' }">
			<c:set var="preference"><fmt:message key="displayPreference_${param.displayPreference}" bundle="${widgetText}" /></c:set>
			<c:set target="${previewWidgetProperties}" property="displayPreference" value="${preference}" />
		</c:if>
		<c:set target="${previewWidgetProperties}" property="showFeed" value="${param.showFeed}" />
		<c:set target="${previewWidgetProperties}" property="emsType" value="${param.emsType}" />
		<c:set var="widgetManagedByMarketing" value="true" />
		
		<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>
</c:if>

<%-- Target2SellReco override BEGIN --%>
<c:remove var="productRecoURL" />
<c:remove  var="isTarget2SellReco"  />
<c:forEach items="${marketingSpotDatas.baseMarketingSpotActivityData}" var="elt">
	<c:if test="${elt.name == 'DM_NVP' && !empty elt.properties['isTarget2SellReco']}"><%-- is the a  isTarget2SellReco property in my emSpot --%>
		<c:set var="isTarget2SellReco" value="true" scope="request" />
	</c:if>
	<c:if test="${elt.name == 'DM_NVP' && !empty elt.properties['displayType'] && elt.properties['displayType'] == 'proximityMessage' }"><%-- is the a  isTarget2SellReco property in my emSpot --%>
		<c:set var="isProximityMessage" value="true" />
	</c:if>
</c:forEach>
<%-- Target2SellReco override END --%>

<c:if test="${ importedEMarketingSpotWidgetDatas == null}" >
	<jsp:useBean id="importedEMarketingSpotWidgetDatas" class="java.util.LinkedHashMap" scope="request" />
</c:if>
<c:set target="${importedEMarketingSpotWidgetDatas}" property="${emsName}" value="${marketingSpotDatas }" />
<%-- The map to trace the feed for a EMarketingSpot, the key is emsName, if the feedurl was included the value will be set --%>
<c:if test="${ eSpotRssFeedEnabled == null}" >
	<jsp:useBean id="eSpotRssFeedEnabled" class="java.util.LinkedHashMap" scope="request" />
</c:if>


<%--  
	Set showFeed to false. It is because we only need to
	show one feed icon and url for one EMarketingSpot.
--%>
<c:if test="${eSpotRssFeedEnabled[emsName]}" >
	<c:set var="showFeed" value="false" />
</c:if>
<c:choose>
	<c:when test="${emsName eq 'productPrice_RecoPromo'}">
		<%@ include file="/Widgets-lapeyre/Common/ESpot/PromotionPriceDisplay.jspf" %>
	</c:when>
	<%-- Ecocea : Displays the push Catalogue area in the home page --%>
	<c:when test="${emsName eq 'HomeMarketingSpot_PushCatalogue'}">
		<%@ include file="EMarketingSpot_PushCatalogue_UI.jspf" %>	
	</c:when>
	<c:when test="${isEmspotSelectionOfTheMonth eq true}">
		<% out.flush(); %>
		<c:import url="${catalogEntryRecommendationwidgetPath}">
			<%-- Parameters exposed to CMC --%>
			<c:param name="emsName" value="${emsName}"/>
			<c:param name="pagingControl" value="${param.pagingControl}"/>
			<c:param name="widgetOrientation" value="${param.widgetOrientation}"/>  <%--TODO pagingControl and widgetOrientation get the same value as align --%>					
			<c:param name="maxProductsToDisplay" value="${param.maxItemsToDisplay}"/>
			<c:param name="showFeed" value="${showFeed}"/>
			<c:param name="pageSize" value="${param.pageSize}"/>
			<c:param name="displayPreference" value="${param.displayPreference}"/>
			
			<%-- Unexposed common parameters --%>
			<c:param name="feedURL" value="${param.feedURL}"/>
			<c:param name="custom_data" value="${param.custom_data}"/>
			<c:param name="custom_view" value="${param.custom_view}"/>
			
			<%-- Unexposed data parameters --%>
			<c:param name="commandName" value="${param.commandName}"/>
			<c:param name="align" value="${param.align}"/>
			
			<c:param name="displayHeader" value="${param.displayHeader}"/>
			<c:param name="useFullURL" value="${param.useFullURL}"/>
			<c:param name="clickInfoURL" value="${param.clickInfoURL}"/>
			<c:param name="productId" value="${param.productId}"/>
			<c:param name="previewReport" value="${param.previewReport}"/>
			<c:param name="espotTitle" value="${param.espotTitle}"/>
			<c:param name="pageView" value="${pageView}"/>
			<c:param name="currentPage" value="${param.currentPage}"/>
			<c:param name="isEmspotSelectionOfTheMonth" value="${isEmspotSelectionOfTheMonth}"/>
			
			<%-- Unexposed UI parameters --%>
			<c:param name="feedLayer" value="${param.feedLayer}"/>
			<c:param name="widgetCeption" value="true" />
		</c:import>
		<% out.flush(); %>
	</c:when>
	<c:when test="${(isEmspotProductContent eq true) && (!empty excludedMarketingSpotDatas || useDefaultData)}">
		<% out.flush(); %>
		<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.ProductContentRecommendationWidget/ProductContentRecommendationWidget.jsp">
			<%-- PARAMETRES FOR CATALOGENTRY -->
			<%-- Parameters exposed to CMC --%>
			<c:param name="emsName" value="${emsName}"/>
			<c:param name="pagingControl" value="${param.pagingControl}"/>
			<c:param name="widgetOrientation" value="${param.widgetOrientation}"/>  <%--TODO pagingControl and widgetOrientation get the same value as align --%>					
			<c:param name="showFeed" value="${showFeed}"/>
			<c:param name="pageSize" value="${param.pageSize}"/>
			<c:param name="displayPreference" value="${param.displayPreference}"/>
			
			<%-- Unexposed common parameters --%>
			<c:param name="feedURL" value="${param.feedURL}"/>
			<c:param name="custom_data" value="${param.custom_data}"/>
			<c:param name="custom_view" value="${param.custom_view}"/>
			
			<%-- Unexposed data parameters --%>
			<c:param name="commandName" value="${param.commandName}"/>
			<c:param name="align" value="${param.align}"/>
			
			<c:param name="displayHeader" value="${param.displayHeader}"/>
			<c:param name="useFullURL" value="${param.useFullURL}"/>
			<c:param name="clickInfoURL" value="${param.clickInfoURL}"/>
			<c:param name="productId" value="${param.productId}"/>
			<c:param name="previewReport" value="${param.previewReport}"/>
			<c:param name="espotTitle" value="${param.espotTitle}"/>
			<c:param name="pageView" value="${pageView}"/>
			<c:param name="currentPage" value="${param.currentPage}"/>
			
			<%-- Unexposed UI parameters --%>
			<c:param name="feedLayer" value="${param.feedLayer}"/>
			
			<%-- PARAMETRES FOR CONTENT -->
			
			<%-- Parameters exposed to CMC --%>
			<c:param name="emsName" value="${emsName}"/>
			<c:param name="pagingControl" value="${param.pagingControl}"/>
			<c:param name="widgetOrientation" value="${param.widgetOrientation}"/>
			<c:param name="pageSize" value="${param.pageSize}"/>
			<c:param name="showFeed" value="${showFeed}"/>
			<c:param name="displayPreference" value="${param.displayPreference}"/>
						
			<%-- Unexposed common parameters --%>
			<c:param name="isEmail" value="${param.isEmail}"/>
			<c:param name="isURLLink" value="${param.isURLLink}"/>
			
			<%-- Unexposed data parameters --%>
			<c:param name="commandName" value="${param.commandName}"/>
			<c:param name="useFullURL" value="${param.useFullURL}"/>
			<c:param name="clickInfoURL" value="${param.clickInfoURL}"/>
			<c:param name="numberContentPerRow" value="${param.numberContentPerRow}"/>
			<c:param name="substitutionName1" value="${param.substitutionName1}"/>
			<c:param name="substitutionValue1" value="${param.substitutionValue1}"/>
			<c:param name="substitutionName2" value="${param.substitutionName2}"/>
			<c:param name="substitutionValue2" value="${param.substitutionValue2}"/>
			<c:param name="substitutionName3" value="${param.substitutionName3}"/>
			<c:param name="substitutionValue3" value="${param.substitutionValue3}"/>
			<c:param name="substitutionName4" value="${param.substitutionName4}"/>
			<c:param name="substitutionValue4" value="${param.substitutionValue4}"/>
			<c:param name="substitutionName5" value="${param.substitutionName5}"/>
			<c:param name="substitutionValue5" value="${param.substitutionValue5}"/>
			<c:param name="previewReport" value="${param.previewReport}"/>
			<c:param name="fromPage" value="${param.fromPage}"/>
			<c:param name="contentClickUrl" value="${param.contentClickUrl}"/>
			<c:param name="errorViewName" value="${param.errorViewName}"/>
			<c:param name="orderId" value="${param.orderId}"/>
			<c:param name="isCategorySubsriptionDisplayURL" value="${param.isCategorySubsriptionDisplayURL}"/>
			<c:param name="storeId" value="${param.storeId}"/>
			<c:param name="catalogId" value="${param.catalogId}"/>
			<c:param name="langId" value="${param.langId}"/>
			<c:param name="categoryId" value="${param.categoryId}"/>
			
			<%-- Unexposed UI parameters --%>
			<c:param name="adWidth" value="${param.adWidth}"/>
			<c:param name="adHeight" value="${param.adHeight}"/>
			<c:param name="widgetCeption" value="true" />
		</c:import>
		<% out.flush(); %>
		
		<c:if test="${ !empty remainedMarketingSpotDatas}">
			<%@ include file="EmarketingSpot_Default.jspf" %>
		</c:if>
	</c:when>
	<c:otherwise>
		<%@ include file="EmarketingSpot_Default.jspf" %>
	</c:otherwise>
</c:choose>
<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
<wcpgl:pageLayoutWidgetCache/>