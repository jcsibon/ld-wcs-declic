dojo.require("dojo/request");

SearchShopsJS = {
		
		geoCoder: null,
		favoritesOperationURL: null,
		idMagAddToFavorites: null,
		defaultLatLng: null,
		currLatLng: null,
		SearchFromBar: false,
		userId:"",
		country:"",
		nothingDone: true,
		
		init:function(favoritesOperationURL){
			this.geoCoder = new google.maps.Geocoder();
			this.favoritesOperationURL = favoritesOperationURL;
		},
		
		initCountry:function(country) {
			if(country != null && country != '' && trim(country).length > 0) {
				this.country = country;
			}
		},
		
		addFavoriteMag:function(idMag, isRegistered) {
			this.addOrRemoveFavoriteMag(false, idMag, isRegistered);
		},
		
		removeFavoriteMag:function(idMag, isRegistered) {
			this.addOrRemoveFavoriteMag(true, idMag, isRegistered);
		},
		
		addOrRemoveFavoriteMag: function(yetEpingle, idMag, isRegistered) {
			var self = this;
			if(!submitRequest()) {
				return;
			}
			
			var epinglerClass = (yetEpingle) ? 'epingle' : 'aepingler';
			var aEpinglerClass = (yetEpingle) ? 'aepingler' : 'epingle';
			var currentOperation = (yetEpingle) ? 'remove' : 'add';
			var nextOperation = (yetEpingle) ? 'add' : 'remove';
			
			cursor_wait();
			if (isRegistered) {
				dojo.xhrPost({
					url: this.favoritesOperationURL,
					postData : {
						operation : currentOperation,
						idMag : idMag
					},
					load : function(data, ioargs) {
							SearchShopsJS.updateFavorite(ioargs.args.postData.idMag, epinglerClass, aEpinglerClass, nextOperation, isRegistered, yetEpingle, idMag);
					},
					error : function(error){
						SearchShopsJS.idMagAddToFavorites = null;
						if(console){
							console.debug("Issue occured when tried to " + currentOperation + " mag "+idMag+" to favorites");
						}
						cursor_clear();
					}
				});
			} else {
				$.ajax({
					type: "GET",
					url : getAbsoluteURL() + "/SetDefaultStore",
					data: {"shopId": idMag, "shopName" : yetEpingle, "localisation" : "denied"},
					success: function(event) {
						cursor_clear();
						wc.render.updateContext("HeaderStoreLocation_Context");
						if(!yetEpingle){
							self.updateFavoritesShops(idMag);
							self.updateNearestShops();
						}else{
							self.updateFavoritesShops(idMag);
							self.updateNearestShops();
						}
						MapStoreLocatorJS.setInfoWindowPinState(idMag, !yetEpingle);
						SearchShopsJS.toggleEpinglageHeader(idMag, currentOperation, nextOperation, epinglerClass, aEpinglerClass);
					},
					error: function(errorThrown) {
						cursor_clear();
						console.error(errorThrown);
					}
				});
			}
		},
		
		toggleEpinglageHeader:function(idMag, curentOperation, nextOperation, epinglerClass, aEpinglerClass){
			if($(".epinglage a").size() > 0){
				
				var idCurrentMag = $(".epinglage a").attr('id').replace('storeInfo','');
				//i on travaille sur le magasin affich� ou que le magasin affich� est le magasin �pingl�
				if(idMag === idCurrentMag || $(".epinglage a").attr('class') === "epingle"+idCurrentMag){
					$(".epinglageText").toggle();
					var newOnClick =  $(".epinglage a").attr('onclick').replace(curentOperation, nextOperation);
					$(".epinglage a").attr('onclick', newOnClick);
					var newStyleClass =  $(".epinglage a").attr('class').replace(epinglerClass, aEpinglerClass);
					$(".epinglage a").attr("class", newStyleClass);
				}
			}
		},
		
		updateFavorite: function(myIdMag, epinglerClass,aEpinglerClass, nextOperation,isRegistered,yetEpingle,idMag){
			try {
				dojo.query('.' + epinglerClass+myIdMag).forEach(function(selectedLink){
					selectedLink.className = aEpinglerClass+myIdMag;
					SearchShopsJS.replaceOnClick(selectedLink, 'SearchShopsJS.'+nextOperation+'FavoriteMag(\''+myIdMag+'\','+isRegistered+'); return false;');
					//ECOCEA: on change le libell� du texte: �pingl�/�pingler
					$('#'+epinglerClass+myIdMag +  'Label').hide();
					$('#'+aEpinglerClass+myIdMag +  'Label').show();
				});
				var mapEpingleLink = dojo.byId('mapEpingle'+myIdMag);
				if(mapEpingleLink != undefined){
					SearchShopsJS.replaceOnClick(mapEpingleLink, 'SearchShopsJS.'+nextOperation+'FavoriteMag(\''+myIdMag+'\','+isRegistered+'); return false;');
				}
				if(yetEpingle) {
					if(typeof MapStoreLocatorJS != "undefined"){
						var shopObject = MapStoreLocatorJS.shopsMap['\'' + idMag + '\''];
						if (!!shopObject) {
							shopObject.isEpingle = false;
							MapStoreLocatorJS.closeInfoWindow(shopObject);
							if (shopObject.marker) {
								shopObject.marker.setMap(null);
							}
							MapStoreLocatorJS.addShopToMap(shopObject)
						}
					}
					SearchShopsJS.idMagAddToFavorites = null;
				} else {
					SearchShopsJS.idMagAddToFavorites = '\''+myIdMag+'\'';
				}
				
				SearchShopsJS.updateNearestShops();
				SearchShopsJS.updateFavoritesShops();
				wc.render.updateContext("HeaderStoreLocation_Context");
				
				if(SearchShopsJS.idMagAddToFavorites != null){
					var shopBlockDiv = dojo.byId('shopBlockMain'+SearchShopsJS.idMagAddToFavorites.replace(/'/g,""));
					if(shopBlockDiv != null) {
						var blockPopUpBody = dojo.byId('addedFavoriteShop_shopBlockMain');
						//Copy block
						var newCopyBlock = document.createElement('div');
						newCopyBlock.innerHTML = shopBlockDiv.innerHTML;
						dojo.empty(blockPopUpBody);
						blockPopUpBody.appendChild(newCopyBlock);
						
						//Get Link
						var shopBlockLinkToMag = dojo.byId('shopBlockLinkToMag'+SearchShopsJS.idMagAddToFavorites.replace(/'/g,""));
						var shopLinkPopUpGoToMag = dojo.byId('addedFavoriteShop_voirFiche');
						shopLinkPopUpGoToMag.href = shopBlockLinkToMag.href;
						
						SearchShopsJS.idMagAddToFavorites = null;
						dijit.byId('addedFavoriteShop').show();
					}
				}					
				cursor_clear();
			} catch (e) {
				console.error(e);
				cursor_clear();
			}
		},
		
		replaceOnClick:function(element, newTarget) {
			element.removeAttribute('onclick');
			element.setAttribute('onclick', newTarget);
		},
		
		updateFavoritesShops:function(addedToFavoritesShopId) {
			wc.render.updateContext('searchFavoritesShops_Context', {"lat": "", "lng": "", "shopId": addedToFavoritesShopId});
		},
		
		updateFavoritesShopsFromLatLng:function(latLngObject){
			if (latLngObject != null) {
				wc.render.updateContext('searchFavoritesShops_Context',{"lat": latLngObject.lat, "lng": latLngObject.lng, "shopId": ""});
			}
		},
		
		updateNearestShops:function(all){
			this.updateNearestShopsFromLatLng(SearchShopsJS.currLatLng, all);
		},
		
		updateNearestShopsFromCache: function() {
			if (!this.currLatLng) {
				return;
			}
			var position = new Geolocation().getResolvedPosition();
			if (!!position) {
				wc.render.updateContext('searchNearestShops_Context',{"lat":this.currLatLng.lat, "lng":this.currLatLng.lng, "userLat":position.coords.latitude, "userLng":position.coords.longitude});
			} else {
				wc.render.updateContext('searchNearestShops_Context',{"lat":this.currLatLng.lat, "lng":this.currLatLng.lng, "userLat":"", "userLng":""});
			}
		},
		/* all is a boolean to force find all shops */
		updateNearestShopsFromLatLng:function(latLngObject, all){
			if(latLngObject != null){
				nothingDone=true;
				new Geolocation().getCurrentPosition(
					function success(position){
						nothingDone=false;
						wc.render.updateContext('searchNearestShops_Context',{"lat":latLngObject.lat,"lng":latLngObject.lng, "userLat":position.coords.latitude, "userLng":position.coords.longitude});
					},
					function errorCallback(error){
						nothingDone=false;
						wc.render.updateContext('searchNearestShops_Context',{"lat":latLngObject.lat,"lng":latLngObject.lng, "userLat":"", "userLng":""});
					}, 
					{ timeout:2500, enableHighAccuracy:true }
				).unavailable(function(){
					nothingDone=false;
					wc.render.updateContext('searchNearestShops_Context',{"lat":latLngObject.lat,"lng":latLngObject.lng, "userLat":"", "userLng":""});
				});
					if(nothingDone){
					var t = setTimeout(function(){ //fix IE11/FF : if popup closed nothing launched
						wc.render.updateContext('searchNearestShops_Context',{"lat":latLngObject.lat,"lng":latLngObject.lng, "userLat":"", "userLng":""});
					},6000);
					}
			} 
			if(all) {
				wc.render.updateContext('searchNearestShops_Context',{"lat":null,"lng":null, "userLat":"", "userLng":"","all":true});
			}
		},
		
		/*
		 * Update nearest shops in ajax from address
		 * address : address search
		 */
		doSearchShopFromAddress:function(addressStr,callback){
			addressStr = trim(addressStr);
			this.dismissError();
			addressStr = this.formatAddress(addressStr);
			if(addressStr){
				this.currLatLng = null;
				
				var geocodeRequest = {	
					address : addressStr,  
					componentRestrictions: {
						country: this.country
					}
				};
				
				this.geoCoder.geocode(geocodeRequest,function(results,status){
					if(status == google.maps.GeocoderStatus.OK){
						if(results.length > 1){
							var nearestShopDiv = dojo.byId('nearestShopErrorMessage');
							var msgError = nearestShopDiv.getAttribute('data-affine');
							SearchShopsJS.displayError(msgError);
						}
						if(results.length == 1){
							var latLngObj = {lat: results[0].geometry.location.lat(), lng: results[0].geometry.location.lng()};
							SearchShopsJS.currLatLng = latLngObj;
						}
					}
					else{
						if(console){
							console.debug("Unable to find location from address !");
						}
						var nearestShopDiv = dojo.byId('nearestShopErrorMessage');
						var msgError =  nearestShopDiv.getAttribute('data-noresults');
						SearchShopsJS.displayError(msgError);
					}
					if(callback){
						callback();
					}
				});
			}
		},
		
		displayError:function(msgError){
			var formSearchBoxMaps = dojo.byId('searchBoxMaps');
			var divErrorMsg = dojo.query('#searchBoxMaps + div');
			var labelErrorMsg = dojo.query('#searchBoxMaps + div > label');
			if(formSearchBoxMaps && divErrorMsg && divErrorMsg.length > 0 && labelErrorMsg && labelErrorMsg.length > 0){
				dojo.addClass(formSearchBoxMaps,'error');
				dojo.addClass(divErrorMsg[0],'error');
				labelErrorMsg[0].innerHTML = msgError;
			}
			cursor_clear();
		},
		
		dismissError:function(){
			var formSearchBoxMaps = dojo.byId('searchBoxMaps');
			var divErrorMsg = dojo.query('#searchBoxMaps + div');
			var labelErrorMsg = dojo.query('#searchBoxMaps + div > label');
			if(formSearchBoxMaps && divErrorMsg && divErrorMsg.length > 0 && labelErrorMsg && labelErrorMsg.length > 0){
				dojo.removeClass(formSearchBoxMaps,'error');
				dojo.removeClass(divErrorMsg[0],'error');
				labelErrorMsg[0].innerHTML = '';
			}
		},
		
		formatAddress:function(address){
			if(address){
				return address.replace(/\s/g,'+')
			}
		},
		
		geoLocSearch:function(callback){
			SearchShopsJS.currLatLng = null;
			new Geolocation().getCurrentPosition(function(position) {
				if (MapStoreLocatorJS != "undefined") {
					MapStoreLocatorJS.geoLocCallback(position);
				}
				var pos = {
						lat : position.coords.latitude,
						lng : position.coords.longitude
				};
				SearchShopsJS.currLatLng = pos;
				if (callback) {
					callback();
				}
			}).unavailable(function(){
				if (callback) {
					callback();
				}
			});
		}
}