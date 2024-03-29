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

<!-- BEGIN LongDescription.jsp -->

<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<%@ include file="ext/LongDescription_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="LongDescription_Data.jspf" %>
</c:if>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>

<%@ include file="ext/LongDescription_UI.jspf" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="LongDescription_UI.jspf" %>
</c:if>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>
<jsp:useBean id="LongDescription_TimeStamp" class="java.util.Date" scope="request"/>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		if(typeof productDisplayJS != 'undefined'){
			productDisplayJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}" />','<c:out value="${catalogId}" />','<c:out value="${userType}" />','<c:out value="${env_CurrencySymbolToFormat}" />');
			dojo.topic.subscribe('DefiningAttributes_Resolved', productDisplayJS.updateProductLongDescription);		
		}		
	});
</script>
<wcpgl:pageLayoutWidgetCache/>
<!-- END LongDescription.jsp -->