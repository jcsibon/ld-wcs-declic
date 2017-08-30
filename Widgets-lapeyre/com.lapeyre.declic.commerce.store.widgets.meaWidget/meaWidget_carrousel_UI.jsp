<!-- START meaWidget_carrousel_UI.jsp -->
<%-- Attention, c'est un carrousel au sens Lapeyre, non des images qui scrollent --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<div class="meaCarrousel row ${param.classForMeaBlock}">

	<span class="titleBlock">${meas[param.idx].titre}</span>
	
	<div class="col12 acol12 contrib1">
		<div class="backgroundContainer"><%-- TODO quid si pas 3 elements ? --%>
			<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
					<c:param name="type" value="${meas[param.idx].contenus[0].cible.type}" />
					<c:param name="lien" value="${meas[param.idx].contenus[0].cible.lien}" />
			</c:import>
			<a href="${linkUrl}" >
				<img  alt="${isMobile?meas[param.idx].contenus[0].banniere.visuelSmall.alt:meas[param.idx].contenus[0].banniere.visuelLarge.alt}" 
				     src="${imageUrl}${isMobile?meas[param.idx].contenus[0].banniere.visuelSmall.url:meas[param.idx].contenus[0].banniere.visuelLarge.url}">
			</a>
		</div>
		
		<div class="right">
		<c:forEach items="${meas[param.idx].contenus}" var="contenu" varStatus="statut">
			<c:if test="${(statut.index==1 || statut.index==2) && !isMobile}">
				<c:if test="${(isMobile && !empty contenu.banniere.visuelSmall.url) || (not isMobile && !empty contenu.banniere.visuelLarge.url)}" >
					<%-- On affiche à partir du moment où une image est définie --%>
					<div class="linkToArticle">
						<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
							<c:param name="type" value="${contenu.cible.type}" />
							<c:param name="lien" value="${contenu.cible.lien}" />
						</c:import>
						<a class="hover_underline" href="${linkUrl}">
							<div class="backgroundContainer">
								<img  alt="${isMobile?contenu.banniere.visuelSmall.alt:contenu.banniere.visuelLarge.alt}" src="${imageUrl}${isMobile?contenu.banniere.visuelSmall.url:contenu.banniere.visuelLarge.url}"/>
							</div>
							<c:if test="${!empty contenu.titre }"><span class="title">${contenu.titre}</span></c:if>
						</a>
					</div>
				</c:if>
			</c:if>
		</c:forEach>			
		</div>
		
		<div class="left">
			<div class="textContainer">
				<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
					<c:param name="type" value="${meas[param.idx].contenus[0].cible.type}" />
					<c:param name="lien" value="${meas[param.idx].contenus[0].cible.lien}" />
				</c:import>
				<c:choose>		
					<c:when test="${isOnMobileDevice}">
						<a class="hover_underline"  href="${linkUrl}" title="${meas[param.idx].contenus[0].titre}" ><span class="title"><ecocea:crop value="${meas[param.idx].contenus[0].titre}" length="46" /></span></a>
						<c:if test="${!empty meas[param.idx].contenus[0].accroche}">
						<div class="bodytext">
							<ecocea:crop value="${ecocea:replaceCarriageReturn(meas[param.idx].contenus[0].accroche)}" length="141" />					
						</div>
						</c:if>
					</c:when>
					<c:when test="${!isOnMobileDevice}">
						<a class="hover_underline" href="${linkUrl}" title="${meas[param.idx].contenus[0].titre}" ><span class="title"><ecocea:crop value="${meas[param.idx].contenus[0].titre}" length="66" /></span></a>
						<c:if test="${!empty meas[param.idx].contenus[0].accroche}">
						<div class="bodytext">
							<ecocea:crop value="${ecocea:replaceCarriageReturn(meas[param.idx].contenus[0].accroche)}" length="451" />
						</div>
						</c:if>
					</c:when>
				</c:choose>
				<br />
				<c:if test="${!empty meas[param.idx].contenus[0].libelleLien }">
				<a class="button" href="${linkUrl}" >${meas[param.idx].contenus[0].libelleLien}</a>
				</c:if>
			</div>
		</div>
	</div>
</div>

<!-- END meaWidget_carrousel_UI.jsp -->