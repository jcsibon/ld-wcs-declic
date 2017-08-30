<!-- Begin Page_HomeEditorial.jsp-->
<%@ page trimDirectiveWhitespaces="true" %>
<c:set var="meas" value="${content.dossier.meas}" scope="request" />
<%out.flush(); %>
<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget.jsp">
	<c:param name="isHomeEditoPage" value="true" />
</c:import>
<%out.flush(); %>

<% //on ne peut faire un c:set ou c:param sinon on perd le type 
		java.util.Map lapage = (java.util.Map) request.getAttribute("content"); 
		lapage = (java.util.Map) lapage.get("dossier");
		
		java.util.Map object = (java.util.Map) lapage.get("tendance"); 
		java.util.List list = (java.util.List) object.get("articles");
%>

<c:if test="${!empty content.dossier.tendance.articles || !empty content.dossier.tendance.dossiers || !empty content.dossier.tendance.titre}">
	<div class="row homeEditorialSections">
		<c:if test="${!empty content.dossier.tendance.titre}"><span class="titleBlock">${content.dossier.tendance.titre}</span></c:if>
		<%
		for(Object element : list){
			request.setAttribute("editoElement", element);
		%>
			<c:import url="/Widgets-lapeyre/Common/Editorial/teaserView_UI.jsp">
				<c:param name="format" value="list" />
			</c:import>
		<%} %>
	</div>
</c:if>
<c:if test="${fn:length(content.dossier.pushProduit.produits) > 0}">
	<div class="row linkContainer productsAssociatedBlock homeEditorialSections">
		<c:if test="${!empty content.dossier.pushProduit.titre}"><span class="titleBlock">${content.dossier.pushProduit.titre}</span></c:if>
		<c:set var="productsAssociated" value="${content.dossier.pushProduit.produits}" />
		<c:set var="useProcductCMSTitle" value="true" />
			<%@include file="CatalogEntryRecommendation/Content_CatalogEntryRecommendation.jsp" %>
	</div>
</c:if>

<c:if test="${not empty content.dossier.battle.contenus}">
<div class="rowContainer homeEditorialSections">
	<c:if test="${!empty content.dossier.battle.titre}"><span class="titleBlock">${content.dossier.battle.titre}</span></c:if>
	<c:forEach var="battle" items="${content.dossier.battle.contenus}">
		<c:if test="${not empty content.dossier.battle.contenus}">
			<div class="centeredText">${battle}</div>
		</c:if>
	</c:forEach>
</div>
</c:if>

<div class="row homeEditorialSections"> 
	<c:if test="${!empty content.dossier.domoInnovateurs.titre}"><span class="titleBlock">${content.dossier.domoInnovateurs.titre}</span></c:if>
	<%
	object = (java.util.Map) lapage.get("domoInnovateurs"); 
	list = (java.util.List) object.get("articles");
	for(Object element : list){
		request.setAttribute("editoElement", element);
	%>
		<c:import url="/Widgets-lapeyre/Common/Editorial/teaserView_UI.jsp">
			<c:param name="format" value="list" />
		</c:import>
	<%} %>
</div>

<div class="row homeEditorialSections">
	<c:if test="${!empty content.dossier.tuto.titre}"><span class="titleBlock">${content.dossier.tuto.titre}</span></c:if>
	<%
	object = (java.util.Map) lapage.get("tuto"); 
	list = (java.util.List) object.get("articles");
	for(Object element : list){
		request.setAttribute("editoElement", element);
	%>
		<c:import url="/Widgets-lapeyre/Common/Editorial/teaserView_UI.jsp">
			<c:param name="format" value="list" />
		</c:import>
	<%} %>
</div>

<div class="row homeEditorialSections mobile-hidden">
	<c:if test="${!empty content.dossier.paroleLapeyre.titre}"><span class="titleBlock">${content.dossier.paroleLapeyre.titre}</span></c:if>
	<c:if test="${!empty content.dossier.paroleLapeyre.contenuPrincipal}">
	<div class="col12 acol12 contrib1">
		<div class="backgroundContainer">
			<a href="${content.dossier.paroleLapeyre.contenuPrincipal.url}">
				<img  alt="${(isMobile) ? content.dossier.paroleLapeyre.contenuPrincipal.visuelMobile.alt : content.dossier.paroleLapeyre.contenuPrincipal.visuelDesktop.alt}" src="${imageUrl}${(isMobile) ? content.dossier.paroleLapeyre.contenuPrincipal.visuelMobile.url : content.dossier.paroleLapeyre.contenuPrincipal.visuelDesktop.url}">
			</a>
		</div>
		<c:if test="${!empty content.dossier.paroleLapeyre.contenu2 || !empty content.dossier.paroleLapeyre.contenu3}">
			<div class="right col5">
				<c:if test="${!empty content.dossier.paroleLapeyre.contenu2}">
				<div class="linkToArticle"><div class="coin<ecocea:typeArticleIcon types="${content.dossier.paroleLapeyre.contenu2.type}"/>"><div>${content.dossier.paroleLapeyre.contenu2.tempsLecture}</div></div>
					<a href="${content.dossier.paroleLapeyre.contenu2.url}">
						<div class="backgroundContainer"><img  alt="${(isMobile) ? content.dossier.paroleLapeyre.contenu2.visuelMobile.alt : content.dossier.paroleLapeyre.contenu2.visuelDesktop.alt}" src="${imageUrl}${(isMobile) ? content.dossier.paroleLapeyre.contenu2.visuelMobile.url : content.dossier.paroleLapeyre.contenu2.visuelDesktop.url}"></div>
						<h2 class="title">${content.dossier.paroleLapeyre.contenu2.titre}</h2>
					</a>
				</div>
				</c:if>
				<c:if test="${!empty content.dossier.paroleLapeyre.contenu3}">
				<div class="linkToArticle"><div class="coin<ecocea:typeArticleIcon types="${content.dossier.paroleLapeyre.contenu3.type}"/>"><div>${content.dossier.paroleLapeyre.contenu3.tempsLecture}</div></div>
					<a href="${content.dossier.paroleLapeyre.contenu3.url}">
						<div class="backgroundContainer"><img  alt="${(isMobile) ? content.dossier.paroleLapeyre.contenu3.visuelMobile.alt : content.dossier.paroleLapeyre.contenu3.visuelDesktop.alt}" src="${imageUrl}${(isMobile) ? content.dossier.paroleLapeyre.contenu3.visuelMobile.url : content.dossier.paroleLapeyre.contenu3.visuelDesktop.url}"></div>
						<h2 class="title">${content.dossier.paroleLapeyre.contenu3.titre}</h2>
					</a>
				</div>
				</c:if>
			</div>
		</c:if>
		<div class="left col7">
			<div class="textContainer">
				<h2 class="title"><a href="${content.dossier.paroleLapeyre.contenuPrincipal.url}">${content.dossier.paroleLapeyre.contenuPrincipal.titre}</a></h2>
				<div class="bodytext">
					${content.dossier.paroleLapeyre.contenuPrincipal.accroche}
				</div>
				<br>
				<a class="button" href="${content.dossier.paroleLapeyre.contenuPrincipal.url}"><fmt:message key="contentTeaserViewListButtonLabel" bundle="${widgetText}" /></a>
			</div>
		</div>
		
	</div>
	</c:if>
</div>
	
</div>


<c:if test="${not empty content.dossier.ilsParlentDeNous.contenus}">
<div class="rowContainer homeEditorialSections">
	<c:if test="${!empty content.dossier.ilsParlentDeNous.titre}"><span class="titleBlock">${content.dossier.ilsParlentDeNous.titre}</span></c:if>
	<c:forEach var="ilsparlent" items="${content.dossier.ilsParlentDeNous.contenus}">
		<div class="centeredText">${ilsparlent}</div>
	</c:forEach>
</div>
</c:if>
<!-- End Page_HomeEditorial.jsp-->