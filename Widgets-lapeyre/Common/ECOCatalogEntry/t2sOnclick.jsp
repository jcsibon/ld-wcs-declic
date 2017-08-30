<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${isTarget2SellReco}">
	onclick="T2S.event('click', {sp:'${t2sSpaceId}', pID:'${t2sPId}', iID: '${param.partNumber}', po: '${t2sPosition}', ru: '${t2salgorithmMap[param.catEntryIdentifier]}', redir :'${param.redir}'});return false;"
</c:if>