//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2013 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

productDisplayJS={

	/** The language ID currently in use **/
	langId: "-1",
	
	/** The store ID currently in use **/
	storeId: "",
	
	/** The catalog ID currently in use **/
	catalogId: "",
	
	/** Holds the current user type such as guest or registered user. Allowed values are 'G' for guest and 'R' for registered.**/
	userType:"",
	
	/** A boolean used in a variety of the add to cart methods to tell whether or not the base item was added to the cart. **/
	baseItemAddedToCart:false,
	
	/** An array of entitled items which is used in various methods throughout ShoppingActions.js **/
	entitledItems:[],
	
	/** a JSON object that holds attributes of an entitled item **/
    entitledItemJsonObject: null,
	
	/** A map of attribute name value pairs for the currently selected attribute values **/
	selectedAttributesList:new Object(),
	
	/** A variable used to form the url dynamically for the more info link in the Quickinfo popup */
	moreInfoUrl :"",
	
	/**
	* A boolean used to to determine is it from a Qick info popup or not. 
	**/
	isPopup : false,
	
	/**
	* A boolean used to to determine whether or not to display the price range when the catEntry is selected. 
	**/
	displayPriceRange : true,

	/**
	* This array holds the json object returned from the service, holding the price information of the catEntry.
	**/
	itemPriceJsonOject : [],
	
	/** 
	* stores all name and value of all swatches 
	* this is a 2 dimension array and each record i contains the following information:
	* allSwatchesArray[i][0] - attribute name of the swatch
	* allSwatchesArray[i][1] - attribute value of the swatch
	* allSwatchesArray[i][2] - image1 of swatch (image to use for enabled state)
	* allSwatchesArray[i][3] - image2 of swatch (image to use for disabled state)
	* allSwatchesArray[i][4] - onclick action of the swatch when enabled
	**/
	allSwatchesArrayList : new Object(),
	
	/**
	* Holds the ID of the image used for swatch
	**/
	skuImageId:"",
	
	/**
	 * The prefix of the cookie key that is used to store item IDs. 
	 */
	cookieKeyPrefix: "CompareItems_",
	
	/**
	 * The delimiter used to separate item IDs in the cookie.
	 */
	cookieDelimiter: ";",
	
	/**
	 * The maximum number of items allowed in the compare zone. 
	 */
	maxNumberProductsAllowedToCompare: 4,
	
	/**
	 * The minimum number of items allowed in the compare zone. 
	 */
	minNumberProductsAllowedToCompare: 2,
	
	/**
	 * Id of the base catalog entry. 
	 */
	baseCatalogEntryId: 0,

	/**
	 * An map which holds the attributes of a set of products
	 */
	selectedProducts: new Object(),
	
	/**
	 * An array to keep the quantity of the products in a list (bundle)
	 */
	productList: new Object(),
	
	/**
	 * stores the currency symbol
	 */
	currencySymbol: "",
	
	/**
	 * stores the compare return page name
	 */
	compareReturnName: "",
	/**
	 * stores the search term
	 */
	searchTerm: "",
	
	search01: "'",
	
	search02: '"',
	
	replaceStr01: /\\\'/g,
	
	replaceStr02: /\\\"/g,
	
	ampersandChar: /&/g,
	
	ampersandEntityName: "&amp;" ,
	
	setCommonParameters:function(langId,storeId,catalogId,userType,currencySymbol){
		productDisplayJS.langId = langId;
		productDisplayJS.storeId = storeId;
		productDisplayJS.catalogId = catalogId;
		productDisplayJS.userType = userType;
		productDisplayJS.currencySymbol = currencySymbol;
	},
	
	setEntitledItems : function(entitledItemArray){
		productDisplayJS.entitledItems = entitledItemArray;
	},
	
	getCatalogEntryId : function(entitledItemId){
		var attributeArray = [];
		var selectedAttributes = productDisplayJS.selectedAttributesList[entitledItemId];
		for(attribute in selectedAttributes){
			attributeArray.push(attribute + "_" + selectedAttributes[attribute]);
		}
		return productDisplayJS.resolveSKU(attributeArray);
	},
	
	/**
	* getCatalogEntryIdforProduct Returns the catalog entry ID for a catalog entry that has the same attribute values as a specified product's selected attributes as passed in via the selectedAttributes parameter.
	*
	* @param {String[]} selectedAttributes The array of selected attributes upon which to resolve the SKU.
	*
	* @return {String} catalog entry ID of the SKU.
	*
	**/
	getCatalogEntryIdforProduct : function(selectedAttributes){
		var attributeArray = [];
		for(attribute in selectedAttributes){
			attributeArray.push(attribute + "_" + selectedAttributes[attribute]);
		}
		return productDisplayJS.resolveSKU(attributeArray);
	},
	
	/**
     * retrieves the entitledItemJsonObject
     */
    getEntitledItemJsonObject: function () {
    	return productDisplayJS.entitledItemJsonObject;
    },
	
	/**
	* resolveSKU Resolves a SKU using an array of defining attributes.
	*
	* @param {String[]} attributeArray An array of defining attributes upon which to resolve a SKU.
	*
	* @return {String} catentry_id The catalog entry ID of the SKU.
	*
	**/
	resolveSKU : function(attributeArray){
		console.debug("Resolving SKU >> " + attributeArray +">>"+ this.entitledItems);
		var catentry_id = "";
		var attributeArrayCount = attributeArray.length;
		
		// if there is only one item, no need to check the attributes to resolve the sku
		if(this.entitledItems.length == 1){
			return this.entitledItems[0].catentry_id;
		}
		for(x in this.entitledItems){
			var catentry_id = this.entitledItems[x].catentry_id;
			var Attributes = this.entitledItems[x].Attributes;
			var attributeCount = 0;
			for(index in Attributes){
				attributeCount ++;
			}

			// Handle special case where a catalog entry has one sku with no attributes
			if (attributeArrayCount == 0 && attributeCount == 0){
				return catentry_id;
			}
			if(attributeCount != 0 && attributeArrayCount >= attributeCount){
				var matchedAttributeCount = 0;

				for(attributeName in attributeArray){
					var attributeValue = attributeArray[attributeName];
					if(attributeValue in Attributes){
						matchedAttributeCount ++;
					}
				}
				
				if(attributeCount == matchedAttributeCount){
					console.debug("CatEntryId:" + catentry_id + " for Attribute: " + attributeArray);
					return catentry_id;
				}
			}
		}
		return null;
	},
	
	/**
	* setSelectedAttribute Sets the selected attribute value for a particular attribute not in reference to any catalog entry.
	*					   One place this function is used is on CachedProductOnlyDisplay.jsp where there is a drop down box of attributes.
	*					   When an attribute is selected from that drop down this method is called to update the selected value for that attribute.
	*
	* @param {String} selectedAttributeName The name of the attribute.
	* @param {String} selectedAttributeValue The value of the selected attribute.
	* @param {String} entitledItemId The element id where the json object of the sku is stored
	* @param {String} skuImageId This is optional. The element id of the product image - image element id is different in product page and category list view. Product page need not pass it because it is set separately
	* @param {String} imageField This is optional. The json field from which image should be picked. Pass value if a different size image need to be picked
	*
	**/
	setSelectedAttribute : function(selectedAttributeName , selectedAttributeValue, entitledItemId, skuImageId, imageField){ 		
		var selectedAttributes = productDisplayJS.selectedAttributesList[entitledItemId];
		if(selectedAttributes == null){
			selectedAttributes = new Object();
		}
		selectedAttributeValue = selectedAttributeValue.replace(productDisplayJS.replaceStr01, productDisplayJS.search01);
		selectedAttributeValue = selectedAttributeValue.replace(productDisplayJS.replaceStr02, productDisplayJS.search02);
		selectedAttributeValue = selectedAttributeValue.replace(productDisplayJS.ampersandChar, productDisplayJS.ampersandEntityName);
		selectedAttributes[selectedAttributeName] = selectedAttributeValue;
		productDisplayJS.moreInfoUrl=productDisplayJS.moreInfoUrl+'&'+selectedAttributeName+'='+selectedAttributeValue;
		productDisplayJS.selectedAttributesList[entitledItemId] = selectedAttributes;
		if(skuImageId != undefined){
			productDisplayJS.setSKUImageId(skuImageId);
		}
		var entitledItemJSON;
		if (dojo.byId(entitledItemId)!=null && !productDisplayJS.isPopup) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = productDisplayJS.getEntitledItemJsonObject(); 
		}
		productDisplayJS.setEntitledItems(entitledItemJSON);		
	},

	
	/**
	* Add2ShopCartAjax This function is used to add a catalog entry to the shopping cart using an AJAX call. This will resolve the catentryId using entitledItemId and adds the item to the cart.
	*				This function will resolve the SKU based on the entitledItemId passed in and call {@link fastFinderJS.AddItem2ShopCartAjax}.
	* @param {String} entitledItemId A DIV containing a JSON object which holds information about a catalog entry. You can reference CachedProductOnlyDisplay.jsp to see how that div is constructed.
	* @param {int} quantity The quantity of the item to add to the cart.
	* @param {String} isPopup If the value is true, then this implies that the function was called from a quick info pop-up. 	
	* @param {Object} customParams - Any additional parameters that needs to be passed during service invocation.
	*
	**/
	Add2ShopCartAjax : function(entitledItemId,quantity,isPopup,customParams)
	{	
		var entitledItemJSON;

		if (dojo.byId(entitledItemId)!=null) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = this.getEntitledItemJsonObject(); 
		}
		
		productDisplayJS.setEntitledItems(entitledItemJSON);
		var catalogEntryId = productDisplayJS.getCatalogEntryId(entitledItemId);
		
		if(catalogEntryId!=null){
			var productId = entitledItemId.substring(entitledItemId.indexOf("_")+1);
			productDisplayJS.AddItem2ShopCartAjax(catalogEntryId , quantity,customParams, productId);
			productDisplayJS.baseItemAddedToCart=true;
			if(dijit.byId('second_level_category_popup') != null){
				hidePopup('second_level_category_popup');
			}
		}
		else if (isPopup == true){
			dojo.byId('second_level_category_popup').style.zIndex = '1';
			MessageHelper.formErrorHandleClient('addToCartLinkAjax', storeNLS['ERR_RESOLVING_SKU']);			
		} else{
			MessageHelper.displayErrorMessage(storeNLS['ERR_RESOLVING_SKU']);
			productDisplayJS.baseItemAddedToCart=false;
		}
	},
	
	AddItem2ShopCartAjax : function(catEntryIdentifier, quantity, customParams, productId)
	{
		var params = [];
		params.storeId		= this.storeId;
		params.catalogId	= this.catalogId;
		params.langId		= this.langId;
		params.orderId		= ".";
		params.calculationUsage = "-1,-2,-5,-6,-7";
		params.inventoryValidation = "true";
		var ajaxShopCartService = "AddOrderItem";
		
		shoppingActionsJS.productAddedList = new Object();
		if(dojo.isArray(catEntryIdentifier) && dojo.isArray(quantity)){
			for(var i=0; i<catEntryIdentifier.length; i++){
				if(!isPositiveInteger(quantity[i])){
					MessageHelper.displayErrorMessage(storeNLS['QUANTITY_INPUT_ERROR']);
					return;
				}
				params["catEntryId_" + (i+1)] = catEntryIdentifier[i];
				params["quantity_" + (i+1)]	= quantity[i];
			}
		}
		else{
			if(!isPositiveInteger(quantity)){
				MessageHelper.displayErrorMessage(storeNLS['QUANTITY_INPUT_ERROR']);
				return;
			}
			params.catEntryId	= catEntryIdentifier;
			params.quantity		= quantity;
			
			var selectedAttrList = new Object();
			for(attr in productDisplayJS.selectedAttributesList['entitledItem_'+productId]){
				selectedAttrList[attr] = productDisplayJS.selectedAttributesList['entitledItem_'+productId][attr];
			}			
			
			if(productId == undefined){
				shoppingActionsJS.saveAddedProductInfo(quantity, catEntryIdentifier, catEntryIdentifier, selectedAttrList);
			} else {
				shoppingActionsJS.saveAddedProductInfo(quantity, productId, catEntryIdentifier, selectedAttrList);
			}
		}		

		//Pass any other customParams set by other add on features
		if(customParams != null && customParams != 'undefined'){
			for(i in customParams){
				params[i] = customParams[i];
			}
			if(customParams['catalogEntryType'] == 'dynamicKit' ){
				ajaxShopCartService = "AddPreConfigurationToCart";
			}
		}

		var contractIdElements = document.getElementsByName('contractSelectForm_contractId');
		if (contractIdElements != null && contractIdElements != "undefined") {
			for (i=0; i<contractIdElements.length; i++) {
				if (contractIdElements[i].checked) {
					params.contractId = contractIdElements[i].value;
					break;
				}
			}
		}
		
		//For Handling multiple clicks
		if(!submitRequest()){
			return;
		}   
		cursor_wait();	
		
		wc.service.invoke(ajaxShopCartService, params);
		productDisplayJS.baseItemAddedToCart=true;
		
		if(document.getElementById("headerShopCartLink")&&document.getElementById("headerShopCartLink").style.display != "none")
		{
			document.getElementById("headerShopCart").focus();
		}
		else
		{
			if(document.getElementById("headerShopCart1")){
				document.getElementById("headerShopCart1").focus();
			}
		}
	},
	
	/* SwatchCode start */

	/**
	* Sets the ID of the image to use for swatch.
	* @param {String} skuImageId The ID of the full image element.
	**/
	setSKUImageId:function(skuImageId){
		productDisplayJS.skuImageId = skuImageId;
	},
	
	/**
	* getImageForSKU Returns the full image of the catalog entry with the selected attributes as specified in the {@link fastFinderJS.selectedAttributes} value.
	*					This method uses resolveImageForSKU to find the SKU image with the selected attributes values.
	*
	* @param {String} imageField, the field name from which the image should be picked
	* @return {String} path to the SKU image.
	* 
	*
	**/
	getImageForSKU : function(entitledItemId, imageField){
		var attributeArray = [];
		var selectedAttributes = productDisplayJS.selectedAttributesList[entitledItemId];
		for(attribute in selectedAttributes){
			attributeArray.push(attribute + "_" + selectedAttributes[attribute]);
		}
		return productDisplayJS.resolveImageForSKU(attributeArray, imageField);
	},
	
	/**
	* resolveImageForSKU Resolves image of a SKU using an array of defining attributes.
	*
	* @param {String[]} attributeArray An array of defining attributes upon which to resolve a SKU.
	* @param {String} imageField, the field name from which the image should be picked
	*
	* @return {String} imagePath The location of SKU image.
	*
	**/
	resolveImageForSKU : function(attributeArray, imageField){
		console.debug("Resolving SKU >> " + attributeArray +">>"+ this.entitledItems);
		var imagePath = "";
		var attributeArrayCount = attributeArray.length;
		
		for(x in this.entitledItems){
			if(null != imageField){
				var imagePath = this.entitledItems[x][imageField];
			} else {
			var imagePath = this.entitledItems[x].ItemImage467;
			}
			
			var Attributes = this.entitledItems[x].Attributes;
			var attributeCount = 0;
			for(index in Attributes){
				attributeCount ++;
			}

			// Handle special case where a catalog entry has one sku with no attributes
			if (attributeArrayCount == 0 && attributeCount == 0){
				return imagePath;
			}
			if(attributeCount != 0 && attributeArrayCount >= attributeCount){
				var matchedAttributeCount = 0;

				for(attributeName in attributeArray){
					var attributeValue = attributeArray[attributeName];
					if(attributeValue in Attributes){
						matchedAttributeCount ++;
					}
				}
				
				if(attributeCount == matchedAttributeCount){
					console.debug("ItemImage:" + imagePath + " for Attribute: " + attributeArray);
					var imageArray = [];
					imageArray.push(imagePath);
					imageArray.push(this.entitledItems[x].ItemThumbnailImage);
					if(this.entitledItems[x].ItemAngleThumbnail != null && this.entitledItems[x].ItemAngleThumbnail != undefined){
						imageArray.push(this.entitledItems[x].ItemAngleThumbnail);
						imageArray.push(this.entitledItems[x].ItemAngleFullImage);
						imageArray.push(this.entitledItems[x].ItemAngleThumbnailShortDesc);
					}
					return imageArray;
				}
			}
		}
		return null;
	},


	/**
	* changeViewImages Updates the angle views of the SKU.
	*
	* @param {String[]} itemAngleThumbnail An array of SKU view thumbnails.
	* @param {String[]} itemAngleFullImage An array of SKU view full images.
	* @param {String[]} itemAngleThumbnailShortDesc An array of short description for the SKU view thumbnails.
	**/
	changeViewImages : function(itemAngleThumbnail, itemAngleFullImage, itemAngleThumbnailShortDesc){	
		var imageCount = 0;
		for (x in itemAngleThumbnail) {
			var prodAngleCount = imageCount;
			imageCount++;
			
			var thumbnailWidgets = dojo.query("ul[id^='ProductAngleImagesAreaList']");
			if(thumbnailWidgets != null){
				for(var i = 0; i<thumbnailWidgets.length; i++){			
					if(null != thumbnailWidgets[i]){
						var angleThumbnail = document.createElement("li");						
						var angleThumbnailLink = document.createElement("a");
						var angleThumbnailImg = document.createElement("img");
						
						angleThumbnail.id = "productAngleLi" + prodAngleCount;
						
						angleThumbnailLink.href = "JavaScript:changeThumbNail('productAngleLi" + prodAngleCount + "','" + itemAngleFullImage[x] + "');";
						angleThumbnailLink.id = "WC_CachedProductOnlyDisplay_links_1_" + imageCount ;
						if(itemAngleThumbnailShortDesc != 'undefined' && itemAngleThumbnailShortDesc != null){
							angleThumbnailLink.title = itemAngleThumbnailShortDesc[x];
						}
						
						angleThumbnailImg.src = itemAngleThumbnail[x];
						angleThumbnailImg.id = "WC_CachedProductOnlyDisplay_images_1_" + imageCount;
						if(itemAngleThumbnailShortDesc != 'undefined' && itemAngleThumbnailShortDesc != null){
							angleThumbnailImg.alt = itemAngleThumbnailShortDesc[x];
						}
						
						if(prodAngleCount == 0){
							dojo.empty(thumbnailWidgets[i]);						
						}						
						
						angleThumbnailLink.appendChild(angleThumbnailImg);
						angleThumbnail.appendChild(angleThumbnailLink);
						thumbnailWidgets[i].appendChild(angleThumbnail);
					}
				}				
			}			
		}
		
		var displayImageArea = "";
		if(imageCount > 0){
			displayImageArea = 'block';
		} else {
			displayImageArea = 'none';
		}
		var angleImageArea = dojo.query("div[id^='ProductAngleImagesArea']");
		if(angleImageArea != null){
			for(var i = 0; i<angleImageArea.length; i++){			
				if(null != angleImageArea[i]){
					angleImageArea[i].style.display = displayImageArea;
				}
			}
		}		
	},
	
	/**
	* Updates the swatches selections on list view.
	* Sets up the swatches array and sku images, then selects a default swatch value.
	**/	
	updateSwatchListView: function(){
			var swatchArray = dojo.query("a[id^='swatch_array_']");
			for(var i = 0; i<swatchArray.length; i++){
				var swatchArrayElement = swatchArray[i];
				eval(dojo.attr(swatchArrayElement,"href"));
			}
			
			var swatchSkuImage = dojo.query("a[id^='swatch_setSkuImage_']");
			for(var i = 0; i<swatchSkuImage.length; i++){
				var swatchSkuImageElement = swatchSkuImage[i];
				eval(dojo.attr(swatchSkuImageElement,"href"));
			}			
			
			var swatchDefault = dojo.query("a[id^='swatch_selectDefault_']");
			for(var i = 0; i<swatchDefault.length; i++){
				var swatchDefaultElement = swatchDefault[i];
				eval(dojo.attr(swatchDefaultElement,"href"));
			}		
	},
		
	/**
	* Handles the case when a swatch is selected. Set the border of the selected swatch.
	* @param {String} selectedAttributeName The name of the selected swatch attribute.
	* @param {String} selectedAttributeValue The value of the selected swatch attribute.
	* @param {String} entitledItemId The ID of the SKU
	* @param {String} doNotDisable The name of the swatch attribute that should never be disabled.
	* @param {String} imageField, the field name from which the image should be picked
	* @return boolean Whether the swatch is available for selection
	**/
	selectSwatch: function(selectedAttributeName, selectedAttributeValue, entitledItemId, doNotDisable, skuImageId, imageField) {
		if(dojo.hasClass("swatch_" + entitledItemId + "_" + selectedAttributeValue, "color_swatch_disabled")){
			return;
		}
		var selectedAttributes = this.selectedAttributesList[entitledItemId];
		for (attribute in selectedAttributes) {
			if (attribute == selectedAttributeName) {
				// case when the selected swatch is already selected with a value, if the value is different than
				// what's being selected, reset other swatches and deselect the previous value and update selection
				if (selectedAttributes[attribute] != selectedAttributeValue) {
					// deselect previous value and update swatch selection
					var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + selectedAttributes[attribute]);
					swatchElement.className = "color_swatch";
					swatchElement.src = swatchElement.src.replace("_disabled.png","_enabled.png");
					
					//change the title text of the swatch link
					dojo.byId("swatch_link_" + entitledItemId + "_" + selectedAttributes[attribute]).title = swatchElement.alt;
				}
			}
			if (document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributes[attribute]) != null) {
				document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributes[attribute]).setAttribute("aria-checked", "false");
			}
		}
		this.makeSwatchSelection(selectedAttributeName, selectedAttributeValue, entitledItemId, doNotDisable, skuImageId, imageField);
	},

	/**
	* Make swatch selection - add to selectedAttribute, select image, and update other swatches and SKU image based on current selection.
	* @param {String} swatchAttrName The name of the selected swatch attribute.
	* @param {String} swatchAttrValue The value of the selected swatch attribute.
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} doNotDisable The name of the swatch attribute that should never be disabled.	
	* @param {String} skuImageId This is optional. The element id of the product image - image element id is different in product page and category list view. Product page need not pass it because it is set separately
	* @param {String} imageField This is optional. The json field from which image should be picked. Pass value if a different size image need to be picked
	**/
	makeSwatchSelection: function(swatchAttrName, swatchAttrValue, entitledItemId, doNotDisable, skuImageId, imageField) {
		productDisplayJS.setSelectedAttribute(swatchAttrName, swatchAttrValue, entitledItemId, skuImageId, imageField);
		document.getElementById("swatch_" + entitledItemId + "_" + swatchAttrValue).className = "color_swatch_selected";
		document.getElementById("swatch_link_" + entitledItemId + "_" + swatchAttrValue).setAttribute("aria-checked", "true");
		document.getElementById("swatch_selection_label_" + entitledItemId + "_" + swatchAttrName).className = "header color_swatch_label";
		if (document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrName).style.display == "none") {
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrName).style.display = "inline";
		}
		document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrName).innerHTML = swatchAttrValue;
		productDisplayJS.updateSwatchImages(swatchAttrName, entitledItemId, doNotDisable,imageField);
	},
		
	/**
	* Constructs record and add to this.allSwatchesArray.
	* @param {String} swatchName The name of the swatch attribute.
	* @param {String} swatchValue The value of the swatch attribute.	
	* @param {String} swatchImg1 The path to the swatch image.
	**/
	addToAllSwatchsArray: function(swatchName, swatchValue, swatchImg1, entitledItemId) {
		var swatchList = this.allSwatchesArrayList[entitledItemId];
		if(swatchList == null){
			swatchList = new Array();;
		}
		if (!this.existInAllSwatchsArray(swatchName, swatchValue, swatchList)) {
			var swatchRecord = new Array();
			swatchRecord[0] = swatchName;
			swatchRecord[1] = swatchValue;
			swatchRecord[2] = swatchImg1;
			swatchRecord[4] = document.getElementById("swatch_link_" + entitledItemId + "_" + swatchValue).onclick;
			swatchList.push(swatchRecord);
			this.allSwatchesArrayList[entitledItemId] = swatchList;
		}
	},

	/**
	* Checks if a swatch is already exist in this.allSwatchesArray.
	* @param {String} swatchName The name of the swatch attribute.
	* @param {String} swatchValue The value of the swatch attribute.		
	* @return boolean Value indicating whether or not the specified swatch name and value exists in the allSwatchesArray.
	*/
	existInAllSwatchsArray: function(swatchName, swatchValue, swatchList) {
		for(var i=0; i<swatchList.length; i++) {
			var attrName = swatchList[i][0];
			var attrValue = swatchList[i][1];
			if (attrName == swatchName && attrValue == swatchValue) {
				return true;
			}
		}
		return false;
	},
	
	/**
	* Check the entitledItems array and pre-select the first entitled SKU as the default swatch selection.
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} doNotDisable The name of the swatch attribute that should never be disabled.		
	**/
	makeDefaultSwatchSelection: function(entitledItemId, doNotDisable) {
		if (this.entitledItems.length == 0) {
			if (dojo.byId(entitledItemId)!=null) {
				 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
			}
			productDisplayJS.setEntitledItems(entitledItemJSON);
		}
		
		// need to make selection for every single swatch
		for(x in this.entitledItems){
			var Attributes = this.entitledItems[x].Attributes;
			for(y in Attributes){
				var index = y.indexOf("_");
				var swatchName = y.substring(0, index);
				var swatchValue = y.substring(index+1);
				this.makeSwatchSelection(swatchName, swatchValue, entitledItemId, doNotDisable,imageField);
			}
			break;
		}
	},
	
	/**
	* Update swatch images - this is called after selection of a swatch is made, and this function checks for
	* entitlement and disable swatches that are not available
	* @param {String} selectedAttrName The attribute that is selected
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} doNotDisable The name of the swatch attribute that should never be disabled.	
	**/
	updateSwatchImages: function(selectedAttrName, entitledItemId, doNotDisable,imageField) {
		var swatchToUpdate = new Array();
		var selectedAttributes = productDisplayJS.selectedAttributesList[entitledItemId];
		var selectedAttrValue = selectedAttributes[selectedAttrName];
		var swatchList = productDisplayJS.allSwatchesArrayList[entitledItemId];
		
		// finds out which swatch needs to be updated, add to swatchToUpdate array
		for(var i=0; i<swatchList.length; i++) {
			var attrName = swatchList[i][0];
			var attrValue = swatchList[i][1];
			var attrImg1 = swatchList[i][2];
			var attrImg2 = swatchList[i][3];
			var attrOnclick = swatchList[i][4];
			
			if (attrName != doNotDisable && attrName != selectedAttrName) {
				var swatchRecord = new Array();
				swatchRecord[0] = attrName;
				swatchRecord[1] = attrValue;
				swatchRecord[2] = attrImg1;
				swatchRecord[4] = attrOnclick;
				swatchRecord[5] = false;
				swatchToUpdate.push(swatchRecord);
			}
		}
		
		// finds out which swatch is entitled, if it is, image should be set to enabled
		// go through entitledItems array and find out swatches that are entitled 
		for (x in productDisplayJS.entitledItems) {
			var Attributes = productDisplayJS.entitledItems[x].Attributes;

			for(y in Attributes){
				var index = y.indexOf("_");
				var entitledSwatchName = y.substring(0, index);
				var entitledSwatchValue = y.substring(index+1);	
				
				//the current entitled item has the selected attribute value
				if (entitledSwatchName == selectedAttrName && entitledSwatchValue == selectedAttrValue) {
					//go through the other attributes that are available to the selected attribute
					//exclude the one that is selected
					for (z in Attributes) {
						var index2 = z.indexOf("_");
						var entitledSwatchName2 = z.substring(0, index2);
						var entitledSwatchValue2 = z.substring(index2+1);
						
						if(y != z){ //only check the attributes that are not the one selected
							for (i in swatchToUpdate) {
								var swatchToUpdateName = swatchToUpdate[i][0];
								var swatchToUpdateValue = swatchToUpdate[i][1];
								
								if (entitledSwatchName2 == swatchToUpdateName && entitledSwatchValue2 == swatchToUpdateValue) {
									swatchToUpdate[i][5] = true;
								}
							}
						}
					}
				}
			}
		}

		// Now go through swatchToUpdate array, and update swatch images
		var disabledAttributes = [];
		for (i in swatchToUpdate) {
			var swatchToUpdateName = swatchToUpdate[i][0];
			var swatchToUpdateValue = swatchToUpdate[i][1];
			var swatchToUpdateImg1 = swatchToUpdate[i][2];
			var swatchToUpdateImg2 = swatchToUpdate[i][3];
			var swatchToUpdateOnclick = swatchToUpdate[i][4];
			var swatchToUpdateEnabled = swatchToUpdate[i][5];		
			
			if (swatchToUpdateEnabled) {
				if(document.getElementById("swatch_" + entitledItemId + "_" + swatchToUpdateValue).className != "color_swatch_selected"){
					var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + swatchToUpdateValue);
					swatchElement.className = "color_swatch";
					swatchElement.src = swatchElement.src.replace("_disabled.png","_enabled.png");
					
					//change the title text of the swatch link
					dojo.byId("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).title = swatchElement.alt;
				}
				document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).setAttribute("aria-disabled", "false");
				document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).onclick = swatchToUpdateOnclick;
			} else {
				if(swatchToUpdateName != doNotDisable){
					var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + swatchToUpdateValue);
					var swatchLinkElement = dojo.byId("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue);
					swatchElement.className = "color_swatch_disabled";					
					swatchLinkElement.onclick = null;
					swatchElement.src = swatchElement.src.replace("_enabled.png","_disabled.png");
					
					//change the title text of the swatch link
					var titleText = storeNLS["INV_ATTR_UNAVAILABLE"];
					swatchLinkElement.title = dojo.string.substitute(titleText,{0: swatchElement.alt});
					
					document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateValue).setAttribute("aria-disabled", "true");
					
					//The previously selected attribute is now unavailable for the new selection
					//Need to switch the selection to an available value
					if(selectedAttributes[swatchToUpdateName] == swatchToUpdateValue){
						disabledAttributes.push(swatchToUpdate[i]);
					}
				}
			}
		}
		
		//If there were any previously selected attributes that are now unavailable
		//Find another available value for that attribute and update other attributes according to the new selection
		for(i in disabledAttributes){
			var disabledAttributeName = disabledAttributes[i][0];
			var disabledAttributeValue = disabledAttributes[i][1];

			for (i in swatchToUpdate) {
				var swatchToUpdateName = swatchToUpdate[i][0];
				var swatchToUpdateValue = swatchToUpdate[i][1];
				var swatchToUpdateEnabled = swatchToUpdate[i][5];	
				
				if(swatchToUpdateName == disabledAttributeName && swatchToUpdateValue != disabledAttributeValue && swatchToUpdateEnabled){
						productDisplayJS.makeSwatchSelection(swatchToUpdateName, swatchToUpdateValue, entitledItemId, doNotDisable,imageField);
					break;
				}
			}
		}
	},
	/* SwatchCode end */
	 
	/** 
	* Displays price of the attribute selected with the catalog entry id.
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/	
	displayPrice : function(catEntryId, productId){
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;

		var tempString;
		var popup = productDisplayJS.isPopup;

		if(popup == true){
			document.getElementById('productPrice').innerHTML = catEntry.offerPrice;
		}
		
		if(popup == false){
			var innerHTML = "";
			var listPrice = dojo.currency.parse(catEntry.listPrice,{symbol: this.currencySymbol});
			var offerPrice = dojo.currency.parse(catEntry.offerPrice,{symbol: this.currencySymbol});
			
			if(!catEntry.listPriced || listPrice <= offerPrice){
				innerHTML = "<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='price'>" + catEntry.offerPrice + "</span>";
			}
			else{
				innerHTML = "<span id='listPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='old_price'>" + catEntry.listPrice + "</span>"+
							"<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='price'>" + catEntry.offerPrice + "</span>";
			}
			document.getElementById('price_display_'+productId).innerHTML = innerHTML
				+ "<input type='hidden' id='ProductInfoPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' value='" + catEntry.offerPrice.replace(/"/g, "&#034;").replace(/'/g, "&#039;") + "'/>";

			innerHTML = "";
			if(productDisplayJS.displayPriceRange == true){
				for(var i in catEntry.priceRange){
					if(catEntry.priceRange[i].endingNumberOfUnits == catEntry.priceRange[i].startingNumberOfUnits){
						tempString = storeNLS['PQ_PRICE_X'];
						innerHTML = innerHTML + "<p>" + dojo.string.substitute(tempString,{0: catEntry.priceRange[i].startingNumberOfUnits});
					}
					else if(catEntry.priceRange[i].endingNumberOfUnits != 'null'){
						tempString = storeNLS['PQ_PRICE_X_TO_Y'];
						innerHTML = innerHTML + "<p>" + dojo.string.substitute(tempString,{0: catEntry.priceRange[i].startingNumberOfUnits, 
							1: catEntry.priceRange[i].endingNumberOfUnits});
					}
					else{
						tempString = storeNLS['PQ_PRICE_X_OR_MORE'];
						innerHTML = innerHTML + "<p>" + dojo.string.substitute(tempString,{0: catEntry.priceRange[i].startingNumberOfUnits});
					}					
					innerHTML = innerHTML + " <span class='price'>" + catEntry.priceRange[i].localizedPrice + "</span></p>";
				}
			}
			// Append productId so that element is unique in bundle page, where there can be multiple components
			var quantityDiscount = dojo.byId("productLevelPriceRange_"+productId);
			var itemQuantityDiscount = dojo.byId("itemLevelPriceRange_"+productId);
			
			// if product level price exists and no section to update item level price
			if(null != quantityDiscount && null == itemQuantityDiscount){
				dojo.style(quantityDiscount, "display", ""); //display product level price range
			}
			// if item level price range is present
			else if("" != innerHTML && null != itemQuantityDiscount){
				innerHTML = storeNLS['PQ_PURCHASE'] + innerHTML;
				itemQuantityDiscount.innerHTML = innerHTML;
				dojo.style(itemQuantityDiscount, "display", "");
				// hide the product level price range
				if(null != quantityDiscount){
					dojo.style(quantityDiscount, "display", "none");
				}
			}
			// if item level price range is not present
			else if("" == innerHTML){
				if(null != itemQuantityDiscount){
					dojo.style(itemQuantityDiscount, "display", "none"); //hide item level price range
				}
				if(null != quantityDiscount){
					dojo.style(quantityDiscount, "display", ""); //display product level price range
				}
			} 
		}
	},
	 
	/** 
	* Updates the product name in the NameAndPrice widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/
	updateProductName: function(catEntryId, productId){
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;	 
	 
		if(productDisplayJS.isPopup == true){
			document.getElementById('productName').innerHTML = catEntry.description[0].name;
		} else {	 
			if(dojo.query(".top > div[id^='PageHeading_']") != null){
				dojo.query(".top > div[id^='PageHeading_']").forEach(function(node){
					if(node.childNodes != null && node.childNodes.length == 3){
						node.childNodes[1].innerHTML = catEntry.description[0].name;
					}
				});		
			}
			
			var productInfoWidgets = dojo.query("input[id^='ProductInfoName_"+productId+"']");
			if(productInfoWidgets != null){
				for(var i = 0; i<productInfoWidgets.length; i++){				
					if(productInfoWidgets[i] != null){
						productInfoWidgets[i].value = catEntry.description[0].name;
					}
				}
			}
		}
	},
	
	/** 
	* Updates the product part number in the NameAndPrice widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/	 
	updateProductPartNumber: function(catEntryId, productId){
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;	 
		
		if(productDisplayJS.isPopup == true){
			document.getElementById('productSKUValue').innerHTML = catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
		} else {
			var partnumWidgets = dojo.query("span[id^='product_SKU_"+productId+"']");
			if(partnumWidgets != null){
				for(var i = 0; i<partnumWidgets.length; i++){				
					if(partnumWidgets[i]){
						partnumWidgets[i].innerHTML = storeNLS['SKU'] + " " + catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
					}
				}
			}
		}
	 },
	 
	/** 
	* Updates the product short description in the ShortDescription widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/	
	updateProductShortDescription: function(catEntryId, productId){
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;	 
		
		var shortDescWidgets = dojo.query("p[id^='product_shortdescription_"+productId+"']");
		if(shortDescWidgets != null){
			for(var i = 0; i<shortDescWidgets.length; i++){		
				if(shortDescWidgets[i]) {
					shortDescWidgets[i].innerHTML = catEntry.description[0].shortDescription;
				}
			}
		}
	},	 

	/** 
	* Updates the product long description in the LongDescription widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/	
	updateProductLongDescription: function(catEntryId, productId){
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;	 
		
		var longDescWidgets = dojo.query("p[id^='product_longdescription_"+productId+"']");
		if(longDescWidgets != null){
			for(var i = 0; i<longDescWidgets.length; i++){		
				if(longDescWidgets[i]) {
					longDescWidgets[i].innerHTML = catEntry.description[0].longDescription;
				}
			}
		}
	},	 
	
	/** 
	* Updates the product discounts in the Discounts widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/	
	updateProductDiscount: function(catEntryId, productId){
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;
		
		var newHtml = '';
		if(typeof catEntry.discounts != 'undefined'){
			for(var i=0; i<catEntry.discounts.length; i++){
				if(i > 0){
					newHtml += '<div class="clear_float"></div><div class="item_spacer_2px"></div>';
				}
				/* catEntry.discounts[i].description comes from short description associated with the promotion.
				 * If it is blank or missing, the link text is blank, thus is not clickable or displayed.
				 */
				newHtml += '<a class="promotion" href="' + catEntry.discounts[i].url + '">' + catEntry.discounts[i].description + '</a>';
			}
		}		
		
		var discountWidgets = dojo.query("div[id^='Discounts_']");
		if(discountWidgets != null){
			for(var i = 0; i<discountWidgets.length; i++){
				if(discountWidgets[i]){
					discountWidgets[i].innerHTML = newHtml;
				}
			}
		}
	},	 
	 
	/** 
	* Updates the product full image and angle images in the FullImage widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/		 
	updateProductImage:function(catEntryId, productId){
		var newFullImage = null;
		var newAngleThumbnail = null;
		var newAngleFullImage = null;
		var newAngleThumbnailShortDesc = null;
		
		var entitledItemId = "entitledItem_" + productId;
		var imageArr = productDisplayJS.getImageForSKU(entitledItemId);	
		if(imageArr != null){
			newAngleThumbnail = imageArr[2];
			newAngleFullImage = imageArr[3];	
			newAngleThumbnailShortDesc = imageArr[4];	
		}
		
		if(catEntryId != null){
			newFullImage = imageArr[0];
		} else {		
			var imageFound = false;
			var selectedAttributes = productDisplayJS.selectedAttributesList[entitledItemId];
			for (x in productDisplayJS.entitledItems) {
				var Attributes = productDisplayJS.entitledItems[x].Attributes;
	
				for(y in Attributes){
					var index = y.indexOf("_");
					var entitledSwatchName = y.substring(0, index);
					var entitledSwatchValue = y.substring(index+1);	
					
					for(attribute in selectedAttributes){
						if (entitledSwatchName == attribute && entitledSwatchValue == selectedAttributes[attribute]) {
							newFullImage = productDisplayJS.entitledItems[x].ItemImage467;
							newAngleThumbnail = productDisplayJS.entitledItems[x].ItemAngleThumbnail;
							newAngleFullImage = productDisplayJS.entitledItems[x].ItemAngleFullImage;						
							newAngleThumbnailShortDesc = productDisplayJS.entitledItems[x].ItemAngleThumbnailShortDesc;
							imageFound = true;
							break;
						}
					}
					if(imageFound){
						break;
					}					
				}
				if(imageFound){
					break;
				}
			}			
		}
		
		var imgWidgets = dojo.query("img[id^='"+productDisplayJS.skuImageId+"']");
		for(var i = 0; i<imgWidgets.length; i++){				
			if(imgWidgets[i] != null && newFullImage != null){
				imgWidgets[i].src = newFullImage;
			}
		}
		
		var productImgWidgets = dojo.query("input[id^='ProductInfoImage_"+productId+"']");
		for(var i = 0; i<productImgWidgets.length; i++){			
			if(productImgWidgets[i] != null && newFullImage != null){
				productImgWidgets[i].value = newFullImage;
			}
		}
		
		if(newAngleThumbnail != null && newAngleFullImage != null){
			productDisplayJS.changeViewImages(newAngleThumbnail, newAngleFullImage, newAngleThumbnailShortDesc);
		} else {
			var angleImageArea = dojo.query("div[id^='ProductAngleImagesArea']");
			if(angleImageArea != null){
				for(var i = 0; i<angleImageArea.length; i++){			
					if(null != angleImageArea[i]){
						angleImageArea[i].style.display = 'none';
					}
				}
			}		
		}
	}, 
	
	/** 
	* To notify the change in attribute to other components that is subscribed to 'DefiningAttributes_Changed' or 'DefiningAttributes_Resolved' event.
	* 
	* @param {string} productId The identifier of the product.
	* @param {string} entitledItemId The identifier of the entitled item.
	* @param {boolean} isPopup If the value is true, then this implies that the function was called from a quick info pop-up.
	* @param {boolean} displayPriceRange A boolean used to to determine whether or not to display the price range when the catEntry is selected. 	
	*/		 
	notifyAttributeChange: function(productId, entitledItemId, isPopup, displayPriceRange){
		productDisplayJS.baseCatalogEntryId = productId;	
		var selectedAttributes = productDisplayJS.selectedAttributesList[entitledItemId];
		
		productDisplayJS.displayPriceRange = displayPriceRange;
		productDisplayJS.isPopup = isPopup;
		
		var catalogEntryId = null;		
		if(productDisplayJS.selectedProducts[productId]){
			catalogEntryId = productDisplayJS.getCatalogEntryIdforProduct(productDisplayJS.selectedProducts[productId]);
		} else {
			catalogEntryId = productDisplayJS.getCatalogEntryId(entitledItemId);
		}
		
		if(catalogEntryId != null){
			dojo.topic.publish('DefiningAttributes_Resolved_'+productId, catalogEntryId, productId);
			
			//check if the json object is already present for the catEntry.
			var catEntry = productDisplayJS.itemPriceJsonOject[catalogEntryId];		
			
			if(catEntry != null && catEntry != undefined){
				productDisplayJS.publishAttributeResolvedEvent(catalogEntryId, productId);
			}
			//if json object is not present, call the service to get the details.
			else{
				var parameters = {};
				parameters.storeId = productDisplayJS.storeId;
				parameters.langId= productDisplayJS.langId;
				parameters.catalogId= productDisplayJS.catalogId;
				parameters.catalogEntryId= catalogEntryId;
				parameters.productId = productId;

				dojo.xhrPost({
					url: getAbsoluteURL() + "GetCatalogEntryDetailsByIDView",				
					handleAs: "json-comment-filtered",
					content: parameters,
					service: productDisplayJS,
					sync:true,
					load: productDisplayJS.publishAttributeResolvedEventServiceResponse,
					error: function(errObj,ioArgs) {
						console.debug("productDisplayJS.notifyAttributeChange: Unexpected error occurred during an xhrPost request.");
					}
				});
			}
		}
		else{
			dojo.topic.publish('DefiningAttributes_Changed', catalogEntryId, productId);
			dojo.topic.publish('DefiningAttributes_Changed_' + productId, catalogEntryId, productId);
			console.debug("Publishing event 'DefiningAttributes_Changed' with params: catEntryId="+catalogEntryId+", productId="+productId);
		}
	},
	
	/** 
	* Publishes the 'DefiningAttributes_Resolved' event using the JSON object returned from the server.
	* 
	* @param {object} serviceRepsonse The JSON response from the service.
	* @param {object} ioArgs The arguments from the service call.
	*/		
	publishAttributeResolvedEventServiceResponse: function(serviceResponse, ioArgs){		
		var productId = ioArgs['args'].content['productId'];
		//stores the json object, so that the service is not called when same catEntry is selected.
		productDisplayJS.itemPriceJsonOject[serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID] = serviceResponse;		
		
		productDisplayJS.publishAttributeResolvedEvent(serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID, productId);
	 },
	
	/** 
	* Publishes the 'DefiningAttributes_Resolved' event with the necessary parameters. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/		
	publishAttributeResolvedEvent: function(catEntryId, productId){		
		if(!productDisplayJS.isPopup){
			dojo.topic.publish('DefiningAttributes_Resolved', catEntryId, productId);			
			console.debug("Publishing event 'DefiningAttributes_Resolved' with params: catEntryId="+catEntryId +", productId="+productId);
		}
	},
	
	/**
	 * To notify the change in quantity to other components that is subscribed to ShopperActions_Changed event.
	 */
	notifyQuantityChange: function(quantity){
		dojo.topic.publish('ShopperActions_Changed', quantity);
		console.debug("Publishing event 'ShopperActions_Changed' with params: quantity="+quantity);
	},	
	
	/**
	 * To display attachment page.
	 */
	showAttachmentPage:function(data){
		var pageNumber = data['pageNumber'];
		var pageSize = data['pageSize'];
		pageNumber = dojo.number.parse(pageNumber);
		pageSize = dojo.number.parse(pageSize);

		setCurrentId(data["linkId"]);

		if(!submitRequest()){
			return;
		}
			
		console.debug(wc.render.getRefreshControllerById('AttachmentPagination_Controller').renderContext.properties);
		var beginIndex = pageSize * ( pageNumber - 1 );
		cursor_wait();
		wc.render.updateContext('AttachmentPagination_Context', {'beginIndex':beginIndex});
		MessageHelper.hideAndClearMessage();
	}
}
require(["dojo/on", "dojo/has", "dojo/_base/sniff", "dojo/domReady!"], function(on, has) {
	if (has("ie") < 9) {
		on(document, ".compare_target > input[type=\"checkbox\"]:click", function(event) {
			this.blur();
			this.focus();
		});
	}
});