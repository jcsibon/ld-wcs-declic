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
	
	/** ECOCEA: An array of angle images of the product **/
	productAngleImages:[],
	
	/** a JSON object that holds attributes of an entitled item **/
    entitledItemJsonObject: null,
    
    /** a JSON object that holds angle images of the product **/
    productAngleImageJsonObject: null,
	
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
	
	skusCount: null,
	
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
	
	setProductAngleImages : function(angleImagesArray){
		productDisplayJS.productAngleImages = angleImagesArray;
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
     * ECOCEA: retrieves the productAngleImageJsonObject
     */
    getProductAngleImageJsonObject: function () {
    	return productDisplayJS.productAngleImageJsonObject;
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
		//console.debug("Resolving SKU >> " + attributeArray +">>"+ this.entitledItems);
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
			 entitledItemJSON = JSON.parse(dojo.byId(entitledItemId).innerHTML);
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = productDisplayJS.getEntitledItemJsonObject(); 
		}
		productDisplayJS.setEntitledItems(entitledItemJSON);	
		
		productDisplayJS.generateProductAngleImageArray(entitledItemId+'_AngleImages');
	},
	
	/**
	 * ECOCEA: stocke le JSON contenant les angles images du product
	 */
	generateProductAngleImageArray : function(entitledItemIdAngleImages){
		var productAngleImageJSON;
		if (dojo.byId(entitledItemIdAngleImages)!=null && !productDisplayJS.isPopup) {
			//the json object for entitled items are already in the HTML. 
			console.debug('angles images recuperees du html');
			productAngleImageJSON = JSON.parse(dojo.byId(entitledItemIdAngleImages).innerHTML);
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			console.debug('angles images recuperees du js');
			productAngleImageJSON = productDisplayJS.getProductAngleImageJsonObject(); 
		}
		productDisplayJS.setProductAngleImages(productAngleImageJSON);		
		
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

		if(dojo.query("#add2CartBtn.disabled").length>0){
			return false;
		}
			
		if (dojo.byId(entitledItemId)!=null) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = JSON.parse(dojo.byId(entitledItemId).innerHTML);
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = this.getEntitledItemJsonObject(); 
		}
		
		productDisplayJS.setEntitledItems(entitledItemJSON);
		productDisplayJS.generateProductAngleImageArray(entitledItemId+'_AngleImages');
		var catalogEntryId = productDisplayJS.getCatalogEntryId(entitledItemId);
		if(catalogEntryId!=null){
			var productId = entitledItemId.substring(entitledItemId.indexOf("_")+1);
			productDisplayJS.AddItem2ShopCartAjax(catalogEntryId , quantity,customParams, productId);
			productDisplayJS.baseItemAddedToCart=true;
			if(dijit.byId('second_level_category_popup') != null){
				hidePopup('second_level_category_popup');
			}
			var productSkuContainer = dojo.byId("product_SKU_" + productId);
			var offerPriceContainer = dojo.byId("ProductInfoPrice_viewPage_" + productId);
			if(	productDisplayJS.itemPriceJsonOject.length > 0 && 
			    typeof(productDisplayJS.itemPriceJsonOject[catalogEntryId]) != 'undefined' && productDisplayJS.itemPriceJsonOject[catalogEntryId] != null && 
			    typeof(productDisplayJS.itemPriceJsonOject[catalogEntryId].catalogEntry) != 'undefined' && productDisplayJS.itemPriceJsonOject[catalogEntryId].catalogEntry != null) 
			{
				var catEntry = productDisplayJS.itemPriceJsonOject[catalogEntryId].catalogEntry;
			}
			
			if(productSkuContainer && offerPriceContainer && catEntry){
					productDisplayJS.pushEventToGoogleTagManager({
					'currencyCode': 'EUR',
						'event' : 'addToCart',
					'page_cat1_name': catEntry.pageCat1,
					'products': [{
							'id' : productSkuContainer.innerHTML,
						'category': catEntry.pageCat2,
						'price': offerPriceContainer.value,
							'name' : catEntry.description[0].name,
						'brand': catEntry.brand ,
						'quantity': quantity,
						'variant': 'Standard'
					}]
				});
				
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
	
	selectSkuWithoutAttrs : function(entitledItemId, productId, displayType) {
		var entitledItemJSON;

		if (dojo.byId(entitledItemId)!=null) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = JSON.parse(dojo.byId(entitledItemId).innerHTML);
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = this.getEntitledItemJsonObject(); 
		}
		
		productDisplayJS.setEntitledItems(entitledItemJSON);
		productDisplayJS.generateProductAngleImageArray(entitledItemId+'_AngleImages');
		var catalogEntryId = productDisplayJS.getCatalogEntryId(entitledItemId);
		
		if(catalogEntryId != null){
			//check if the json object is already present for the catEntry.
			var catEntry = productDisplayJS.itemPriceJsonOject[catalogEntryId];		
			
			if(catEntry != null && catEntry != undefined){
				productDisplayJS.selectSkuWithoutAttrsResolvedEvent(catalogEntryId,productId,displayType);
			}
			//else check if the JSON is in the HTML
			else if(dojo.byId("defaultItemDetailJSON_"+catalogEntryId) != null){
				console.debug('selectSkuWithoutAttrs: retrieve default item details from html. id= itemDetailJSON_'+catalogEntryId);
				productDisplayJS.itemPriceJsonOject[catalogEntryId] = JSON.parse(dojo.byId("defaultItemDetailJSON_"+catalogEntryId).innerHTML);
				if(productDisplayJS.itemPriceJsonOject[catalogEntryId] != null && productDisplayJS.itemPriceJsonOject[catalogEntryId] != undefined){
					productDisplayJS.selectSkuWithoutAttrsResolvedEvent(catalogEntryId,productId,displayType);
				}
			}else{			
				var parameters = {};
				parameters.storeId = productDisplayJS.storeId;
				parameters.langId= productDisplayJS.langId;
				parameters.catalogId= productDisplayJS.catalogId;
				parameters.catalogEntryId= catalogEntryId;
				parameters.productId = productId;
				parameters.displayType = displayType;
				dojo.xhrPost({
					url: getAbsoluteURL() + "GetCatalogEntryDetailsByIDView",				
					handleAs: "json-comment-filtered",
					content: parameters,
					sync:true,
					service: productDisplayJS,
					load: productDisplayJS.selectSkuWithoutAttrsResolvedEventServiceResponse,
					error: function(errObj,ioArgs) {
						console.debug("productDisplayJS.notifyAttributeChange: Unexpected error occurred during an xhrPost request.");
						console.debug(ioArgs);
					}
				});
			}
		}else{
			console.debug('unable to retrieve item details. entitledItemId = '+entitledItemId);
		}
	},

	selectSkuWithoutAttrsResolvedEventServiceResponse : function(serviceResponse, ioArgs) {
		var productId = ioArgs['args'].content['productId'];
		var displayType = ioArgs['args'].content['displayType'];
		//stores the json object, so that the service is not called when same catEntry is selected.
		productDisplayJS.itemPriceJsonOject[serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID] = serviceResponse;		
		productDisplayJS.updateSurface(serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID, productId);
		productDisplayJS.updateProductPartNumber(serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID, productId,displayType);
		productDisplayJS.displayPrice(serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID, productId);
	},
	
	selectSkuWithoutAttrsResolvedEvent : function(catalogEntryId,productId,displayType){
		productDisplayJS.updateSurface(catalogEntryId, productId);
		productDisplayJS.updateProductPartNumber(catalogEntryId, productId,displayType);
		productDisplayJS.displayPrice(catalogEntryId, productId);
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
		//console.debug("Resolving SKU >> " + attributeArray +">>"+ this.entitledItems);
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
					//console.debug("ItemImage:" + imagePath + " for Attribute: " + attributeArray);
					var imageArray = [];
					imageArray.push(imagePath);
					imageArray.push(this.entitledItems[x].ItemThumbnailImage);
					imageArray.push(this.entitledItems[x].ItemZoomImage);
					if(this.productAngleImages != null && this.productAngleImages[0] != null && this.productAngleImages[0] != undefined 
							&& this.productAngleImages[0].ItemAngleThumbnail != null && this.productAngleImages[0].ItemAngleThumbnail != undefined
							&& this.productAngleImages[0].ItemAngleFullImage != null && this.productAngleImages[0].ItemAngleFullImage != undefined){
						imageArray.push(this.productAngleImages[0].ItemAngleThumbnail);
						imageArray.push(this.productAngleImages[0].ItemAngleFullImage);
					}
					return imageArray;
				}
			}
		}
		return null;
	},


	/**
	 * ECOCEA
	 * 
	* changeViewImages Updates the angle views of the SKU.
	*
	* @param {String[]} itemAngleThumbnail An array of SKU view thumbnails.
	* @param {String[]} itemAngleFullImage An array of SKU view full images.
	* @param {String[]} itemAngleThumbnailShortDesc An array of short description for the SKU view thumbnails.
	* @param {String[]} itemAngleZoomImage An array of zoom image
	**/
	changeViewImages : function(itemAngleThumbnail, itemAngleFullImage, displayType){
//		console.debug('changeViewImages called with: itemAngleThumbnail=');
//		console.debug(itemAngleThumbnail);
		
		require(["dojo/on", "dojo/dom", "dojo/dom-attr", "dojo/mouse", "dojo/dom-class", "dojo/query", "dojo/_base/array"],
		    function(on, dom, domAttr, mouse, domClass, query, array) {	
			
			// Thumbnails counter
			var imageCount = 0;
			// Main image
			var mainImage = query(".product_main_image")[0];
			var thumbnails = query(".fullImage-thumbnails-container");
			// Global thumbnails container
			var thumbnailWidgets = query("ul[id^='ProductAngleImagesArea" + displayType + "List']");
			
			if (thumbnailWidgets != null) {
				for (x in itemAngleThumbnail) {			
					
					// Retrieve the thumbnail container <li>
					var angleThumbnail = thumbnails[imageCount];
					
					if(imageCount < thumbnails.length  ) {
						// Retrieve the thumbnail link <a>
						var angleThumbnailLink = query("a", angleThumbnail)[0];
						// Retrieve the thumbnail image <img>
						var angleThumbnailImg = query("img", angleThumbnailLink)[0];
						
						angleThumbnail.id = "productAngleLi" + displayType + imageCount;
						
						angleThumbnailLink.id = "WC_CachedProductOnlyDisplay_links_1_" + imageCount ;
						angleThumbnailLink.title = itemAngleThumbnail[x].split(";")[1];
                        angleThumbnailLink.href = "JavaScript:ProductFullImageJS.changeThumbNail('" + itemAngleFullImage[x].split(";")[0] + "', '"+displayType+"','"+itemAngleFullImage[x].split(";")[1]+"');";
							
						angleThumbnailImg.src = itemAngleThumbnail[x].split(";")[0];
						angleThumbnailImg.alt = itemAngleThumbnail[x].split(";")[1];
						angleThumbnailImg.id = "WC_CachedProductOnlyDisplay_images_1_" + imageCount;
						// Update the main image on thumbnails hover
						domClass.add(angleThumbnailImg, "fullImage-thumbnails");
						domAttr.set(angleThumbnailImg, 'data-src', itemAngleFullImage[x].split(";")[1]);
					} else {
						dojo.destroy(angleThumbnail);
					}
			    	
			    	imageCount++;
				}
			}
			

			var selectedClass = "thumbnail-selected";
			var hiddenClass = "hidden";
			if(query(".fullImage-thumbnails-container").length > 0){
				thumbnails.removeClass(selectedClass);
				domClass.add(query(".fullImage-thumbnails-container")[0], selectedClass);
			}
			on(thumbnails, "click", function(){	
				// Display image in the main container
				if (domAttr.get(this, "data-type") === "image") {
					domClass.add(dom.byId("fullImageVideoContainer"), hiddenClass);
    				domClass.remove(dom.byId("fullImageImageContainer"), hiddenClass);
    			} 
				// Display video in the main container
				else if (domAttr.get(this, "data-type") === "video" && !domClass.contains(this, selectedClass)) {					
    				domClass.remove(dom.byId("fullImageVideoContainer"), hiddenClass);
    				domClass.add(dom.byId("fullImageImageContainer"), hiddenClass);
    				domAttr.set(dom.byId("youtubePlayer"), "src", domAttr.get(query("img", this)[0], "data-embed-url"));
    			}
				// Highlight the selected thumbnail
				thumbnails.removeClass(selectedClass);
	            domClass.add(this, selectedClass);
	        });
			
			var displayImageArea = "";
			if(imageCount > 0){
				displayImageArea = 'block';
			} else {
				displayImageArea = 'none';
			}
			var angleImageArea = dojo.query("div[id^='ProductAngleImagesArea" + displayType + "']");
			if(angleImageArea != null){
				for(var i = 0; i<angleImageArea.length; i++){			
					if(null != angleImageArea[i]){
						angleImageArea[i].style.display = displayImageArea;
					}
				}
			}	
		});
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
	* @param {String} selectedAttributeIdentifier The name of the selected swatch attribute.
	* @param {String} selectedAttributeValue The value of the selected swatch attribute.
	* @param {String} entitledItemId The ID of the SKU
	* @param {String} allSwatchAttributes List of all swatch attributes.
	* @param {String} imageField, the field name from which the image should be picked
	* @return boolean Whether the swatch is available for selection
	**/
	selectSwatch: function(selectedAttributeIdentifier, selectedAttributeValue, entitledItemId, allSwatchAttributes, skuImageId, imageField) {
		//ECOCEA: if setSelectedAttribute has not been called, the selectSwatch function will do nothing and return immediatly
		if(dojo.byId("swatch_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributeValue) == null || dojo.hasClass("swatch_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributeValue, "color_swatch_disabled")){
			return;
		}
		var selectedAttributes = this.selectedAttributesList[entitledItemId];
		for (attribute in selectedAttributes) {
			if (attribute == selectedAttributeIdentifier) {
				// case when the selected swatch is already selected with a value, if the value is different than
				// what's being selected, reset other swatches and deselect the previous value and update selection
				if (selectedAttributes[attribute] != selectedAttributeValue) {
					// deselect previous value and update swatch selection
					var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributes[attribute]);
					if (swatchElement.src != null) {
					//if (swatchElement.src && typeof(swatchElement.src) != "undefined") { // Added FBA
						swatchElement.src = swatchElement.src.replace("_disabled.png","_enabled.png");
						swatchElement.className = "color_swatch";
					} else {
						swatchElement.className = "color_swatch button";
					}
				}
			}
			if (document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributes[attribute]) != null) {
				document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributes[attribute]).setAttribute("aria-checked", "false");
			}
		}
		this.makeSwatchSelection(selectedAttributeIdentifier, selectedAttributeValue, entitledItemId, allSwatchAttributes, skuImageId, imageField);
	},

	swatchListChanged: function(event, selectedAttributeIdentifier, entitledItemId, allSwatchAttributes, skuImageId, imageField, registered, displayPriceRange, isPopup, displayType) {
		var selectedAttributeValue = event.target.options[event.target.selectedIndex].value;
		this.skusCount = null;
		this.setSKUImageId('productMainImage' + displayType);
//		this.selectSwatch(selectedAttributeIdentifier, selectedAttributeValue, 'entitledItem_' + entitledItemId, allSwatchAttributes, skuImageId, imageField);
		this.selectSwatch(selectedAttributeIdentifier, selectedAttributeValue, 'entitledItem_' + entitledItemId, allSwatchAttributes);
		this.notifyAttributeChange(entitledItemId, 'entitledItem_' + entitledItemId, false, displayPriceRange, displayType);
		if (registered) {
			shoppingActionsJS.changeWishListButton('entitledItem_' + entitledItemId, entitledItemId);
		}
	},

	/**
	* Make swatch selection - add to selectedAttribute, select image, and update other swatches and SKU image based on current selection.
	* @param {String} swatchAttrIdentifier The name of the selected swatch attribute.
	* @param {String} swatchAttrValue The value of the selected swatch attribute.
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} allSwatchAttributes List of all swatch attributes.
	* @param {String} skuImageId This is optional. The element id of the product image - image element id is different in product page and category list view. Product page need not pass it because it is set separately
	* @param {String} imageField This is optional. The json field from which image should be picked. Pass value if a different size image need to be picked
	**/
	makeSwatchSelection: function(swatchAttrIdentifier, swatchAttrValue, entitledItemId, allSwatchAttributes, skuImageId, imageField) {
		productDisplayJS.setSelectedAttribute(swatchAttrIdentifier, swatchAttrValue, entitledItemId, skuImageId, imageField);

		var swatchOptionElement = dojo.byId('swatch_option_' + entitledItemId + '_' + swatchAttrIdentifier + '_' + swatchAttrValue);
		if (swatchOptionElement) {
			swatchOptionElement.selected = true;
		}

		if(productDisplayJS.skusCount != 1) {
			document.getElementById("swatch_" + entitledItemId + "_" + swatchAttrIdentifier + "_" + swatchAttrValue).className = "color_swatch_selected tooltip";
		} else {
			document.getElementById("swatch_" + entitledItemId + "_" + swatchAttrIdentifier + "_" + swatchAttrValue).className = "color_swatch_selected_one_sku";
		}
		if(document.getElementById("swatch_link_" + entitledItemId + "_" + swatchAttrIdentifier + "_" + swatchAttrValue) != null) {
			document.getElementById("swatch_link_" + entitledItemId + "_" + swatchAttrIdentifier + "_" + swatchAttrValue).setAttribute("aria-checked", "true");
		}
		if(document.getElementById("swatch_selection_label_" + entitledItemId + "_" + swatchAttrIdentifier) != null)
			document.getElementById("swatch_selection_label_" + entitledItemId + "_" + swatchAttrIdentifier).className = "header color_swatch_label";
		if (document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier) != null && document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier).style.display == "none") {
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier).style.display = "inline";
		}
		if(document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier) != null)
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier).innerHTML = swatchAttrValue;
		productDisplayJS.updateSwatchImages(swatchAttrIdentifier, entitledItemId, allSwatchAttributes,imageField,skuImageId);
	},
		
	/**
	* Constructs record and add to this.allSwatchesArray.
	* @param {String} swatchIdentifier The name of the swatch attribute.
	* @param {String} swatchValue The value of the swatch attribute.	
	* @param {String} swatchImg1 The path to the swatch image.
	**/
	addToAllSwatchsArray: function(swatchIdentifier, swatchValue, swatchImg1, entitledItemId) {
		var swatchList = this.allSwatchesArrayList[entitledItemId];
		
		if(swatchList == null){
			swatchList = new Array();
		}
		if (!this.existInAllSwatchsArray(swatchIdentifier, swatchValue, swatchList)) {
			var swatchRecord = new Array();
			swatchRecord[0] = swatchIdentifier;
			swatchRecord[1] = swatchValue;
			swatchRecord[2] = swatchImg1;
			swatchRecord[4] = document.getElementById("swatch_link_" + entitledItemId + "_" + swatchIdentifier + "_" + swatchValue).onclick;
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
	* @param {String} allSwatchAttributes List of all swatch attributes.		
	**/
	makeDefaultSwatchSelection: function(entitledItemId, allSwatchAttributes) {
		if (this.entitledItems.length == 0) {
			if (dojo.byId(entitledItemId)!=null) {
				 entitledItemJSON = JSON.parse(dojo.byId(entitledItemId).innerHTML);
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
				this.makeSwatchSelection(swatchName, swatchValue, entitledItemId, allSwatchAttributes,imageField);
			}
			break;
		}
	},
	
	/**
	* Update swatch images - this is called after selection of a swatch is made, and this function checks for
	* entitlement and disable swatches that are not available
	* @param {String} selectedAttrName The attribute identifier that is selected
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} allSwatchAttributes List of all swatch attributes.	
	**/
	updateSwatchImages: function(selectedAttrName, entitledItemId, allSwatchAttributes,imageField,skuImageId) {
		var swatchToUpdate = new Array();
		var selectedAttributes = this.selectedAttributesList[entitledItemId];
		var selectedAttrValue = selectedAttributes[selectedAttrName];
		var swatchList = this.allSwatchesArrayList[entitledItemId];
		if(swatchList == null)
			return;
		
		//ECOCEA
		var allSwatchAttributesArray = allSwatchAttributes.split(',');
		var indexOfAttrName = 0;

		for(var k=0;k<allSwatchAttributesArray.length;k++){
			if(allSwatchAttributesArray[k] == selectedAttrName){
				indexOfAttrName=k;
			}
		}
		

		// finds out which swatch needs to be updated, add to swatchToUpdate array
		var selectedSwatchs = new Array();
		for(var i=0; i<swatchList.length; i++) {

				
				var attrName = swatchList[i][0];
				var indexOfCurrentAttrName = 0;
				for(var m=0; m<allSwatchAttributesArray.length; m++){
					if(allSwatchAttributesArray[m] == attrName){
						indexOfCurrentAttrName=m;
					}
				}
				
				if(indexOfCurrentAttrName>indexOfAttrName){
					var attrValue = swatchList[i][1];
					var attrImg1 = swatchList[i][2];
					var attrImg2 = swatchList[i][3];
					var attrOnclick = swatchList[i][4];

					if (attrName != allSwatchAttributes && attrName != selectedAttrName) {
						var swatchRecord = new Array();
						swatchRecord[0] = attrName;
						swatchRecord[1] = attrValue;
						swatchRecord[2] = attrImg1;
						swatchRecord[4] = attrOnclick;
						swatchRecord[5] = false;
						swatchToUpdate.push(swatchRecord);
					}
					
				}
		}

		//ECOCEA
		//parcours des combinaisons d'attributs possibles
		var availablesCombinaisonsList = new Object();
		for (x in productDisplayJS.entitledItems) {
			var Attributes = productDisplayJS.entitledItems[x].Attributes;
			var availableCombinaison = new Object();
			for(y in Attributes){
				
				//construct the map of attributes combinaison
				var index = y.lastIndexOf("_");
				var entitledSwatchName = y.substring(0, index);
				var entitledSwatchValue = y.substring(index+1);	
				
				availableCombinaison[entitledSwatchName]=entitledSwatchValue;
			}
			availablesCombinaisonsList[x]=availableCombinaison;
		}

		//ECOCEA
		for (i in swatchToUpdate) {
			var swatchToUpdateName = swatchToUpdate[i][0];
			var swatchToUpdateValue = swatchToUpdate[i][1];

			for(y in availablesCombinaisonsList){
				var oneCombinaison = availablesCombinaisonsList[y];
				//on regarde si le swatch courant est pr�sent dans l'une des combinaisons
				
				//1: on v�rifie d'abord que la combinaison est valide par rapport au swatchs d�ja s�l�ctionn�s.
				var isCombinaisonPrerequisOK = false;
				for(z=0;z<=indexOfAttrName;z++){
					var attrNameSelected = allSwatchAttributesArray[z];
					var attrValueSelected = selectedAttributes[allSwatchAttributesArray[z]];

					if(oneCombinaison[attrNameSelected] == attrValueSelected){
						isCombinaisonPrerequisOK = true;
					}else{
						isCombinaisonPrerequisOK = false;
						break;
					}
				}
				
				//2: si la combinaison est valide par rapport au swatchs d�ja selectionn�s, on regarde si le swatch en cours existe dans la combinaison
				if(isCombinaisonPrerequisOK){
					if(oneCombinaison[swatchToUpdateName] == swatchToUpdateValue){
						swatchToUpdate[i][5]=true;
						break;
					}
				}else{
					swatchToUpdate[i][5]=false;
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
			var swatchOptionElement = dojo.byId('swatch_option_' + entitledItemId + '_' + swatchToUpdateName + '_' + swatchToUpdateValue);
			

			// Enable swatch
			if (swatchToUpdateEnabled) {

				// Swatch is rendered as a select option
				if (swatchOptionElement) {
					dojo.removeAttr(swatchOptionElement, "disabled");
				}

				// Swatch normal rendering
				else {
					if(document.getElementById("swatch_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue).className != "color_swatch_selected") {
						var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue);
						var swatchSpanDisableElement = dojo.byId("swatchSpanDisable_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue);
						
						// Enable the swatch with picto
						if (swatchSpanDisableElement != null ){
							swatchSpanDisableElement.className="";
						}

						if (swatchElement.src != null) {
						//if (swatchElement.src && typeof(swatchElement.src) != "undefined") {
							swatchElement.src = swatchElement.src.replace("_disabled.png","_enabled.png");
							swatchElement.className = "color_swatch tooltip";
						} else {
							swatchElement.className = "color_swatch button tooltip";
						}
						
					}
					document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue).setAttribute("aria-disabled", "false");
					document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue).onclick = swatchToUpdateOnclick;
				}

			// Disable swatch
			} else {

				// Do not disable single swatch
				if (swatchToUpdateName != allSwatchAttributes) {

					// Swatch is rendered as a select option
					if (swatchOptionElement) {
						dojo.attr(swatchOptionElement, "disabled", "true");
					}

					// Swatch normal rendering
					else {
						var swatchElement = dojo.byId("swatch_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue);
						var swatchLinkElement = dojo.byId("swatch_link_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue);
						var swatchSpanDisableElement = dojo.byId("swatchSpanDisable_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue);
						swatchElement.className = "color_swatch_disabled tooltip";
						
						// Disable the swatch with picto
						if (swatchSpanDisableElement != null) {
							swatchSpanDisableElement.className="disabled-swatch-color";
						}

						swatchLinkElement.onclick = null;
						if (dojo.exists('swatchElement.src')) {
						//if (swatchElement.src && typeof(swatchElement.src) != "undefined") {
							swatchElement.src = swatchElement.src.replace("_enabled.png","_disabled.png");
						}

						document.getElementById("swatch_link_" + entitledItemId + "_" + swatchToUpdateName + "_" + swatchToUpdateValue).setAttribute("aria-disabled", "true");
					}
					
					// The previously selected attribute is now unavailable for the new selection
					// Need to switch the selection to an available value
					if (selectedAttributes[swatchToUpdateName] == swatchToUpdateValue) {
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
						productDisplayJS.makeSwatchSelection(swatchToUpdateName, swatchToUpdateValue, entitledItemId, allSwatchAttributes,imageField);
					break;
				}
			}
		}
		
		//ECOCEA: on selectionne le swatch suivant jusqu'a ce qu'on arrive au dernier.
		var nextAttrName = allSwatchAttributesArray[indexOfAttrName+1];
		var nextAttrValue = selectedAttributes[nextAttrName];
		if(nextAttrName != undefined && nextAttrValue != undefined){
			this.selectSwatch(nextAttrName, nextAttrValue, entitledItemId, allSwatchAttributes, skuImageId, imageField);
		}

	},
	/* SwatchCode end */
	
	changePriceLabel : function(productId, priceLabel) {
		if(dojo.byId("priceLabel_" + productId) != null){
			dojo.byId("priceLabel_" + productId).innerHTML = priceLabel;
		}
	},
	
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

		if(popup == true && document.getElementById('productPrice') != null){
			document.getElementById('productPrice').innerHTML = catEntry.offerPrice;
		}
		
		if(popup == false){
			var innerHTML = "";

			if(!catEntry.listPriced || catEntry.listPriced=='false' ){
				if(catEntry.offerPriceWithoutSymbol != undefined && catEntry.offerPriceWithoutSymbol != null && catEntry.offerPriceWithoutSymbol != ''){
					//innerHTML = "<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='price'><span itemprop='price'>" + catEntry.offerPrice + '</span>';
					innerHTML = catEntry.offerPrice;
					$('#supHTOldPriceProductPage_viewPage_' +  productId).hide();
					$('#supHTPriceProductPage_viewPage_' +  productId).show();
					$('#offerPrice_viewPage_' +  productId).removeClass("noPrice").addClass("price");
					$('#blockOfferPrice_viewPage_' +  productId).removeClass("noPrice").addClass("price");
					$('#priceFromDiv_'+productId).show();
					$('#add2CartBtn').removeClass("disabled");
				}else{
					//No price for this catentry => display teh noPriceLabel
					//innerHTML = "<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='noPrice'><span itemprop='price'>" + catEntry.emptyPriceLabel; + '</span>';
					innerHTML = catEntry.emptyPriceLabel;
					$('#supHTOldPriceProductPage_viewPage_' +  productId).hide();
					$('#supHTPriceProductPage_viewPage_' +  productId).hide();
					$('#blockOfferPrice_viewPage_' +  productId).removeClass("price").addClass("noPrice");
					$('#offerPrice_viewPage_' +  productId).removeClass("price").addClass("noPrice");
					$('#priceFromDiv_'+productId).hide();
					
					$('#add2CartBtn').addClass("disabled");
				}
				
				if(document.getElementById('offerPrice_viewPage_'+productId) != null){
					document.getElementById('offerPrice_viewPage_'+productId).innerHTML = innerHTML;
				}
				$('#offerPrice_viewPage_' +  productId).show();
				$('#listPrice_viewPage_' +  productId).hide();
				$('#blockListPrice_viewPage_' +  productId).hide();
				$('#cguDisplayContainer_viewPage_' +  productId).hide();
				$('#asterix_viewPage_' + productId).hide();
				$('#promoDescription_' + productId).hide();
				$('#promoDescription_' + productId).html("");
				
			}
			else{
				//innerHTML = "<span id='listPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='old_price_value' style='margin-bottom: -40px;'>" + catEntry.listPrice + "</span>"
				innerHTML =  catEntry.listPrice;
				if(document.getElementById('listPrice_viewPage_'+productId) != null){
					document.getElementById('listPrice_viewPage_'+productId).innerHTML = innerHTML;
				}
				
				//innerHTML =	"<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='price'><span itemprop='price'>" + catEntry.offerPrice + '</span> ';
				innerHTML = catEntry.offerPrice ;
				if(document.getElementById('offerPrice_viewPage_'+productId) != null){
					document.getElementById('offerPrice_viewPage_'+productId).innerHTML = innerHTML;
				}
				
				$('#offerPrice_viewPage_' +  productId).removeClass("noPrice").addClass("price");
				$('#blockOfferPrice_viewPage_' +  productId).removeClass("noPrice").addClass("price");
				
				$('#supHTPriceProductPage_viewPage_' +  productId).show();
				$('#supHTOldPriceProductPage_viewPage_' +  productId).show();
				
				$('#offerPrice_viewPage_' +  productId).show();
				$('#listPrice_viewPage_' +  productId).show();
				$('#blockListPrice_viewPage_' +  productId).show();
				
				$('#cguDisplayContainer_viewPage_' +  productId).show();
				
				$('#priceFromDiv_'+productId).show();
				
				$('#asterix_viewPage_' + productId).show();
				$('#add2CartBtn').removeClass("disabled");
				
				promoDescriptionInnerHTML = "";
				if(catEntry.priceAdjustments && catEntry.priceAdjustments.length > 0) {
					for(var i = 0 ; i < catEntry.priceAdjustments.length ; ++i) {
						priceAdjustement = catEntry.priceAdjustments[i];
						promoDescriptionInnerHTML += (priceAdjustement.promo_desc) ? "<div>" + priceAdjustement.promo_desc + "</div>" : "";
					}
				}
				
				if(promoDescriptionInnerHTML.length > 0) {
					$('#promoDescription_' + productId).html(promoDescriptionInnerHTML);
					$('#promoDescription_' + productId).show();
				}

			}
			
			//Upadte priceLabel
			productDisplayJS.changePriceLabel(productId, catEntry.priceLabel);
			
			// Update EcoPart
			productDisplayJS.updateEcoPart(catEntry, productId);
		}
	},
	
	updateEcoPart : function(catEntry, productId) {
		var ecopartcontainer = document.getElementById('ecoPartContainer_' + productId);
		var ecopartLabel = dojo.query("div[id='ecoPartContainer_"+productId+"'] > span");
		if(ecopartcontainer != null && ecopartLabel != null && ecopartLabel.length == 1) {
			if(catEntry.ecopartList != '') {
				ecopartLabel[0].innerHTML = catEntry.ecopartList;
				dojo.style(ecopartcontainer, 'display', "block");
			} else {
				dojo.style(ecopartcontainer, 'display', "none");
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
	
	refreshShopperAction: function(catEntryId, productId, displayType) {
		var inQuickInfo = (displayType == '_popup'),
		    contextToUpdate = inQuickInfo ? 'WCQuickInfoShopperAction_Context' : 'ShopperAction_Context';
		wc.render.updateContext(contextToUpdate, {"catalogEntryID": catEntryId, "productId": productId, "isItem": true, "displayType": displayType, "inQuickInfo": inQuickInfo});
	},

	/** 
	* Updates the product part number in the NameAndPrice widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	* @param {string} displayType _popup or null
	*/	 
	updateProductPartNumber: function(catEntryId, productId, displayType){
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;	 
		if(productDisplayJS.isPopup == true){
			document.getElementById('productSKUValue').innerHTML = catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
		} else {
			var partnumWidgets = dojo.query("span[id^='product_SKU_"+productId+"']");
			if(partnumWidgets != null){
				for(var i = 0; i<partnumWidgets.length; i++){				
					if(partnumWidgets[i]){
						partnumWidgets[i].innerHTML = catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
					}
				}
			}
		}
		
		// Update EcoPart
		productDisplayJS.updateEcoPart(catEntry, productId);
		
			if(stockAvailability_Popin) {
				$(stockAvailability_Popin).trigger("onComputeTask_Event", {productId : productId});
			}
			if(stockAvailability) {
				$(stockAvailability).trigger("onComputeTask_Event", {productId : productId});
			}
		
		// Update NoticeMontage
		productDisplayJS.updateNoticeMontage(catEntryId, productId);
	 },
	 updateAtoutPrix:function(catEntryId, productId){
		 var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;
		 var atp = document.getElementById('atoutPrix');
		 if(atp!=undefined) {
			 if(catEntry.atoutPrix=="1.0"){
				 atp.setAttribute('class', '');
				 document.getElementById("atoutPrixComment").setAttribute('class', '');
			 }else{
				 atp.setAttribute('class', 'hidden');
				 document.getElementById("atoutPrixComment").setAttribute('class', 'hidden');
			 }
		 }else{
		 }
	 },
	 
	
	 /** les notices sont d�finies au niveau product et on va afficher/masquer la bonne notice au changement d'item
	  * Pour chaque notice une classe avec le partnumber permet d'associer la notice � un ou plusieurs items */
	 updateNoticeMontage: function(catEntryId, productId){
		 var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;
		 var partNumber = catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;

		 var currentNoticeMontage = dojo.query("#noticeMontageSection div."+partNumber); 
		 
		 var allNoticeMontage = dojo.query("#noticeMontageSection div.noticeMontageContainer");
		 
		 var section = dojo.query('a[name="noticeMontage"]').parents('.row');			
		 var menuItem = dojo.query('#bodyNavigationMenu li a[href="#noticeMontage"]').parents('li');
		 if (allNoticeMontage.length >0) {
			 //on masque
			 if (allNoticeMontage != null || otherNoticeMontage != 'undefined') {
				 for (var i =0; i < allNoticeMontage.length; i++) {
				 dojo.style(allNoticeMontage[i], 'display', "none");
				 }
			 }
			 
			 if (currentNoticeMontage.length >0 ) {
				 dojo.forEach(currentNoticeMontage, function(e){
					 dojo.style(e, 'display', "block");
				 });
				 dojo.style(section[0], 'display', "block");
				 if(!!menuItem[0]){
					 dojo.style(menuItem[0], 'display', "block");;
				 }
			 }
			 else {
				 // si pas de notice de montage pour l'item courant, on masque la section (et le menu)
				 
				 dojo.style(section[0], 'display', "none");
				 if(!!menuItem[0]){
					 dojo.style(menuItem[0], 'display', "none"); 
				 }
			 }
		 }
		 
	 },

	 /**
	  * Push a new event to Google Tag Manager
	  * 
	  * @param events, object contains the event to push
	  * 
	  * 	event = 
	  *		{
	  * 		"event" : "eventName",
	  * 		"eventCategory" : "aCategory",
	  * 		"eventAction" : "anAction"
	  * 		...
	  * 	}
	  * 
	  */
	 pushEventToGoogleTagManager : function(events) {
		 if(typeof(dataLayer) != 'undefined' && dataLayer != null) {
			 dataLayer.push(events);
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
	* Updates the product detailed description in the ProductBodyDisplayWidget Details part 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/	
	updateProductDetailedDescription: function(catEntryId, productId) {
		
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;
		
		var longDescText = catEntry.description[0].longDescription;
		var longDescId = 'product_detaileddescription_' + productId + '_longDesc';
		var longDescElement = dojo.byId(longDescId);
		if (longDescElement != null) {
			longDescElement.innerHTML = $('<div/>').html(longDescText).text();
		}
		
		var auxDescText = catEntry.description[0].auxDescription2;
		var auxDescId = 'product_detaileddescription_' + productId + '_auxDesc';
		var auxDescElement = dojo.byId(auxDescId);
		if (auxDescElement != null) {
			auxDescElement.innerHTML = $('<div/>').html(auxDescText).text();
		}
		
		var listPictosId = 'product_detaileddescription_' + productId + '_listePictos';
		var listPictosElement = dojo.byId(listPictosId);
		
		var querySection = dojo.query('a[name="detailedDescription"]').parents('.row');
		if (querySection.length > 0) {
			var section = querySection[0];
		}
		
		var queryMenuItem = dojo.query('#bodyNavigationMenu a[href="#detailedDescription"]').parents('li');
		if (queryMenuItem.length > 0) {
			var menuItem = queryMenuItem[0];;
		}
		
		if ((longDescText === null || longDescText.length === 0) && (auxDescText === null || auxDescText.length === 0) && listPictosElement === null) {
			if (section  && menuItem ) {
				dojo.addClass(section, 'hidden');
				dojo.addClass(menuItem, 'hidden');
			}
			return;
		}

		if (section && menuItem ) {
			dojo.removeClass(section, 'hidden');
			dojo.removeClass(menuItem, 'hidden');
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
	 * Updates ribon ads on full image, at sku change
	 */
	updateRibonAds:function(catEntryId, productId, displayType){
		var ribons= productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry.ribonAds;

		
		//remove former ones
		var mainImg= dojo.query("img[id='productMainImage']").parent()[0];
		dojo.query(".RibbonAdDefault",mainImg).forEach(dojo.destroy);
//		if(ribons!=undefined &&  ribons[0] !=undefined && ribons[0].id !=''){
//			//add mine
//			for(var i=0;i<ribons.length;i++){
//				var ribon=ribons[i];
//				var newribon = dojo.create("div", {"class":"RibbonAdDefault "+ribon.id, "innerHTML":ribon.val});
//				dojo.place(newribon,mainImg,"last");
//			}
//		}

	},
	
	/**
	 * Updates bandeau soldes on full image, at sku change
	 */
	updateBandeau:function(catEntryId, productId, displayType){
		var type= productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry.type;
		var soldeFlag= productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry.soldeFlagProduct;
		var PromoFlag= productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry.isOnSpecial;
		
		//remove former ones
		document.getElementById('ficheImage').removeAttribute('class', 'soldes promo');		
		if((soldeFlag =='1.0' || soldeFlag =='1') && type != 'STANDARD' ){
			//add mine
			document.getElementById('ficheImage').setAttribute('class', 'col s12 ficheImage surMesure soldes');
			}
		else if ((soldeFlag =='1.0' || soldeFlag =='1') && type == 'STANDARD' ){
			//add mine
			document.getElementById('ficheImage').setAttribute('class', 'col s12 ficheImage soldes');
			}
		
		else if (PromoFlag == 'true' && type != 'STANDARD' ) {
			document.getElementById('ficheImage').setAttribute('class', 'col s12 ficheImage surMesure promo');
		}
		
		else if (PromoFlag == 'true' && type == 'STANDARD') {
			document.getElementById('ficheImage').setAttribute('class', 'col s12 ficheImage promo');
		}
		
		else if (type != 'STANDARD'  ) {
			document.getElementById('ficheImage').setAttribute('class', 'col s12 ficheImage surMesure');
		}
		else {
			document.getElementById('ficheImage').setAttribute('class', 'col s12 ficheImage');
			}
	},
	


	/** 
	* Updates the product full image and angle images in the FullImage widget. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/		 
	updateProductImage:function(catEntryId, productId, displayType){
		var newFullImage = null;
		var newZoomImage = null;
		var newAngleThumbnail = null;
		var newAngleFullImage = null;
		
		var entitledItemId = "entitledItem_" + productId;
		var imageArr = productDisplayJS.getImageForSKU(entitledItemId);	
		if(imageArr != null){
			newAngleThumbnail = imageArr[3];
			newAngleFullImage = imageArr[4];
		} else {
			return;
		}
		if(catEntryId != null){
			newFullImage = imageArr[0];
			newZoomImage = imageArr[2];
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
							newZoomImage = productDisplayJS.entitledItems[x].ItemZoomImage;
							if(productDisplayJS.productAngleImages != null && productDisplayJS.productAngleImages[0] != null && productDisplayJS.productAngleImages[0] != undefined){
								newAngleThumbnail = productDisplayJS.productAngleImages[0].ItemAngleThumbnail;
								newAngleFullImage = productDisplayJS.productAngleImages[0].ItemAngleFullImage;
							}
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
		
		var imgWidgets = dojo.query("img[id='"+productDisplayJS.skuImageId+"']");
		for(var i = 0; i<imgWidgets.length; i++){				
			if(imgWidgets[i] != null && newFullImage != null){
				imgWidgets[i].src = newFullImage;
			}
		}
		
		//ECOCEA
		//AngleZoomImage
		var imgWidgets = dojo.query("img[id='"+productDisplayJS.skuImageId+"Preview']");
		for(var i = 0; i<imgWidgets.length; i++){				
			if(imgWidgets[i] != null && newFullImage != null){
				imgWidgets[i].src = newZoomImage;
			}
		}

		var productImgWidgets = dojo.query("input[id^='ProductInfoImage_"+productId+displayType+"']");
		for(var i = 0; i<productImgWidgets.length; i++){			
			if(productImgWidgets[i] != null && newFullImage != null){
				productImgWidgets[i].value = newFullImage;
			}
		}
		
		if(newAngleThumbnail != null && newAngleFullImage != null){
			productDisplayJS.changeViewImages(newAngleThumbnail, newAngleFullImage, displayType);
		} else {
			var angleImageArea = dojo.query("div[id^='ProductAngleImagesArea"+displayType+"']");
			if(angleImageArea != null){
				for(var i = 0; i<angleImageArea.length; i++){			
					if(null != angleImageArea[i]){
						angleImageArea[i].style.display = 'none';
					}
				}
			}		
		}
		dojo.topic.publish('ProductImageUpdated');
	}, 
	
	/** 
	* To notify the change in attribute to other components that is subscribed to 'DefiningAttributes_Changed' or 'DefiningAttributes_Resolved' event.
	* 
	* @param {string} productId The identifier of the product.
	* @param {string} entitledItemId The identifier of the entitled item.
	* @param {boolean} isPopup If the value is true, then this implies that the function was called from a quick info pop-up.
	* @param {boolean} displayPriceRange A boolean used to to determine whether or not to display the price range when the catEntry is selected. 	
	*/		 
	notifyAttributeChange: function(productId, entitledItemId, isPopup, displayPriceRange, displayType){
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
			dojo.topic.publish('DefiningAttributes_Resolved_'+productId, catalogEntryId, productId, displayType);
			
			//check if the json object is already present for the catEntry.
			var catEntry = productDisplayJS.itemPriceJsonOject[catalogEntryId];		
			
			if(catEntry != null && catEntry != undefined){
				productDisplayJS.publishAttributeResolvedEvent(catalogEntryId, productId, displayType);
			}
			//else check if the JSON is in the HTML
			else if(dojo.byId("defaultItemDetailJSON_"+catalogEntryId) != null){
				console.debug('notifyAttributeChange: retrieve default item details from html. id= itemDetailJSON_'+catalogEntryId);
				productDisplayJS.itemPriceJsonOject[catalogEntryId] = JSON.parse(dojo.byId("defaultItemDetailJSON_"+catalogEntryId).innerHTML);
				if(productDisplayJS.itemPriceJsonOject[catalogEntryId] != null && productDisplayJS.itemPriceJsonOject[catalogEntryId] != undefined){
					productDisplayJS.publishAttributeResolvedEvent(catalogEntryId, productId, displayType);
				}
			}
			//if json object is not present, call the service to get the details.
			else{
				var parameters = {};
				parameters.storeId = productDisplayJS.storeId;
				parameters.langId= productDisplayJS.langId;
				parameters.catalogId= productDisplayJS.catalogId;
				parameters.catalogEntryId= catalogEntryId;
				parameters.productId = productId;
				parameters.displayType = displayType;
				dojo.xhrPost({
					url: getAbsoluteURL() + "GetCatalogEntryDetailsByIDView",				
					handleAs: "json-comment-filtered",
					content: parameters,
					sync:true,
					service: productDisplayJS,
					load: productDisplayJS.publishAttributeResolvedEventServiceResponse,
					error: function(errObj,ioArgs) {
						//console.debug("productDisplayJS.notifyAttributeChange: Unexpected error occurred during an xhrPost request.");
					}
				});
			}
			refreshAddRemoveCompareProductDiv(productId, catalogEntryId,displayType,'compareContainer_' + productId + '_' + displayType);
		}
		else{
			dojo.topic.publish('DefiningAttributes_Changed', catalogEntryId, productId, displayType);
			dojo.topic.publish('DefiningAttributes_Changed_' + productId, catalogEntryId, productId, displayType);
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
		var displayType = ioArgs['args'].content['displayType'];
		//stores the json object, so that the service is not called when same catEntry is selected.
		productDisplayJS.itemPriceJsonOject[serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID] = serviceResponse;		
		
		productDisplayJS.publishAttributeResolvedEvent(serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID, productId, displayType);
	 },
	
	/** 
	* Publishes the 'DefiningAttributes_Resolved' event with the necessary parameters. 
	* 
	* @param {string} catEntryId The identifier of the sku.
	* @param {string} productId The identifier of the product.
	*/		
	publishAttributeResolvedEvent: function(catEntryId, productId, displayType){		
		if(!productDisplayJS.isPopup){
			dojo.topic.publish('DefiningAttributes_Resolved', catEntryId, productId, displayType);			
			//console.debug("Publishing event 'DefiningAttributes_Resolved' with params: catEntryId="+catEntryId +", productId="+productId);
		}
	},
	
	/**
	 * To notify the change in quantity to other components that is subscribed to ShopperActions_Changed event.
	 */
	notifyQuantityChange: function(quantity, productId){
		dojo.topic.publish('ShopperActions_Changed', quantity);
		if(stockAvailability) $(stockAvailability).trigger("onComputeTask_Event", {productId : productId});
		if(stockAvailability_Popin) $(stockAvailability_Popin).trigger("onComputeTask_Event", {productId : productId});
		
		//console.debug("Publishing event 'ShopperActions_Changed' with params: quantity="+quantity);
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
			
		//console.debug(wc.render.getRefreshControllerById('AttachmentPagination_Controller').renderContext.properties);
		var beginIndex = pageSize * ( pageNumber - 1 );
		cursor_wait();
		wc.render.updateContext('AttachmentPagination_Context', {'beginIndex':beginIndex});
		MessageHelper.hideAndClearMessage();
	}
	,nbDecimals:function(num){
		var match = ('' + num).match(/[0-9]+(\.[0-9]+)/);
        if (!match || match[1] == 0) {
            return 0;
        }else{
        	return match[1].length-1;
        }
	}
	,round2:function(valeur){
		if(productDisplayJS.nbDecimals(valeur)>=2){
			//valeur=Math.round(valeur ,2);
			//Arrondi � 2 chiffres apr�s virgule
			var valeurArrondie = Number(Math.round(valeur+'e2')+'e-2');
			if(valeurArrondie != null && valeurArrondie != 'undefined' && valeurArrondie != undefined){
				//On fixe le nombre de d�cimal � 2 obligatoirement
				valeurArrondie = valeurArrondie.toFixed(2);
				return valeurArrondie;
			}
		}
		return valeur;
	}
	,roundN:function(valeur,digits){
		if(productDisplayJS.nbDecimals(valeur)>=digits){
			//valeur=Math.round(valeur ,digits);
			//Arrondi a 2 chiffres apres virgule
			var valeurArrondie = Number(Math.round(valeur+'e'+digits)+'e-'+digits);
			if(valeurArrondie != null && valeurArrondie != 'undefined' && valeurArrondie != undefined){
				//On fixe le nombre de decimal a 2 obligatoirement
				valeurArrondie = valeurArrondie.toFixed(digits);
				return valeurArrondie;
			}
		}
		return valeur;
	}
	,formatNumber:function(nombre){
		return (''+nombre).replace(".",",");
	}
	,updateSurface:function(catEntryId, productId){
		var catalogEntryId = catEntryId;
		var catEntry = productDisplayJS.itemPriceJsonOject[catEntryId].catalogEntry;
	
		if(catEntry){	
			var surfaceMap = dojo.query("div[id='coeffArea_"+productId+"']");
			if(surfaceMap != null ){
				for(var i = 0; i<surfaceMap.length; i++){		
					if(surfaceMap[i]) {
						//0001097: [Quick view] - Un texte "Unit�" pr�c�d� du prix est affich�
						if(catEntry.uniteSecondaire && catEntry.uniteVenteLegale && catEntry.uniteVenteLegale.toLowerCase() != catEntry.uniteSecondaire.toLowerCase()) {
							var content = "";
							if(catEntry.offerPriceValueNumber != ""){
								if(catEntry.coeffConversionQuantite ){
									prix = catEntry.offerPriceValueNumber*catEntry.coeffConversionQuantite;
									if(prix > 0) {
										prixFormatted=productDisplayJS.formatNumber(productDisplayJS.round2(prix));
										content=catEntry.colisagePriceLabel.replace('PRICE',prixFormatted).replace('NBUNIT',catEntry.coeffConversionQuantite).replace(".",",");
									}
								}else if(catEntry.coeffConversionPrix){
									prix = catEntry.offerPriceValueNumber/catEntry.coeffConversionPrix;
									if(prix > 0) {
										coeff= 1/catEntry.coeffConversionPrix;
										coeff=productDisplayJS.formatNumber(productDisplayJS.roundN(coeff,3));

										prixFormatted=productDisplayJS.formatNumber(productDisplayJS.round2(prix));
										content=catEntry.colisagePriceLabel.replace('PRICE',prixFormatted).replace('NBUNIT',coeff).replace(".",",");
									}
								}
							}
							
							surfaceMap[i].innerHTML = content;
						} else {
							surfaceMap[i].innerHTML = '';
						}
					}
				}
			}
			var uvl= dojo.query("span[id='uniteVenteLabel_"+productId+"']");
			if(uvl != null ){
				for(var i = 0; i<uvl.length; i++){		
					if(uvl[i]) {
						if(catEntry.uniteSecondaire && catEntry.uniteVenteLegale && catEntry.uniteVenteLegale.toLowerCase() != catEntry.uniteSecondaire.toLowerCase()) {
							uvl[i].innerHTML = "le "+catEntry.uniteVenteLegaleLabel;
						} else {
							uvl[i].innerHTML = '';
						}
					}
				}
			}
	
			var quantity = dojo.query("div[id='qtySurface_"+productId+"']");
			for(var i = 0; i<quantity.length; i++){		
				if(quantity[i]) {
					var content = "";
					if ((catEntry.coeffConversionQuantite || catEntry.coeffConversionPrix) && catEntry.uniteSecondaire && catEntry.uniteVenteLegale && catEntry.uniteVenteLegale.toLowerCase() != catEntry.uniteSecondaire.toLowerCase()) {
						var coeff =1;
						if(catEntry.coeffConversionQuantite) coeff =catEntry.coeffConversionQuantite;
						else coeff =Math.round(1/catEntry.coeffConversionPrix*1000)/1000;
						content = '<label for="surface">'+catEntry.quantityLegaleFieldLabel+'</label>'
							+'<input type="hidden" id="coeff_'+productId+'" value="'+coeff+'"/><input type="hidden" id="colisage_'+productId+'" value="'+catEntry.contrainteColisage+'"/>'
							+'<div class="qty_controls_container">'
								+'<input type="text" class="quantity_input surface" id="surface_' + productId + '" name="surface">'
							+ catEntry.uniteVenteLegaleLabel + '</div>';
	
						quantity[i].innerHTML = content;
						$('#surface_' + productId).on('keydown', checkNumericInputWithAllowedDot);
						$('#surface_' + productId).on('paste', function() { return false });
						$('#surface_' + productId).on('change', function() { QuickInfoJS.updateQty(productId, coeff, catEntry.contrainteColisage) } );
						QuickInfoJS.updateSurface(productId,coeff);
						
						// Décale l'affichage du prix
						dojo.addClass(dojo.byId("priceSectionRow"), "surfaceOffset");
						
					}else{
						quantity[i].innerHTML = content;
					}
				}
			}
		}
	},
	hideInfoBulleOptionsChoices:function() {
		dojo.cookie('comboUsageWarnClosed', 'true', {path:'/'});
		$('#infobulleOptionsChoices').remove();
	}
}

require(["dojo/query", "dojo/dom-construct", "dojo/on", "dojo/has", "dojo/mouse", "dojo/dom-class", "dojo/dom-style", "dojo/_base/sniff", "dojo/domReady!"], 
	function(query, domConstruct, on, has, mouse, domClass, domStyle) {
	if (has("ie") < 9) {
		on(document, ".compare_target > input[type=\"checkbox\"]:click", function(event) {
			this.blur();
			this.focus();
		});
	}
	
	function ecopartContainerMgt(mediaQuery) {
		var mobile = mediaQuery ? mediaQuery.matches : document.documentElement.clientWidth > 800;
		
		var queryEcoPartContainer = query('.collection.ecoPartContainer');
		if (queryEcoPartContainer.length > 0) {
			var ecoPartContainer = queryEcoPartContainer[0];
		} else {
			return;
		}
		
		var queryPriceDisplay = query('div[id^="price_display"]');
		if (queryPriceDisplay.length > 0) {
			var priceDisplay = queryPriceDisplay[0];
		} else {
			return;
		}
		
		var queryFicheInfosPrix = query('.ficheInfosPrix');
		if (queryFicheInfosPrix.length > 0) {
			var ficheInfosPrix = queryFicheInfosPrix[0];
		} else {
			return;
		}
		
		if (mobile) {
			dojo.place(ecoPartContainer, priceDisplay, "last");
			
		} else {
			dojo.place(ecoPartContainer, ficheInfosPrix, "first");
		}
	}
	
	var mediaQuery = window.matchMedia("(max-width: 800px)");
	    mediaQuery.addListener(ecopartContainerMgt);
	    
	ecopartContainerMgt(mediaQuery);
	
	// Product recommandation block
	query(".catentrydisplay-product").on(mouse.enter, function() {
		domClass.remove(query(".button-catentrydisplay", this)[0], "hidden");
		domClass.remove(query(".catentrydisplay-wishlist", this)[0], "hidden");
		domClass.add(query(".catentrydisplay-content", this)[0], "hidden");
		domStyle.set(query(".catentrydisplay-action-container", this)[0], "bottom", "25px");	
		domStyle.set(query(".catentrydisplay-price-container", this)[0], "top", "-150px");		
		domStyle.set(query(".catentrydisplay-price", this)[0], "position", "initial");		
	});
	query(".catentrydisplay-product").on(mouse.leave, function() {
		domClass.add(query(".button-catentrydisplay", this)[0], "hidden");
		domClass.add(query(".catentrydisplay-wishlist", this)[0], "hidden");
		domClass.remove(query(".catentrydisplay-content", this)[0], "hidden");
		domStyle.set(query(".catentrydisplay-action-container", this)[0], "bottom", "0");	
		domStyle.set(query(".catentrydisplay-price-container", this)[0], "top", "0px");
		domStyle.set(query(".catentrydisplay-price", this)[0], "position", "absolute");		
	});
});