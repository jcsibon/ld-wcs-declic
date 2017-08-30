var currentShop = null;
var currentShippingMode = '';
var orderDispo = true;
var driveTimeSelected = null;
var retraitLivraison=0;	

function switchTabTunnelCommand(type, publishEvent) {
	$('#alertErrorMessageBottomAddress').html('');

	retraitLivraison=type;
	if(type == 0) { //livraison => retrait
		$('#retraitDuMagasinTab').show();
		$('#livraisonTab').hide();
		$('#boutonTabRetraitMagasin').addClass('selected');
		$('#boutonTabLivraison').removeClass('selected');
		$('#zoneSelectBillingAddress').show();
		if (currentShippingMode == modeDrive && !driveTimeSelected) {
			$('.validateButton').addClass('disabled');
		}
	} else { // retrait => livraison 
		$('#retraitMagasinPlageHoraire').hide();
		$('#retraitDuMagasinTab').hide();
		$('#livraisonTab').show();
		$('#boutonTabLivraison').addClass('selected');
		$('#boutonTabRetraitMagasin').removeClass('selected');
		if($('#useSameAddressForBilling').is(':checked')) {
			$('#zoneSelectBillingAddress').hide();
		}
		$('.validateButton').removeClass('disabled');
		$('#alertErrorMessageBottom').removeClass('bold error');
	}
	
	updateOrderShippingMode(type, publishEvent);
}

function updateOrderShippingMode(type, publishEvent, refreshAddresses) {
	currentShop = null;
	if(type == 0 && typeof(shopForWithdrawalStore) != 'undefined' && shopForWithdrawalStore != null) {
		currentShop = shopForWithdrawalStore;
	} else if(typeof(shopForDeliver) != 'undefined' && shopForDeliver != null){
		currentShop = shopForDeliver;
	}
	
	var shopId = (currentShop != null && typeof(currentShop.strLocId) != 'undefined' && currentShop.strLocId != null && trim(currentShop.strLocId).length > 0) ? currentShop.strLocId : '';
	if(shopId != '' || isCatalogCommand) {
		if(!submitRequest())
			return false;
		cursor_wait();
		
		dojo.xhrPost({
			url: getAbsoluteURL() + "/SwitchOrderShippingMode",				
			handleAs: "json-comment-filtered",
			content: {"type":type,"orderId": orderId, "addressId" : addressIdForShipping, "shopId" : shopId,"isCatalogCommand":isCatalogCommand},
			service: this,
			sync:true,
			load: function(serviceResponse) {
				
				cursor_clear();
				if(serviceResponse.errorCode!=undefined){ //"CMN2010E"
					if(type==0) {
						$('#alertErrorMessageTop').html(noShippingServiceCarryoutMessageTop);
						$('#alertErrorMessageBottom').html(noShippingServiceCarryoutMessageBottom);
					}else{
						$('#alertErrorMessageTop').html(noShippingServiceDeliveryMessageTop);
						$('#alertErrorMessageBottom').html(noShippingServiceDeliveryMessageBottom);						
					}
					$('#zoneAlertErrorMessage').show();
					$('.validateButton').addClass('disabled');
					return;
				}
					
				currentShippingMode = serviceResponse.shippingMode;
				if(currentShippingMode != modeDrive) {
					$('#retraitMagasinPlageHoraire').hide();
					$('#zoneAlertErrorMessage').removeClass('choixHoraire');
				}
				if(serviceResponse.shippingMode == modeTransporter) {
					$('#supplementEtageWarningMessage').show();
					$('.validateButton').removeClass('disabled');
					$('#alertErrorMessageBottom').css('');
				} else {
					$('#supplementEtageWarningMessage').hide();
					if ((serviceResponse.shippingMode == modeDrive && driveTimeSelected)) {
						$('.validateButton').removeClass('disabled');
					}
				}
				if(!isCatalogCommand) {
					getProductsAvailability(currentShop.identifier);
				}
				
				if (publishEvent) {
					dojo.publish("ShippingModeChanged");
				}
                if((publishEvent || refreshAddresses) && (serviceResponse.shippingMode == modeTransporter || serviceResponse.shippingMode == modeColissimo)) {
                     dojo.publish("LivraisonModeChanged");
                }

				var newDataLayer=[];
				dataLayer.forEach(function(element){
					if(element["basket_shipping_method"]!=undefined){
						newDataLayer.push({"basket_shipping_method" : currentShippingMode});			
					}else{
						newDataLayer.push(element);
					}
				});
				dataLayer=newDataLayer;
				
			},
			error: function(errorThrown) {
				cursor_clear();
				console.error(errorThrown);
				
				if (publishEvent) {
					dojo.publish("ShippingModeChanged");
				}
			}
		});
	} else {
		//si aucun magasin trouvé
		resetOrderShippingMode(orderId);
		
		$("div[id^='dispo_']").each(function() {
		  $(this).removeClass('dispo').removeClass('tard').removeClass('non');	
		  $(this).html('');
		});
		
		if(type == 0) {
			$('#alertErrorMessageTop').html(noStoreMessageTop);
			$('#alertErrorMessageBottom').html(noStoreMessageBottom);
		} else {
			$('#alertErrorMessageTop').html(noStoreForAddressMessageTop);
			$('#alertErrorMessageBottom').html(noStoreForAddressMessageBottom);
		}
		$('#zoneAlertErrorMessage').addClass('pasDispo');
		$('#zoneAlertErrorMessage').show()
		
		$('.validateButton').addClass('disabled');
		
		$('#supplementEtageWarningMessage').hide();
		
		if (publishEvent) {
			dojo.publish("ShippingModeChanged");
		}
	}
}

resetOrderShippingMode = function(orderId) {
	if(!submitRequest())
		return false;
	cursor_wait();
	
	dojo.xhrPost({
		url: getAbsoluteURL() + "/ResetOrderShippingMode",				
		handleAs: "json-comment-filtered",
		content: {"orderId": orderId},
		service: this,
		sync:true,
		load: function(serviceResponse) {
			cursor_clear();
		},
		error: function(errorThrown) {
			cursor_clear();
			console.error(errorThrown);
		}
	});
}

getProductsAvailability = function(shopId) {
	if(shopId != null && trim(shopId).length > 0) {
		var shopIds = new Array();
		shopIds.push(shopId);
		if(sizeOfObject(productsInCart) > 0) {
			var datas = {"shopIds" : JSON.stringify(shopIds), "products" : JSON.stringify(productsInCart)};
			stockAvailabilityForTunnelLivraison.setDatas(datas);
			//on peut lancer tout de suite getDispoStock car c'est synchrone
			//timer.reset(function(){stockAvailabilityForTunnelLivraison.askForAvailability();}, 500);
			stockAvailabilityForTunnelLivraison.askForAvailability();
		}
	}
}

onGetProductsAvailabilityForShippingHandler = function(data) {
	$("div[id^='dispo_']").each(function() {
	  $(this).html('');
	  $(this).removeClass('dispo').removeClass('tard').removeClass('non');
	});
	if (data != null && data != '') {
  		var storeKeys = Object.keys(data);
		for (var i = 0; i < storeKeys.length ; i++) {
			var storeKey = storeKeys[i];
			var resultObject = data[storeKey];
			if (resultObject == null || (typeof resultObject == 'string' && resultObject == "ERR")) {
				$("div[id^='dispo_']").each(function() {
					$(this).addClass('dispo').addClass('non');
					$(this).html(messageNonDispo);
				});
				
				$('#alertErrorMessageTop').html(noStockMessageTop);
				$('#alertErrorMessageBottom').html(noStockMessageBottom);
				$('#zoneAlertErrorMessage').addClass('pasDispo');
				$('#zoneAlertErrorMessage').show();
				$('.validateButton').addClass('disabled');
			} else {
				
				var dateDispoOrder = null;
				
				for (partNumber in resultObject) {
					var dateDispo = resultObject[partNumber];
					if (dateDispo == 'today') {
						var today = formatDate(new Date());
						if(dateDispoOrder == null || isLater(today, dateDispoOrder)) {
							dateDispoOrder = today;
						}
						
						$("#container_" + storeKey).addClass("dispo");
						$("div[id^='dispo_" + partNumber +"']")
							.addClass('dispo')
							.html(messageDispo);
						
					} else if (dateDispo == null || trim(dateDispo).length == 0){
						orderDispo = false;
						$("div[id^='dispo_" + partNumber +"']")
							.addClass('dispo non')
							.html(messageNonDispo);
						
					} else {
						dateDispo = formatDate(parseDate(dateDispo));
						var sDateToday = formatDate(new Date());
						
						if (differenceFromDateToNow(dateDispo) <= 0 ){
							dateDispo = sDateToday;
							$("#container_" + storeKey).addClass("dispo");
							$("div[id^='dispo_" + partNumber +"']")
								.addClass('dispo')
								.html(messageDispo);
							
						} else {
							$("div[id^='dispo_" + partNumber +"']")
								.addClass('dispo tard')
								.html(messageDispoLater + ' ' + dateDispo);
						}
						
						if (dateDispoOrder == null || isLater(dateDispo, dateDispoOrder)) {
							dateDispoOrder = formatDate(parseDate(dateDispo));
						}
					}
				}
				
				if(orderDispo) {
					$('#zoneAlertErrorMessage').removeClass('pasDispo');
					$('#zoneAlertErrorMessage').hide();
					if ((currentShippingMode == modeDrive && driveTimeSelected) || (currentShippingMode != modeDrive)) {
						$('.validateButton').removeClass('disabled');
					}
					if(currentShippingMode == modeDrive || currentShippingMode == modeRetrait) {
						var infoMessageBottom = availabilityMessageBottomForRetrait;
					} else {
						if (currentShippingMode != modeColissimo){
							var infoMessageBottom = availabilityMessageBottomForLivraison;
						}else{
							var infoMessageBottom = "";
						}
					}
					if (dateDispoOrder == null) {
						dateDispoOrder = formatDate(new Date());
					}
					
					if (currentShippingMode == modeDrive) {
						showDriveSchedule(currentShop.identifier,dateDispoOrder);
					}
					
					if (differenceFromDateToNow(dateDispoOrder) >= 0 ){
						if(currentShippingMode == modeDrive || currentShippingMode == modeRetrait) {
							var availabilityMessageTop = availabilityMessageTopForRetrait;
						} else {
							var availabilityMessageTop = availabilityMessageTopForLivraison;
						}
						$('#alertErrorMessageTop').html(formatMessage(availabilityMessageTop, dateDispoOrder, currentShop.name));
						$('#alertErrorMessageBottom').html(infoMessageBottom);
						$('#zoneAlertErrorMessage').show();
					}
				} else {
					$('#alertErrorMessageTop').html(noStockMessageTop);
					$('#alertErrorMessageBottom').html(noStockMessageBottom);
					$('#zoneAlertErrorMessage').addClass('pasDispo');
					$('#zoneAlertErrorMessage').show();
					$('.validateButton').addClass('disabled');
				}
			}
		}
	} else {
		$("div[id^='dispo_']").each(function() {
		  $(this).addClass('dispo').addClass('non');
		  $(this).html(messageNonDispo);
		});
		
		$('#alertErrorMessageTop').html(technicalErrorMessageTop);
		$('#alertErrorMessageBottom').html(technicalErrorMessageBottom);
		$('#zoneAlertErrorMessage').addClass('pasDispo');
		$('#zoneAlertErrorMessage').show();
		$('.validateButton').addClass('disabled');
	}
}

function showDriveSchedule(shopId,dateDispoOrder) {
	var sDateDebut = null;
	var sDateFin = null;
	var drivePreSelected = '';
	var driveScheduleStartDate = parseDate(dateDispoOrder);
	var endDriveScheduleDate = parseDate(dateDispoOrder);
	var dateDebut = parseDate(dateDispoOrder);
	var dateFin = parseDate(dateDispoOrder);
	
	dateFin.setDate(dateFin.getDate() + driveScheduleStepDays - 1);
	
	if(typeof(driveScheduleSelected) != 'undefined' && driveScheduleSelected != null && trim(driveScheduleSelected).length > 0) {
		var d = driveScheduleSelected.split('_')[0];
		var datePreSelected = parseCMSDate(d);
		var dateDebut2 = new Date(dateDebut.getTime());
		var dateFin2 = new Date(dateFin.getTime());
		var dateTmp = defineStartDateForDrive(datePreSelected,dateDebut2,dateFin2,driveScheduleStepDays,driveScheduleNbDays);
		if(dateTmp != null) {
			sDateDebut = convertToCMSDate(dateTmp);
			dateFin.setDate(dateTmp.getDate() + driveScheduleStepDays - 1);
			sdateFin = convertToCMSDate(dateFin);
		}
		
		drivePreSelected = driveScheduleSelected;
	}
	
	if(sDateDebut == null && sDateFin == null) {
		sDateDebut = convertToCMSDate(dateDebut);
		sdateFin = convertToCMSDate(dateFin);
	}
	
	endDriveScheduleDate.setDate(endDriveScheduleDate.getDate() + driveScheduleNbDays);
	sDriveScheduleStartDate = convertToCMSDate(driveScheduleStartDate);
	sEndDriveScheduleDate = convertToCMSDate(endDriveScheduleDate);
	
	if(shopId != null && sDriveScheduleStartDate != null && dateFin != null) {
		wc.render.updateContext("DriveSchedule_Context",{shopId:shopId,dateDebut:sDateDebut,dateFin:sdateFin,startDateDriveSchedule:sDriveScheduleStartDate,endDateDriveSchedule:sEndDriveScheduleDate,step:driveScheduleStepDays,drivePreSelected:drivePreSelected});
	}
}

function defineStartDateForDrive(datePreSelected,startDate,endDate,step,nbDays) {
	console.log('defineStartDateForDrive',startDate,endDate);
	if(nbDays > 0 ) {
		if(datePreSelected < startDate) {
			return null;
		} else if(datePreSelected >= startDate && datePreSelected <= endDate) {
			return startDate;
		} else {
			startDate.setDate(endDate.getDate() + 1);
			endDate.setDate(startDate.getDate() + step - 1);
			nbDays -= step + 1;
			return defineStartDateForDrive(datePreSelected,startDate,endDate,step,nbDays);
		}
	}
}

function changeFacturationAddress(addressId) {
	cursor_wait();
	
	var deferred = $.Deferred();
	
	dojo.xhrPost({
		url: getAbsoluteURL() + "/UpdateFacturationAddress",				
		handleAs: "json-comment-filtered",
		content: {"orderId": orderId, "addressId" : addressId},
		service: this,
		sync:true,
		load: function(serviceResponse) {
			cursor_clear();
			$("div[id^='facturation_select_address_']").each(function() {
				  $(this).parent().removeClass('selected').addClass('selectable');
				  $(this).removeClass('selected').addClass('selectable');
			});
			$('#facturation_select_address_' + addressId).parent().addClass('selected').removeClass('selectable');
			$('#facturation_select_address_' + addressId).addClass('selected').removeClass('selectable');
			
			currentAddressBillingId = addressId;
			
			deferred.resolve(serviceResponse);
		},
		error: function(errObj, ioArgs) {
			cursor_clear();
			deferred.reject(errObj);
		}
	});
	
	return deferred.promise();
}

function submitShippingChoice(target,url) {
	//check address completion
	//if livraison, check shippingAddress num/voie
	if($('#livraisonTab').css('display') != 'none'){
		shippingAddressLine0=$("#zoneSelectShippingAddress .selected [id^=blocAddress_addressLine0]");
		shippingAddressLine0=shippingAddressLine0.text();
		if(shippingAddressLine0.trim()==''){
			$('#alertErrorMessageBottomAddress').addClass('bold error');
			$('#alertErrorMessageBottomAddress').html(uncompletedAddressMessageBottom);
			$('#zoneAlertErrorMessage').show();
			return false;
		}
	}
	//TODO also check billing ?
	if(false){ // $('#retraitDuMagasinTab').css('display') != 'none' || !$("#useSameAddressForBilling").is(":checked")){  
		billingAddressLine0=$("#zoneSelectBillingAddress .selected [id^=blocAddress_addressLine0]").text();
		if(billingAddressLine0.trim().length()==0){
			$('#alertErrorMessageBottomAddress').addClass('bold error');
			$('#alertErrorMessageBottomAddress').html(uncompletedAddressMessageBottom);
			$('#zoneAlertErrorMessage').show();
			return false;
		}
	}
	
	if(currentShippingMode == modeDrive) {
		if (!orderDispo) {
			return false;
		}
		if (!driveTimeSelected) {
			$('#alertErrorMessageBottom').addClass('bold error');
			$('html, body').animate( { scrollTop: $('#zoneAlertErrorMessage').offset().top }, 200 );
			return false;
		}
		document.location.href = url + '&driveschedule=' + driveTimeSelected;
		
	} else {
		if ($(target).is('.disabled')) {
			return false;
		}
		document.location.href = url;
	}
	return false;
}

function useSameAddressForBillingClickHandler(target) {
	if($(target).is(':checked')) {
		if(currentAddressBillingId != addressIdForShipping) {
			changeFacturationAddress(addressIdForShipping);
			currentAddressBillingId = addressIdForShipping;
		}
		$('#zoneSelectBillingAddress').hide();
	} else {
		$('#zoneSelectBillingAddress').show();
	}
}

function switchRetraitMagasinZoneDefaultSelectMagasin(type) {
	if(type == 0) {
		$('#retraitMagasinZoneDefaultMagasin').show();
		$('#retraitMagasinZoneSelectMagasin').hide();
	} else {
		$('#retraitMagasinZoneDefaultMagasin').hide();
		$('#retraitMagasinZoneSelectMagasin').show();
	}
}

function changeDefaultMagasinForRetraitMagasin(target) {
	var shopName = $(target).attr("data-shop-name");
	var shopId = $(target).attr("data-shop-id");
	if(!submitRequest())
		return false;	
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

dojo.subscribe("ErrorOnGetDriveSchedule",function(data){
	$('#retraitMagasinPlageHoraire').hide();
	$('#alertErrorMessageTop').html(reservationCreneauDriveError);
	$('#alertErrorMessageBottom').html(noStockMessageBottom);
	$('#zoneAlertErrorMessage').addClass('pasDispo');
	$('#zoneAlertErrorMessage').removeClass('choixHoraire');
	$('#zoneAlertErrorMessage').show();
	$('.validateButton').addClass('disabled');
});

dojo.subscribe("ShippingModeChanged", function(){
	wc.render.updateContext('OrderSummaryContext');
});

dojo.subscribe("LivraisonModeChanged", function(){
     wc.render.updateContext('ShippingAddressContext');
});

dojo.subscribe("SuccessOnGetDriveSchedule",function(data){
	$('#zoneAlertErrorMessage').addClass('choixHoraire');
	$('#alertErrorMessageBottom').html(selectCreneauDriveMessageBottom);
	$('#retraitMagasinPlageHoraire').show();
	dijit.byId('driveScheduleCarousel').resize();
});

dojo.topic.subscribe('DriveTime_Selected',function(driveTimeSelect) {
	driveTimeSelected = driveTimeSelect;
	$('#alertErrorMessageBottom').removeClass('bold error');
	if (orderDispo) {
		$('.validateButton').removeClass('disabled');
	}
});

