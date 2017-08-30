<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<c:set var="hasBkg" value="false" />
<c:if test="${meas[param.idx].imageFondDesktop.url ne null }">
	<c:set var="hasBkg" value="true" />
</c:if>
<%-- Background URL --%>
<c:set var="backgroundUrl" value="${ecocea:concatUrls(imageUrl, meas[param.idx].imageFondDesktop.url)}" />
<c:if test="${isMobile}">
	<c:set var="backgroundUrl" value="${ecocea:concatUrls(imageUrl, meas[param.idx].imageFondMobile.url)}" />
</c:if>

<c:choose>
	<c:when test="${hasBkg }">
		<div class="meaLiens${param.classForMeaBlock}">
			<span class="titleBlock">${meas[param.idx].titre}</span>
			<div class="col12 acol12 linksBlock rowCol${param.colNumber} noFloat" style="background:url('${backgroundUrl}');background-repeat:no-repeat;background-size:cover;">
				<ul>
					<c:forEach items="${meas[param.idx].cible}" var="cible" varStatus="iter">		
						<li>
							<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
								<c:param name="type" value="${cible.type}" />
								<c:param name="lien" value="${cible.lien}" />
							</c:import>
							<a href="${linkUrl}" class="button">${cible.libelleBouton}</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="meaLiens${param.classForMeaBlock} meaLienNoBkg">
			<span class="titleBlock">${meas[param.idx].titre}</span>
			<div class="col12 acol12">
				<ul>
					<c:forEach items="${meas[param.idx].cible}" var="cible" varStatus="iter">		
						<li class="redBullet">
							<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
								<c:param name="type" value="${cible.type}" />
								<c:param name="lien" value="${cible.lien}" />
							</c:import>
							<a href="${linkUrl}" class="hover_underline">${cible.libelleBouton}</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	
	</c:otherwise>
</c:choose>