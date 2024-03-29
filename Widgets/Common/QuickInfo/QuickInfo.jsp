<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN QuickInfo.jsp -->
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>
	
<%@ include file="ext/QuickInfo_Data.jspf" %>
<c:if test = "${param.custom_data ne 'true'}">
	<%@ include file="QuickInfo_Data.jspf" %>
</c:if>

<%@ include file="ext/QuickInfo_UI.jspf" %>
<c:if test = "${param.custom_view ne 'true'}">
	<%@ include file="QuickInfo_UI.jspf" %>
</c:if>
<jsp:useBean id="QuickInfo_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END QuickInfo.jsp -->