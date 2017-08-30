<%@ page trimDirectiveWhitespaces="true" %>
<c:if test="${!empty favoritesShops && fn:length(favoritesShops) gt 0}">
	<span class="titleBlock padding-top-2">
		<c:choose>
			<c:when test="${userType eq 'G' }">
				<fmt:message key="StoreLocMagasinCourantGuestBlockTitle" bundle="${storeText}" />
			</c:when>
			<c:otherwise>
				<fmt:message key="StoreLocMagasinPrefereBlockTitle" bundle="${storeText}" />
			</c:otherwise>
		</c:choose>
		<span class="grayPin"></span>
	</span>
	<c:set var="idxShop" value="0" />
	<c:forEach items="${favoritesShops}" var="shop" varStatus="status">
		<c:if test="${idxShop%2 == 0}">
			<div class="shopContainer">
		</c:if>
			<c:set var="idxShop" value="${idxShop+1}" />
			<%@include file="ShopDisplay.jsp" %>
		<c:if test="${idxShop%2 == 0}">
			</div>
		</c:if>
	</c:forEach>
	<c:if test="${idxShop%2 != 0}">
		</div>
	</c:if>
	<div id="favoritesShopsScript">
		<script>
				function addFavoritesShopsToMap(){
					if(typeof MapStoreLocatorJS != "undefined"){
						<c:forEach items="${favoritesShops}" var="shop" varStatus="status">
							MapStoreLocatorJS.addShop({
								strLocId : ${ecocea:quote(shop.strLocId)},
								label: ${ecocea:quote(ecocea:escapeJS(shop.name))},
								type: ${ecocea:quote(shop.type)},
								address1: ${ecocea:quote(ecocea:escapeJS(shop.address1))},
								complAdr1: ${ecocea:quote(ecocea:escapeJS(shop.address2))},
								complAdr2: ${ecocea:quote(ecocea:escapeJS(shop.address3))},
								complAdr3: ${ecocea:quote(ecocea:escapeJS(shop.address4))},
								cp: ${ecocea:quote(shop.cp)},
								ville: ${ecocea:quote(ecocea:escapeJS(shop.city))},
								phone: ${ecocea:quote(shop.mainPhone)},
								seoUrl : ${ecocea:quote(shop.seoUrl)},
								isEpingle : ${shop.favorite},
								isDrive : ${ecocea:quote(mag.ModeLivraison.retraitDrive)},
								isEpinglable : ${ecocea:quote(shop.retraitMagasin eq 'true' || shop.retraitDrive eq 'true' || shop.livraisonColissimo eq 'true' || shop.livraisonTransporteur eq 'true')},
								lat: ${shop.lat},
								lng: ${shop.lng}
							});
							<c:if test="${status.first}">
								MapStoreLocatorJS.currLatLng = {lat: ${shop.lat}, lng: ${shop.lng}};
								<c:set var="firstShopId" value="${shop.strLocId}" />
							</c:if>
						</c:forEach>
					}
				}
				<c:choose>
					<c:when test="${fn:length(extendedUserContext.defaultStores) > 0}">
						<c:set var="shopIdToCenter" value="${extendedUserContext.defaultStores[0].id}" />
					</c:when>
					<c:otherwise>
						<c:if test="${not empty firstShopId}">
							<c:set var="shopIdToCenter" value="${firstShopId}" />
						</c:if>
					</c:otherwise>
				</c:choose>
				
				<c:if test="${not empty shopIdToCenter}">
					if(typeof MapStoreLocatorJS != "undefined"){
						MapStoreLocatorJS.centerToRightShop = function() {
							var shopId = '<c:out value="${shopIdToCenter}" />';
							MapStoreLocatorJS.centerToShopById('\''+shopId+'\'');
							MapStoreLocatorJS.openInfoWindowById('\''+shopId+'\'');
							MapStoreLocatorJS.setZoom(14);
						}
					}
				</c:if>
		</script>
	</div>
</c:if>
