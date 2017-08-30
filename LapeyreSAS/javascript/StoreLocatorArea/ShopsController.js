
dojo.require("dojo/query");

wc.render.declareContext("searchFavoritesShops_Context", {"lat":"","lng":"","shopId":""});
	
var refreshControllerFavoritesShops = wc.render.declareRefreshController({
	id: "favoritesShops_controller",
	renderContext : wc.render.getContextById("searchFavoritesShops_Context"),
	url: "",
	formId: ""
	,renderContextChangedHandler: function(message, widget) {
		var renderContext = this.renderContext;
		widget.refresh(renderContext.properties);
	}
	,postRefreshHandler: function(widget) {
	
		var favoritesShopsScript = byId("favoritesShopsScript");

		if(favoritesShopsScript != null) {
			var scripts = favoritesShopsScript.getElementsByTagName("script");
			var j = scripts.length;
			for (var i = 0; i < j; i++){
				var newScript = document.createElement('script');
				newScript.type = "text/javascript";
				newScript.text = scripts[i].text;
				favoritesShopsScript.appendChild(newScript);
			}
			if(typeof MapStoreLocatorJS != "undefined"){
				if(dojo.byId('mapShopContainerRow')!=null){
					if(dojo.byId('mapShopContainerRow').className == 'row mobile-maps-hidden'){
						toggleMapList();
					}
				}
				addFavoritesShopsToMap();
				//autocenter : si fiche magasin centrer le magasin de la fiche
				if(!MapStoreLocatorJS.autocenter){
					if(MapStoreLocatorJS.centerToFocusShop != null){
						MapStoreLocatorJS.centerToFocusShop();
					}
				}
				//sinon autocenter
				else if (MapStoreLocatorJS.centerToRightShop != null){
					MapStoreLocatorJS.centerToRightShop();
				}
				MapStoreLocatorJS.setFavoriteStore(this.renderContext.properties.shopId);
			}
		}
		dojo.publish("CMPageRefreshEvent");
		cursor_clear();
	}
});

var refreshControllerFavoritesShopsInTunnelLivraison = wc.render.declareRefreshController({
	id: "favoritesShopsInTunnelLivraison_controller",
	renderContext : wc.render.getContextById("searchFavoritesShops_Context"),
	url: "",
	formId: ""
		,renderContextChangedHandler: function(message, widget) {
			var renderContext = this.renderContext;
			widget.refresh(renderContext.properties);
		}
	,postRefreshHandler: function(widget) {
	
		dojo.query('script[id^="favoritesShopsInTunnelLivraisonScript"]').forEach(function(node, index, nodelist){
			dojo.eval(node.innerHTML);
		  });
		
		dojo.publish("CMPageRefreshEvent");
	}
});

	
	
wc.render.declareContext("searchNearestShops_Context",{"lat":"", "lng":"", "userLat":"", "userLng":"", "all":""});

var refreshControllerNearestShops = wc.render.declareRefreshController({
	id: "nearestShops_controller",
	renderContext : wc.render.getContextById("searchNearestShops_Context"),
	url: "",
	formId: ""
	,renderContextChangedHandler: function(message, widget) {
		var renderContext = this.renderContext;
		widget.refresh(renderContext.properties);
	}
	,postRefreshHandler: function(widget) {
		var renderContext = this.renderContext;
		console.log(renderContext.properties.all);
		
		renderContext.properties.all = false;
		
		var nearestShopsScript = byId("nearestShopsScript");

		if(nearestShopsScript != null) {
			var scripts = nearestShopsScript.getElementsByTagName("script");
			var j = scripts.length;
			for (var i = 0; i < j; i++){
				var newScript = document.createElement('script');
				newScript.type = "text/javascript";
				newScript.text = scripts[i].text;
				nearestShopsScript.appendChild(newScript);
			}
			
			cursor_clear();
			
			if (typeof MapStoreLocatorJS != "undefined" ) {
				if (typeof placeStoresOnMap !== "undefined") {
					placeStoresOnMap();
				}
				getFavoritesAndFirstShop();
				//autocenter : si fiche magasin centrer le magasin de la fiche
				if(!MapStoreLocatorJS.autocenter){
					if(MapStoreLocatorJS.centerToFocusShop != null){
						MapStoreLocatorJS.centerToFocusShop();
					}
				}
//				si on a fait une recherche : on centre sur le magasin le plus proche
				else if (SearchShopsJS.SearchFromBar && MapStoreLocatorJS.centerToRightShopSearch != null) {
					if (window.matchMedia) {
						var mediaQuery = window.matchMedia("(max-width: 800px)");
						if (!!mediaQuery && mediaQuery.matches) { 
							$('#listMapToggle')
								.off('click')
								.one('click', function() {									
									toggleMapList();
									MapStoreLocatorJS.repaint();
									MapStoreLocatorJS.centerToRightShopSearch();
									SearchShopsJS.SearchFromBar=false;	
									$('#listMapToggle').click(toggleMapList);
								});
							//return;
						}
					}
					MapStoreLocatorJS.centerToRightShopSearch();
					SearchShopsJS.SearchFromBar=false;
				}
				//sinon autocenter
				else if (MapStoreLocatorJS.centerToRightShop != null){
					MapStoreLocatorJS.centerToRightShop();
				}
			}
		}
		
		dojo.publish("CMPageRefreshEvent");
	}
});

var refreshControllerNearestShopsInTunnelLivraison = wc.render.declareRefreshController({
	id: "nearestShopsInTunnelLivraison_controller",
	renderContext : wc.render.getContextById("searchNearestShops_Context"),
	url: "",
	formId: ""
	,renderContextChangedHandler: function(message, widget) {
		var renderContext = this.renderContext;
		widget.refresh(renderContext.properties);
	}
	,postRefreshHandler: function(widget) {
		dojo.query('script[id^="nearestShopsInTunnelLivraisonScript"]').forEach(function(node, index, nodelist){
			dojo.eval(node.innerHTML);
		  });
		cursor_clear();
		dojo.publish("CMPageRefreshEvent");
	}
});

wc.render.declareContext("StoreHoursPopin_Context",{});
var refreshControllerStoreHoursPopin = wc.render.declareRefreshController({
	id: "storeHoursPopin_controller",
	renderContext : wc.render.getContextById("StoreHoursPopin_Context"),
	url: "",
	formId: ""
		,renderContextChangedHandler: function(message, widget) {
			var renderContext = this.renderContext;
			widget.refresh(renderContext.properties);
		}
	,postRefreshHandler: function(widget) {
		dijit.byId('storeHoursPopin').show();
		dojo.publish("CMPageRefreshEvent");
	}
});

wc.render.declareContext("DriveSchedule_Context",{shopId:'',dateDebut:'',dateFin:'',startDateDriveSchedule:'',endDateDriveSchedule:'',step:'',drivePreSelected:''});
var refreshDriveScheduleController = wc.render.declareRefreshController({
	id:"driveSchedule_controller",
	renderContext: wc.render.getContextById("DriveSchedule_Context"),
	url : "DriveScheduleView",
	formId: "",
	renderContextChangedHandler: function(message, widget) {
		displayProgressBar('driveSchedule_controller');
		widget.refresh(this.renderContext.properties);
	},
	postRefreshHandler: function(widget) {
		dojo.query('script[id^="DriveScheduleScript"]').forEach(function(node, index, nodelist){
			dojo.eval(node.innerHTML);
		});
		hideProgressBar('driveSchedule_controller');
	}
})

