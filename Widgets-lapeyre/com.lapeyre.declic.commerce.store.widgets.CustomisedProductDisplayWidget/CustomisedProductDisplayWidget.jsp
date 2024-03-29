<%--  The following code is created as an example. Modify the generated code and add any additional required code.  --%>
<%-- BEGIN CustomisedProductDisplayWidget.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<fmt:setBundle basename="/Widgets-lapeyre/Properties/mywidgettext" var="mywidgettext" />
<c:set var="widgetPreviewText" value="${mywidgettext}"/>
<c:set var="emptyWidget" value="false"/>
	
<%@include file="CustomisedProductDisplayWidget_Data.jspf"%>


<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<%--Laisser l'import du JS ici, car on en a besoin juste apr�s --%>
<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/Common/ECOCatalogEntry/javascript/ProductDisplay.js?${versionNumber}"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		if(typeof productDisplayJS != 'undefined'){
			productDisplayJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','${env_CurrencySymbolToFormat}');
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateNoticeMontage);	
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateRibonAds);
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateBandeau);
		}
	});
</script>
		
		<%--ECOCEA perf: on �vite de faire un appel ajax, on r�cup�re directement le JSON de l'item par d�faut 
		LA JSP cr�e la div defaultItemDetailJSON_catentryID avec le JSON de l'item � l'int�rieur
		--%>
		<c:set var="defaultProductSkuID" value="${defaultSku.uniqueID}" />
		<c:set var="defaultSKUFullAttributes" value="${defaultSku.attributes}" />
		<%@ include file="/LapeyreSAS/Widgets/Shared/GetCatalogEntryDetailsByIDInJSONTag.jsp" %>

<%@ include file="CustomisedProductDisplayWidget_UI.jspf"%>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<%-- END CustomisedProductDisplayWidget.jsp --%>
