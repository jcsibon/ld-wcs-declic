
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"  %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>

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

<%
	String codeTypePro = ConfigTool.CODE_NATURE_CLIENT_CRM_PRO;
	request.setAttribute("codeTypePro",codeTypePro);
%>

<!-- BEGIN AccountRegistrationNotify.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>
			<fmt:message bundle="${storeText}" key="emailCompteSubject" />
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
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findByLogonID">
	       <wcf:param name="accessProfile" value="IBM_All" />
	       <wcf:param name="logonID" value="${WCParam.logonId}" />
	</wcf:getData>

	<c:set var="userFields" value="${person.personalProfile}"/>

	<c:set var="firstName" value="${person.contactInfo.contactName.firstName}"/>
	
	<c:set var="lastName" value="${person.contactInfo.contactName.lastName}"/>
	
	<c:set var="personTitle" value="${person.contactInfo.contactName.personTitle}"/>
	
	<c:set var="email1" value="${person.contactInfo.emailAddress1.value}"/>

	
	<c:set var="mobilePhone1" value="${person.contactInfo.mobilePhone1.value}"/>
	
	<c:set var="telephone1" value="${person.contactInfo.telephone1.value}"/>
	
	<c:set var="telephone2" value="${person.contactInfo.telephone2.value}"/>
	
	<c:choose >
	<c:when test="${!empty mobilePhone1 }">
		<c:set var="telephone" value="${mobilePhone1}"/>
	</c:when>
	<c:when test="${!empty telephone1 }">
		<c:set var="telephone" value="${telephone1}"/>
	</c:when>
	<c:otherwise>
			<c:set var="telephone" value="${telephone2}"/>
	</c:otherwise>
	</c:choose>
	
	<c:set var="address1" value="${person.contactInfo.address.addressLine[0]}"/>
	
	<c:set var="address2" value="${person.contactInfo.address.addressLine[1]}"/>
	
	<c:set var="address3" value="${person.contactInfo.address.addressLine[2]}"/>
	
	<c:set var="city" value="${person.contactInfo.address.city}"/>
	
	<c:set var="country" value="${person.contactInfo.address.country}"/>
	
	<c:set var="zipCode" value="${person.contactInfo.address.postalCode}"/>
	
	
	<c:set var="organizationName" value="${person.contactInfo.organizationName}"/>
	
	<c:set var="demographicField5" value="${userFields.attributes['demographicField5']}"/>

	<c:set var="codeEffectif" value="${userFields.attributes['userProfileField1']}"/>
	
	<c:set var="demographicField7" value="${userFields.attributes['demographicField7']}"/>
	
	<c:set var="demographicField6" value="${userFields.attributes['demographicField6']}"/>
	
	<c:set var="taxPayerId" value="${userFields.attributes['taxPayerId']}"/>
	      
	<c:set var="isPro" value="false" />   
	<c:if test="${(!empty person.attributes['userField3']) && (person.attributes['userField3'] eq codeTypePro)}">
		<c:set var="isPro" value="true" />
	</c:if>

	<c:set var="isCompteLight" value="${person.contactInfo.address.addressLine[0]=='defaultStreet'}" />
	
	<body style="margin:0px; padding:0px; -webkit-text-size-adjust:none;">
		<table width="100%" style="max-width:680px !important" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
			<!-- Include email header -->
			<c:set var="imageHeaderFile" value="${fullJspStoreImgDir}images/bandeau_image_creation_compte.jpg" />
			<fmt:message var="headerTitle" bundle="${storeText}" key="emailCompteName" />
			
			<%@ include file="../Common/Header.jsp"%>
		
			<!-- separateur horizontal -->
			<tr>
				<td height="30" width="100%" style="max-width:680px !important" ></td>
			</tr>
		
			<!-- contenu texte -->
			<tr>
				<td width="100%" style="max-width:680px !important" >
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width:680px !important" >
						<tbody>
							<tr>
								<td width="7%"></td>
								<td width="86%">
									<table width="100%" style="max-width:680px !important" align="center" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="100%" align="center">
												<font face="arial" color="#666666" style="font-size: 22px;"><fmt:message bundle="${storeText}" key="emailCompteBodyNormal" /></font>
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
													<fmt:message bundle="${storeText}" key="emailCompteBodyRedBold">
														<fmt:param value="${hostPath}${env_TopCategoriesDisplayURL}" />
													</fmt:message>
												</font>
											</td> 
										</tr>
									</table>
								</td>
								<td width="7%"></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		
			<!-- separateur horizontal -->
			<tr>
				<td height="30" width="100%" style="max-width:680px !important" ></td>
			</tr>
		
			<!-- contenu formulaire -->
			<tr>
				<td width="100%" style="max-width:680px !important" >
					<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#efefef">
						<tbody><tr>
							<td width="7%"></td>
							<td width="86%">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<!-- separateur horizontal -->
									<tr>
										<td height="15" width="100%" colspan="2"></td>
									</tr>
									
									<c:choose>
										<c:when test="${isPro}">
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressLegalEntityFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;"><fmt:message bundle="${storeListe}" key="Civilite_${personTitle}" /></font>
												</td> 
											</tr>
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="raisonSocialeFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;">${organizationName}</font>
												</td>
											</tr> 
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="siretFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;">${demographicField5}</font>
												</td>
											</tr>
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="apeFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;">${demographicField7}</font>
												</td>
											</tr>
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="activitePrincipaleFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;"><fmt:message bundle="${storeListe}" key="Activite_${demographicField7}" /></font>
												</td>
											</tr>
										</c:when>
										
										<c:otherwise>
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressCiviliteFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;"><fmt:message bundle="${storeListe}" key="Civilite_${personTitle}" /></font>
												</td> 
											</tr>
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressFirstnameFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;">${firstName}</font>
												</td> 
											</tr>
											<tr>
												<td width="25%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressLastnameFieldLabel" /></font>
												</td>
												<td width="75%" height="35" align="left" valign="middle">
													<font face="arial" color="#666666" style="font-size: 13px;">${lastName}</font>
												</td> 
											</tr>
										</c:otherwise>
									
									</c:choose>
									
									<tr>
										<td width="25%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="loginFieldlabel" /></font>
										</td>
										<td width="75%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;">${email1}</font>
										</td> 
									</tr>
								<c:if test="${!isCompteLight}">
									<tr>
										<td width="25%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressStreetFieldLabel" /></font>
										</td>
										<td width="75%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;">${address1}</font>
										</td> 
									</tr>
									<c:if test="${not empty address2}">
										<tr>
											<td width="25%" height="35" align="left" valign="middle">
												<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressBatimentFieldLabel" /></font>
											</td>
											<td width="75%" height="35" align="left" valign="middle">
												<font face="arial" color="#666666" style="font-size: 13px;">${address2}</font>
											</td> 
										</tr>
									</c:if>
									<c:if test="${not empty address3}">
										<tr>
											<td width="25%" height="35" align="left" valign="middle">
												<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressEtageFieldLabel" /></font>
											</td>
											<td width="75%" height="35" align="left" valign="middle">
												<font face="arial" color="#666666" style="font-size: 13px;"><fmt:message bundle="${storeListe}" key="Etage_${address3}" /></font>
											</td> 
										</tr>
									</c:if>
								</c:if>
									<tr>
										<td width="25%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressZipcodeFieldLabel" /></font>
										</td>
										<td width="75%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;">${zipCode}</font>
										</td> 
									</tr>
								<c:if test="${!isCompteLight}">
									<tr>
										<td width="25%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressCityFieldLabel" /> </font>
										</td>
										<td width="75%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;">${city}</font>
										</td> 
									</tr>
									<tr>
										<td width="25%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressCountryFieldLabel" /></font>
										</td>
										<wcbase:useBean id="countryBeanList" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
											<c:set target="${countryBeanList}" property="countryCode" value="${country}" />
										</wcbase:useBean>
										<c:forEach var="countryItem" items="${countryBeanList.countries}">
											<c:if test="${countryItem.code eq country}">
												<c:set var="selectedCountryDisplayName" value="${countryItem.displayName}"/>
											</c:if>
										</c:forEach>
										<td width="75%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;">${selectedCountryDisplayName}</font>
										</td> 
									</tr>
								</c:if>
								<c:if test="${!empty telephone}">
									<tr>
										<td width="25%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;font-weight:bold;"><fmt:message bundle="${storeText}" key="addressPhoneNumberFieldLabel" />  </font>
										</td>
										<td width="75%" height="35" align="left" valign="middle">
											<font face="arial" color="#666666" style="font-size: 13px;">${telephone}</font>
										</td> 
									</tr>
								</c:if>
									<!-- separateur horizontal -->
									<tr>
										<td height="15" width="100%" colspan="2"></td>
									</tr>
								</table>
							</td>
							<td width="7%"></td>
						</tr>			
					</tbody></table>
				</td>
			</tr>
		
			<!-- separateur horizontal -->
			<tr>
				<td height="20" width="100%" style="max-width:680px !important" ></td>
			</tr>
		
			<!-- contenu texte -->
			<tr>
				<td width="100%" style="max-width:680px !important" >
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td width="7%"></td>
							<td width="86%">
								<table width="100%"  border="0" cellpadding="0" cellspacing="0">
									<tbody><tr>
										<td width="100%" align="left">
											<font face="arial" color="#666666" style="font-size: 13px;">
												<fmt:message bundle="${storeText}" key="emailCompteBodyABientot" >
													<fmt:param value="${hostPath}${env_TopCategoriesDisplayURL}" />
												</fmt:message>
											</font>
										</td> 
									</tr>
								</tbody></table>
							</td>
							<td width="7%"></td>
						</tr>
					</tbody></table>
				</td>
			</tr>
		
			<!-- separateur horizontal -->
			<tr>
				<td height="30" width="100%" style="max-width:680px !important" ></td>
			</tr>
			<%@ include file="../Common/FooterLAP.jsp"%>
		</table>
	</body>
</html>
