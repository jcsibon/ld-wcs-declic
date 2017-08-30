<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN CollectionProductDisplayWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>
	
<%@include file="CollectionProductDisplayWidget_Data.jspf"%>

<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ECOCatalogEntry/javascript/ProductDisplay.js?${versionNumber}"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		if(typeof productDisplayJS != 'undefined'){
			productDisplayJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','${env_CurrencySymbolToFormat}');
			<c:if test="${env_displayListPriceInProductPage == 'true'}">
				dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.displayPrice);		
			</c:if>
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateProductName);	
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateProductPartNumber);
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

<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<%@ include file="CollectionProductDisplayWidget_UI.jspf"%>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>


<%-- END CollectionProductDisplayWidget.jsp --%>
