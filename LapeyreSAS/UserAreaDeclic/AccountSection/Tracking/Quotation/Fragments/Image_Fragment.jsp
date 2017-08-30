<c:choose>
	<c:when test="${(fn:startsWith(productThumbNail, 'http://') || fn:startsWith(productThumbNail, 'https://'))}">
		<wcst:resolveContentURL var="productThumbNail" url="${productThumbNail}"/>
	</c:when>
	<c:otherwise>
		<c:set var="productThumbNail" value="${productThumbNail}" />
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${(fn:startsWith(productFullImage, 'http://') || fn:startsWith(productFullImage, 'https://'))}">
		<wcst:resolveContentURL var="productFullImage" url="${productFullImage}"/>
	</c:when>
	<c:otherwise>
		<c:set var="productFullImage" value="${productFullImage}" />
	</c:otherwise>
</c:choose>

<div class="productImageContainer">
<a href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="catalogEntry_img<c:out value="${catEntryIdentifier}"/>" 
	class="itemhoverdetailed" title="<c:out value='${fn:replace(productName, search, replaceStr)} ${formattedPriceString}' escapeXml='false'/>" >

	<c:choose>
	<c:when test="${!empty productThumbNail}">
		<astpush:assetPushUrl var="productFullImage" scope="page" urlRelative="${itemFullImage}" type="${productType}" source="list" device="${device}" format="full"/>
		<img src="${productFullImage}" alt="${itemResult.name}" border="0"/>
		<astpush:assetPushUrl var="productThumbImage" scope="page" urlRelative="${productThumbNail}" type="${productType}" source="list" device="${device}" format="full"/>
	</c:when>
	<c:otherwise>
		<c:set var="keyDefaultImageMaps" value="${productType}_main_full"/>
		<astpush:assetPushUrl var="productThumbImage" scope="page" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="${productType}" source="list" device="${device}" format="full" defaultUrl="true"/>
		<astpush:assetPushUrl var="productFullImage"  scope="page" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="${productType}" source="list" device="${device}" format="full" defaultUrl="true"/>
		<img src="${productFullImage}" 
			alt="<c:out value='${fn:replace(productName, search, replaceStr)}' escapeXml='false'/>" 
			/>
	</c:otherwise>
	</c:choose>
</a>
</div>