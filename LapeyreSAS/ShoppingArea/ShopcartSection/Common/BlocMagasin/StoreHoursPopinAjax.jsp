<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN StoreHoursPopinAjax.jsp -->
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../../include/ErrorMessageSetup.jspf" %>
<wcbase:useBean id="errorBean" classname="com.ibm.commerce.beans.ErrorDataBean"/>
<c:choose>
	<c:when test="${!empty errorBean.messageKey }">
		<%@ include file="../../../../GenericError_UI.jspf" %>		
	</c:when>
	<c:otherwise>
		<c:set var="mag" value="${content}" />
		<c:set var="seo" value="${mag.seo}" />
		<%@ include file="/LapeyreSAS/StoreInfoArea/StoreHours.jsp" %>
	</c:otherwise>
</c:choose>		
<!-- END StoreHoursPopinAjax.jsp -->
