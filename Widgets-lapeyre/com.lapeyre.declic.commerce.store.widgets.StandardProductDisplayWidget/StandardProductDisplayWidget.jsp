<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<!-- BEGIN StandardProductDisplayWidget.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>

	
<%@include file="StandardProductDisplayWidget_Data.jspf"%>

<c:if test="${param.displayType eq '_popup'}">
	<%@ include file="../../LapeyreSAS/Common/JSTLEnvironmentSetupExtForSocialNetworks.jsp" %>
</c:if>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ECOCatalogEntry/javascript/ProductDisplay.js?${versionNumber}"></script>
<wcf:url var="ShopperActionURL" value="ShopperActionView" type="Ajax" />

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		if(typeof productDisplayJS != 'undefined'){
			wc.render.getRefreshControllerById('shopperActionsRefreshAreaController').url = '${ShopperActionURL}';
			productDisplayJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','${env_CurrencySymbolToFormat}');
			<c:if test="${env_displayListPriceInProductPage == 'true'}">
				dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.displayPrice);		
			</c:if>
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateAtoutPrix);	
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateProductName);	
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateSurface);	
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateProductPartNumber);			
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.refreshShopperAction);
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateProductDetailedDescription);
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateRibonAds);
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateBandeau);
			

		}
	});
</script>

		<%--ECOCEA perf: on évite de faire un appel ajax, on récupère directement le JSON de l'item par défaut 
		LA JSP crée la div defaultItemDetailJSON_catentryID avec le JSON de l'item à l'intérieur
		--%>
		<c:set var="defaultProductSkuID" value="${defaultSku.uniqueID}" />
		<c:set var="defaultSKUFullAttributes" value="${defaultSku.attributes}" />
		<%@ include file="/LapeyreSAS/Widgets/Shared/GetCatalogEntryDetailsByIDInJSONTag.jsp" %>


<%@ include file="StandardProductDisplayWidget_UI.jspf"%>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
<!-- END StandardProductDisplayWidget.jsp -->
