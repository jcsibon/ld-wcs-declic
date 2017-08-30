<c:if test="${!empty mag.qrCode}">
	<div class="row mobile-hidden magasinQRCode">
		<span class="titleBlock"> <fmt:message bundle="${widgetText}" key="magasinQRCodeTitle" /> </span>
		<p style="text-align: center;"> <img id="QR-code" src="${imageUrl}${mag.qrCode.url}" alt="${mag.qrCode.alt}"> </p>
	</div>
</c:if>