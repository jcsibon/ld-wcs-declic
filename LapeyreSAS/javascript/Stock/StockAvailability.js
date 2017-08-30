var StockAvailability = (function() {
	
	var onComputeTaskListeners = null;
	var onStockAvailabilityListeners = null;
	var dataObject = null;
	var id=null;
	var url=null;

	function StockAvailability(id) {
		this.bindEvent();
		this.id = id;
		this.url = 'GetProductAvailabilityByShop';
	}
	
	StockAvailability.prototype.initialize = function() {
		
	}
	
	StockAvailability.prototype.addOnComputeTaskReceivedListener = function(computeTaskHandler) {
		if(this.onComputeTaskListeners == null) this.onComputeTaskListeners = new Array();
		for(var i = 0; i < this.onComputeTaskListeners.length; i++) {
			if(this.onComputeTaskListeners[i].toString() == computeTaskHandler.toString()) return;
		}
		this.onComputeTaskListeners.push(computeTaskHandler);
	}
	
	StockAvailability.prototype.addOnStockAvailabilityReceivedListener = function(resultHandler) {
		if(this.onStockAvailabilityListeners == null) this.onStockAvailabilityListeners = new Array();
		for(var i = 0; i < this.onStockAvailabilityListeners.length; i++) {
			if(this.onStockAvailabilityListeners[i] + '' == resultHandler + '') return;
		}
		this.onStockAvailabilityListeners.push(resultHandler);
	}
	
	StockAvailability.prototype.setDatas = function(dataObject) {
		this.dataObject = dataObject;
	}
	StockAvailability.prototype.setUrl = function(url) {
		this.url = url;
	}
	
	StockAvailability.prototype.askForAvailability = function() {
		var that = this;

		cursor_wait();
		$.ajax({
			url: getAbsoluteURL() + this.url,
			type : 'POST',
			data: that.dataObject,
			async :false,
			success: function(data) {
				cursor_clear();
				if(that.onStockAvailabilityListeners != null){
					for(var i = 0; i < that.onStockAvailabilityListeners.length; i++) {
						that.onStockAvailabilityListeners[i].call(this, data);
					}
				}
			},
			error : function(errorThrown) {
				cursor_clear();
				if(errorThrown.statusText == 'timeout') {
					if(that.onStockAvailabilityListeners != null){
						for(var i = 0; i < that.onStockAvailabilityListeners.length; i++) {
							that.onStockAvailabilityListeners[i].call(this, null);
						}
					}
					console.error("WebService timeout.");
				} else {
					console.error(errorThrown);
				}
			}
		});
		
	}
	
	StockAvailability.prototype.bindEvent = function() {
		var that = this;
		$(this).on("onComputeTask_Event", function(event, params) {
			if(that.onComputeTaskListeners != null){
				for(var i = 0; i < that.onComputeTaskListeners.length; i++) {
					if(params != null) {
						that.onComputeTaskListeners[i].call(that, params.productId);
					} 
				}
			}
		});
	}
	
	return StockAvailability;
})();

var stockAvailability = new StockAvailability('stockAvailability'); 
var stockAvailability_Popin = new StockAvailability('stockAvailability_Popin'); 