<!-- Begin Page_FolderEditorial.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="row">
	<div class="blockPresentation dossierHeader" itemscope itemtype="${MICRO_DATA_ARTICLE}">
		<c:if test="${!empty content.dossier.tempsLecture}"><div class="coin<ecocea:typeArticleIcon types="${content.dossier.type}"/>"><div><span>${content.dossier.tempsLecture}</span></div></div></c:if>
		<c:choose>
			<c:when test="${isOnMobileDevice}">
				<div class="editoBackground"><img itemprop="image" alt="${content.dossier.visuelMobile.alt}" src="${imageUrl}${content.dossier.visuelMobile.url}" onerror="this.src='/wcsstore/LapeyreSAS/images/contentListView/defaultImage.png'" /></div>
			</c:when>
			<c:when test="${!isOnMobileDevice}">
				<div class="editoBackground"><img  itemprop="image" alt="${content.dossier.visuelDesktop.alt}" src="${imageUrl}${content.dossier.visuelDesktop.url}" onerror="this.src='/wcsstore/LapeyreSAS/images/contentListView/defaultImage.png'" /></div>
			</c:when>
		</c:choose>
		<div class="textContainer">
			<c:choose>
				<c:when test="${isOnMobileDevice}">
					<span class="mobile" ><h1 title="${content.dossier.titre}" itemprop="headline"><ecocea:crop value="${content.dossier.titre}" length="46" /></h1></span>
					<c:if test="${!empty content.dossier.titre && !empty content.dossier.accroche}"><img class="separator" alt="separator" src="${jspStoreImgDir}images/separator.png" /></c:if>
					<div itemprop="description"><ecocea:crop value="${content.dossier.accroche}" length="186" /></div>
				</c:when>
				<c:when test="${!isOnMobileDevice}">
					<h1 title="${content.dossier.titre}" itemprop="headline">${content.dossier.titre}</h1>
					<c:if test="${!empty content.dossier.titre && !empty content.dossier.accroche}"><img class="separator" alt="separator" src="${jspStoreImgDir}images/separator.png" /></c:if>
					<div itemprop="description">${content.dossier.accroche}</div>
				</c:when>
			</c:choose>
			<meta itemprop="datePublished" content="${MICRO_DATA_TODAY}"/>
		</div>
	</div>
	
</div>

<c:set var="tabSlotId" value="2"/>
<c:set var="totalCount" value="0"/>
<c:set var="statusCount" value="2"/>
<c:set var="tabStyle" value=""/>
<c:set var="noLayoutFolderEdito" value="true"/>
<c:choose>
<c:when test="${content.dossier.facetable}">
	<c:set var="searchMethod" value="search/byParent"/>
</c:when>
</c:choose>
<c:remove var="contentHelper"/>
<script type="text/javascript" src="${jspStoreImgDir}../Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.CatalogEntryList/javascript/SearchBasedNavigationDisplay.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/tooltipster/jquery.tooltipster.min.js?${versionNumber}"></script>

<c:choose>
<c:when test="${content.dossier.facetable}">
<div class="row">
		<div class="tabButtonContainer col12" role="tablist" style="float: initial;">
		<c:set var="contentSearchTerm" value="${content.dossier.idFolder}" />
		<c:set var="searchTerm" value="${content.dossier.idFolder}" scope="request" />
		<%-- TODO ok sur l'affichage, mais sur application de la facette, il perd le searchTerm  --%>
			<%@ include file="/Widgets-lapeyre/Common/SearchCrossContentSetup.jspf" %>
			<%@ include file="../Container/SearchTab.jsp" %>	
		</div>
</div>
</c:when>
<c:otherwise>
<%-- ancienne version --%>
<div class="row contentList">
<c:forEach items="${content.listArticles}" var="element">
<% //on ne peut faire un c:set ou c:param sinon on perd le type 
	request.setAttribute("editoElement", pageContext.getAttribute("element"));
	%>
	<c:import url="/Widgets-lapeyre/Common/Editorial/teaserView_UI.jsp">
		<c:param name="format" value="list" />
	</c:import>
</c:forEach>
</div>
</c:otherwise>
</c:choose>
<div class="row">
		<div class="content">
			<%out.flush();%>
			<c:catch var="exc">
				<ecocea:widgetPath var="emspotpath" identifier="EMarketingSpot" />
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_bestSeller" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_bestSeller"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_RecoProduits" />
					<c:param name="pageSize" value="3"/>
					<%-- Target2Sell BEGIN --%>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_RecoProduits"/>
					<c:param name="displayPreference" value="1"/>
					<%-- Target2Sell END --%>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_SelectionDuMois" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_SelectionDuMois"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_ProduitsEtContenus" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_ProduitsEtContenus"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
			</c:catch>
			<%out.flush();%>
		
		</div>
	</div>


<!-- End Page_FolderEditorial.jsp -->


