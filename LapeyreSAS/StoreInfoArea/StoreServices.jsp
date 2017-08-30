<c:if test="${fn:length(mag.servicesMagasin)>0}">
	<hr class="bHorizontalDivider desktopHidden" />	
	<div class="row">
		<span class="titleBlock">
			<fmt:message bundle="${widgetText}" key="servicesMagasinTitle"/>
		</span>
		<div class="col12 acol12 servicesBlock rowCol5 noFloat">
			<ul>
				<c:forEach var="serv" items="${mag.servicesMagasin}">
					<li>
						<a href="${serv.url}">
							<c:if test="${!empty serv.picto}">
								<img alt="${serv.picto.alt}" src="${imageUrl}${serv.picto.url}"/>
							</c:if>
							<span class="mobile-hidden"><c:out value="${serv.titre}"/></span>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</c:if>