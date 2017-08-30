<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<div class="meaVignettes${param.classForMeaBlock}">
	<c:if test="${!empty meas[param.idx].titre}">
		<span class="titleBlock">${meas[param.idx].titre}</span>
	</c:if>
	<div class="col12 acol12 engageBlock rowCol${param.colNumber} noFloat">
		<ul>
			<c:forEach var="contenu" items="${meas[param.idx].contenus}" varStatus="iter">
				<li>
					<a class="engageBlock-container" href="${contenu.lien}">
						<img alt="${contenu.titre}" src="${ecocea:concatUrls(imagePathCMS, contenu.picto)}" />
						<div class="engageBlock-description-container">
							<div class="engageBlock-description">
								<h2 class="engageBlock-title">${contenu.titreMea}</h2>
								<div class="hide-on-small-only">${contenu.accrocheMea}</div>
								<span class="button button-primary button-catentrydisplay" href="http://dev137.lapeyre.ecocea.com/abattant-classic-pvc-FPC2185950">
									<fmt:message key="meaVignetteButtonLabel" bundle="${storeText}" />
								</span>
							</div>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>
