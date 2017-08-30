<div id="newsContainer">
	<c:if test="${mag.motDirecteur!=''}">
		<hr class="bHorizontalDivider">
		<div class="row motDuDirecteur">
			<span class="titleBlock">
				<fmt:message bundle="${widgetText}" key="motDirecteur" />
			</span>
			<div class="col8 push2 acol12 apush0">
				<div class="content">
					<c:out value="${mag.motDirecteur}" escapeXml="false" />
				</div>
			</div>
		</div>
	</c:if>

	<c:if test="${mag.actualites!=''}">
		<div class="row mobile-hidden">
			<span class="titleBlock">
				<fmt:message bundle="${widgetText}" key="actualites" />
			</span>
			<div class="col8 push2 acol12 apush0">
				<div class="content">
					<c:out value="${mag.actualites}" escapeXml="false" />
				</div>
			</div>
		</div>
	</c:if>
</div>