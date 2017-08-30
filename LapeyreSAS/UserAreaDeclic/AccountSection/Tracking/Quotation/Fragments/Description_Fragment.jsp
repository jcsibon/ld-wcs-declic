<div class="productDetailsContainer">
<h3>
	<c:if test="${!empty catEntryDisplayUrl}">
		<a class="hover_underline" href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>">
	</c:if>
	<c:out value="${productName}" escapeXml="false"/>
	<c:if test="${!empty catEntryDisplayUrl}">
		</a>
	</c:if>
</h3>
<p></p>
<p><c:out value="${productShortDescription}" escapeXml="false"/></p>
</div>

<c:if test="${!empty definingAttributes and !isOnMobileDevice}">
	<ul class="item_desc">
		<c:forEach var="definingAttr" items="${definingAttributes}">
			<li>${definingAttr.name} : ${definingAttr.values[0].value}</li>
		</c:forEach>
	</ul>
</c:if>
