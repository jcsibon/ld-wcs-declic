changeQuantityItemInCart = function(element, productSKU, orderItemId, value, coeff) {
	
	console.log(element);
	
	var qtyId = productSKU+'_'+orderItemId;
	
	elementId="quantity_"+qtyId;
	var quantityInput = document.getElementById(elementId);
	
	if(quantityInput != null) {
		var curQty = parseInt(quantityInput.value);
		var surfaceInput = document.getElementById("surface_"+qtyId);
		
		// Remove on click inline handler
		if (element) {
			element.onclick = null;
			$(element).attr('onclick', null);
		}
		
		if(value > 0) {
			// bouton +
			quantityInput.value = curQty + value;
			$("#" + elementId).trigger("change");
			if(surfaceInput!=undefined){
				surfaceInput.value=quantityInput.value*coeff;
			}
		} else {
			// bouton -
			if(curQty > 1) {
				quantityInput.value = curQty + value;
				$("#" + elementId).trigger("change");
				if(surfaceInput!=undefined){
					surfaceInput.value=quantityInput.value*coeff;
				}
			}
			else{
				//Suppression de l'item car quantité à zéro
				setCurrentId('WC_OrderItemDetailsf_links_remove_item_'+orderItemId);
				CheckoutHelperJS.deleteFromCart(orderItemId);
			}
		}
	}
};



applyCodeAvantage = function(validateCouponURL) {
	var coupon = $('#codeAvantageInput').val();
	var parameters = {};
	parameters.codePromo = coupon;
	parameters.action= "Add";

	dojo.xhrPost({
		url: validateCouponURL,				
		handleAs: "json-comment-filtered",
		content: parameters,
		service: this,
		sync:true,
		load: handleApplyCodeAvantageOnSuccess,
		error: function(errObj,ioArgs) {
			//$('#codeAvantageErrorMsg').html(errObj.errorMessage);
			$('#codeAvantageErrorMsg').html(codeAvantageErreur['ERROR_TECHNIQUE']);
			$('#codeAvantageErrorMsg').show();
		}
	});
}

checkCodeAvantage = function(validateCouponURL) {
	var coupon = $('#codeAvantageInput').val();
	var parameters = {};
	parameters.codePromo = coupon;
	parameters.action= "Validate";
	
	dojo.xhrPost({
		url: validateCouponURL,				
		handleAs: "json-comment-filtered",
		content: parameters,
		service: this,
		sync:true,
		load: handleCheckCodeAvantageOnSuccess,
		error: function(errObj,ioArgs) {
			$('#codeAvantageErrorMsg').html(codeAvantageErreur['ERROR_TECHNIQUE']);
			$('#codeAvantageErrorMsg').show();
		}
	});
}

handleApplyCodeAvantageOnSuccess = function(serviceResponse, ioArgs) {
	if(serviceResponse.status == 'error' || serviceResponse.errorMessageKey != null) {
		
		if (serviceResponse.status == 'error') {
			var messageErreur = codeAvantageErreur['ERROR_TECHNIQUE'];
			if(typeof(codeAvantageErreur[serviceResponse.errorCode]) != 'undefined' && codeAvantageErreur[serviceResponse.errorCode] != null) {
				messageErreur = codeAvantageErreur[serviceResponse.errorCode];
			}
			if(serviceResponse.errorCode == 'NOT_VALID_YET') {
				messageErreur = formatMessage(messageErreur,serviceResponse.data.debutValidite);
			}
		} else {
			var messageErreur = codeAvantageErreur['ERROR_TECHNIQUE'];
			if(typeof(codeAvantageErreur[serviceResponse.errorMessageKey]) != 'undefined' && codeAvantageErreur[serviceResponse.errorMessageKey] != null) {
				messageErreur = codeAvantageErreur[serviceResponse.errorMessageKey];
			}
		}

		$('#codeAvantageErrorMsg').html(messageErreur);
		$('#codeAvantageErrorMsg').show();
		
		//réactiver le champ input pour le coupon, afficher le bouton Ajouter, masquer le bouton Supprimer
		$('#codeAvantageInput').prop('disabled', false);
		$('#codeAvantageInput').addClass('error');
		$('#addCodePromoButton').show();
		$('#removeCodePromoButton').hide();
		
		var closeIcon = $("<span/>", {
		  "class": "shoppingcart-icons shoppingcart-icon-delete",
		});
		$("#codeAvantageErrorMsg").prepend(closeIcon);
		
	} else {
		if(serviceResponse.PromoWCS != undefined && serviceResponse.PromoWCS == true){
			refreshPromotionCode();
		}
		
		var codePromo = serviceResponse.codePromo.replace(/ /g,'-');
		$('#codeAvantageErrorMsg').hide();
		var orderId = serviceResponse.orderId;
		
		// le coupon est de type RATE_ITEM
		if(typeof(serviceResponse.data.orderItemsId) != 'undefined' && serviceResponse.data.orderItemsId != null) {
			//mettre à jour
			//coupon description
			var type = serviceResponse.data.adjustType;
			var description = eval('coupon_' + type + '_Description');
			if(type == 'AMOUNT') {
				if(isPro) {
					description = formatMessage(description,serviceResponse.data.adjustAmount_HT + env_currency_symbol);
				} else {
					description = formatMessage(description,serviceResponse.data.adjustAmount_TTC + env_currency_symbol);
				}
				
			} else {
				description = formatMessage(description,serviceResponse.data.adjustValue + '%');
			}
			//update IHM page tunnel etape1
			if($('#externalAdjustOrderItemLabel_' + codePromo + '_' + serviceResponse.orderId).length) {
				$('#externalAdjustOrderItemLabel_' + codePromo + '_' + serviceResponse.orderId).html(description);
			} else {
				$('#divInfoOrderItem_' + serviceResponse.data.orderItemsId).append('<p id="externalAdjustOrderItemLabel_' + codePromo + '_' + serviceResponse.orderId + '" class="promo">' + description + '</p>');
			}
		}
		
		//désactiver champ input pour le code promo, afficher le bouton Supprimer, masquer le bouton Ajouter
		$('#codeAvantageInput').prop('disabled', true);
		$('#codeAvantageInput').removeClass('error');
		$('#addCodePromoButton').hide();
		$('#removeCodePromoButton').show();
		
		wc.render.updateContext('OrderSummaryContext');
	}
}

removeCodeAvantage = function(validateCouponURL) {
	var coupon = $('#codeAvantageInput').val();
	var parameters = {};
	parameters.codePromo = coupon;
	parameters.action= "Remove";

	dojo.xhrPost({
		url: validateCouponURL,				
		handleAs: "json-comment-filtered",
		content: parameters,
		service: this,
		sync:true,
		load: handleRemoveCodeAvantageOnSuccess,
		error: function(errObj,ioArgs) {
			$('#codeAvantageErrorMsg').html(codeAvantageErreur['ERROR_TECHNIQUE']);
			$('#codeAvantageErrorMsg').show();
		}
	});
}

/**
 * Méthode callback pour la suppression du coupon. 
 * Mettre à jour les prix initiaux, réactiver le champs input du coupon, afficher le bouton Ajouter, cacher le bouton Supprimer
 * @param serviceResponse
 * @param ioArgs
 */
handleRemoveCodeAvantageOnSuccess = function(serviceResponse, ioArgs) {
	if(serviceResponse.status == 'error') {
		var messageErreur = codeAvantageErreur['ERROR_TECHNIQUE'];
		if(typeof(codeAvantageErreur[serviceResponse.errorCode]) != 'undefined' && codeAvantageErreur[serviceResponse.errorCode] != null) {
			messageErreur = codeAvantageErreur[serviceResponse.errorCode];
		}
		$('#codeAvantageErrorMsg').html(messageErreur);
		$('#codeAvantageErrorMsg').show();
		
	} else if(serviceResponse.errorMessageKey != null) {
		var messageErreur = codeAvantageErreur['ERROR_TECHNIQUE'];
		if(typeof(codeAvantageErreur[serviceResponse.errorMessageKey]) != 'undefined' && codeAvantageErreur[serviceResponse.errorMessageKey] != null) {
			messageErreur = codeAvantageErreur[serviceResponse.errorMessageKey];
		}
		$('#codeAvantageErrorMsg').html(messageErreur);
		$('#codeAvantageErrorMsg').show();
		
	} else {
		if(serviceResponse.PromoWCS != undefined && serviceResponse.PromoWCS == true){
			refreshPromotionCode();
		}
		var codePromo = serviceResponse.codePromo.replace(/ /g,'-');
		
		// le coupon supprimé est de type RATE_ITEM
		if(serviceResponse.data != null && serviceResponse.data.orderItemsId != null) { 
			//Supprimer le libellé du coupon pour l'orderItem
			if ($('#externalAdjustOrderItemLabel_' + codePromo + '_' + serviceResponse.orderId).length) {
				$('#externalAdjustOrderItemLabel_' + codePromo + '_' + serviceResponse.orderId).remove();
			}
			//Remettre le prix initial
//			$('#orderItemTotalPrice_' + serviceResponse.data.orderItemsId).html(formatCurrency(serviceResponse.data.orderItemsTotalPrice) + ' <sup>' + env_currency_symbol + '</sup>');
		}
		
		//réactiver le champ input pour le coupon, afficher le bouton Ajouter, masquer le bouton Supprimer
		$('#codeAvantageInput').val('');
		$('#codeAvantageInput').prop('disabled', false);
		$('#addCodePromoButton').show();
		$('#removeCodePromoButton').hide();
		
		wc.render.updateContext('OrderSummaryContext');
	}
}

/**
* Constructs the next URL to call when user validate the shop cart
* 2 scenarios to handle:
* 	1. User is not logged in -> invokes logon URL (step2TunnelLogonURL), after logon URL, go to the shipping mode page (step3TunnelShippingModeURL)
* 	2. User is logged on, go to the shipping mode page (step3TunnelShippingModeURL)
* @param {String} userType type of user (R or G) 
* @param {String} step2TunnelLogonURL URL to perform user logon 
* @param {String} step3TunnelShippingModeURL URL to the shipping mode page
*/
validateRecapShopCart = function(target,userType, step2TunnelLogonURL, step3TunnelShippingModeURL) {
	if($(target).attr('disabled') != 'disabled') {
		//For handling multiple clicks
		if(!submitRequest()){
			return;
		}
		cursor_wait();
		
		var completeOrderMoveURL = step2TunnelLogonURL;
		if(userType == 'R') {
			completeOrderMoveURL = step3TunnelShippingModeURL;
		} 
		document.location.href = completeOrderMoveURL;
	}
}

guestShopperLogon = function(logonURL, orderMoveURL, tunnelShippingModeURL) {
	var completeOrderMoveURL = orderMoveURL;
	
	// change URL of logon link
	completeOrderMoveURL = completeOrderMoveURL + "&URL=OrderCalculate%3FURL=" + tunnelShippingModeURL + "&calculationUsageId=-1&calculationUsageId=-2&calculationUsageId=-7";
	document.AjaxLogon.URL.value = completeOrderMoveURL;
	document.location.href = logonURL;
};

refreshPromotionCode = function(){
	document.location.href="OrderCalculate?URL=TunnelShopCartView&calculationUsageId=-1&calculationUsageId=-2&calculationUsageId=-7";
}