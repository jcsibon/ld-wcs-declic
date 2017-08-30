<%@page contentType="text/html" pageEncoding="UTF-8"  %>
<%@ include file="../../Common/EnvironmentSetup.jspf" %>
 <%@ include file="../../Common/nocache.jspf"%>

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

<!-- BEGIN AccountUpdateNotify.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml">
	
	<head>
		<title>
			<fmt:message bundle="${storeText}" key="emailAccountUpdateSubject" />
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
			<fmt:message var="headerTitle" bundle="${storeText}" key="emailAccountUpdateName" />
			
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
								<fmt:message bundle="${storeListe}" key="Civilite_Abreviation_${WCParam.personTitle}" var="civ" /><c:if test="${not fn:startsWith(civ,'???')}">${civ}</c:if>
								${WCParam.firstName} ${fn:toUpperCase(WCParam.lastName)}
							</td>
							<td width="7%"></td>
						</tr>
						<tr>
							<td width="7%"></td>
							<td width="86%" align="left">
								<fmt:message bundle="${storeText}" key="emailAccountUpdateBody" >
									<fmt:param value="${hostPath}${env_TopCategoriesDisplayURL}"/>
								</fmt:message>
							</td>
							<td width="7%"></td>
						</tr>
						<tr>
							<td width="7%"></td>
							<td width="86%" align="center">
								<a href="${hostPath}/contact?formName=contactServiceClient" style="border-radius: 3px;box-shadow: 1px 2px 3px rgba(0, 0, 0, 0.2);display: inline-block;font-family:Roboto Condensed,sans-serif;font-size: 13px;margin: 8px 0;padding: 12px 15px;text-align: center;width: auto;font-weight:bold;text-decoration:none;background: #57b554;color: #fff;background: #59b956;">
									<fmt:message bundle="${storeText}" key="emailAccountUpdateContactButton" />
									<%-- background: -moz-linear-gradient(top, #59b956 0%, #56b253 100%);background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #59b956),color-stop(100%, #56b253) );background: -webkit-linear-gradient(top, #59b956 0%, #56b253 100%);background: -o-linear-gradient(top, #59b956 0%, #56b253 100%);background: -ms-linear-gradient(top, #59b956 0%, #56b253 100%);background: linear-gradient(to bottom, #59b956 0%, #56b253 100%);filter: progid : DXImageTransform.Microsoft.gradient ( startColorstr = '#59b956', endColorstr = '#56b253', GradientType = 0 );  --%>
								</a>
							</td>
							<td width="7%"></td>
						</tr>
						<tr>
							<td width="7%"></td>
							<td width="86%" align="left">
								<fmt:message bundle="${storeText}" key="emailAccountUpdateBodySign" />
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