<!-- Begin article_teaserView_grid_UI.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>
<div class="article" itemscope itemtype="${MICRO_DATA_ARTICLE}">
	<c:if test="${!empty editoElement.tempsLecture}"><div class="coin<ecocea:typeArticleIcon types="${editoElement.type}"/>"><div><span>${editoElement.tempsLecture}</span></div></div></c:if>
	<a class="hover_underline" href="${editoElement.url}">
		<div class="backgroundContainer mag-content" >
			<img class="article-image responsive-img" itemprop="image" onerror="this.src='/wcsstore/LapeyreSAS/images/desktopList/defaultImage.png'" alt="${editoElement.visuelMEA!=null?editoElement.visuelMEA.alt:(editoElement.visuelMea.alt!=null?editoElement.visuelMea.alt:(editoElement.visuelMobile!=null?editoElement.visuelMobile.alt:editoElement.visuelDesktop.alt))}" src="${imageUrl}${editoElement.visuelMEA!=null?editoElement.visuelMEA.url:(editoElement.visuelMea.url!=null?editoElement.visuelMea.url:(editoElement.visuelMobile!=null?editoElement.visuelMobile.url:editoElement.visuelDesktop.url))}">
			<div class="col s10 offset-s1 mag-text">
				<div class="mag-type">${editoElement.libelleType}</div>
				<h2 itemprop="headline" class="article-title" title="${editoElement.titreMEA}">${editoElement.titreMEA}</h2>
			</div>
		</div>
		
	</a>
	<meta itemprop="url" content=" ${env_absoluteUrlWithoutEndSlash }${editoElement.url}"/>
	<meta itemprop="datePublished" content="${MICRO_DATA_TODAY}"/>
</div>
<!-- End article_teaserView_grid_UI.jsp -->