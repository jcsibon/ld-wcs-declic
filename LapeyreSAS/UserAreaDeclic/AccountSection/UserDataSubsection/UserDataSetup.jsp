<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>

<fmt:setBundle basename="/${sdb.jspStoreDir}/storelist" var="storeListe" scope="request"/>

<c:choose>
		<c:when test="${userType eq 'G'}">
			<c:set var="incfile" value="${env_jspStoreDir}/UserAreaDeclic/AccountSection/LogonSubsection/LogonDisplay.jsp"/>
		</c:when>
		<c:otherwise>
			<c:set var="incfile" value="${env_jspStoreDir}/UserAreaDeclic/AccountSection/UserDataSubsection/UserDataForm.jsp"/>
		</c:otherwise>
	</c:choose>
	
	<%out.flush();%>
	<c:import url="${incfile}"/>
	<%out.flush();%>