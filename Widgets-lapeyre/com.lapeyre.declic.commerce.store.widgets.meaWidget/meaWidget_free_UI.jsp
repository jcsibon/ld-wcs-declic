<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<div class="meaFreeHtml${param.classForMeaBlock}">
	<c:if test="${!empty meas[param.idx].titre}">
		<span class="titleBlock">${meas[param.idx].titre}</span>
	</c:if>
	<div>${isMobile?meas[param.idx].bodyMobile:meas[param.idx].bodyDesktop}</div>
</div>
