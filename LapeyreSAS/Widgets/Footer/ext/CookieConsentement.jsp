<%@ include file= "../../../Common/EnvironmentSetup.jspf" %>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<c:if test="${cookie['cookieConsentement'] == null}">
	<%
		String consentementLink = ConfigTool.getConnectionPropertiesResource().getProperty("cgu.cookie.consentement.url");
		request.setAttribute("consentementLink", consentementLink);
	%>
	<fmt:message var="linkLabel" key="consentementCookieLinkLabel" bundle="${storeText}" />
	<fmt:message var="consentementCookieLabel" key="consentementCookieLabel" bundle="${storeText}" />
	<c:import url="/Widgets-lapeyre/Common/Cookie/CookieConsentement.jsp">
		<c:param name="consentementCookieLabel" value="${consentementCookieLabel}" />
		<c:param name="consentementCookieLinkLabel" value="${linkLabel}" />
		<c:param name="consentementCookieLink" value="${consentementLink}" />
	</c:import>
</c:if>