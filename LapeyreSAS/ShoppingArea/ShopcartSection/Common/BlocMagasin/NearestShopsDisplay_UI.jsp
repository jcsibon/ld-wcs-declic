<!-- BEGIN NearestShopsDisplay_UI.jsp -->

<c:set var="prefixRetraitMagasin" value="retraitMagasin"/>
<c:set var="prefixNearest" value="nearest"/>
<c:set var="prefixSelect" value="select"/>

<fmt:message key="noStoreResultMessage" var="noStoreResultMessage" bundle="${storeText}" />

<p id="nearestShopErrorMessage" data-noresults="<fmt:message key="noStoreResultMessage" bundle="${storeText}" />" data-affine="<fmt:message key="StoreLocatorPleaseSpecify" bundle="${storeText}" />">
	<c:if test="${empty nearestShops || fn:length(nearestShops) eq 0}">
		<c:out value="${noStoreResultMessage}" />
	</c:if>
</p>
<c:if test="${!empty nearestShops && fn:length(nearestShops) gt 0}">
	<c:set var="nearestShopCpt" value="0"/>
	<c:forEach items="${nearestShops}" var="shop">
		<c:if test="${nearestShopCpt lt 3}">
			<c:if test="${shop.retraitMagasin || shop.retraitDrive || shop.livraisonColissimo || shop.livraisonTransporteur}">
				<c:set var="nearestShopCpt" value="${nearestShopCpt + 1}"/>
				<fmt:formatNumber var="distance" value="${shop.distance}" maxFractionDigits="1" />
				<c:set var="prefix" value="${prefixRetraitMagasin}_${prefixNearest}_${prefixSelect}"/>
				<c:set var="selectable" value="true"/>
				<c:set var="selected" value="false"/>
				<c:if test="${extendedUserContext.defaultStores[0].id eq shop.strLocId}">
					<c:set var="selectable" value="false"/>
					<c:set var="selected" value="true"/>
				</c:if>
				<%@include file="BlocMagasin_UI.jsp" %>
			</c:if>
		</c:if>
	</c:forEach>
</c:if>

<script id="nearestShopsInTunnelLivraisonScript_0">
	function changeDefaultMagasinForRetraitMagasin(target) {
		var shopName = $(target).attr("data-shop-name");
		var shopId = $(target).attr("data-shop-id");
		cursor_wait();
		$.ajax({
			type: "GET",
			url : getAbsoluteURL() + "/SetDefaultStore",
			data: {"shopId": shopId, "shopName" : shopName, "localisation" : "denied"},
			success: function(event) {
				cursor_clear();
				window.location.reload();
			},
			error: function(errorThrown) {
				cursor_clear();
				console.error(errorThrown);
			}
		});
	}
	
	$("div[id^='${prefixRetraitMagasin}_${prefixNearest}_${prefixSelect}']").each(function(index){
		if($(this).hasClass('selectable')) {
			var that = this;
			$(this).click(function(){
				changeDefaultMagasinForRetraitMagasin(that);
			});
		}
	});
	
	var numberOfShopsFound = ${fn:length(nearestShops)};
	$('#noShops-error').remove();
</script>

<%-- Avertissement aucun magasin trouvé dans le tunnel --%>
<c:if test="${empty nearestShops || fn:length(nearestShops) eq 0}">
	<script id="nearestShopsInTunnelLivraisonScript_1">
		$('#SearchShopByZipCode').append('<label id="noShops-error" class="error">${ecocea:escapeHTML(noStoreResultMessage)}</label>');
	</script>
</c:if>

<!-- END NearestShopsDisplay_UI.jsp -->