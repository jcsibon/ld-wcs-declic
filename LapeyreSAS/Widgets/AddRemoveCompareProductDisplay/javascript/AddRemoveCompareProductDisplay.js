function refreshAddRemoveCompareProductDiv(productId, catalogEntryId,displayType,divContainerId){
	var divContainer = dojo.byId(divContainerId);
	if (!divContainer) {
		return;
	}
	
	var innerHTML = '<div id="compare_'+ catalogEntryId + displayType + '" productid="compare_' + productId + '" class="compare_target mobile-hidden">'+
						'<label for="comparebox_' + catalogEntryId + displayType + '"> <input id="comparebox_' + catalogEntryId + displayType + '" type="checkbox" name="comparebox_' + catalogEntryId +
						'" value="' + catalogEntryId + '" onchange="javascript:shoppingActionsJS.addOrRemoveFromCompare(\''+catalogEntryId+'\',this.checked)" class="checkLP"/> '+
							' <div> </div> <span id="spanFor_' + catalogEntryId + displayType + '">' + '</span>'+
						'</label>'+
					'</div>';
	
	divContainer.innerHTML = innerHTML;
	shoppingActionsJS.checkForCompare();
	
	/*ECOCEA perf: plus besoin de fair un appel ajax
	var parameters = {};
	parameters.catalogEntryId= catalogEntryId;
	parameters.productId = productId;
	parameters.displayType = displayType;
	dojo.xhrPost({
		url: getAbsoluteURL() + "AddRemoveCompareProductDisplayAjax",				
		content: parameters,
		sync:true,
		service: productDisplayJS,
		load: function(content) {
			divContainer.innerHTML = content;
			shoppingActionsJS.checkForCompare();
        },
		error: function(errObj,ioArgs) {
			console.debug("Unexpected error occurred during an xhrPost request.",errObj);
		}
	});*/
}