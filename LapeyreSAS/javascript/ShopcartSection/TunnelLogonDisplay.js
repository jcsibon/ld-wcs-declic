guestShopperLogon = function(logonURL, orderMoveURL, tunnelShippingModeURL) {
	var completeOrderMoveURL = orderMoveURL;
	
	// change URL of logon link
	completeOrderMoveURL = completeOrderMoveURL + "&URL=OrderCalculate%3FURL=" + tunnelShippingModeURL + "&calculationUsageId=-1&calculationUsageId=-2&calculationUsageId=-7";
	document.AjaxLogon.URL.value = completeOrderMoveURL;
	document.location.href = logonURL;
};

dojo.ready(function(){
	
});
