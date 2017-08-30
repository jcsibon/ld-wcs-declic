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
<!-- BEGIN MerchandisingAssociations.jsp -->

<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<%@ include file="../Common/QuickInfo/QuickInfoPopup.jspf" %>

<%@ include file="ext/MerchandisingAssociations_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="MerchandisingAssociations_Data.jspf" %>
</c:if>

<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>
</c:if>

<%@ include file="ext/MerchandisingAssociations_UI.jspf" %>
<c:if test = "${param.custom_view ne 'true'}">
	<c:choose>
	<c:when test="${param.fromPage eq 'product'}">
		<%@ include file="MerchandisingAssociations_UI_Product.jspf" %>
	</c:when>
	<c:otherwise>
		<%@ include file="MerchandisingAssociations_UI.jspf" %>
	</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${empty param.widgetCeption || param.widgetCeption eq 'false'}" >
	<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
</c:if>
<jsp:useBean id="MerchandisingAssociations_TimeStamp" class="java.util.Date" scope="request"/>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		if(typeof productDisplayJS != 'undefined'){
			productDisplayJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','${env_CurrencySymbolToFormat}');
			<c:if test="${hasAssociations}">
				dojo.topic.subscribe("ShopperActions_Changed", MerchandisingAssociationJS.setBaseItemQuantity);
				dojo.topic.subscribe("DefiningAttributes_Resolved", MerchandisingAssociationJS.setBaseItemAttributesFromProduct);
			</c:if>			
		}		
	});
</script>
<wcpgl:pageLayoutWidgetCache/>
<!-- END MerchandisingAssociations.jsp -->