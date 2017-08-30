<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="/LapeyreSAS/Common/EnvironmentSetup.jspf"%>
<%@ include file="/LapeyreSAS/Common/nocache.jspf"%>
<%@ include file="/LapeyreSAS/include/ErrorMessageSetup.jspf"%>

{	
	<c:choose>
		<c:when test="${!empty errorMessage}">
			"status" : "error",
			"errorMessage":"${ecocea:escapeJS(errorMessage)}"
		</c:when>
		<c:otherwise>
			"status" : "success",
			<c:choose>
				<c:when test="${!empty mailSent && mailSent eq true}">
					"mailSent" : true
				</c:when>
				<c:otherwise>
					"mailSent" : false
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
}
