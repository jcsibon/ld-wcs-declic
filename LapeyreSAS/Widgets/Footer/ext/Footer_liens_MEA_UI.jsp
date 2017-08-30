	<div class="header">
		<h3>
			${mea.titre}
		</h3>
	</div>
	<c:forEach items="mea.meas" var="linkList">
	<div class="section">
		<a href=""><h4>${linkList.titre}</h4></a>
		<ul>
		<c:forEach var="cible" items="linkList.cibles">
			<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
					<c:param name="type" value="${cible.type}" />
					<c:param name="lien" value="${cible.lien}" />
			</c:import>
			<li><a href="${linkUrl}" class="button">${cible.libelleBouton}</a></li>
		</c:forEach>
		</ul>
	</div>
	</c:forEach>
</div>
