MapStoreLocatorJS = {

	zoomDefault : 7,
	centerDefLat : 46.71,
	centerDefLon : 1.72,

	isRegisterUser: false,
	logonFormUrl: null,
	
	directionsRender: null,
	directionsLabel: null,
	
	styles: [{
		featureType: "poi", 
		elementType: "labels", 
		stylers: [{ 
			visibility: "off" }]
	}],

	currShopIdOpened: null,
	autocenter: true,
	
	placeStoresOnMapDone: false,
	
	map : null,
	directionsService: null,
	shopsMap: new Object(),
	prefixImageUrl : null,
	imagePinnedIcon: '/pinned.png',
	imageToPinIcon: '/mapsToPinBlock.png',
	imagePin : '/storeLocatorPinBlock.png',
	gmapLocatorPicto : '/gmapLocatorPicto.png',
	imageDrive : '/logoDrive.png',
	imagePinObject : {
		size : new google.maps.Size(24, 37),
		origin : new google.maps.Point(0, 0),
		anchor : new google.maps.Point(12, 37)
	},

	imageGeoLoc : '/mapsLocalisation.png',
	imageGeoLocObject : {
		size : new google.maps.Size(18, 18),
		origin : new google.maps.Point(0, 0),
		anchor : new google.maps.Point(12, 12)
	},

	shapePinObject : {
		coords : [ 0, 11, 12, 37, 24, 11, 12, 0 ],
		type : 'poly'
	},
	shapeGeoLocObject : {
		coords : [ 0, 0, 0, 18, 18, 18, 18, 0 ],
		type : 'poly'
	},

	markerGeoLoc : null,

	init : function(id, zoom, centerLat, centerLon) {
		var mapOptions = {
			zoom : (zoom == undefined ? this.zoomDefault : zoom),
			center : (centerLat == undefined || centerLon == undefined ? new google.maps.LatLng(
					this.centerDefLat, this.centerDefLon)
					: new google.maps.LatLng(centerLat, centerLon)),
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			disableDefaultUI : true,
			styles: [{
				featureType: "poi", 
				elementType: "labels", 
				stylers: [{ 
					visibility: "off" }]
			},
			{
			featureType: "transit", 
			elementType: "labels", 
			stylers: [{ 
				visibility: "off" }]
			}]
		};
		this.map = new google.maps.Map(document.getElementById(id), mapOptions);
		this.map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(this.createControlsZoneMap(this.map));
		this.map.controls[google.maps.ControlPosition.TOP_RIGHT].push(this.createControlDirectionsZone());
		this.directionsService = new google.maps.DirectionsService();
	},

	setPrefixImageUrl : function(prefixImageUrl) {
		this.prefixImageUrl = prefixImageUrl;
		this.imagePinObject.url = this.prefixImageUrl + this.imagePin;
		this.imageGeoLocObject.url = this.prefixImageUrl + this.imageGeoLoc;
	},
	
	setDirectionsLabel : function(directionsLabel) {
		this.directionsLabel = directionsLabel;
	},

	addShop:function(shopObject){
		var oldShop = this.shopsMap['\''+shopObject.strLocId+'\''];
		var wasOpened = false;
		if(oldShop != undefined){
			if(this.isInfoWindowOpened(oldShop.infoWindow)){
				wasOpened = true;
			}
			this.removeShop(oldShop);
		}
		this.shopsMap['\''+shopObject.strLocId+'\''] = shopObject;
		this.addShopToMap(shopObject);
		if(wasOpened){
			this.openInfoWindow(shopObject);
		}
	},
	
	isInfoWindowOpened:function(infoWindow){
		if(infoWindow != undefined){
			var map = infoWindow.getMap();
			return (map != null && typeof map !== undefined);
		}
		return false;
	},
	
	addShopToMap:function(shopObject){
		var LatLngObj = new google.maps.LatLng(shopObject.lat, shopObject.lng);

		var marker = new google.maps.Marker({
			position : LatLngObj,
			map : this.map,
			icon : this.imagePinObject,
			shape : this.shapePinObject,
			anchorPoint : new google.maps.Point(0, 11),
			title : shopObject.label
		});
		shopObject.marker = marker;
		var href = '#';
		var funcName = (shopObject.isEpingle) ? 'remove' : 'add';
		var script = 'SearchShopsJS.'+funcName+'FavoriteMag(\''+shopObject.strLocId+'\','+this.isRegisterUser+'); return false;';
		var scriptDirection = 'MapStoreLocatorJS.openPopupDirections(' +
			'\''+shopObject.seoUrl+'\',' +
			'\''+shopObject.strLocId+'\',' +
			'\''+shopObject.label.replace(/\'/g, '\\\'')+'\',' +
			'\''+shopObject.type+'\',' +
			'\''+shopObject.address1.replace(/\'/g, '\\\'')+'\',' +
			'\''+shopObject.cp+'\',' +
			'\''+shopObject.ville.replace(/\'/g, '\\\'')+'\',' +
			'\''+shopObject.phone+'\',' +
			'\''+shopObject.isDrive+'\',' +
			'\''+shopObject.lat+'\',' +
			'\''+shopObject.lng+'\');';
		
		var img="";
		
		if (shopObject.isDrive==true){
			img=this.imageDrive;
		}

		var infoWindow = new google.maps.InfoWindow({
			content : '<div class="infoPin">' + 
							'<h3 >' + '<div class="truncate infoPin-title"><a class="hover_underline" title="'+shopObject.label+'" href="'+shopObject.seoUrl+'">' +shopObject.label + '</a></div></h3>' + 
							'<div class="infoPin-description">' +
								'<div class="infoPin-description-address-block">' +
									'<span class="infoPin-picto storeLocator-picto"></span>'+
									'<div class="infoPin-description-address">' +
										'<p>' + shopObject.address1 + '</p>' +
										'<p>' + shopObject.complAdr1 + '</p>' + 
										'<p>' + shopObject.complAdr2 + '</p>' + 
										'<p>' + shopObject.complAdr3 + '</p>' + 
										'<p>' + shopObject.cp + ' ' + shopObject.ville + '</p>' + 
									'</div>' +
								'</div>' +
								'<div class="infoPin-description-phone-block">' +
									'<span class="infoPin-picto phone-picto"></span>'+
									'<div class="infoPin-description-phone">' +
										'<p>' + shopObject.phone.replace(/(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/, "$1 $2 $3 $4 $5") + '</p>' + 
									'</div>' +
								'</div>' +
							'</div>' +
							'<div class="infoPin-links print-hidden new-style">' + 
								'<div class="infoPin-link print-hidden">' + 
									'<a class="shop-infoPin-button button-light-gray" onclick="'+scriptDirection+'" >' +
									 'Itinéraire' +
									 '</a>'+
								'</div>' +
								'<div class="infoPin-link print-hidden">' + 
									'<a class="shop-infoPin-button button-primary" href="' + shopObject.seoUrl + '" id="mapEpingle' + shopObject.strLocId + '"' +
										(shopObject.isEpingle ? 'class="favorite"' : '') + '>' +	 
										'<span>' +
											'Plus d\'infos' +
										'</span>' + 
									'</a>' +
								'</div>' +
							'</div>' +
							'<div class="transparentPin print-hidden">' + 
							'</div>' + 
						'</div>',
			maxWidth: 300
		});
		/*'<div class="goTo">' + 
								'<a href="'+shopObject.seoUrl+'"><img src="' + this.prefixImageUrl + '/mapsGoTo.png" alt=""></a>' + 
							'</div>' + */
		
		shopObject.infoWindow = infoWindow;
		
		google.maps.event.addListener(marker, 'click', function() {
			MapStoreLocatorJS.closeInfoWindows();
			MapStoreLocatorJS.openInfoWindow(shopObject);
		});
		
		google.maps.event.addListener(infoWindow,'closeclick',function(){
			marker.setVisible(true);
		});
	},
	
	closeInfoWindows : function() {
		for (var shop in this.shopsMap) {
			this.closeInfoWindow(this.shopsMap[shop]);
		}
	},
	closeInfoWindow : function(shopObject) {
		if (shopObject.infoWindow != undefined) {
			shopObject.infoWindow.close();
			shopObject.marker.setVisible(true);
			if(this.currShopIdOpened == '\''+shopObject.strLocId+'\''){
				this.currShopIdOpened = null;
			}
		}
	},
	openInfoWindow : function(shopObject) {
		if (this.map == null || this.map == undefined || shopObject == null || shopObject == undefined) {
			console.log('return');
			return;
		}
		if (shopObject.infoWindow != undefined & shopObject.marker != undefined) {
			//shopObject.marker.setVisible(false);
			shopObject.infoWindow.open(this.map, shopObject.marker);
			this.currShopIdOpened = '\''+shopObject.strLocId+'\'';
			this.map.setCenter(shopObject.marker.getPosition());
			MapStoreLocatorJS.setInfoWindowPinState(shopObject.strLocId, shopObject.isEpingle);
		}
	},

	setFavoriteStore: function(idMag) {
		if (!idMag) {
			return;
		}

		var $storeHeaderAnchor = $('[id^=storeInfo]');
		if($storeHeaderAnchor.length > 0){
			var epingleClass = $storeHeaderAnchor.attr('class').replace(/^epingle/g, 'aepingler');
			$storeHeaderAnchor.attr('class', epingleClass);
			
			$storeHeaderAnchor = $('#storeInfo' + idMag);
			$storeHeaderAnchor.attr('class', 'epingle'+idMag);
			$storeHeaderAnchor.parent().siblings('[id^=aepingler]').hide();
			$storeHeaderAnchor.parent().siblings('[id^=epingle]').show();
		}

		for (var shop in this.shopsMap) {
			if (this.shopsMap.hasOwnProperty(shop)) {
				var shopId = shop.replace(/['"]+/g, '');
				if (shopId === idMag) {
					this.setInfoWindowPinState(shopId, true);
					if(!this.isRegisterUser){
						this.shopsMap[shop].isEpingle = true;
					}
				} else {
					this.setInfoWindowPinState(shopId, false);
					if(!this.isRegisterUser){
						this.shopsMap[shop].isEpingle = false;
					}
				}
			}
		}
	},

	setInfoWindowPinState: function(shopId, isEpingle) {
		/*var $anchor = $('#mapEpingle' + shopId),
			$icon = $anchor.children('img'),
			$texte = $anchor.children('span');
		if (isEpingle) {
			$anchor.addClass('favorite');
			$anchor.attr('onclick', "SearchShopsJS.removeFavoriteMag('" + shopId + "',"+ this.isRegisterUser +" ); return false;");
			$icon.attr('src', this.prefixImageUrl + this.imagePinnedIcon);
			$texte.html('D&eacute;s&eacute;lectionner ce magasin');
		} else {
			$anchor.attr('onclick', "SearchShopsJS.addFavoriteMag('" + shopId + "', "+ this.isRegisterUser +"); return false;");
			$anchor.removeClass('favorite');
			$icon.attr('src', this.prefixImageUrl + this.imageToPinIcon);
			$texte.html('Choisir ce magasin');
		}*/
	},
	
	removeShopById:function(idMag){
		var shopObject = this.shopsMap[idMag];
		this.removeShop(shopObject);
	},
	
	removeShop:function(shopObject){
		if(shopObject != undefined){
			delete this.shopsMap['\''+shopObject.strLocId+'\''];
			this.closeInfoWindow(shopObject);
			if (shopObject.marker) {
				shopObject.marker.setMap(null);
			}
		}
	},
	
	clearShopsFromMaps : function() {
		for (var shop in this.shopsMap) {
			this.removeShop(this.shopsMap[shop]);
		}
	},

	createControlsZoneMap : function(map) {
		var divMain = document.createElement('div');
		divMain.className = 'btnContainer btnControls';

		var divGeoLoc = document.createElement('div');
		divGeoLoc.className = 'btn';

		var img = document.createElement('img');
		img.src = this.prefixImageUrl + '/gmapLocatorPicto.png'
		divGeoLoc.appendChild(img);
		
		var divZoomContainer = document.createElement('div');
		divZoomContainer.className = 'btn-container';

		var divZoomPlus = document.createElement('div');
		divZoomPlus.className = 'btn';
		divZoomPlus.innerHTML = '+';
		
		var divSeparator = document.createElement('div');
		divSeparator.className = 'horizontal-separator';

		var divZoomMoins = document.createElement('div');
		divZoomMoins.className = 'btn';
		divZoomMoins.innerHTML = '-';

		divMain.appendChild(divGeoLoc);
		divZoomContainer.appendChild(divZoomPlus);
		divZoomContainer.appendChild(divSeparator);
		divZoomContainer.appendChild(divZoomMoins);
		divMain.appendChild(divZoomContainer);

		google.maps.event.addDomListener(divZoomPlus, 'click', function() {
			MapStoreLocatorJS.zoomIn();
		});

		google.maps.event.addDomListener(divZoomMoins, 'click', function() {
			MapStoreLocatorJS.zoomOut();
		});

		var updatePosition = function() {
			var geoloc = new Geolocation().askForPosition();
			geoloc.getCurrentPosition(function(position) {
				MapStoreLocatorJS.geoLocCallback(position);
				var latLng = {
					lat : position.coords.latitude,
					lng : position.coords.longitude
				}
				SearchShopsJS.currLatLng = latLng;
				SearchShopsJS.SearchFromBar = true;
				SearchShopsJS.updateNearestShops();
			});
		};
		
		google.maps.event.addDomListener(divGeoLoc, 'click', function() {
			updatePosition();
		});
		
		var storeLocatorSearchBox = document.getElementById("storeLocatorSearchBox");
		/* If the storeLocatorSearchBox exists -> we are in the store locator page */
		if(storeLocatorSearchBox != null) {
			/* Create zone locator button in the search bar */
			var divGeoLocSearchBar = document.createElement('div');
			divGeoLocSearchBar.className = 'searchBar-button new-style';
			divGeoLocSearchBar.id = 'locationButtonSearchBar';
			
			var imgSearchBox = document.createElement('img');
			imgSearchBox.src = this.prefixImageUrl + '/gmapLocatorPicto.png'
			divGeoLocSearchBar.appendChild(imgSearchBox);
			
			storeLocatorSearchBox.appendChild(divGeoLocSearchBar);
			
			/* Get the postition of the user and update the map */
			google.maps.event.addDomListener(divGeoLocSearchBar, 'click', function() {	
				updatePosition();
			});
		}	
		
		return divMain;
	},
	
	createControlDirectionsZone:function(){
		var divMain = document.createElement('div');
		divMain.className = 'btnContainer';

		var divDirections = document.createElement('div');
		divDirections.className = 'directionContainer button btnDirections';
		
		var spanDirLabel = document.createElement('span');
		spanDirLabel.id = 'btnDirectionsLabel';
		spanDirLabel.innerHTML = this.directionsLabel;
		divDirections.appendChild(spanDirLabel);
		
		var durationp = document.createElement('p');
		durationp.id = 'durationDirection';
		divDirections.appendChild(durationp);
		
		google.maps.event.addDomListener(divDirections,'click',function(){
			showPopup('popupDirections');
			if(MapStoreLocatorJS.currShopIdOpened != null){
				MapStoreLocatorJS.openInfoWindowById(MapStoreLocatorJS.currShopIdOpened);
				var shopObject = MapStoreLocatorJS.shopsMap[MapStoreLocatorJS.currShopIdOpened];
				MapStoreLocatorJS.openPopupDirections(shopObject.seoUrl, shopObject.strLocId, shopObject.label, shopObject.type, shopObject.address1, shopObject.cp, shopObject.ville, shopObject.phone, shopObject.isDrive, shopObject.lat, shopObject.lng);
			}
		});
		
		
		divMain.appendChild(divDirections);
		
		return divMain;
	},
	
	zoomIn : function() {
		this.map.setZoom(this.map.getZoom() + 1);
	},
	zoomOut : function() {
		this.map.setZoom(this.map.getZoom() - 1);
	},
	geoLocCallback : function(position) {
		if (this.map == null) {
			return;
		}
		if (this.markerGeoLoc != null && this.markerGeoLoc != undefined) {
			this.markerGeoLoc.setMap(null);
			this.markerGeoLoc = null;
		}
		var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
		this.markerGeoLoc = new google.maps.Marker({
			position : pos,
			map : this.map,
			icon : this.imageGeoLocObject,
			shape : this.shapeGeoLocObject
		});
		this.map.setCenter(pos);
		this.map.setZoom(12);
	},
	
	centerToShopById:function(shopId){
		var shopObject = this.shopsMap[shopId];
		this.centerToShop(shopObject);
	},
	
	centerToShop:function(shopObject){
		if (this.map == null) {
			return;
		}
		if(shopObject != undefined) {
			var pos = new google.maps.LatLng(shopObject.lat,shopObject.lng);
			this.map.setCenter(pos);
		}
	},
	centerToShopByIds:function(shopId1,shopId2,shopId3){
		var nb=1;
		var shopObject1 = this.shopsMap[shopId1];
		var lat=shopObject1.lat;
		var lng = shopObject1.lng;
		if (shopId2!=''){
			var shopObject2 = this.shopsMap[shopId2];
			nb++;
			lat=lat+shopObject2.lat;
			lng=lng+shopObject2.lng;
			if (shopId3!=''){
				var shopObject3 = this.shopsMap[shopId3];
				nb++;
				lat=lat+shopObject3.lat;
				lng=lng+shopObject3.lng;
			}
		}
		var pos = new google.maps.LatLng(lat/nb,lng/nb);
		this.openInfoWindow(shopObject1);
		this.map.setCenter(pos);
		if(nb>1) this.map.setZoom(12);
		else		this.map.setZoom(14);
	},
	
	openInfoWindowById:function(idMag){
		if(typeof idMag == "string" && idMag.indexOf('\'') != 0) {
			idMag = "\'"+idMag+"\'";
		}

		this.closeInfoWindows();
		var shopObject = this.shopsMap[idMag];
		this.openInfoWindow(shopObject);
	},
	
	setZoom:function(zoom) {
		if (this.map == null) {
			return;
		}
		this.map.setZoom(zoom);
	},
	
	/*
	 * Center to first favorite/ nearest shop or center of France
	 */
	centerToRightPos: null,
	
	
	launchDirections:function(origin,destination){
		var dirRequest = {
				origin : origin,
				destination : destination,
				travelMode: google.maps.DirectionsTravelMode.DRIVING,
				unitSystem: google.maps.UnitSystem.METRIC
		}
		dojo.byId('durationDirection').innerHTML = '';
		this.directionsService.route(dirRequest,function(response,status){
			if(status == google.maps.DirectionsStatus.OK){
				if(MapStoreLocatorJS.directionsRender != null){
					MapStoreLocatorJS.directionsRender.setMap(null);
					MapStoreLocatorJS.directionsRender = null;
				}
				var duration = response.routes[0].legs[0].duration.text;
				dojo.byId('durationDirection').innerHTML = duration;
				MapStoreLocatorJS.directionsRender = new google.maps.DirectionsRenderer({
					map : MapStoreLocatorJS.map,
					directions : response,
					suppressMarkers : true,
					suppressInfoWindows : true,
					polylineOptions : {
						//ligne d'itin�raire en pointill� 
						strokeOpacity: 0,
						strokeColor : "#cd0018",
						icons: [{
						      icon: {
						    	  strokeOpacity: 1,
						          path: 'M 0,-1 0,1',
						          scale: 5,
						          strokeWeight: 4
						      },
						      offset: '0',
						      repeat: '25px'
						    }],
					}
				});
				
			}
			else{
				if(console){
					console.debug("Unable to get directions !");
				}
			}
		});
	},
	
	createDivShopBlock:function(seoUrl, shopId, shopName, shopType, address, zipCode, city, phone, isDrive) {
		var newBlock = document.createElement('div');
		var sHtml = '<h3>' + '<div class="truncate"><a title="'+shopName+'" id="shopBlockLinkToMag' + shopId + '" href="' + seoUrl +'">' + shopName + '</a></div></h3>';
		sHtml += '<p>' + shopType; 
		if(isDrive) {
			sHtml += '&nbsp;<img src="'+this.prefixImageUrl+this.imageDrive + '">';
		}
		sHtml += '</p>';
		sHtml += '<p>' + address + '</p>';
		sHtml += '<p>' + zipCode + ' ' + city + '</p>';
		sHtml += '<p>' + phone + '</p>';
		newBlock.innerHTML = sHtml;
		return newBlock;
	},
	
	openPopupDirections: function(shopSeoUrl, shopIdDest, shopName, shopType, address, zipCode, city, phone, isDrive, latDest,lngDest){
		var shopDescAddress = address + ' ' + zipCode + ' ' + city;
		
		// Toggle map mode on mobile device
		if(dojo.byId('mapShopContainerRow')!=null){
			if(dojo.byId('mapShopContainerRow').className == 'row mobile-maps-hidden'){
				toggleMapList();
			}
		}
		
		//Fill popup shopBlock
		var blockPopUpBody = dojo.byId('popupDirections_shopBlockMain');
		blockPopUpBody.removeChild(blockPopUpBody.firstChild);
		var newCopyBlock = MapStoreLocatorJS.createDivShopBlock(shopSeoUrl,shopIdDest,shopName,shopType,address,zipCode,city,phone,isDrive);
		blockPopUpBody.appendChild(newCopyBlock);
		
		//Fill form : SearchShopsJS.currLatLng for origin or empty
		if(!document.DirectionsForm.departAddress.value){			
			if(typeof SearchShopsJS != "undefined"){
				SearchShopsJS.geoLocSearch(function(){
					MapStoreLocatorJS.geoCoderReverseForPopup();
				});
			}
		}

		//lat,lng & address for dest
		document.DirectionsForm.arriveeLat.value = latDest
		document.DirectionsForm.arriveeLng.value = lngDest
		document.DirectionsForm.arriveeAddress.value = shopDescAddress;
		
		checkInputDirections();
		
		// Open popup & info window
		showPopup('popupDirections');
		MapStoreLocatorJS.openInfoWindowById('\''+shopIdDest+'\'');
	},
	
	geoCoderReverseForPopup: function(){
		document.DirectionsForm.departLat.value = SearchShopsJS.currLatLng.lat;
		document.DirectionsForm.departLng.value = SearchShopsJS.currLatLng.lng;
		var geoCoder = new google.maps.Geocoder();
		geoCoder.geocode({'latLng': new google.maps.LatLng(SearchShopsJS.currLatLng.lat,SearchShopsJS.currLatLng.lng)},function(results,status){			
			if(status == google.maps.GeocoderStatus.OK){
				if(results[1]) {
					document.DirectionsForm.departAddress.value = results[1].formatted_address;
				} else {
					document.DirectionsForm.departAddress.value = SearchShopJS.currLatLng.lat+','+SearchShopJS.currLatLng.lng;
				}
			}
			else{
				document.DirectionsForm.departAddress.value = SearchShopJS.currLatLng.lat+','+SearchShopJS.currLatLng.lng;
			}
			if(checkInputDirections){
				checkInputDirections();
			}
		});
	},
	
	repaint: function() {
		if (this.map == null) {
			return;
		}
		google.maps.event.trigger(this.map, 'resize');
		this.map.setZoom(14);
	}
}
