<!-- Begin article_teaserView_list_UI.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<div class="blockPresentation" itemscope itemtype="${MICRO_DATA_ARTICLE}"><%-- et article ? --%>
	<c:if test="${!empty editoElement.tempsLecture}"><div class="coin<ecocea:typeArticleIcon types="${editoElement.type}"/>"><div><span>${editoElement.tempsLecture}</span></div></div></c:if>
	<c:choose>
		<c:when test="${isOnMobileDevice}">
			<div class="editoBackground"><img itemprop="image" alt="${editoElement.visuelMobile.alt}" src="${imageUrl}${editoElement.visuelMobile.url}" onerror="this.src='/wcsstore/LapeyreSAS/images/contentListView/defaultImage.png'" /></div>
		</c:when>
		<c:when test="${!isOnMobileDevice}">
			<div class="editoBackground"><img  itemprop="image" alt="${editoElement.visuelDesktop.alt}" onerror="this.src='/wcsstore/LapeyreSAS/images/contentListView/defaultImage.png'" src="${imageUrl}${editoElement.visuelDesktop.url}" /></div>
		</c:when>
	</c:choose>
	<div class="textContainer <c:if test="${empty editoElement.surTitre}">margin-bottom</c:if>">
		<c:choose>	
			<c:when test="${isOnMobileDevice}">	
				<a class="mobile hover_underline" href="${editoElement.url}" title="${editoElement.titre}"><h2 itemprop="headline"><ecocea:crop value="${editoElement.titre}" length="38" /></h2></a>
				<c:if test="${!empty editoElement.titre && !empty editoElement.surTitre}"><img class="separator" alt="separator" src="${jspStoreImgDir}images/separator.png" /></c:if>
				<p class="subtitle" itemprop="description"><ecocea:crop value="${editoElement.surTitre}" length="31" /></p>
				
			</c:when>
			
			<c:when test="${!isOnMobileDevice}">
				<a class="hover_underline" href="${editoElement.url}" title="${editoElement.titre}"><h2 itemprop="headline"><ecocea:crop value="${editoElement.titre}" length="80" /></h2></a>
				<c:if test="${!empty editoElement.titre && !empty editoElement.surTitre}"><img class="separator" alt="separator" src="${jspStoreImgDir}images/separator.png" /></c:if>
				<p class="subtitle" itemprop="description"><ecocea:crop value="${editoElement.surTitre}" length="70" /></p>
			</c:when>
		</c:choose>
		<meta itemprop="url" content="${editoElement.url}"/>
		<meta itemprop="datePublished" content="${MICRO_DATA_TODAY}"/>
	</div>
	<div class="buttonContainer">
		<a href="${editoElement.url}" class="button"><fmt:message key="articleTeaserViewListButtonLabel" bundle="${widgetText}" /></a>
	</div>
</div>
<!-- End article_teaserView_list_UI.jsp -->

