<%@ page trimDirectiveWhitespaces="true" %>
<wcf:url var="FavoritesShopsDisplayViewURL" value="FavoritesShopsDisplayView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
</wcf:url>

<wcf:url var="FavoritesShopsOperationCmdURL" value="FavoritesShopsOperationCmd" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
</wcf:url>


<script>
	<%-- Charge intialement la zone des magasins favoris, la distance pour y aller est calculée à partir de l'adresse postale de l'utilisateur --%>
	dojo.addOnLoad(function() {
		refreshControllerFavoritesShops.url = '<c:out value="${FavoritesShopsDisplayViewURL}" />';
		SearchShopsJS.favoritesOperationURL = '<c:out value="${FavoritesShopsOperationCmdURL}" />';
		
		if (SearchShopsJS.currLatLng != null) {
			SearchShopsJS.updateFavoritesShopsFromLatLng(SearchShopsJS.currLatLng);
			
		} else {
			SearchShopsJS.updateFavoritesShops();
		}
		
		<%-- Dès lors que l'utilisateur est correctement géolocalisé la distance pour se rendre au magasin doit être actualisée --%>
		require(["dojo/_base/connect"], function(connect){
		  var handle = connect.subscribe('Geolocation.onPositionSucceed', function(position) {
				SearchShopsJS.currLatLng = {"lat": position.coords.latitude, "lng": position.coords.longitude};
				SearchShopsJS.updateFavoritesShopsFromLatLng(SearchShopsJS.currLatLng);
				handle.remove();
			});
		});
	});
	
</script>

<div dojoType="wc.widget.RefreshArea" id="favoritesShopsId" objectId="favoritesShopsId" controllerId="favoritesShops_controller">
	<%@include file="FavoritesShopsDisplay_UI.jsp" %>
</div>

<%@include file="FavoriteShopsPopup.jspf" %>

