<%@ page trimDirectiveWhitespaces="true" %>
<c:set var="rowColClass" value="rowCol2"/>
<c:if test="${isOnMobileDevice}">
	<c:set var="rowColClass" value="rowCol1"/>
</c:if>
<div id="gpsButtonsPopin" data-dojo-type="lapeyre/widget/Dialog" title="GPS" style="display: none" >
  <div class="widget_site_popup">
		<div class="content">
			<div class="header">
				<span class="bold blockTitle">GPS</span>
				<a class="close" href="javascript:hidePopup('gpsButtonsPopin')" title="<fmt:message bundle="${widgetText}" key="SL_CLOSE" />"></a>
			</div>
			<div class="body ${rowColClass} noFloat">
				<ul>
					<c:forEach items="${mag.solutionsGps}" var="gps">
						<li><a href="${ecocea:concatUrls(imageUrl, gps.fichier)}" class="button" download><c:out value="${gps.libelle}"/></a> </li>
					</c:forEach>
				</ul>
			</div>
			<div class="footer">
			</div>
		</div>
	</div>
</div>
