//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2011, 2013 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

shoppingActionsJS={
		
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
	* A boolean used to to determine whether or not to diplay the price range when the catEntry is selected. 
	**/
	displayPriceRange : true,

	/**
	* This array holds the json object retured from the service, holding the price information of the catEntry.
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
	 * The prefix of the cookie key that is used to store item Ids. 
	 */
	cookieKeyPrefix: "CompareItems_",
	
	/**
	 * The delimiter used to separate item Ids in the cookie.
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
	
	shoppingListActionsAlreadyLoaded: false,
	
	/**
	 * An array to keep the details of the newly added products.
	 */
	productAddedList: new Object(),	
	
	setCompareReturnName:function(compareReturnName){
		this.compareReturnName = compareReturnName;
	},
	
	setSearchTerm:function(searchTerm){
		this.searchTerm = searchTerm;
	},
	
	setCommonParameters:function(langId,storeId,catalogId,userType,currencySymbol){
		this.langId = langId;
		this.storeId = storeId;
		this.catalogId = catalogId;
		this.userType = userType;
		this.currencySymbol = currencySymbol;
	},
	
	setEntitledItems : function(entitledItemArray){
		this.entitledItems = entitledItemArray;
	},
	
	getCatalogEntryId : function(entitledItemId){
		var attributeArray = [];
		var selectedAttributes = this.selectedAttributesList[entitledItemId];
		for(attribute in selectedAttributes){
			attributeArray.push(attribute + "_" + selectedAttributes[attribute]);
		}
		return this.resolveSKU(attributeArray);
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
		return this.resolveSKU(attributeArray);
	},
	
	/**
     * retrieves the entitledItemJsonObject
     */
    getEntitledItemJsonObject: function () {
    	return this.entitledItemJsonObject;
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
	
		//////////console.debug("Resolving SKU >> " + attributeArray +">>"+ this.entitledItems);
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
					//////////console.debug("CatEntryId:" + catentry_id + " for Attribute: " + attributeArray);
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
		//////////console.debug("setSelectedAttribute=>"+selectedAttributeName +" : "+ selectedAttributeValue);
		var selectedAttributes = this.selectedAttributesList[entitledItemId];
		if(selectedAttributes == null){
			selectedAttributes = new Object();
		}
		selectedAttributeValue = selectedAttributeValue.replace(this.replaceStr01, this.search01);
		selectedAttributeValue = selectedAttributeValue.replace(this.replaceStr02, this.search02);
		selectedAttributeValue = selectedAttributeValue.replace(this.ampersandChar, this.ampersandEntityName);
		selectedAttributes[selectedAttributeName] = selectedAttributeValue;
		this.moreInfoUrl=this.moreInfoUrl+'&'+selectedAttributeName+'='+selectedAttributeValue;
		this.selectedAttributesList[entitledItemId] = selectedAttributes;
		this.changeProdImage(entitledItemId, selectedAttributeName, selectedAttributeValue, skuImageId, imageField);
	},
	
	/**
	* setSelectedAttributeOfProduct Sets the selected attribute value for an attribute of a specified product.
	*								This function is used to set the assigned value of defining attributes to specific 
	*								products which will be stored in the selectedProducts map.
	*
	* @param {String} productId The catalog entry ID of the catalog entry to use.
	* @param {String} selectedAttributeName The name of the attribute.
	* @param {String} selectedAttributeValue The value of the selected attribute.
	* @param {boolean} true, if it is single SKU
	*
	**/
	setSelectedAttributeOfProduct : function(productId,selectedAttributeName,selectedAttributeValue, isSingleSKU){
		
		var selectedAttributesForProduct = null;

		if(this.selectedProducts[productId]){
			selectedAttributesForProduct = this.selectedProducts[productId];
		} else {
			selectedAttributesForProduct = new Object();
		}
		
		// add only if attribute has some name. value can be empty
		if(null != selectedAttributeName && '' != selectedAttributeName){
			selectedAttributesForProduct[selectedAttributeName] = selectedAttributeValue;
		}
		this.selectedProducts[productId] = selectedAttributesForProduct;
		
		//the json object for entitled items are already in the HTML. 
		var entitledItemJSON = eval('('+ dojo.byId("entitledItem_"+productId).innerHTML +')');

		this.setEntitledItems(entitledItemJSON);
		
		var catalogEntryId = this.getCatalogEntryIdforProduct(selectedAttributesForProduct);
		
		if(catalogEntryId == null) {
			catalogEntryId = 0;
		} else {
			// pass true to display price range
			this.changePrice("entitledItem_"+productId, false, true, productId);
			
			//Update selected sku in merchandising association array
			if(typeof MerchandisingAssociationJS != 'undefined'){
				if(MerchandisingAssociationJS.baseItemParams != null){
					if(MerchandisingAssociationJS.baseItemParams.type=='BundleBean'){
						// Update items in the bundle
						for(idx=0;idx<MerchandisingAssociationJS.baseItemParams.components.length;idx++){
							if(productId == MerchandisingAssociationJS.baseItemParams.components[idx].productId){
								MerchandisingAssociationJS.baseItemParams.components[idx].id = catalogEntryId;
							}
						}
					}
				}
			}			
		}
		var productDetails = null;
		if(this.productList[productId]){
			productDetails = this.productList[productId];
		} else {
			productDetails = new Object();
			this.productList[productId] = productDetails;
			productDetails.baseItemId = productId;
		}
		
		productDetails.id = catalogEntryId;
		if(productDetails.quantity){
			dojo.topic.publish("Quantity_Changed", dojo.toJson(productDetails));
		}
		
		if(!isSingleSKU){
			// publish the attribute change event
			if (catalogEntryId != 0) {
				dojo.topic.publish('DefiningAttributes_Resolved_'+productId, catalogEntryId, productId);
			}
		}
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
		
		this.setEntitledItems(entitledItemJSON);
		var catalogEntryId = this.getCatalogEntryId(entitledItemId);
		
		if(catalogEntryId!=null){
			var productId = entitledItemId.substring(entitledItemId.indexOf("_")+1);
			this.AddItem2ShopCartAjax(catalogEntryId , quantity,customParams, productId);
			this.baseItemAddedToCart=true;
			if(dijit.byId('second_level_category_popup') != null){
				hidePopup('second_level_category_popup');
			}
		}
		else if (isPopup == true){
			dojo.byId('second_level_category_popup').style.zIndex = '1';
			MessageHelper.formErrorHandleClient('addToCartLinkAjax', storeNLS['ERR_RESOLVING_SKU']);			
		} else{
			MessageHelper.displayErrorMessage(storeNLS['ERR_RESOLVING_SKU']);
			this.baseItemAddedToCart=false;
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
		
		this.productAddedList = new Object();
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
			for(attr in this.selectedAttributesList['entitledItem_'+productId]){
				selectedAttrList[attr] = this.selectedAttributesList['entitledItem_'+productId][attr];
			}			
			
			if(productId == undefined){
				this.saveAddedProductInfo(quantity, catEntryIdentifier, catEntryIdentifier, selectedAttrList);
			} else {
				this.saveAddedProductInfo(quantity, productId, catEntryIdentifier, selectedAttrList);
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
		this.baseItemAddedToCart=true;
		
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
	
	/**
	* AddBundle2ShopCartAjax This function is used to add a bundle to the shopping cart.
	**/
	AddBundle2ShopCartAjax : function(){
		var ajaxShopCartService = "AddOrderItem";
		var params = [];

		params.storeId		= this.storeId;
		params.catalogId	= this.catalogId;
		params.langId		= this.langId;
		params.orderId		= ".";
		params.calculationUsage = "-1,-2,-5,-6,-7";
		params.inventoryValidation = "true";
		
		var idx = 1;
		this.productAddedList = new Object();
		
		for(productId in this.productList){
			var productDetails = this.productList[productId];
			var quantity = dojo.number.parse(productDetails.quantity);
			if (quantity == 0) {
				continue;
			}
			if(productDetails.id == 0){
				MessageHelper.displayErrorMessage(storeNLS['ERR_RESOLVING_SKU']);
				return;
			}
			if(isNaN(quantity) || quantity < 0){
				MessageHelper.displayErrorMessage(storeNLS['QUANTITY_INPUT_ERROR']);
				return;
			}

			params["catEntryId_" + idx] = productDetails.id;
			params["quantity_" + idx++] = quantity;
			this.baseItemAddedToCart=true;
				
			this.saveAddedProductInfo(quantity, productId, productDetails.id, this.selectedProducts[productId]);
		}

		//For Handling multiple clicks
		if(!submitRequest()){
			return;
		}   		
		cursor_wait();		
		wc.service.invoke(ajaxShopCartService, params);

	},
		
	resetProductAddedList: function () {
		shoppingActionsJS.productAddedList = new Object();
	},
	/**
	* Save the product information of the newly added product(s) to be used for the mini cart product added popup
	*
	* @param {String} quantity The quantity of the product being purchased.
	* @param {String} productId The id of the product.
	* @param {String} skuId The id of the sku.
	* @param {String} attrList The list of selected attributes for the product, if any.
	**/	
	saveAddedProductInfo:function(quantity, productId, skuId, attrList){
	
		var productName = "";
		if(document.getElementById("ProductInfoName_"+productId) != null){
			productName = document.getElementById("ProductInfoName_"+productId).value;
		} else if(document.getElementById("ProductInfoName_"+skuId) != null){
			productName = document.getElementById("ProductInfoName_"+skuId).value;
		}
		
		var productThumbnail = "";
		if(document.getElementById("ProductInfoImage_"+productId) != null){
			productThumbnail = document.getElementById("ProductInfoImage_"+productId).value;
		} else if(document.getElementById("ProductInfoImage_"+skuId) != null){
			productThumbnail = document.getElementById("ProductInfoImage_"+skuId).value;
		}
		
		var productPrice = "";
		//ECOCEA: save the current item price.
		if(document.getElementById('offerPrice_list_'+productId) != null){
			productPrice = document.getElementById('offerPrice_list_'+productId).innerHTML;
		}
		
		var productAdded = [productName, productThumbnail, productPrice, quantity, attrList];
		if(productId != skuId){
			this.productAddedList[skuId] = productAdded;
		} else {
			this.productAddedList[productId] = productAdded;
		}
		
		dojo.topic.publish("ProductInfo_Added", this.productAddedList);
	},
	
	/* SwatchCode start */

	/**
	*setSKUImageId Sets the ID of the image to use for swatch.
	**/
	setSKUImageId:function(skuImageId){
		this.skuImageId = skuImageId;
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
		var selectedAttributes = this.selectedAttributesList[entitledItemId];
		for(attribute in selectedAttributes){
			attributeArray.push(attribute + "_" + selectedAttributes[attribute]);
		}
		return this.resolveImageForSKU(attributeArray, imageField);
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
	
		//console.debug("resolveImageForSKU " );
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
					//////////console.debug("ItemImage:" + imagePath + " for Attribute: " + attributeArray);
					var imageArray = [];
					imageArray.push(imagePath);
					imageArray.push(this.entitledItems[x].ItemThumbnailImage);
					imageArray.push(this.entitledItems[x].ItemZoomImage);
					if(this.entitledItems[x].ItemAngleThumbnail != null && this.entitledItems[x].ItemAngleThumbnail != undefined){
						imageArray.push(this.entitledItems[x].ItemAngleThumbnail);
						imageArray.push(this.entitledItems[x].ItemAngleFullImage);
						imageArray.push(this.entitledItems[x].ItemAngleZoomImage);
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
	* @param {String[]} itemAngleZoomImage An array of SKU view zoom image. (ECOCEA)
	**/
	changeViewImages : function(itemAngleThumbnail, itemAngleFullImage, itemAngleZoomImage){
		var imageCount = 0;
		for (x in itemAngleThumbnail) {
			var prodAngleCount = imageCount;
			imageCount++;
			if(null != dojo.byId("WC_CachedProductOnlyDisplay_images_1_" + imageCount)){
				dojo.byId("WC_CachedProductOnlyDisplay_images_1_" + imageCount).src = itemAngleThumbnail[x];
			}
			if(null != dojo.byId("WC_CachedProductOnlyDisplay_links_1_" + imageCount)){
				dojo.byId("WC_CachedProductOnlyDisplay_links_1_" + imageCount).href =
					"JavaScript:changeThumbNail('productAngleLi" + prodAngleCount + "','" + itemAngleFullImage[x] + "','"+itemAngleZoomImage[x]+"');";
			}
			
			if(null != dojo.byId("productAngleLi" + prodAngleCount) && dojo.byId("productAngleLi" + prodAngleCount).className == "selected"){
				changeThumbNail("productAngleLi" + prodAngleCount, itemAngleFullImage[x],itemAngleZoomImage[x]);
			}
		}
	},

	
	/**
	* updates the product image from the PDP page to use the selected SKU image
	* @param String swatchAttrName the newly selection attribute name
	* @param String swatchAttrValue the newly selection attribute value
	* @param {String} imageField, the field name from which the image should be picked
	**/
	changeProdImage: function(entitledItemId, swatchAttrName, swatchAttrValue, skuImageId, imageField){
		//console.debug("call changeProdImage");
		if (dojo.byId(entitledItemId)!=null) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
		}

		this.setEntitledItems(entitledItemJSON);
		var productId = entitledItemId.substring(entitledItemId.indexOf("_")+1);

		var skuImage = null;
		var imageArr = shoppingActionsJS.getImageForSKU(entitledItemId, imageField);
		if(imageArr != null){
			skuImage = imageArr[0];
		}
		
		if(skuImageId != undefined){
			this.setSKUImageId(skuImageId);
		}
		
		if(skuImage != null){
			if(dojo.byId(this.skuImageId) != null){
				document.getElementById(this.skuImageId).src = skuImage;	
				if(document.getElementById("ProductInfoImage_"+productId) != null){
					document.getElementById("ProductInfoImage_"+productId).value = skuImage;
				}				
				
				var itemAngleThumbnail = imageArr[3];
				var itemAngleFullImage = imageArr[4];
				var itemAngleZoomImage = imageArr[5];
				if(itemAngleThumbnail != null && itemAngleThumbnail != undefined){
					shoppingActionsJS.changeViewImages(itemAngleThumbnail, itemAngleFullImage, itemAngleZoomImage);
				}
			}
		} else {
			var imageFound = false;
			for (x in this.entitledItems) {
				var Attributes = this.entitledItems[x].Attributes;
				if(null != imageField){
					var itemImage = this.entitledItems[x][imageField];
				} else {
				var itemImage = this.entitledItems[x].ItemImage467;
				}
				
				
				var itemAngleThumbnail = this.entitledItems[x].ItemAngleThumbnail;
				var itemAngleFullImage = this.entitledItems[x].ItemAngleFullImage;
				var itemAngleZoomImage = this.entitledItems[x].ItemAngleZoomImage;
	
				for(y in Attributes){
					var index = y.indexOf("_");
					var entitledSwatchName = y.substring(0, index);
					var entitledSwatchValue = y.substring(index+1);	
					
					if (entitledSwatchName == swatchAttrName && entitledSwatchValue == swatchAttrValue) {
						// set sku image only if the img element is present
						if(null != dojo.byId(this.skuImageId) && typeof(itemImage) != 'undefined' && itemImage != null && trim(itemImage).length > 0){
							dojo.byId(this.skuImageId).src = itemImage;
							if(document.getElementById("ProductInfoImage_"+productId) != null){
								document.getElementById("ProductInfoImage_"+productId).value = itemImage;
							}
						}	
						if(itemAngleThumbnail != null && itemAngleThumbnail != undefined){
							shoppingActionsJS.changeViewImages(itemAngleThumbnail, itemAngleFullImage,itemAngleZoomImage);
						}
						imageFound = true;
						break;
					}
				}
				
				if(imageFound){
					break;
				}
			}
		}
	},
	
	/**
	* Updates the swatches selections on list view.
	* Sets up the swatches array and sku images, then selects a default swatch value.
	* 
	* ECO: update price/qty with default items values
	**/	
	updateSwatchListView: function(){
		//console.debug("updateSwatchListView call");
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
			
			var swatchDefault = dojo.query("a[id^='swatch_selectDefault1_']");
			for(var i = 0; i<swatchDefault.length; i++){
				var swatchDefaultElement = swatchDefault[i];
				eval(dojo.attr(swatchDefaultElement,"href"));
			}
			//select default item for each
			var productListForDefault = dojo.query("div[id^='entitledItem_']");
			var nb = productListForDefault.length;
			for(var i = 0; i<nb; i++){
				var id= productListForDefault[i].id.split('_')[1];
				shoppingActionsJS.changePrice("entitledItem_"+id,false,true,id);
				shoppingActionsJS.updateSurface("entitledItem_"+id, id);
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
		//console.debug("selectSwatch");
		if(document.getElementById("swatch_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributeValue, "color_swatch_disabled") == null || 
				dojo.hasClass("swatch_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributeValue, "color_swatch_disabled")){
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
					swatchElement.className = "color_swatch button tooltip";
					if(swatchElement.src != null)
						swatchElement.src = swatchElement.src.replace("_disabled.png","_enabled.png");
					
				}
			}
			if (document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributes[attribute]) != null) {
				document.getElementById("swatch_link_" + entitledItemId + "_" + selectedAttributeIdentifier + "_" + selectedAttributes[attribute]).setAttribute("aria-checked", "false");
			}
		}
		this.makeSwatchSelection(selectedAttributeIdentifier, selectedAttributeValue, entitledItemId, allSwatchAttributes, skuImageId, imageField);
	},

	swatchListChanged: function(event, selectedAttributeIdentifier, entitledItemId, allSwatchAttributes, skuImageId, imageField, registered, displayPriceRange, isPopup) {
		var selectedAttributeValue = event.target.options[event.target.selectedIndex].value;
		this.selectSwatch(selectedAttributeIdentifier, selectedAttributeValue, 'entitledItem_' + entitledItemId, allSwatchAttributes, skuImageId, imageField);
		this.changePrice('entitledItem_' + entitledItemId, isPopup, displayPriceRange, entitledItemId);
		this.updateSurface('entitledItem_' + entitledItemId, entitledItemId);
		if (registered) {
			this.changeWishListButton('entitledItem_' + entitledItemId, entitledItemId);
		}
	},

	/**
	* Make swatch selection - add to selectedAttribute, select image, and update other swatches and SKU image based on current selection.
	* @param {String} swatchAttrIdentifier The name of the selected swatch attribute.
	* @param {String} swatchAttrValue The value of the selected swatch attribute.
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} doNotDisable The name of the swatch attribute that should never be disabled.	
	* @param {String} skuImageId This is optional. The element id of the product image - image element id is different in product page and category list view. Product page need not pass it because it is set separately
	* @param {String} imageField This is optional. The json field from which image should be picked. Pass value if a different size image need to be picked
	**/
	makeSwatchSelection: function(swatchAttrIdentifier, swatchAttrValue, entitledItemId, doNotDisable, skuImageId, imageField) {
		// setSelectedAttribute internally calls changeProdImage method to change product image.
		this.setSelectedAttribute(swatchAttrIdentifier, swatchAttrValue, entitledItemId, skuImageId, imageField);

		var swatchOptionElement = dojo.byId('swatch_option_' + entitledItemId + '_' + swatchAttrIdentifier + '_' + swatchAttrValue);
		if (swatchOptionElement) {
			swatchOptionElement.selected = true;
		}

		document.getElementById("swatch_" + entitledItemId + "_" + swatchAttrIdentifier + "_" + swatchAttrValue).className = "color_swatch_selected tooltip";
		document.getElementById("swatch_link_" + entitledItemId + "_" + swatchAttrIdentifier + "_" + swatchAttrValue).setAttribute("aria-checked", "true");
		if(document.getElementById("swatch_selection_label_" + entitledItemId + "_" + swatchAttrIdentifier) != null)
			document.getElementById("swatch_selection_label_" + entitledItemId + "_" + swatchAttrIdentifier).className = "header color_swatch_label";
		if (document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier) != null && document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier).style.display == "none") {
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier).style.display = "inline";
		}
		if(document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier) != null)
			document.getElementById("swatch_selection_" + entitledItemId + "_" + swatchAttrIdentifier).innerHTML = swatchAttrValue;
		this.updateSwatchImages(swatchAttrIdentifier, entitledItemId, doNotDisable,imageField,skuImageId);
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
			swatchList = new Array();;
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
	* Check the entitledItems array and pre-select the first entited SKU as the default swatch selection.
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} doNotDisable The name of the swatch attribute that should never be disabled.		
	**/
	makeDefaultSwatchSelection: function(entitledItemId, doNotDisable) {
		if (this.entitledItems.length == 0) {
			if (dojo.byId(entitledItemId)!=null) {
				 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
			}
			this.setEntitledItems(entitledItemJSON);
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
	* @param selectedAttrName The attribute Identifier that is selected
	* @param {String} entitledItemId The ID of the SKU.
	* @param {String} allSwatchAttributes List of all swatch attributes.
	**/
	updateSwatchImages: function(selectedAttrName, entitledItemId, allSwatchAttributes,imageField,skuImageId) {
		//console.log("updateSwatchImages=> selectedAttrName="+selectedAttrName+",allSwatchAttributes="+allSwatchAttributes);
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
		for (x in this.entitledItems) {
			var Attributes = this.entitledItems[x].Attributes;
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
			////console.log("swatchToUpdateName="+swatchToUpdateName+",swatchToUpdateValue= "+swatchToUpdateValue);

			for(y in availablesCombinaisonsList){
				var oneCombinaison = availablesCombinaisonsList[y];
				//on regarde si le swatch courant est pr�sent dans l'une des combinaisons
				//1: on v�rifie d'abord que la combinaison est valide par rapport au swatchs d�ja s�l�ctionn�s.
				var isCombinaisonPrerequisOK = false;
				for(z=0;z<=indexOfAttrName;z++){
					var attrNameSelected = allSwatchAttributesArray[z];
					var attrValueSelected = selectedAttributes[allSwatchAttributesArray[z]];
					////console.log("attrNameSelected="+attrNameSelected+", and attrValueSelected="+attrValueSelected);
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
		
		// If there were any previously selected attributes that are now unavailable
		// Find another available value for that attribute and update other attributes according to the new selection
		for(i in disabledAttributes){
			var disabledAttributeName = disabledAttributes[i][0];
			var disabledAttributeValue = disabledAttributes[i][1];

			for (i in swatchToUpdate) {
				var swatchToUpdateName = swatchToUpdate[i][0];
				var swatchToUpdateValue = swatchToUpdate[i][1];
				var swatchToUpdateEnabled = swatchToUpdate[i][5];	
				
				if(swatchToUpdateName == disabledAttributeName && swatchToUpdateValue != disabledAttributeValue && swatchToUpdateEnabled){
						//////////console.log("disable:swatchToUpdateName="+swatchToUpdateName+", and swatchToUpdateValue= "+swatchToUpdateValue);
						this.makeSwatchSelection(swatchToUpdateName, swatchToUpdateValue, entitledItemId, allSwatchAttributes,imageField);
					break;
				}
			}
		}
		
		//ECOCEA: on selectionne le swatch suivant jusqu'a ce qu'on arrive au dernier.
		var nextAttrName = allSwatchAttributesArray[indexOfAttrName+1];
		var nextAttrValue = selectedAttributes[nextAttrName];
		//////////console.log("nextAttrName="+nextAttrName+", and nextAttrValue="+nextAttrValue);
		if(nextAttrName != undefined && nextAttrValue != undefined){
			//////console.log("selectSwatch=>nextAttrName="+nextAttrName+",nextAttrValue="+nextAttrValue+",entitledItemId="+entitledItemId+",allSwatchAttributes="+allSwatchAttributes);
			this.selectSwatch(nextAttrName, nextAttrValue, entitledItemId, allSwatchAttributes, skuImageId, imageField);
		}

	},
	/* SwatchCode end */
		
	/**
	* This function is used to change the price displayed in the Product Display Page on change of  a attribute of the product using an AJAX call. 
	* This function will resolve the catentryId using entitledItemId and displays the price of the catentryId.
	*				
	* @param {Object} entitledItemId A DIV containing a JSON object which holds information about a catalog entry. You can reference CachedProductOnlyDisplay.jsp to see how that div is constructed.
	* @param {Boolean} isPopup If the value is true, then this implies that the function was called from a quick info pop-up.
	* @param {Boolean} displayPriceRange If the value is true, then display the price range. If it is false then donot display the price range.
	*
	**/
	changePrice : function(entitledItemId,isPopup,displayPriceRange,productId){
		this.displayPriceRange = displayPriceRange;
		this.isPopup = isPopup;
		var entitledItemJSON;

		if (dojo.byId(entitledItemId)!=null && !this.isPopup) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = this.getEntitledItemJsonObject(); 
		}
		var catalogEntryId = null;
		this.setEntitledItems(entitledItemJSON);
		
		if(this.selectedProducts[productId]){
			var catalogEntryId = this.getCatalogEntryIdforProduct(this.selectedProducts[productId]);
		} else {
			var catalogEntryId = this.getCatalogEntryId(entitledItemId);
		}
		if(catalogEntryId!=null){
			//check if the json object is already present for the catEntry.
			dojo.topic.publish("ShopplinList_AttributesDefining_Changed", catalogEntryId, productId);
			if(this.itemPriceJsonOject[catalogEntryId] != null && this.itemPriceJsonOject[catalogEntryId] != 'undefined'){
				this.displayPrice(this.itemPriceJsonOject[catalogEntryId].catalogEntry,productId);
			}
			//else check if the JSON is in the HTML
			else if(dojo.byId("defaultItemDetailJSON_"+catalogEntryId) != null){
				console.debug('retrieve default item details from html. id= itemDetailJSON_'+catalogEntryId);
				this.itemPriceJsonOject[catalogEntryId] = eval('('+ dojo.byId("defaultItemDetailJSON_"+catalogEntryId).innerHTML +')');
				if(this.itemPriceJsonOject[catalogEntryId] != null && this.itemPriceJsonOject[catalogEntryId] != 'undefined'){
					this.displayPrice(this.itemPriceJsonOject[catalogEntryId].catalogEntry,productId);
				}
			}
			//if json object is not present, call the service to get the details.
			else{
				var parameters = {};
				parameters.storeId = this.storeId;
				parameters.langId= this.langId;
				parameters.catalogId= this.catalogId;
				parameters.catalogEntryId= catalogEntryId;
				parameters.productId = productId;

				dojo.xhrPost({
					url: getAbsoluteURL() + "GetCatalogEntryDetailsByIDView",				
					handleAs: "json-comment-filtered",
					content: parameters,
					sync:true,
					service: this,
					load: shoppingActionsJS.displayPriceServiceResponse,
					error: function(errObj,ioArgs) {
						//////////console.debug("ShoppingActions.changePrice: Unexpected error occurred during an xhrPost request.");
					}
				});
			}
			refreshAddRemoveCompareProductDiv(productId, catalogEntryId,'','compareContainer_' + productId);
		}
		else{
			//////////console.debug("ShoppingActions.changePrice: all attributes are not selected.");
		}
				
	},
	
	changeWishListButton: function(entitledItemId, productId) {
		console.debug("changeWishListButton called with id="+entitledItemId )
		var catalogEntryId = this.findCatalogEntryId(entitledItemId, productId);
		if(catalogEntryId != null) {
			var buttonQuery = dojo.query('.productListingWidget a[id$=addToShoppingList_' + productId +']');
			if (buttonQuery.length > 0) {
				var button = buttonQuery[0];
				dojo.attr(button, 'href', 'javascript:wishList.openAddPopin("-1", "' + catalogEntryId + '");');
				dojo.attr(button, 'onclick', 'javascript:wishList.openAddPopin("-1", "' + catalogEntryId + '"); return false;');
			}
		}
	},
	
	updateShopperActionsForListView : function(entitledItemId, productId) {
		require(["dojo/html", "dojo/request/xhr"], function(html, xhr){
			console.log("this.shoppingListActionsAlreadyLoaded : " + shoppingActionsJS.shoppingListActionsAlreadyLoaded);
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			xhr(getAbsoluteURL() + "ShopperActionsListView", {
				query: {"catalogEntryID": shoppingActionsJS.findCatalogEntryId(entitledItemId, productId), "productId" : productId, "alreadyLoaded": shoppingActionsJS.shoppingListActionsAlreadyLoaded}
			}).then(function(data){
				html.set(dojo.byId("catalogEntryDisplayShopperAction_" + productId), data);
				cursor_clear();
			}, function(err){
				console.error(err);
				cursor_clear();
			}, function(evt){
				
			})
			
		})
//		$.get("/ShopperActionsListView", {"catalogEntryID": this.findCatalogEntryId(entitledItemId, productId), "productId" : productId, "alreadyLoaded": shoppingActionsJS.shoppingListActionsAlreadyLoaded}).done(function(data, status, params){
//			$("#catalogEntryDisplayShopperAction_" + productId).html(data);
//			shoppingActionsJS.shoppingListActionsAlreadyLoaded = true;
//			cursor_clear();
//		}).fail(function(errorThrown, statusText, message){
//			console.error("Cannot refresh ShopperActionsList. Repport : ErrorCode = " + errorThrown.status + ", message = " + message);
//			cursor_clear();
//		});
	},
	
	findCatalogEntryId : function(entitledItemId, productId) {
		var entitledItemJSON;

		if (dojo.byId(entitledItemId)!=null) {
			//the json object for entitled items are already in the HTML. 
			 entitledItemJSON = eval('('+ dojo.byId(entitledItemId).innerHTML +')');
		}else{
			//if dojo.byId(entitledItemId) is null, that means there's no <div> in the HTML that contains the JSON object. 
			//in this case, it must have been set in catalogentryThumbnailDisplay.js when the quick info
			entitledItemJSON = this.getEntitledItemJsonObject(); 
		}
		
		var catalogEntryId = null;
		this.setEntitledItems(entitledItemJSON);
		
		if(this.selectedProducts[productId]){
			var catalogEntryId = this.getCatalogEntryIdforProduct(this.selectedProducts[productId]);
		} else {
			var catalogEntryId = this.getCatalogEntryId(entitledItemId);
		}
		
		return catalogEntryId;
	},
	
	
	
	/** 
	 * Displays price of the catEntry selected with the JSON objrct returned from the server.
	 * 
	 * @param {object} serviceRepsonse The JSON response from the service.
	 * @param {object} ioArgs The arguments from the service call.
	 */	
	 displayPriceServiceResponse : function(serviceResponse, ioArgs){
		var productId = ioArgs['args'].content['productId'];
		//stores the json object, so that the service is not called when same catEntry is selected.
		shoppingActionsJS.itemPriceJsonOject[serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID] = serviceResponse;
		shoppingActionsJS.displayPrice(serviceResponse.catalogEntry,productId);
	},
	 
	 /** 
	 * Displays price of the attribute selected with the JSON oject.
	 * 
	 * Cette m�thode est appel� uniquement dans la vue liste des pages familles, recherche ...
	 * Pour les pages produits et la quickview, c'est le JS Productdisplay.js qui se charge d'afficher les prix en ajax.
	 * 
	 * @param {object} catEntry The JSON object with catalog entry details.
	 */	
	 displayPrice : function(catEntry,productId){

		var tempString;
		var popup = shoppingActionsJS.isPopup;

		if(popup == true){
			if(document.getElementById('productPrice') != null){
				document.getElementById('productPrice').innerHTML = catEntry.offerPrice;
			}
			if(document.getElementById('productName') != null){
				document.getElementById('productName').innerHTML = catEntry.description[0].name;
			}
			if(document.getElementById('productSKUValue') != null){
				document.getElementById('productSKUValue').innerHTML = catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
			}
		}
		
		if(popup == false){
			var innerHTML = "";


			this.setPriceInProductList(productId,catEntry.offerPrice);
			
			//Prix normal ou indisponible
			if(!catEntry.listPriced || catEntry.listPriced=='false' ){
				
				if(catEntry.offerPriceWithoutSymbol != undefined && catEntry.offerPriceWithoutSymbol != null && catEntry.offerPriceWithoutSymbol != ''){
					//innerHTML = "<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='price'><span itemprop='price'>" + catEntry.offerPrice + '</span>';
					innerHTML = catEntry.offerPrice;
					$('#supHTPriceCategoryPage_list_' +  productId).show();
					$('#supHTOldPriceCategoryPage_list_' +  productId).hide();
					$('#blockOfferPrice_list_' +  productId).removeClass("noPrice").addClass("price");
					$('#listViewAdd2CartUnavailable_' + productId).hide();
					$('#listViewAdd2Cart_' + productId).show();
					$('#priceFromDiv_list_'+productId).show();
				}else{
					//No price for this catentry => display the noPriceLabel
					//innerHTML = "<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='noPrice'><span itemprop='price'>" + catEntry.emptyPriceLabel + '</span>';
					innerHTML = catEntry.emptyPriceLabel;
					$('#supHTOldPricCategoryPage_list_' +  productId).hide();
					$('#supHTPriceCategoryPage_list_' +  productId).hide();
					$('#blockOfferPrice_list_' +  productId).removeClass("price").addClass("noPrice");
					$('#listViewAdd2CartUnavailable_' + productId).show();
					$('#listViewAdd2Cart_' + productId).hide();
					$('#priceFromDiv_list_'+productId).hide();
				}
				

				if(document.getElementById('offerPrice_list_'+productId) != null){
					document.getElementById('offerPrice_list_'+productId).innerHTML = innerHTML;
				}
				$('#blockOfferPrice_list_' +  productId).show();
				$('#listPrice_list_' +  productId).hide();
				$('#cguDisplayContainer_list_' +  productId).hide();
				$('#asterix_list_' + productId).hide();
				$('#promoDescription_list_' + productId).hide();
				$('#promoDescription_list_' + productId).html("");
			}
			//Prix barr�
			else{
				//innerHTML = "<span id='listPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='old_price_value' style='margin-bottom: -40px;'>" + catEntry.listPrice + "</span>"
				innerHTML =  catEntry.listPrice;
				if(document.getElementById('listPrice_list_'+productId) != null){
					document.getElementById('listPrice_list_'+productId).innerHTML = innerHTML;
				}
				
				//innerHTML =	"<span id='offerPrice_" + catEntry.catalogEntryIdentifier.uniqueID + "' class='price'><span itemprop='price'>" + catEntry.offerPrice + '</span> * ';
				innerHTML = catEntry.offerPrice ;
				if(document.getElementById('offerPrice_list_'+productId) != null){
					document.getElementById('offerPrice_list_'+productId).innerHTML = innerHTML;
				}
				
				$('#blockOfferPrice_list_' +  productId).removeClass("noPrice").addClass("price");
				
				$('#supHTPriceCategoryPage_list_' +  productId).show();
				$('#supHTOldPricCategoryPage_list_' +  productId).show();
				
				$('#blockOfferPrice_list_' +  productId).show();
				$('#listPrice_list_' +  productId).show();
				
				$('#cguDisplayContainer_list_' +  productId).show();
				
				$('#asterix_list_' + productId).show();
				
				$('#priceFromDiv_list_'+productId).show();
				
				$('#listViewAdd2CartUnavailable_' + productId).hide();
				$('#listViewAdd2Cart_' + productId).show();
				
				promoDescriptionInnerHTML = "";
				if(catEntry.priceAdjustments && catEntry.priceAdjustments.length > 0) {
					for(var i = 0 ; i < catEntry.priceAdjustments.length ; ++i) {
						priceAdjustement = catEntry.priceAdjustments[i];
						promoDescriptionInnerHTML += (priceAdjustement.promo_desc) ? "<div>" + priceAdjustement.promo_desc + "</div>" : "";
					}
				}
				
				if(promoDescriptionInnerHTML.length > 0) {
					$('#promoDescription_list_' + productId).html(promoDescriptionInnerHTML);
					$('#promoDescription_list_' + productId).show();
				}
			}
			
			
			innerHTML = "";
						
			// Update eco part
			shoppingActionsJS.updateEcoPart(catEntry, productId);
			
			//Update priceLabel
			shoppingActionsJS.changePriceLabel(productId,catEntry.priceLabel);
			
			
			/*
			 * If the product name is a link, do not replace the link only replace the text in the link.
			 * Otherwise, replace the whole text
			 */
			
			//ECOCEA the name must be the name of the product and not the item => do not change the name when selecting item.
			/*var productNameLink = dojo.query('#product_name_' + productId + ' > a');
			if(productNameLink.length == 1){
				productNameLink[0].innerHTML = catEntry.description[0].name;
			} else if(dojo.byId('product_name_'+productId)) {
				dojo.byId('product_name_'+productId).innerHTML = catEntry.description[0].name;
			}*/
			
			if(dojo.query("#widget_product_info_viewer > div[id^='PageHeading_']") != null){
				dojo.query("#widget_product_info_viewer > div[id^='PageHeading_']").forEach(function(node){
					if(node.childNodes != null && node.childNodes.length == 3){
						node.childNodes[1].innerHTML = catEntry.description[0].name;
					}
				});		
			}			
			if(document.getElementById("ProductInfoName_"+productId) != null){
				document.getElementById("ProductInfoName_"+productId).value = catEntry.description[0].name;
			}
			//ECOCEA the shortdesc must be the shortdesc of the product and not the item => do not change the shortdesc when selecting item.
			/*if(document.getElementById('product_shortdescription_'+productId)) {
				document.getElementById('product_shortdescription_'+productId).innerHTML = catEntry.description[0].shortDescription;
			}*/
			if(document.getElementById('product_SKU_'+productId)){
				document.getElementById('product_SKU_'+productId).innerHTML = storeNLS['SKU'] + " " + catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
			}
			
			//UpdateRibonAds
			shoppingActionsJS.updateRibonAds(catEntry,productId);
			//Update bandeau promo
			shoppingActionsJS.updateBandeau(catEntry,productId);
		}
	 },
	 
	 /**
		 * Updates ribon ads on thumbnail image, at sku change
		 */
		updateRibonAds:function(catEntryJSON,productId){
			if(catEntryJSON){
				var ribons= catEntryJSON.ribonAds;

				
				//remove former ones
				var mainImg= dojo.query("img[id='productThumbNailImage_" + productId + "']").parent()[0];
				dojo.query(".RibbonAdDefault",mainImg).forEach(dojo.destroy);
				if(ribons!=undefined &&  ribons[0] !=undefined && ribons[0].id !=''){
					//add mine
					for(var i=0;i<ribons.length;i++){
						var ribon=ribons[i];
						var newribon = dojo.create("div", {"class":"RibbonAdDefault "+ribon.id, "innerHTML":ribon.val});
						dojo.place(newribon,mainImg,"last");
					}
				}
			}
		},
		
		/**
		 * Updates bandeau soldes on thumbnail image, at sku change
		 */
		updateBandeau:function(catEntryJSON,productId){
			if(catEntryJSON){
				var type= catEntryJSON.type;
				var soldeFlag= catEntryJSON.soldeFlagProduct;
				var PromoFlag= catEntryJSON.isOnSpecial;
				
				//remove former ones
				if($('#product_image_list_' +  productId)){
					$('#product_image_list_' +  productId).removeClass("promo").removeClass("soldes");
					if(soldeFlag =='1.0' || soldeFlag =='1'){
						//add mine
						$('#product_image_list_' +  productId).addClass('soldes');
					}
					else if (PromoFlag =='true'){
						//add mine
						$('#product_image_list_' +  productId).addClass('promo');
					}
				}
				
			}
		},
	 
	changePriceLabel : function(productId,priceLabel){
		if(dojo.byId("priceLabel_" + productId) != null){
			dojo.byId("priceLabel_" + productId).innerHTML = priceLabel;
		}
	},
	 
	updateEcoPart : function(catEntry, productId) {
		var ecopartcontainer = document.getElementById('ecoPartContainer_' + productId);
		var ecopartLabel = dojo.query("div[id='ecoPartContainer_" + productId + "'] > span");
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
	 *This method will show the WC Dialog popup
	 *@param{String} widgetId The ID of the WC Dialog which should be shown
	 */
	showWCDialogPopup : function(widgetId){
		var popup = dijit.byId(widgetId); //Change the id of the popup div if it is changed in the html
		if(popup != null){
			popup.closeButtonNode.style.display='none';
			popup.show();
		}
		else {
			//////////console.debug(widgetId +" does not exist");
		}
	},
	
	/**
	 * To notify the change in attribute to other components that is subscribed to DefiningAttributes_Resolved_[productId] event.
	 */
	notifyAttributeChange: function(catalogEntryID){
		this.baseCatalogEntryId = catalogEntryID;
		var selectedAttributes = this.selectedAttributesList["entitledItem_" + catalogEntryID];
		dojo.topic.publish('DefiningAttributes_Resolved_'+catalogEntryID, catalogEntryID, -1);
	},
	
	/**
	 * To notify the change in quantity to other components that is subscribed to Quantity_Changed event.
	 */
	notifyQuantityChange: function(quantity){
		dojo.topic.publish("Quantity_Changed", quantity);
	},
	
	/**
	 * Initializes the compare check box for all the products added to compare.
	 */
	initCompare: function(fromPage){
		if(fromPage == 'compare'){
			this.checkForCompare();
		} else {
			var cookieKey = this.cookieKeyPrefix + this.storeId;
			var newCookieValue = "";
			dojo.cookie(cookieKey, newCookieValue, {path:'/'});
		}
		
	},
	
	/**
	 * Change the compare box status to checked or unchecked
	 * @param{String} cbox The ID of the compare check box of the given catentry identifier.
	 * @param{String} catEntryIdentifier The catalog entry identifer to current product.
	 */
	changeCompareBox: function(cbox,catEntryIdentifier) {
		box = document.getElementById(cbox);
		box.checked = !box.checked;
		this.addOrRemoveFromCompare(catEntryIdentifier,box.checked);
	},
	
	/**
	 * Adds or removes the product from the compare depending on the compare box checked or unchecked.
	 * @param{String} catEntryIdentifier The catalog entry identifer to current product.
	 * @param{boolean} checked True if the checkbox is checked or False
	 */
	addOrRemoveFromCompare: function(catEntryIdentifier,checked){
		//box = eval(cbox);
		if(checked){
			this.addToCompare(catEntryIdentifier);
		}
		else{
			this.removeFromCompare(catEntryIdentifier);
		}
	},
	
	/**
	 * Adds the product to the compare cookie.
	 * @param{String} catEntryIdentifier The catalog entry identifer to current product.
	 */
	addToCompare:function(catEntryIdentifier){
		
		var cookieKey = this.cookieKeyPrefix + this.storeId;
		var cookieValue = dojo.cookie(cookieKey);
		
		if(cookieValue != null){
			if(cookieValue.indexOf(catEntryIdentifier) != -1 || catEntryIdentifier == null){
				MessageHelper.displayErrorMessage(storeNLS["COMPARE_ITEM_EXISTS"]);
				return;
			}
		}
		
		var currentNumberOfItemsInCompare = 0;
		if(cookieValue != null && cookieValue != ""){
			currentNumberOfItemsInCompare = cookieValue.split(this.cookieDelimiter).length;
		}
		
		if (currentNumberOfItemsInCompare < parseInt(this.maxNumberProductsAllowedToCompare)) {
			var newCookieValue = "";
			if(cookieValue == null || cookieValue == ""){
				newCookieValue = catEntryIdentifier;
			}
			else{
				newCookieValue = cookieValue + this.cookieDelimiter + catEntryIdentifier;
			}
			dojo.cookie(cookieKey, newCookieValue, {path:'/'});
			shoppingActionsJS.checkForCompare();
		} else {
			//MessageHelper.displayErrorMessage(storeNLS["COMPATE_MAX_ITEMS"]);
			this.showWCDialogPopup('widget_product_comparison_popup');
			var compareboxes = dojo.query("input[id^='comparebox_"+catEntryIdentifier+"']");
			if(compareboxes != null) {
				for(var i = 0; i < compareboxes.length; i++) {
					compareboxes[i].checked = false;
				}
			}
			//////////console.debug("You can only compare up to 4 products");				
		}
		shoppingActionsJS.countCompareProducts();
		//coche les boxes si effectuer le quickview
		var boxes = document.getElementsByName('comparators_'+catEntryIdentifier);
		for(var i = 0;i<boxes.length;i++){
			if(boxes[i]!=null){
				eval(boxes[i].innerHTML);
			}
		}
	},
	
	/**
	 * Removes the product from the compare cookie.
	 * @param{String} catEntryIdentifier The catalog entry identifer to current product.
	 */
	removeFromCompare: function(catEntryIdentifier){
		var cookieKey = this.cookieKeyPrefix + this.storeId;
		var cookieValue = dojo.cookie(cookieKey);
		var currentNumberOfItemsInCompare = 0;
		if(cookieValue != null){
			if(dojo.trim(cookieValue) == ""){
				dojo.cookie(cookieKey, null, {expires: -1});
			}else{
				var cookieArray = cookieValue.split(this.cookieDelimiter);
				var newCookieValue = "";
				for(index in cookieArray){
					if(cookieArray[index] != catEntryIdentifier){
						if(newCookieValue == ""){
							newCookieValue = cookieArray[index];
						}else{
							newCookieValue = newCookieValue + this.cookieDelimiter + cookieArray[index];
						}
					}
				}
				dojo.cookie(cookieKey, newCookieValue, {path:'/'});
				currentNumberOfItemsInCompare = newCookieValue.split(this.cookieDelimiter).length;
			}
			shoppingActionsJS.checkForCompare();
		}
		shoppingActionsJS.countCompareProducts();
		//d�coche les boxes si effectuer le quickview
		var boxes = document.getElementsByName('comparators_'+catEntryIdentifier);
		for(var i = 0;i<boxes.length;i++){
			if(boxes[i]!=null){
				eval(boxes[i].innerHTML);
			}
		}
		console.log('publish OnRemoveProductFromComparatorEvent. catEntryId : ' + catEntryIdentifier);
		dojo.topic.publish('OnRemoveProductFromComparatorEvent', catEntryIdentifier);	
	},
	
	/**
	 * Re-directs the browser to the CompareProductsDisplay page to compare products side-by-side.
	 */
	compareProducts:function(categoryIds){
		var url = "CompareProductsDisplayView?storeId=" + this.storeId + "&catalogId=" + this.catalogId + "&langId=" + this.langId;
		
		if('' != categoryIds.top_category){
			url = url + "&top_category=" + categoryIds.top_category;
		}
		if('' != categoryIds.parent_category_rn){
			url = url + "&parent_category_rn=" + categoryIds.parent_category_rn;
		}
		if('' != categoryIds.categoryId){
			url = url + "&categoryId=" + categoryIds.categoryId;
		}
		var cookieKey = this.cookieKeyPrefix + this.storeId;
		var cookieValue = dojo.cookie(cookieKey);
		if(cookieValue != null && dojo.trim(cookieValue) != ""){
			url = url + "&catentryId=" + cookieValue;
		}
		var returnUrl = location.href;
		if(returnUrl.indexOf("?") == -1){
			returnUrl = returnUrl + "?fromPage=compare";
		} else if(returnUrl.indexOf("fromPage=compare") == -1){
			returnUrl = returnUrl + "&fromPage=compare";
		}
		url = url + "&returnUrl=" + encodeURIComponent(returnUrl);
		location.href = getAbsoluteURL() + url;
	},
	
	countCompareProducts:function() {
		var cookieKey = this.cookieKeyPrefix + this.storeId;
		var cookieValue = dojo.cookie(cookieKey);
		var countLabel = dojo.query("a[name='comparatorButton'] > label");
		var labelHeader = dojo.query("a[name='comparatorLinkHeader']");
		var countLabelHeader = dojo.query("a[name='comparatorLinkHeader'] > label");
		var compButton = dojo.query("a[name='comparatorButton'][role='button']");
		var enable = true;
		
		countLabel.forEach(function(node, index, arr){
			if(cookieValue == null || cookieValue.trim() == '') {
				node.innerHTML = '';
				enable = false;
			} else {
				var res = cookieValue.split(';');
				
				if (res.length > 1){
					node.innerHTML = ' ' + res.length + ' produits';
				} 
				else if (res.length == 1){
					node.innerHTML = ' ' + res.length + ' produit';
					enable = false;
				}
				else {
					enable = false;
					node.innerHTML = '';
				}

			}
		});
		
		countLabelHeader.forEach(function(node, index, arr){
			if(cookieValue == null || cookieValue.trim() == '') {
				node.innerHTML = '';
				enable = false;
			} else {
				var res = cookieValue.split(';');
				
				if (res.length > 1){
					node.innerHTML = ' (' + res.length + ')';
				} 
				else if (res.length == 1){
					node.innerHTML = ' (' + res.length + ')';
					enable = false;
				} 
				else {
					node.innerHTML = '';
					enable = false;
				}

			}
		});

		compButton.forEach(function(node, index, arr){
			if(!enable){
				node.setAttribute("onclick", "return false;");
				node.setAttribute("class", "button disable");
			}
			else{
				node.removeAttribute("onclick");
				node.setAttribute("class", "button");
			}
		});

		labelHeader.forEach(function(node, index, arr){
			if(!enable){
				node.setAttribute("onclick", "return false;");
				node.setAttribute("class", "disable");
			}
			else{
				node.removeAttribute("onclick");
				node.setAttribute("class", "");
			}
		});

	},
	
	/**
	 * Sets the quantity of a product in the list (bundle)
	 * 
	 * @param {String} catalogEntryType, type of catalogEntry (item/product/bundle/package)
	 * @param {int} catalogEntryId The catalog entry identifer to current product.
	 * @param {int} quantity The quantity of current product.
	 * @param {float} price The price of current product.
	 */
	setProductQuantity: function(catalogEntryType, catalogEntryId, quantity, price){
		var productDetails = null;
		if(this.productList[catalogEntryId]){
			productDetails = this.productList[catalogEntryId];
		} else {
			productDetails = new Object();
			this.productList[catalogEntryId] = productDetails;
			productDetails.baseItemId = catalogEntryId;
			if("item" == catalogEntryType){
				productDetails.id = catalogEntryId;
			} else {
				productDetails.id = 0;
			}
		}
		productDetails.quantity = quantity;
		dojo.topic.publish("Quantity_Changed", dojo.toJson(productDetails));
		
		productDetails.price = dojo.number.parse(price);
	},
	
	/**
	 * Sets the quantity of a product in the list (bundle)
	 * 
	 * @param {int} catalogEntryId The catalog entry identifer to current product.
	 * @param {int} quantity The quantity of current product.
	 */
	quantityChanged: function(catalogEntryId, quantity){
		if(this.productList[catalogEntryId]){
			var productDetails = this.productList[catalogEntryId];
			productDetails.quantity = dojo.trim(quantity);
			dojo.topic.publish("Quantity_Changed", dojo.toJson(productDetails));
			
			//Update quantity for catentries in the merchandising association array
			if(MerchandisingAssociationJS != null){
				if(MerchandisingAssociationJS.baseItemParams != null){
					if(MerchandisingAssociationJS.baseItemParams.type=='BundleBean'){
						// Update items in the bundle
						for(idx=0;idx<MerchandisingAssociationJS.baseItemParams.components.length;idx++){
							if(catalogEntryId == MerchandisingAssociationJS.baseItemParams.components[idx].productId || catalogEntryId == MerchandisingAssociationJS.baseItemParams.components[idx].id){
								MerchandisingAssociationJS.baseItemParams.components[idx].quantity = productDetails.quantity;
							}
						}
					}
				}
			}			
		}
	},
	
	/**
	 * Sets the price of a product in the list (bundle)
	 * 
	 * @param {int} catalogEntryId The catalog entry identifer to current product.
	 * @param {int} price The price of current product.
	 */
	setPriceInProductList: function(catalogEntryId, price){
		var productDetails = this.productList[catalogEntryId];
		if(productDetails){
			productDetails.price = price;
		}
	},
	
	/**
	 * Select bundle item swatch
	 * 
	 * @param {int} catalogEntryId The catalog entry identifer to current product.
	 * @param {String} swatchName
	 * @param {String} swatchValue
	 * @param {String} doNotDisable, the first swatch, that should not be disabled
	 */
	 selectBundleItemSwatch: function(catalogEntryId, swatchName, swatchValue, doNotDisable){
		if(dojo.hasClass("swatch_" + catalogEntryId + "_" + swatchName + "_" + swatchValue, "color_swatch_disabled")){
			return;
		}
		if (dojo.byId("entitledItem_"+catalogEntryId)!=null) {
			var entitledItemJSON;
			var currentSwatchkey = swatchName + "_" +swatchValue;
			//the json object for entitled items are already in the HTML. 
			entitledItemJSON = dojo.fromJson(dojo.byId("entitledItem_"+catalogEntryId).innerHTML);
			var validSwatchArr = new Array();
			for(idx in entitledItemJSON){
				var validItem = false;
				var entitledItem = entitledItemJSON[idx];
				for(attribute in entitledItem.Attributes){
					
					if(currentSwatchkey == attribute){
						validItem = true;
						break;
					}
				}
				if(validItem){
					for(attribute in entitledItem.Attributes){
						var currentSwatch = attribute.substring(0, attribute.lastIndexOf("_"));
						if(currentSwatch != doNotDisable && currentSwatch != swatchName){
							validSwatchArr.push(attribute);
						}
					}
				}
			}
			
			var swatchesDisabled = new Array();
			var selectedSwatches = new Array();
			for(idx in entitledItemJSON){
				var entitledItem = entitledItemJSON[idx];
				for(attribute in entitledItem.Attributes){
					var currentSwatch = attribute.substring(0, attribute.lastIndexOf("_"));
					if(currentSwatch != doNotDisable && currentSwatch != swatchName){
						var swatchId = "swatch_" + catalogEntryId +"_" + attribute;
						var swatchLinkId = swatchId.replace("swatch_","swatch_link_");
						if(dojo.indexOf(validSwatchArr, attribute) > -1){
							if(!dojo.hasClass(swatchId,"color_swatch_selected")){
								dojo.byId(swatchId).className = "color_swatch tooltip";
								dojo.byId(swatchId).src = dojo.byId(swatchId).src.replace("_disabled.png","_enabled.png");
								
								document.getElementById(swatchLinkId).setAttribute("aria-disabled", "false");
							}
						} else if(dojo.indexOf(swatchesDisabled, attribute) == -1){
							swatchesDisabled.push(attribute);
							if(dojo.hasClass(swatchId,"color_swatch_selected")){
								selectedSwatches.push(swatchId);
							}
							dojo.byId(swatchId).className = "color_swatch_disabled tooltip";
							dojo.byId(swatchId).src = dojo.byId(swatchId).src.replace("_enabled.png","_disabled.png");
							
							document.getElementById(swatchLinkId).setAttribute("aria-disabled", "true");
						}
					}
					if (document.getElementById("swatch_link_" + catalogEntryId +"_" + attribute) != null) {
						document.getElementById("swatch_link_" + catalogEntryId +"_" + attribute).setAttribute("aria-checked", "false");
					}
				}
			}
			
			for(idx in selectedSwatches){
				var selectedSwatch = selectedSwatches[idx];
				var idSelector = selectedSwatch.substring(0, selectedSwatch.lastIndexOf("_"));
				var swatchSelected = false;
				dojo.query("[id^='" + idSelector + "']").forEach(function(node, index, arr){
					if(!swatchSelected && dojo.hasClass(node,"color_swatch")){
						var values = node.id.split("_");
						shoppingActionsJS.selectBundleItemSwatch(values[1],values[2],values[3], doNotDisable);
						shoppingActionsJS.setSelectedAttributeOfProduct(values[1],values[2],values[3],false);
						swatchSelected = true;
					}
				});
			}
		}
		
		if(document.getElementById("swatch_selection_label_" + entitledItemId + "_" + swatchAttrName) != null) {
			if (dojo.byId("swatch_selection_" + catalogEntryId + "_" + swatchName).style.display == "none") {
				dojo.byId("swatch_selection_" + catalogEntryId + "_" + swatchName).style.display = "inline";
			}
			dojo.byId("swatch_selection_" + catalogEntryId + "_" + swatchName).innerHTML = swatchValue;
		}
		
		var swatchItem = "swatch_" + catalogEntryId + "_" + swatchName + "_";
		var swatchItemLink = "swatch_link_" + catalogEntryId + "_" + swatchName + "_";
		
		dojo.query("img[id^='" + swatchItem + "']").forEach(function(node, index, arr){
			if(dojo.hasClass(node, "color_swatch_disabled")){
				dojo.removeClass(node, "color_swatch")
			} else {
				dojo.addClass(node, "color_swatch");
			}
			dojo.removeClass(node, "color_swatch_selected");
		});
		
		dojo.byId(swatchItem + swatchValue).className = "color_swatch_selected tooltip";
		document.getElementById(swatchItemLink + swatchValue).setAttribute("aria-checked", "true");
		
		this.setSelectedAttributeOfProduct(catalogEntryId, swatchName, swatchValue,false);
		// select image
		this.changeBundleItemImage(catalogEntryId, swatchName, swatchValue, "productThumbNailImage_" + catalogEntryId);
		
	},
	
		
	
	/**
	 * Check if any product is already selected for compare in other pages and select them
	 */
	checkForCompare: function() {
		require(["dojo/_base/array", "dojo/cookie", "dojo/on", "dojo/query"], function(array, cookie, on, query) {
			var cookieValues = cookie(shoppingActionsJS.cookieKeyPrefix + shoppingActionsJS.storeId);
			cookieValues = (cookieValues ? cookieValues.split(shoppingActionsJS.cookieDelimiter) : []);
			var labels = query(".compareCheckboxLabels > label");
			if(labels != null && labels.length > 0) {
				query(".compare_target").forEach(function(div) {
					var checkbox = query("input[type=\"checkbox\"]", div)[0];
					checkbox.checked = (array.indexOf(cookieValues, checkbox.value) != -1);
					var state = (checkbox.checked ? (cookieValues.length >= 1 ? 1 : 0) : 0);
					div.setAttribute("data-state", state.toString());
					var spanlabels = dojo.query("span[id^='spanFor_" + checkbox.value + "']");
					if(spanlabels != null) {
						for(var i = 0; i < spanlabels.length; i++) {
							spanlabels[i].innerHTML = labels[state].innerHTML; 
						}
					}
				});
			}
		});
	},
	
	/**
	* replaceItemAjaxHelper This function is used to replace an item in the cart. This will be called from the {@link fastFinderJS.ReplaceItemAjax} method.
	*
	* @param {String} catalogEntryId The catalog entry of the item to replace to the cart.
	* @param {int} qty The quantity of the item to add.
	* @param {String} removeOrderItemId The order item ID of the catalog entry to remove from the cart.
	* @param {String} addressId The address ID of the order item.
	* @param {String} shipModeId The shipModeId of the order item.
	* @param {String} physicalStoreId The physicalStoreId of the order item.
	*
	**/
	replaceItemAjaxHelper : function(catalogEntryId,qty,removeOrderItemId,addressId,shipModeId,physicalStoreId){
		
		var params = [];
		params.storeId = WCParamJS.storeId;
		params.catalogId = WCParamJS.catalogId;
		params.langId = WCParamJS.langId;
		params.orderItemId	= removeOrderItemId;
		params.orderId = ".";
		if(CheckoutHelperJS.shoppingCartPage){	
			params.calculationUsage = "-1,-2,-5,-6,-7";
		}else{
			params.calculationUsage = "-1,-2,-3,-4,-5,-6,-7";
		}

		var params2 = [];
		params2.storeId = WCParamJS.storeId;
		params2.catalogId = WCParamJS.catalogId;
		params2.langId = WCParamJS.langId;
		params2.catEntryId	= catalogEntryId;
		params2.quantity = qty;
		params2.orderId = ".";
		if(CheckoutHelperJS.shoppingCartPage){	
			params2.calculationUsage = "-1,-2,-5,-6,-7";
		}else{
			params2.calculationUsage = "-1,-2,-3,-4,-5,-6,-7";
		}

		var params3 = [];
		params3.storeId = WCParamJS.storeId;
		params3.catalogId = WCParamJS.catalogId;
		params3.langId = WCParamJS.langId;
		params3.orderId = ".";
		if(CheckoutHelperJS.shoppingCartPage){	
			params3.calculationUsage = "-1,-2,-5,-6,-7";
		}else{
			params3.calculationUsage = "-1,-2,-3,-4,-5,-6,-7";
		}
		
		var shipInfoUpdateNeeded = false;
		var orderItemReqd = true;
		if(addressId != null && addressId != ""){
			params3.addressId = addressId;
		}
		if(shipModeId != null && shipModeId != ""){
			params3.shipModeId = shipModeId;
		}
		if(physicalStoreId != null && physicalStoreId != ""){
			params3.physicalStoreId = physicalStoreId;
			orderItemReqd = false;
		}
		if(params3.shipModeId != null && (params3.addressId != null || params3.physicalStoreId != null)){
			shipInfoUpdateNeeded = true;
		}
		
		if(orderItemReqd){
			params3.allocate="***";
			params3.backorder="***";
			params3.remerge="***";
			params3.check="*n";
		}
		
		//Delcare service for deleting item...
		wc.service.declare({
			id: "AjaxReplaceItem",
			actionId: "AjaxReplaceItem",
			url: "AjaxOrderChangeServiceItemDelete",
			formId: ""

			,successHandler: function(serviceResponse) {
				//Now add the new item to cart..
				if(!shipInfoUpdateNeeded){
					//We dont plan to update addressId and shipMOdeId..so call AjaxAddOrderItem..
					wc.service.invoke("AjaxAddOrderItem", params2);
				}
				else{
					//We need to update the adderessId and shipModeId..so call our temp service to add..
					wc.service.invoke("AjaxAddOrderItemTemp", params2);
				}
			}

			,failureHandler: function(serviceResponse) {
				if (serviceResponse.errorMessage) {
							 MessageHelper.displayErrorMessage(serviceResponse.errorMessage);
					  } else {
							 if (serviceResponse.errorMessageKey) {
									MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
							 }
					  }
					  cursor_clear();
			}

		});

		//Delcare service for adding item..
		wc.service.declare({
			id: "AjaxAddOrderItemTemp",
			actionId: "AjaxAddOrderItemTemp",
			url: "AjaxOrderChangeServiceItemAdd",
			formId: ""

			,successHandler: function(serviceResponse) {
				if(orderItemReqd){
					// setting the newly created orderItemId
					params3.orderItemId = serviceResponse.orderItemId[0];
				}
				
				MessageHelper.displayStatusMessage(MessageHelper.messages["SHOPCART_ADDED"]);
				
				//Now item is added.. call update to set addressId and shipModeId...
				wc.service.invoke("OrderItemAddressShipMethodUpdate", params3);
			}

			,failureHandler: function(serviceResponse) {
				MessageHelper.displayErrorMessage(serviceResponse.errorMessageKey);
			}
		});

		//For Handling multiple clicks
		if(!submitRequest()){
			return;
		}   
		cursor_wait();
		wc.service.invoke("AjaxReplaceItem",params);
	},

	/**
	* customizeDynamicKit This function is used to call the configurator page for a dynamic kit.
	* @param {String} catEntryIdentifier A catalog entry ID of the item to add to the cart.
	* @param {int} quantity A quantity of the item to add to the cart.
	* @param {Object} customParams - Any additional parameters that needs to be passed to the configurator page.
	*
	**/
	customizeDynamicKit : function(catEntryIdentifier, quantity, customParams)
	{
		var params = [];
		params.storeId		= this.storeId;
		params.catalogId	= this.catalogId;
		params.langId		= this.langId;
		params.catEntryId	= catEntryIdentifier;
		params.quantity		= quantity;
		
		if(!isPositiveInteger(quantity)){
			MessageHelper.displayErrorMessage(storeNLS['QUANTITY_INPUT_ERROR']);
			return;
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
		
		//Pass any other customParams set by other add on features
		if(customParams != null && customParams != 'undefined'){
			for(i in customParams){
				params[i] = customParams[i];
			}
		}

		//For Handling multiple clicks
		if(!submitRequest()){
			return;
		}   
		cursor_wait();
		
		var configureURL = "ConfigureView";
		var i =0;
		for(param in params){
			configureURL += ((i++ == 0)? "?" : "&") + param + "=" + params[param];
		}
		document.location.href = getAbsoluteURL() + configureURL;
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
		if(shoppingActionsJS.nbDecimals(valeur)>=2){
			//valeur=Math.round(valeur ,2);
			//Arrondi � 2 chiffres apr�s virgule
			var valeurArrondie = Number(Math.round(valeur+'e2')+'e-2');
			if(valeurArrondie != null && valeurArrondie != 'undefined' && valeurArrondie != undefined){
				//On fixe le nombre de d�cimal � 2 obligatoirement
				valeurArrondie = valeurArrondie.toFixed(2);
				//console.log('round2('+valeur+')='+valeurArrondie);
				return valeurArrondie;
			}
		}
		return valeur;
	}
	,formatNumber:function(nombre){
		return (''+nombre).replace(".",",");
	}
	,updateSurface:function(entitledItemId, productId){
		if(this.selectedProducts[productId]){
			var catalogEntryId = this.getCatalogEntryIdforProduct(this.selectedProducts[productId]);
		} else {
			var catalogEntryId = this.getCatalogEntryId(entitledItemId);
		}

		var catEntry;
		if(this.itemPriceJsonOject[catalogEntryId] != null && this.itemPriceJsonOject[catalogEntryId] != 'undefined'){
			catEntry = this.itemPriceJsonOject[catalogEntryId].catalogEntry;
		}

		if(catEntry){
			var quantity = dojo.query("div[id='qtySurface_"+productId+"']");
			
				for(var i = 0; i<quantity.length; i++){	
					if(quantity[i]) {
						var content = "";
						//0001097: [Quick view] - Un texte "Unit�" pr�c�d� du prix est affich�
						if ((catEntry.coeffConversionQuantite || catEntry.coeffConversionPrix) && catEntry.uniteSecondaire && catEntry.uniteVenteLegale && catEntry.uniteVenteLegale.toLowerCase() != catEntry.uniteSecondaire.toLowerCase()) {
							
							var coeff =1;
							if(catEntry.coeffConversionQuantite) {
								coeff =catEntry.coeffConversionQuantite
							}
							else{ 
								coeff =Math.round(1/catEntry.coeffConversionPrix*1000)/1000;
							}
							
							content = '<label for="surface">'+catEntry.quantityLegaleFieldLabel+'</label>'
							+'<input type="hidden" id="coeff_'+productId+'" value="'+coeff+'"/>'
							+'<div onpaste="return false;" '
							+'onkeypress="return checkNumericInputWithAllowedDot(event);"'
							+'class="qty_controls_container">'
							+'<input type="text" class="quantity_input surface" id="surface_'+productId
							+'" name="surface" onchange="javascript:QuickInfoJS.updateQty(\''+productId+'\','+coeff+','+catEntry.contrainteColisage+');">' 
							+ catEntry.uniteVenteLegaleLabel + '</div>';

							quantity[i].innerHTML = content;
							QuickInfoJS.updateSurface(productId,coeff);
						}else{
							quantity[i].innerHTML = content;
						}
					}
				}
		}
	},
	toggleSwatchListBox: function(productId, swatchAttrIdentifier) {
		$('#swatch-list-' + productId + '-' + swatchAttrIdentifier).slideToggle(50);
	},
	selectSwatchListBoxItem: function(productId, swatchAttrIdentifier) {
		$('#dropdown-toggle-' + productId + '-' + swatchAttrIdentifier).text('BLA');
		toggleSwatchListBox(productId, swatchAttrIdentifier);
	}
}

dojo.topic.subscribe("ProductInfo_Reset", shoppingActionsJS.resetProductAddedList);

require(["dojo/on", "dojo/has", "dojo/_base/sniff", "dojo/domReady!"], function(on, has) {
	if (has("ie") < 9) {
		on(document, ".compare_target > input[type=\"checkbox\"]:click", function(event) {
			this.blur();
			this.focus();
		});
	}
});
