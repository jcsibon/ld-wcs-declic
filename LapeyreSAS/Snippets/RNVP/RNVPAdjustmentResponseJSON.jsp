<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>


{
"status" : "<c:out value="${mapResult['status']}" />",
<c:choose>
	<c:when test="${mapResult['status'] eq 'MANY'}">
		"isPartOfStreetSel": ${mapResult['isPartOfStreetSel']},
		"isStreetSel": ${mapResult['isStreetSel']},
		"isCitySel": ${mapResult['isCitySel']},
		"choices" : 
			[
				<c:forEach items="${mapResult['choiceBeans']}" var="choiceBean" varStatus="status">
					{
						"numFrom": "${choiceBean.numFrom}",
						"numTo": "${choiceBean.numTo}",
						"street": "${choiceBean.street}",
						"city": "${choiceBean.city}",
						"zip": "${choiceBean.zip}"
					}
					<c:if test="${!status.last}">
						,
					</c:if>
				</c:forEach>
			]
	</c:when>
	<c:when test="${mapResult['status'] eq 'OK' || mapResult['status'] eq 'WARN'}">
		<c:if test="${mapResult['status'] eq 'WARN'}" >
			"warnCode" : "${mapResult['warnCode']}",
			"warnMsg" : "${mapResult['warnMsg']}",
		</c:if>
		<c:set var="result" value="${mapResult['result']}" />
		"result": {
			"line1": "${result.line1}",
			"line2": "${result.line2}",
			"line3": "${result.line3}",
			"line4": "${result.line4}",
			"nomVoie": "${result.nomVoie}",
			"numVoie": "${result.numVoie}",
			"zip": "${result.zip}",
			"city": "${result.city}",
			"cedex": "${result.cedex}",
			"distributingCity": "${result.distributingCity}"
		}
	</c:when>
	<c:when test="${mapResult['status'] eq 'ERR'}">
		"errCode" : "${mapResult['errCode']}",
		"errMsg" : "${mapResult['errMsg']}"
	</c:when>
</c:choose>
}