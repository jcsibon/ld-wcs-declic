var StandardProductDisplayWidget = (function(){

	var defaultAttributes = null;
	var catalogEntryId = null
	var displayPriceRange = null;
	// The master attribute, is the one that should never been disabled.
	var masterAttribute = null;
	var popupSuffixe = null;
	
	function StandardProductDisplayWidget() {
		
	}
	
	StandardProductDisplayWidget.prototype.initialize = function(catentryId, displayPrice, masterAttr, popsuf) {
		masterAttribute = masterAttr;
		catalogEntryId = catentryId;
		displayPriceRange = displayPrice;
		popupSuffixe = popsuf;
	}
	
	StandardProductDisplayWidget.prototype.buildDefiningAttributesArray = function(defaultAttrs) {
		defaultAttributes = JSON.parse(defaultAttrs);
	}
	
	StandardProductDisplayWidget.prototype.selectDefaultSku = function() {
		productDisplayJS.setSKUImageId('productMainImage' + popupSuffixe);
		
		
		var swatchArray2 = dojo.query("a[id^='ECO_QuickInfo_perform_AddToAllSwatchArray_']");
		for(var i = 0; i<swatchArray2.length; i++){
			var swatchArrayElement2 = swatchArray2[i];
			eval(dojo.attr(swatchArrayElement2,"href"));
		}
		
		
		//Important: il faut faire appel aux selectSwatch une fois les attributs selectionnés définis.
		for(var i = 0; i < defaultAttributes.length; i++) {
			productDisplayJS.setSelectedAttribute(defaultAttributes[i].identifier,defaultAttributes[i].value, "entitledItem_" + catalogEntryId);
		}
		for(var i = 0; i < defaultAttributes.length; i++) {
			productDisplayJS.selectSwatch(defaultAttributes[i].identifier,defaultAttributes[i].value,"entitledItem_" + catalogEntryId,masterAttribute);
		}

		if(defaultAttributes != null && defaultAttributes.length != 0) {
			productDisplayJS.notifyAttributeChange(catalogEntryId,"entitledItem_" + catalogEntryId,false,displayPriceRange, popupSuffixe);
		} else {
			productDisplayJS.selectSkuWithoutAttrs("entitledItem_" + catalogEntryId, catalogEntryId, popupSuffixe);
		}

	}
	
	return StandardProductDisplayWidget;
})();

var standardProductDisplay = new StandardProductDisplayWidget();