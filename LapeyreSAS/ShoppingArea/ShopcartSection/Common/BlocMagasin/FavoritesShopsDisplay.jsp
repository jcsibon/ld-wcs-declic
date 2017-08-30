<!-- BEGIN FavoritesShopsDisplay.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<wcf:url var="FavoritesShopsDisplayViewURL" value="FavoritesShopsDisplayView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="view" value="FavoritesShopsInTunnelLivraisonDisplayView" />
</wcf:url>

<wcf:url var="FavoritesShopsOperationCmdURL" value="FavoritesShopsOperationCmd" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
</wcf:url>

<script>

	function fetchFavoriteShopInTunnelLivraison() {
		if(SearchShopsJS.currLatLng == null) {
				<c:set var="geoLocRequired" value="true" />
				<c:choose>
					<c:when test="${userType eq 'G'}">
						<c:set var="geoLocRequired" value="true" />
					</c:when>
					<c:otherwise>
						<wcbase:useBean id="addressDB" classname="com.lapeyre.declic.commerce.usermanagement.commands.SelfAddressDataBean" scope="page" />
						<c:if test="${!empty addressDB.selfAddress}">
							<c:set var="geoLocRequired" value="false" />
							<c:set var="address" value="${addressDB.selfAddress.address1}" />
							<c:set var="address" value="${address}+${addressDB.selfAddress.city}" />
							<c:set var="address" value="${address}+${addressDB.selfAddress.state}" />
							<c:set var="address" value="${address}+${addressDB.selfAddress.zipCode}" />
							SearchShopsJS.doSearchShopFromAddress('<c:out value="${address}" />',function(){
								if(SearchShopsJS.currLatLng == null) {
									SearchShopsJS.geoLocSearch(function() {
										SearchShopsJS.updateFavoritesShops();
									});
								}
								else{
									SearchShopsJS.updateFavoritesShops();
								}
							});
						</c:if>
					</c:otherwise>
				</c:choose>
				<c:if test="${geoLocRequired eq 'true'}">
					SearchShopsJS.geoLocSearch(function(){
						<c:choose>
							<c:when test="${userType eq 'G'}">
								
							</c:when>
							<c:otherwise>
								SearchShopsJS.updateFavoritesShops();
							</c:otherwise>
						</c:choose>
					});
				</c:if>
			}
			else {
				<c:choose>
					<c:when test="${userType eq 'G'}">
						
					</c:when>
					<c:otherwise>
						SearchShopsJS.updateFavoritesShops();
					</c:otherwise>
				</c:choose>
			}
	}
	
	dojo.addOnLoad(function(){
		refreshControllerFavoritesShopsInTunnelLivraison.url = '<c:out value="${FavoritesShopsDisplayViewURL}" />';
		
		SearchShopsJS.favoritesOperationURL = '<c:out value="${FavoritesShopsOperationCmdURL}" />';
		
		fetchFavoriteShopInTunnelLivraison();
	});
</script>

<%@include file="FavoritesShopsDisplay_UI.jsp" %>

<!-- END FavoritesShopsDisplay.jsp -->