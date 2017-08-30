<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN FullImage.jsp -->

<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<%@ include file="ext/FullImage_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="FullImage_Data.jspf" %>
</c:if>

<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>
</c:if>

<%@ include file="ext/FullImage_UI.jspf" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="FullImage_UI.jspf" %>
</c:if>
<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
</c:if>
<jsp:useBean id="FullImage_TimeStamp" class="java.util.Date" scope="request"/>

<a href='javascript:productDisplayJS.setCommonParameters("<c:out value='${langId}'/>","<c:out value='${storeId}' />","<c:out value='${catalogId}' />","<c:out value='${userType}' />","${env_CurrencySymbolToFormat}");dojo.topic.subscribe("DefiningAttributes_Resolved", productDisplayJS.updateProductImage);dojo.topic.subscribe("DefiningAttributes_Changed", productDisplayJS.updateProductImage);' id="ECO_QuickInfo_perform_fullImage_${catalogEntryID}" style="display:none;"></a>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		if(typeof productDisplayJS != 'undefined'){
			productDisplayJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','${env_CurrencySymbolToFormat}');
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateProductImage);
			dojo.topic.subscribe('DefiningAttributes_Changed', productDisplayJS.updateProductImage);
			dojo.topic.subscribe('DefiningAttributes_Changed', productDisplayJS.updateRibonAds);
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateRibonAds);
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateBandeau);
		}	
	});
</script>
<wcpgl:pageLayoutWidgetCache/>
<!-- END FullImage.jsp -->