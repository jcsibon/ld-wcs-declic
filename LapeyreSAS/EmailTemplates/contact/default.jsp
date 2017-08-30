<%@page contentType="text/html" pageEncoding="UTF-8"  %>
<!doctype HTML>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<%
	String host_Path = ConfigTool.getConfigurationPropertiesResource().getProperty("hostpath.no.ending.slash.url");
	request.setAttribute("host_Path",host_Path);

 %>
<c:set value="${host_Path}" var="hostPath" />
<c:set value="${jspStoreImgDir}" var="fullJspStoreImgDir" />
<c:if test="${!(fn:contains(fullJspStoreImgDir, '://'))}">
	<c:set value="${hostPath}${jspStoreImgDir}" var="fullJspStoreImgDir" />
</c:if>

<wcbase:useBean id="activeStoreLocationDB" classname="com.lapeyre.declic.commerce.storelocator.beans.FullActiveStoreLocationDataBean">
	<c:set value="${storeId}" target="${activeStoreLocationDB}" property="storeId" />
	<c:set value="${langId}" target="${activeStoreLocationDB}" property="languageId" />
</wcbase:useBean>

<c:set var="fullActiveStores" value="${activeStoreLocationDB.fullActiveStores}" />

<!-- BEGIN EmailTemplates/contact/default.jsp -->
<html xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#" xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">

	<head>
		<title>
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
			<c:set var="headerTitle" value="${WCParam.headerTitle}" />
			
			<%@ include file="../Common/Header.jsp"%>
		
			<!-- separateur horizontal -->
			<tr>
				<td height="30" width="100%" style="max-width:680px !important"></td> 
			</tr>
			<tr>
				<td width="100%" style="max-width:680px !important">
				
					<table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width:680px !important" align="center">
						<tr>
							<td width="7%"></td>
							<td width="86%" align="left">
								<table>
									<c:forEach var="formItem" items="${WCParam.emailDatas}">
										<tr valign="top">
										<c:if test="${empty WCParam.hideLabel || WCParam.hideLabel != 'true'}">
											<td style="padding: 8px; white-space: nowrap; font-weight: bold">
												<c:choose>
													<c:when test="${WCParam.dontUseBundle}">
														<c:out value="${formItem.key}"/>
													</c:when>
													<c:otherwise>
														<fmt:message bundle="${widgetText}" key="${formItem.key}" />
													</c:otherwise>
												</c:choose>
											</td>
										</c:if>
											<c:choose>
												<c:when test="${fn:startsWith(formItem.key, 'CONTACT_STOREENTITY')}">
													<c:forEach var="shop" items="${fullActiveStores}" >
														<c:if test="${shop.identifier eq formItem.value}">
															<td style="padding:8px;">${shop.name}</td>
														</tr><tr valign="top">
															<c:if test="${empty WCParam.hideLabel || WCParam.hideLabel != 'true'}">
																<td style="padding: 8px; white-space: nowrap; font-weight: bold"><fmt:message bundle="${widgetText}" key="CONTACT_STOREID" /></td>
															</c:if>
															<td style="padding:8px;">${formItem.value}</td>
														</c:if>
													</c:forEach>												
												</c:when>
												<c:otherwise>
													<td style="padding: 8px;">${formItem.value}</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
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
			<%@ include file="../Common/FooterLAP.jsp"%>
		</table>
	</body>

</html>