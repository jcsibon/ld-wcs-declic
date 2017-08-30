<!-- Begin Content_Menu_UI.jsp-->
<%@ page trimDirectiveWhitespaces="true" %>
<div id="headerRow2">	
	<div>
		<ul id="departmentsMenu" role="menu" data-parent="header" aria-labelledby="departmentsButton">
			<li class="navigation_edito_desktop">
				<a aria-haspopup="true" role="menuitem" class="departmentButton" href="${env_TopCategoriesDisplayURL}" id="menu_Home"><span><fmt:message key="lemagBoutiqueEnLigneLabel" bundle="${widgetText}" /></span></a>
				<div id="departmentMenu_lemagBoutiqueEnLigneLabel" class="departmentMenu" role="menu" data-parent="departmentsMenu" aria-label="<fmt:message key="lemagBoutiqueEnLigneLabel" bundle="${widgetText}"/>">
					<div class="header">
						<a id="departmentLink_lemagBoutiqueEnLigneLabel" href="${env_TopCategoriesDisplayURL}" class="link"><fmt:message bundle="${widgetText}" key="lemagBoutiqueEnLigneLabel"/></a>
					</div>
				</div>
			</li>
		<c:forEach items="${content.menu}" var="menu">
			<li class="navigation_edito_desktop">
				<a aria-haspopup="true" role="menuitem" class="departmentButton" href="${menu.lien}"><span>${menu.libelle}</span></a>
				<div class="departmentMenu" role="menu" data-parent="departmentsMenu" aria-label="${menu.libelle}">
					<div class="header">
						<a  href="${menu.lien}" class="link">${menu.libelle}</a>
					</div>
				</div>
			</li>
		</c:forEach>
		</ul>
	</div>
</div>
<!-- End Content_Menu_UI.jsp-->