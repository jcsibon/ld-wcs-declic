<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/RNVPErrorMessageSetup.jspf"%>

<fmt:setBundle basename="/${sdb.jspStoreDir}/storelist" var="storeListe" scope="request"/>


{	
	
	<c:choose>
		<c:when test="${(!empty errorMessage || !empty rnvpErrorCode || rnvpIsBreak eq 'true')}">
			"status" : "error",
			"errorCode" : "${storeError.key}",
			<c:if test="${storeError.key eq '_ERR_DIDNT_LOGON.2500' || storeError.key eq '_ERR_INVALID_COOKIE'}">
				"sessionExpiredError":true,
			</c:if>
		</c:when>
		<c:otherwise>
			"status" : "success",
			"addressId": "${addressId[0]}",
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${(!empty errorMessage && empty rnvpErrorCode && rnvpIsBreak eq 'false')}">
			"errorMessage" : "<c:out value="${errorMessage}"/>",
		</c:when>
		<c:otherwise>
			"errorMessage" : "",
		</c:otherwise>
	</c:choose>
	<c:if test="${rnvpIsBreak eq 'true'}" >
			"choices" : <c:out value='${rnvpChoices}' escapeXml="false" />,
	</c:if>
	"rnvpErrorCode" : "${!empty rnvpErrorCode? rnvpErrorCode :'' }",
	"rnvpIsBreak" : <c:out value="${rnvpIsBreak}"/>,
	"rnvpIsCitySelection" : ${!empty rnvpIsCitySelection ? rnvpIsCitySelection : false},
	"rnvpIsStreetSelection" : ${!empty rnvpIsStreetSelection ? rnvpIsStreetSelection : false}
}
