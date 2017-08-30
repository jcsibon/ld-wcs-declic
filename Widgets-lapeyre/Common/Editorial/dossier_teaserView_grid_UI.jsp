<!-- Begin  dossier_teaserView_grid_UI.jsp-->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>
<div class="linkToArticle centeredText" itemscope itemtype="${MICRO_DATA_ARTICLE}" >
	<c:if test="${!empty editoElement.tempsLecture}"><div class="coin<ecocea:typeArticleIcon types="${editoElement.type}"/>"><div><span>${editoElement.tempsLecture}</span></div></div></c:if>
	<a class="hover_underline" href="${editoElement.url}">
		<div class="backgroundContainer" >
			<img  itemprop="image" onerror="this.src='/wcsstore/LapeyreSAS/images/desktopList/defaultImage.png'" alt="${editoElement.visuelvisuelMEA.alt!=null?editoElement.visuelMEA.alt:(editoElement.visuelMea.alt!=null?editoElement.visuelMea.alt:(editoElement.visuelMobile!=null?editoElement.visuelMobile.alt:editoElement.visuelDesktop.alt))}" src="${imageUrl}${editoElement.visuelMEA.url!=null?editoElement.visuelMEA.url:(editoElement.visuelMea.url!=null?editoElement.visuelMea.url:(editoElement.visuelMobile.url!=null?editoElement.visuelMobile.url:editoElement.visuelDesktop.url))}" >
			<div class="title">${editoElement.libelleType}<h2 itemprop="headline" class="cropTitle" title="${editoElement.titreMEA}">${editoElement.titreMEA}</h2></div>
		</div>
	</a>
	<meta itemprop="url" content=" ${env_absoluteUrlWithoutEndSlash }${editoElement.url}"/>
	<meta itemprop="datePublished" content="${MICRO_DATA_TODAY}"/>
</div>
<!-- End  dossier_teaserView_grid_UI.jsp-->