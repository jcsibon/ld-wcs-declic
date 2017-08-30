<!-- Begin  teaserView_grid_UI.jsp-->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>
<div class="linkToArticle centeredText"><%-- centered ? --%>
	<div class="coin<ecocea:typeArticleIcon types="${editoElement.type}"/>"><div>${editoElement.tempsLecture}</div></div>
	<a href="${editoElement.url}">
		<div class="backgroundContainer"><img alt="${editoElement.visuel.alt}" src="${editoElement.visuel.url}"></div>
		<div class="title">${editoElement.libelleType}<span>${editoElement.titre}</span></div>
		<%-- <div class="linkArrow"></div> --%>
	</a>
</div>
<!-- End  teaserView_grid_UI.jsp-->