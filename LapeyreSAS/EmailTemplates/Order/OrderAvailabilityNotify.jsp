<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!doctype HTML>

<%-- 
  *****
  * When order is submitted by the user, this email will be sent.
  * This email JSP page informs the customer that the order is cancel. 
  *****
--%>

<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../Common/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../Common/nocache.jspf"%>

<fmt:setBundle basename="/${sdb.jspStoreDir}/storelist" var="storeListe" scope="request"/>

<%
	String host_Path = ConfigTool.getConfigurationPropertiesResource().getProperty("hostpath.no.ending.slash.url");
	request.setAttribute("host_Path",host_Path);
 %>
<c:set value="${host_Path}" var="hostPath" />

<c:set value="${jspStoreImgDir}" var="fullJspStoreImgDir" />
<c:if test="${!(fn:contains(fullJspStoreImgDir, '://'))}">
	<c:set value="${hostPath}${jspStoreImgDir}" var="fullJspStoreImgDir" />
</c:if>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findByOrderId" scope="request">
	<wcf:param name="accessProfile" value="IBM_All" />
	<wcf:param name="orderId" value="${WCParam.orderId}" />
</wcf:getData>

<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findByUniqueID">
	<wcf:param name="accessProfile" value="IBM_Details" />
	<wcf:param name="personId" value="${order.buyerIdentifier.uniqueID}" />
</wcf:getData>

<c:set var="firstName" value="${person.contactInfo.contactName.firstName}"/>
	
<c:set var="lastName" value="${person.contactInfo.contactName.lastName}"/>

<c:set var="personTitle" value="${person.contactInfo.contactName.personTitle}"/>


<c:set var="isPro" value="false" />   
<c:if test="${(!empty person.attributes['userField3']) && (person.attributes['userField3'] eq codeTypePro)}">
	<c:set var="isPro" value="true" />
</c:if>

<c:if test="${!empty order.userData.userDataField['field1']}">
	<wcbase:useBean id="shopBean" classname="com.lapeyre.declic.commerce.storelocator.beans.FullShopDataBean">
		<c:set target="${shopBean}" property="languageId" value="${CommandContext.languageId}" />
		<c:set target="${shopBean}" property="identifier" value="${order.userData.userDataField['field1']}" />
	</wcbase:useBean>
</c:if>
<!-- BEGIN OrderCreateNotify.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>
			<fmt:message bundle="${storeText}" key="emailAvailableOrderSubject" />
		</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<style type="text/css">
		    /* Fonts and Content */
		    body, td { font-family: 'Roboto', Arial, Helvetica, Geneva, sans-serif; font-size:14px; }
		    body { margin: 0; padding: 0; -webkit-text-size-adjust:none; -ms-text-size-adjust:none; }
		    h2{ padding-top:12px; /* ne fonctionnera pas sous Outlook 2007+ */color:#0E7693; font-size:22px; }
	    </style>
	</head>
	<body style="margin:0px; padding:0px; -webkit-text-size-adjust:none;">
		<table width="100%" style="max-width:680px !important" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
	        <!-- Include email header -->
			<c:set var="imageHeaderFile" value="${fullJspStoreImgDir}images/bandeau_image_commande_dispo.jpg" />
			<fmt:message var="headerTitle" bundle="${storeText}" key="emailAvailableOrderName" >
				<fmt:param value="${WCParam.orderId}" />
			</fmt:message>
			
			<%@ include file="../Common/Header.jsp"%>
	
	        <!-- separateur horizontal -->
	        <tr>
	            <td height="30" width="100%" style="max-width:680px !important"></td>
	        </tr>
	
	        <!-- contenu texte -->
	        <tr>
				<td width="100%" style="max-width:680px !important">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="7%"></td>
							<td width="86%">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width="100%" align="center">
											<font face="arial" color="#666666" style="font-size: 22px;">
												<fmt:message bundle="${storeText}" key="emailAvailableOrderBodyBonjourNom" >
													<fmt:param><fmt:message bundle="${storeListe}" key="Civilite_${personTitle}" /></fmt:param>
													<fmt:param value="${lastName}" />
												</fmt:message>
											</font>
										</td> 
									</tr>
									<tr>
										<td width="100%" align="center">
											<img style="text-decoration: none; display: block; color:#cb0119; font-size:20px;" src="${fullJspStoreImgDir}images/separator_email.png" alt=".............." height="25" width="226">
										</td> 
									</tr>
									<tr>
										<td width="100%" align="left">
											<font face="arial" color="#666666" style="font-size: 13px;">
												<p>
													<fmt:message bundle="${storeText}" key="emailAvailableOrderBodyFirstPart" >
														<fmt:param value="${WCParam.orderId}" />
														<fmt:param value="${shopBean.name}" />
													</fmt:message>
												</p>
												<p>
													<fmt:message bundle="${storeText}" key="emailAvailableOrderBodySecondPart" />
												</p>
												<p>
													<fmt:message bundle="${storeText}" key="emailAvailableOrderBodyThirdPart" >
														<fmt:param value="${shopBean.name}" />
													</fmt:message>
												</p>
											</font>
										</td> 
									</tr>
									<!-- separateur horizontal -->
									<tr>
										<td height="30" width="100%"></td>
									</tr>
									<c:if test="${!empty shopBean }">
										<%@include file="OrderShopDisplay.jsp" %>
									</c:if>
									<!-- separateur horizontal -->
									<tr>
										<td height="5" width="100%"></td>
									</tr>
									<tr>
										<td width="100%" align="left">
											<font face="arial" color="#666666" style="font-size: 13px;">
												<p>
													<fmt:message bundle="${storeText}" key="emailAvailableOrderBodyLastPart" >
														<fmt:param value="${hostPath}${env_TopCategoriesDisplayURL}" />
													</fmt:message>
												</p>
											</font>
										</td> 
									</tr>
								</table>
							</td>
							<td width="7%"></td>
						</tr>
					</table>
				</td>
	        </tr>
	
	        <!-- separateur horizontal -->
	        <tr>
	            <td height="30" width="100%" style="max-width:680px !important"></td>
	        </tr>
	        
	        <%-- Recap Panier --%>
	        <%@include file="OrderItemsInformation.jsp" %>
	
	        <!-- separateur horizontal -->
			<tr>
				<td height="30" width="100%" style="max-width:680px !important"></td>
			</tr>
			<%@ include file="../Common/FooterLAP.jsp"%>
	    </table>
		
	</body>
</html>