<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN FavoritesShopsDisplay_UI.jsp -->
<c:set var="prefixRetraitMagasin" value="retraitMagasin"/>
<c:set var="prefixFavorite" value="favorite"/>
<c:set var="prefixSelect" value="select"/>

<c:if test="${!empty favoritesShops && fn:length(favoritesShops) gt 0}">
	<c:if test="${isOnMobileDevice eq false}">
		<div class="col6 left">
	</c:if>
		<h2 class="titleBlock"><span><fmt:message key="favoriteStoreSubSectionTitle" bundle="${widgetText}" /></span></h2>
		<div class="shopContainer">
			<c:set var="favShopCpt" value="0"/>
			<c:forEach items="${favoritesShops}" var="shop">
				<c:if test="${favShopCpt lt 3}">
					<c:if test="${shop.retraitMagasin || shop.retraitDrive || shop.livraisonColissimo || shop.livraisonTransporteur}">
						<c:set var="favShopCpt" value="${favShopCpt +1}"/>
						<fmt:formatNumber var="distance" value="${shop.distance}" maxFractionDigits="1" />
						<c:set var="prefix" value="${prefixRetraitMagasin}_${prefixFavorite}_${prefixSelect}"/>
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
		</div>
	<c:if test="${isOnMobileDevice eq false}">	
		</div>
	</c:if>
	<script id="favoritesShopsInTunnelLivraisonScript">
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
		
		$("div[id^='${prefixRetraitMagasin}_${prefixFavorite}_${prefixSelect}']").each(function(index){
				if($(this).hasClass('selectable')) {
					var that = this;
					$(this).click(function(){
						changeDefaultMagasinForRetraitMagasin(that);
					});
				}
		});
	</script>
</c:if>

<!-- END FavoritesShopsDisplay_UI.jsp -->