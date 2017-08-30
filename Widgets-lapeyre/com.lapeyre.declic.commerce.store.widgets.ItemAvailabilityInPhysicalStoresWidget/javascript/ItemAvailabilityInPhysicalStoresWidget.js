var ItemAvailabilityInPhysicalStoresWidget = (function(){

	var localisation = null;
	var userType = "G";
	var setDefaultStoreSucceedHandlerName = "SetDefaultStoreSucceed";
	
	function ItemAvailabilityInPhysicalStoresWidget() {
		this.setDefaultStoreSucceedHandlerName = "SetDefaultStoreSucceed";
	}
	
	ItemAvailabilityInPhysicalStoresWidget.prototype.initialize = function(userType) {
		if(userType == 'G') {
			new Geolocation().getCurrentPosition(registerPosition, registerPositionError);
		}
	}
	
	ItemAvailabilityInPhysicalStoresWidget.prototype.attach = function(shopSelect) {
		var that = this;
		$("#" + shopSelect).on('change', {that: that}, that.onShopListSelectChanged);
	}
	
	/*ItemAvailabilityInPhysicalStoresWidget.prototype.attachRadioByName = function(shopSelect) {
		var that = this;
		$("input:radio[name="+shopSelect+"]").on('change', {that: that}, that.onRadioChanged);
	}*/
	
	ItemAvailabilityInPhysicalStoresWidget.prototype.attachForm = function(form, radioName, selectName) {
		var that = this;
		$("#"+form).on('submit', {that: that, radio: radioName, select: selectName}, that.onFormSubmit);
	}
	
	ItemAvailabilityInPhysicalStoresWidget.prototype.setDefaultStoreSucceed = function(setDefaultStoreSucceedHandlerName) {
		this.setDefaultStoreSucceedHandlerName = setDefaultStoreSucceedHandlerName;
	}

	ItemAvailabilityInPhysicalStoresWidget.prototype.onShopListSelectChanged = function(event) {
//		submitRequest();
//		cursor_wait();
		var shopId = $(event.target).find(":selected").val();
		if(shopId != -1) {
			var shopName = $(event.target).find(":selected").attr("data-shop-name");
			event.data.that.launchServerRequest(shopId, shopName);
		}
	}
	
	ItemAvailabilityInPhysicalStoresWidget.prototype.onFormSubmit = function(event) {
		event.preventDefault();
		var radio = $("input:radio[name="+event.data.radio+"]:checked");
		var select = $("#"+event.data.select);
		
		if(radio.val() != null && radio.val() != -1){
			event.data.that.launchServerRequest(radio.val(), radio.attr("data-shop-name"));
		} else if (select.val() != -1) {
			event.data.that.launchServerRequest(select.find(":selected").val(), select.find(":selected").attr("data-shop-name"));
		}
	}
	
	ItemAvailabilityInPhysicalStoresWidget.prototype.launchServerRequest = function(shopId, shopName) {
		if(typeof localisation == 'object') {
			localisation = JSON.stringify(localisation);
		}
		//For Handling multiple clicks
		if(!submitRequest()){
			return;
		}   
		cursor_wait();
		var that = this;
		
		$.ajax({
			type: "GET",
			url : getAbsoluteURL() + "/SetDefaultStore",
			data: {"shopId": shopId, "shopName" : shopName, "localisation" : localisation},
			success: function(event) {
				cursor_clear();
				$(that).trigger(that.setDefaultStoreSucceedHandlerName);
			},
			error: function(errorThrown) {
				cursor_clear();
				console.error(errorThrown);
			}
		})
	}
	
	var registerPosition = function(position) {
		if (position !== undefined && position != null) {
			localisation = {"lat" : position.coords.latitude, "lng" : position.coords.longitude};
		}
	}
	
	var registerPositionError = function(error) {
		localisation = "denied";
	}

	return ItemAvailabilityInPhysicalStoresWidget;
})();

var itemAvailabilityInPhysicalStores = new ItemAvailabilityInPhysicalStoresWidget();
