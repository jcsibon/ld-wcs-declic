<%@page contentType="text/html" pageEncoding="UTF-8"  %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<%
	String host_Path = ConfigTool.getConfigurationPropertiesResource().getProperty("hostpath.no.ending.slash.url");
	String MyAccount_URL = ConfigTool.getConfigurationPropertiesResource().getProperty("my.account.url");
	request.setAttribute("host_Path",host_Path);
	request.setAttribute("MyAccount_URL",MyAccount_URL);

 %>

<c:set value="${host_Path}" var="hostPath" />
<c:set value="${jspStoreImgDir}" var="fullJspStoreImgDir" />
<c:if test="${!(fn:contains(fullJspStoreImgDir, '://'))}">
	<c:set value="${hostPath}${jspStoreImgDir}" var="fullJspStoreImgDir" />
</c:if>

<c:set value="${MyAccount_URL}" var="MyAccountURL" />

<!-- BEGIN PasswordResetNotify.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml">
	
	<head>
		<title>
			<fmt:message bundle="${storeText}" key="emailMdpSubject" />
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
		<table width="100%" style="max-width:680px !important"  border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
			<!-- Include email header -->
			<c:set var="imageHeaderFile" value="" />
			<fmt:message var="headerTitle" bundle="${storeText}" key="emailMdpName" />
			
			<%@ include file="../Common/Header.jsp"%>
		
			<!-- separateur horizontal -->
			<tr>
				<td height="30" width="100%" style="max-width:680px !important" ></td> 
			</tr>
			<tr>
				<td width="100%" style="max-width:680px !important" >
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="7%"></td>
							<td width="86%" align="left">
								<fmt:message bundle="${storeText}" key="emailMdpBody" >
									<fmt:param value="${MyAccountURL}" />
									<fmt:param value="${hostPath}${env_TopCategoriesDisplayURL}"/>
									<fmt:param value="${logonPassword}"/>
								</fmt:message>
							</td>
							<td width="7%"></td>
						</tr>
					</table>
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