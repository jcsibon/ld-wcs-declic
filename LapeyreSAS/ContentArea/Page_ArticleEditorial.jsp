<%@ page trimDirectiveWhitespaces="true" %>
<div itemscope itemtype="${MICRO_DATA_ARTICLE}">
	<!-- BEGIN ArticleEditorial.jsp -->
	<%@include file="Content_Header_UI.jspf" %>
	<%@include file="Content_Author_UI.jspf" %>
	<%@include file="Content_Summup_UI.jspf" %>
	<%@include file="Content_Body_UI.jspf" %>
</div>
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
	
		
	<c:set var="titleToShare" value="${pageTitle}" scope="page"/>
	<c:set var="metaDescriptionToShare" value="${metaDescription}"  scope="page"/>
	
	<%@ include file="../Common/JSTLEnvironmentSetupExtForSocialNetworks.jsp" %>
	
	<%-- Partage --%>
	<div class="row">
		<div class="textArticle sharingBlock">
			<div class="recommendArticle">
				<span><fmt:message key="EditorialPageShareTitle" bundle="${widgetText}" /></span>
				<!--  background: #f7f7f7  -->
				<%out.flush(); %>
				<c:import url="/Widgets-lapeyre/Common/SocialNetworks/SocialNetworksEdito.jsp">
					<c:param name="classToApply" value="recommendArticleButtons" />
					<c:param name="rootPath" value="${jspStoreImgDir}" />
				</c:import>
				<%out.flush(); %>
			</div>
		</div>
	</div>
	
	<c:set var="xcontents" value="${content.page.contenusLies}" scope="request"/>
	<c:set var="xcontentsSize" value="${fn:length(xcontents)}" scope="request"/>
	<c:set var="maxPerRow" value="2" scope="request" />
	
	<c:if test="${xcontentsSize > 0}">
		<hr class="horizontalDivider"/>
	</c:if>
	
	<fmt:message key="relatedEditorialContentBlockTitle" bundle="${widgetText}" var="titre" scope="request" />
	
	<%out.flush(); %>
	<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.CrossContentWidget/CrossContentWidget.jsp">
		<c:param name="format" value="grid" />
		<c:param name="ignoreData" value="true" />
	</c:import>
	<%out.flush(); %>
	
	
	<c:set var="productsAssociated" value="${content.page.produitsLies}" />
	
	<%--<c:if test="${fn:length(productsAssociated) > 0}">
	 	<hr class="horizontalDivider"/> 
	</c:if>--%>
	
	<%@include file="CatalogEntryRecommendation/Content_CatalogEntryRecommendation.jsp" %>
	<%@include file="Content_Tags_UI.jspf" %>
	<%@include file="Content_Paginate_UI.jspf" %>

<!-- END ArticleEditorial.jsp -->