//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2011, 2014 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

function ShoppingListJS(storeParams, catEntryParams, shoppingListNames, jsObjectName) {
	
	this.storeParams = storeParams;
	
	this.catEntryParams = catEntryParams;
	
	this.catEntryId = null;

	this.catEntryParams.quantity = 1;
	
	this.shoppingListNames = shoppingListNames;
	
	this.addItemAfterCreate = false;
	
	this.jsObjectName = jsObjectName;
	
	this.dropDownVisible = false;

	this.dropDownInFocus = false;

	this.dropDownOpen = false;

	this.exceptionFlag = false;

	this.mouseOnArrow = false;
	
	this.pageName = "";
	
	/**
	 * Gestion d'un objet buffer pour le mode liste d'une page categorie.
	 */
	this.itemBufferObject = new Array();
	
	this.itemId = -1;
	
	var eventName = "";
	
	/**
	 * Keep track of the wish list name that is to be deleted. This is needed only for the my account personal wish
	 * list management UI.
	 **/
	this.nameToDelete = "";
	
	/**
	 * Keep track of the orderItemId that is to be deleted from the shopping cart after successfully adding an item to the
	 * wish list. This is needed only for the shopping cart and checkout related UI that uses this button code.
	 **/
	this.orderItemId = "";

	/**
	 * Keep track of the current action being performed by this button widget. This action is needed when there are several
	 * same button widgets in the same page such as the shopping cart page UI. We need to know which button is actually doing
	 * actions so that we know when to display success dialogs. Otherwise, all buttons display success dialogs.
	 **/
	this.actionBeingPerformed = "";
	
	if(jsObjectName != 'shoppingListJS'){
		this.pageName = jsObjectName.replace('shoppingListJS', '');
		eventName = this.pageName + "_";
	}
	
	/**
	 * Setter for itemId
	 * 
	 * @param {Integer} catEntryId
	 */
	this.setItemId = function(catEntryId){
		this.itemId = catEntryId;
	};
	
	this.setItemBufferId = function(catEntryId, productId) {
		this.itemBufferObject[productId] = catEntryId;
	}
	
	/**
	 * Hides the dropdown with shopping list names if it exists
	 */
	this.hideDropDown = function() {
		var dropDown = dojo.byId(this.pageName + 'shoppingListDropDown');
		if (dropDown) {
			dropDown.style.display = "none";
			dojo.query("#" + this.pageName + "addToShoppingListBtn .drop")[0].focus();
			this.dropDownVisible = false;
			this.dropDownInFocus = false;
			this.dropDownOpen = false;
			
			var contentRightBorder = dojo.query(".widget_quick_info_popup .content_right_border")[0];
			if (contentRightBorder != undefined) {
				dojo.style(contentRightBorder, 'height', 'auto');
			}
		}
	};
	
	/**
	 * Shows the dropdown with shopping list names & a create a new shopping list link - if authenticated
	 * If not authenticated, redirects user to login page
	 */
	this.showDropDown = function() {
		if(this.dropDownOpen == false){
			var contentRightBorder = dojo.query(".widget_quick_info_popup .content_right_border")[0];
			var ocontentRightBorderH = dojo.position(contentRightBorder).h;
			var dropDown = dojo.byId(this.pageName + 'shoppingListDropDown');
			dropDown.style.display = "";
			this.dropDownVisible = true;
			
			dojo.query("#" + this.pageName + "shoppingListDropDown.dropdown_list div").removeClass("focused");
			
			if(dojo.byId("quickInfoRefreshArea") && dojo.byId("QuickInfoshoppingListDropDown") ) {  // check if dropdown is shown in a QuickInfo popup
				var quickInfoRefreshAreaH = dojo.position(dojo.byId("quickInfoRefreshArea")).h;		
				var shoppingListDropDownH = dojo.position(dojo.byId("QuickInfoshoppingListDropDown")).h;
				var contentRightBorderH = dojo.position(contentRightBorder).h;
				
				if((quickInfoRefreshAreaH + shoppingListDropDownH) > contentRightBorderH) {
					var quickInfoPopup = dijit.byId('quickInfoPopup');
					dojo.style(contentRightBorder, 'height', contentRightBorderH + shoppingListDropDownH + 'px');					
					quickInfoPopup.resize();
					//adjust height when scroll bar disappear using original contentRightBorder height
					if (ocontentRightBorderH < contentRightBorderH){
						dojo.style(contentRightBorder, 'height', ocontentRightBorderH + shoppingListDropDownH + 'px');
						quickInfoPopup.resize();
					}
				}
			}
			this.dropDownOpen = true;
		}
		else{
			this.hideDropDown();
		}
	};
	
	/**
	 * Show appropriate popups to create, update or delete Shopping List
	 * 
	 * @param {String}
	 *            action type of popup to be shown (create, update or delete)
	 */
	this.showPopup = function(action){
		this.hideDropDown();
		this.clearPopupText();
		var popup = dijit.byId(this.pageName + action + "ShoppingListPopup");
		this.hideErrorMessage();
		this.hideEditErrorMessage();
		if (popup !=null) {			
			closeAllDialogs(); //close other dialogs(quickinfo dialog, etc) before opening this. 				
			// Add a delay to showing the popup to give closeAllDialogs() a bit of time to do it's job
			setTimeout(function() {popup.show();}, 250);
			if (action == 'create') {
				dojo.byId(this.pageName + "newListName").focus();
			} else if (action == 'edit') {
				dojo.byId("editListName").focus();
			}
		}else {
			console.debug(action+"ShoppingListPopup"+" does not exist");
		}
	};

	/**
	 * Method to display message dialog on successful creation of shopping list.
	 * 
	 */
	 this.showSuccessDialog = function(){
		var popup = dijit.byId(this.pageName + "shoppingListCreateSuccessPopup");
		if (popup !=null && this.actionBeingPerformed != "") {	
			dojo.byId(this.pageName + "successMessageAreaText").innerHTML = storeNLS['LIST_CREATED'];
			popup.closeButtonNode.style.display='none';//hide the close button inherited from dijit.dialog
			popup.show();
			this.actionBeingPerformed = "";
		}
	 };

	/**
	 * Method to display message dialog on successful creation of shopping list.
	 * 
	 */
	 this.showMessageDialog = function(message,cod){
		var popup = dijit.byId(this.pageName + "shoppingListCreateSuccessPopup");
		
		if (popup !=null) {	
			dojo.byId(this.pageName + "successMessageAreaText").innerHTML = message;
			dojo.byId("successActionText").value = cod;
			popup.closeButtonNode.style.display='none';//hide the close button inherited from dijit.dialog
			popup.show();
		}
	 };	 
	 
	/**
	 * Method to display error message pertaining to shopping list
	 * @param (string) msg The error/information message to be displayed
	 * 
	 */
	this.showErrorMessage = function(msg){
		if(document.getElementById(this.pageName + "shoppingListErrorMessageArea") && document.getElementById(this.pageName + "shoppingListErrorMessageText")){
			document.getElementById(this.pageName + "shoppingListErrorMessageText").innerHTML = msg;
			document.getElementById(this.pageName + "shoppingListErrorMessageArea").style.display = "block";
		}
	};

	/**
	 * Method to hide error message display area
	 * 
	 */
	this.hideErrorMessage = function(){
		if(document.getElementById(this.pageName + "shoppingListErrorMessageArea") && document.getElementById(this.pageName + "shoppingListErrorMessageText")){
			document.getElementById(this.pageName + "shoppingListErrorMessageText").innerHTML = "";
			document.getElementById(this.pageName + "shoppingListErrorMessageArea").style.display = "none";
		}
	};

	/**
	 * Method to display error message pertaining to change shopping list name
	 * @param (string) msg The error/information message to be displayed
	 * 
	 */
	this.showEditErrorMessage = function(msg){
		if(document.getElementById("editShoppingListErrorMessageArea") && document.getElementById("editShoppingListErrorMessageText")){
			document.getElementById("editShoppingListErrorMessageText").innerHTML = msg;
			document.getElementById("editShoppingListErrorMessageArea").style.display = "block";
		}
	};

	/**
	 * Method to hide error message display area from the change shopping list name dialog
	 * 
	 */
	this.hideEditErrorMessage = function(){
		if(document.getElementById("editShoppingListErrorMessageArea") && document.getElementById("editShoppingListErrorMessageText")){
			document.getElementById("editShoppingListErrorMessageText").innerHTML = "";
			document.getElementById("editShoppingListErrorMessageArea").style.display = "none";
		}
	};
	
	/**
	 * Method to create a new shopping list
	 * 
	 */
	this.create = function(){
		// picks the new shopping list name and trims it
		var name = trim(dojo.byId(this.pageName + "newListName").value);
		var maxlength = dojo.byId(this.pageName + "newListName").maxLength;
		var defaultName = storeNLS['DEFAULT_WISH_LIST_NAME'];
		
		if (this.empty(name)) {
			// display error message saying list name is empty.
			this.showErrorMessage(storeNLS['ERR_NAME_EMPTY']);
		} else if(!MessageHelper.isValidUTF8length(name, maxlength)){
			// check for max length
			this.showErrorMessage(storeNLS['ERR_NAME_TOOLONG']);
		} else if(name == defaultName) {
			// show error message saying that DEFAULT cannot be used
			this.showErrorMessage(storeNLS['ERR_NAME_SHOPPING_LIST']);
		} else if(this.isDuplicate(name)){
			// show error message saying that DEFAULT cannot be used
			this.showErrorMessage(storeNLS['ERR_NAME_DUPLICATE']);
		} else if(!this.validateWishName(name)){
			// show error message saying that
			this.showErrorMessage(storeNLS['INVALID_NAME_SHOPPING_LIST']);
		} else {
			
			this.hideErrorMessage();
			
			var params = this.setCommonParams();
			params.name = name;
			
			var popup = dijit.byId(this.pageName + "createShoppingListPopup");
			if (popup !=null) {	
				popup.hide();
			}
			// For Handling multiple clicks.
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			// calling the service to save the new list name
			wc.service.invoke('ShoppingListServiceCreate',params);
			this.actionBeingPerformed = "create";
		}
	};
	
	/**
	 * Creates the default shopping list with name 'Wish List' and adds the displayed item to this list.
	 * If the default shopping list is already created, just adds the item to the existing list.
	 * Also, redirects the user to login page if not authenticated.
	 * 
	 * @param {Integer} listId - id of the default shopping list if present, else -1 is passed
	 */
	this.createDefaultListAndAddItem = function(listId, orderItemId, focusElement){
		if (orderItemId && orderItemId != "") {
			this.orderItemId = orderItemId;
		}
		
		if("-1" == listId){
			var params = this.setCommonParams();
			params.name = storeNLS['DEFAULT_WISH_LIST_NAME'];

			// For Handling multiple clicks.
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			this.addItemAfterCreate = true;
			// calling the service to save the new list name
			wc.service.invoke('ShoppingListServiceCreate',params);
		} else {
			if (orderItemId && orderItemId != "") {
				this.addToListAndDelete(listId, orderItemId, focusElement);
			} else {
				this.addToList(listId, focusElement);
			}
		}
	};
	
	/**
	 * add an item/product/bundle/package to a wish list
	 * 
	 * @param {string}
	 *            listId id of the item/product/bundle/package be
	 *            added
	 */
	this.addToList = function(listId, focusElement){
		this.hideDropDown();
		
		var params = this.setCommonParams();
		params.giftListId = listId;
		
		updateParamObject(params, "catEntryId", this.catEntryId, false, -1);
		updateParamObject(params, "quantity", "1", false, -1);

		if (this.jsObjectName != 'shoppingListJS') {
			QuickInfoJS.close();
		}
		
		// For Handling multiple clicks.
		if(!submitRequest()){
			return;
		}
		
		cursor_wait();
		ShoppingListDialogJS.setDialogParams(this.storeParams, {catEntryId:this.catEntryId, thumbnail: 'imgPath', focusElement: focusElement});
		wc.service.invoke('ShoppingListServiceAddItem',params);

	};
	
	/**
	 * Checks if shopping list name already exists
	 * 
	 * @param {String} listName, name of the shopping list to be created
	 * @return {Boolean} true, if a duplicate is present
	 * 					 false, if no duplicates present
	 */
	this.isDuplicate = function(listName) {
		var listName = this.escapeXml(listName, true);
		return (this.shoppingListNames[listName.toUpperCase()] == 1);
	};
	
	/**
	 * Updates the dom object representing the default shopping list with onclick function and also updates the shopping list
	 * 
	 * @param {Integer} listId, default shopping list id
	 */
	this.updateDefaultListId = function(listId){
		this.shoppingListNames[storeNLS['DEFAULT_WISH_LIST_NAME']] = 1;
		if (dojo.byId(this.pageName+'addToShoppingList')) {
			dojo.byId(this.pageName+'addToShoppingList').href = "javascript:" + this.jsObjectName + ".createDefaultListAndAddItem(" + listId + ");";
		}
	};
	
	/**
	 * Adds an entry in shopping list dropdown. Also updates the shopping list names with the new name.
	 * 
	 * @param {Integer} listId, id of the new shopping list that got created
	 * @param {String} listName, name of the new shopping list that got created
	 */
	this.updateShoppingList = function(listId, listName, action){
		var listNameEsc = this.escapeXml(listName, false);
		this.shoppingListNames[listNameEsc.toUpperCase()] = 1;
		
		if (action && (action == 'edit' || action == 'delete')) {
			this.shoppingListNames[this.nameToDelete.toUpperCase()] = -1;
		}
		
		var dexistingListDP = dojo.byId(this.pageName+'existingListDP');
		if(dexistingListDP && this.addItemAfterCreate) {
			var newListOption = document.createElement('option');
			newListOption.text = listName;
			newListOption.value = listId;
			dexistingListDP.add(newListOption, dexistingListDP.length);
		}
		
		var dropdownWidgetNode = dojo.byId(this.pageName+'ShoppingListDivider');
		if (dropdownWidgetNode) {
			var eventHandlerString = "javascript: this.className = 'created_list';";

			if (this.pageName.indexOf("OI") == -1) {
				dojo.place('<div role="menuitem" id="' + this.pageName + 'ShoppingList_' + listId + '" class="created_list" onfocus="javascript:' + jsObjectName + '.focusList(\'' + listId +
						'\'); "  onblur="'+ eventHandlerString +'" onclick="javascript:' + jsObjectName + '.addToList(\'' + listId + 
						'\');"><a role="menuitem" id="' + this.pageName + 'ShoppingListLink_' + listId + '" href="javascript:' + jsObjectName + '.addToList(\'' + listId + 
						'\');" onfocus="javascript:' + jsObjectName + '.focusListLink(\'' + listId + '\');">' + listName + 
						'</a></div>', this.pageName + 'ShoppingListDivider', 'before');
			} else {
				var oiId = this.pageName.replace("OI", "");
				dojo.place('<div role="menuitem" id="' + this.pageName + 'ShoppingList_' + listId + '" class="created_list" onfocus="javascript:' + jsObjectName + '.focusList(\'' + listId +
						'\'); "  onblur="'+ eventHandlerString +'" onclick="javascript:' + jsObjectName + '.addToListAndDelete(\'' + listId + 
						'\',\'' + oiId + '\');"><a role="menuitem" id="' + this.pageName + 'ShoppingListLink_' + listId + '" href="javascript:' + jsObjectName + '.addToListAndDelete(\'' + listId + 
						'\',\'' + oiId + '\');" onfocus="javascript:' + jsObjectName + '.focusListLink(\'' + listId + '\');">' + listName + 
						'</a></div>', this.pageName + 'ShoppingListDivider', 'before');
			}
		}
	};
	
	/**
	 * Clears the textbox in the popup
	 */
	this.clearPopupText = function(){
		dojo.byId(this.pageName + "newListName").value = "";
	};
	
	/**
	 * Converts & < > " ' to xml accepted form
	 * 
	 * @param {String} str, String to be converted
	 * @param {Boolean} fullConversion, if true converts & < > " ' chars
	 * 									if false converts only " ' chars
	 * 
	 * @return {String} converted string
	 */
	this.escapeXml = function(str, fullConversion){
		if(fullConversion){
			str = str.replace(/&/gm, "&amp;").replace(/</gm, "&lt;").replace(/>/gm, "&gt;");
		}
		str = str.replace(/"/gm, "&#034;").replace(/'/gm, "&#039;");
		return str;
	};
	 
	/**
	 * Sets the store specific values such as storeId, catalogId and langId in a Object and returns it.
	 * 
	 * @return {Object} params with store specific values
	 */
	this.setCommonParams = function(){
		var params = {};
		params.storeId		= this.storeParams.storeId;
		params.catalogId	= this.storeParams.catalogId;
		params.langId		= this.storeParams.langId;
		return params;
	};
	
	/**
	 * Checks if the string is null, undefined or empty
	 * 
	 * @param {String} str, value to be checked
	 * @return {Boolean} true, if empty
	 * 					 false, if not empty
	 */
	this.empty = function(str) {
		return (str == null || str == undefined || str == "");
	};
	
	/**
	 * redirect users to the sign on page
	 */
	this.redirectToSignOn = function(forcedUrl,returnPage) {
	
		if(typeof(forcedUrl)!='undefined'){
			var currentURL = forcedUrl;
		}else{
			var currentURL = location.href;
		}
		//Mantis 0001238: il faut retirer les facets
		var indexOfFacet = currentURL.lastIndexOf("#facet:");
		if(indexOfFacet > 0){
			currentURL = currentURL.substring(0,indexOfFacet);
			console.log('currentURLWithoutFacet='+currentURL);
		}
		//Et l'info d'onglet si present
		currentURL=currentURL.replace(/&ongletSearch=contenu/, "").replace(/ongletSearch=contenu&/, "");
		//currentURL=currentURL.replace(/&ongletSearch=contenu/, "&ongletSearch=produits").replace(/ongletSearch=contenu&/, "ongletSearch=produits&");
//		if(true==isGuest){
//			currentURL = getAbsoluteURL() + "OrderItemMove?continue=1&createIfEmpty=1&updatePrices=0&deleteIfEmpty=*&fromOrderId=*&toOrderId=.&page=&calculationUsageId=-1&URL="+encodeURIComponent("OrderCalculate?URL="+encodeURIComponent(currentURL));
//		}
		
		//Mantis: 0001320: on ajoute le returnPage dans l'url pour savoir si on affiche le header ligth ou non
		document.location.href = getAbsoluteURL() + "LogonForm?myAcctMain=1&storeId="
				+ this.storeParams.storeId + "&catalogId=" + this.storeParams.catalogId
				+ "&langId=" + this.storeParams.langId + "&returnPage="+ returnPage + "&URL=" + encodeURIComponent(currentURL);
	};

	/**
	 * changes the style class to show which shopping list is currently focused
	 */
	this.focusList = function(listId){
		this.focusListByElementId(this.pageName + "ShoppingList_" +listId);
	};
	
	/**
	 * changes the style class to show which shopping list is currently focused
	 */
	this.focusListByElementId = function(elementId){
		if(dojo.hasClass(elementId,"focused")) {
			return;
		}
		dojo.byId(elementId.replace("ShoppingList","ShoppingListLink")).focus();
		
	};
	
	/**
	 * changes the style class to show which shopping list is currently focused
	 */
	this.focusListLink = function(listId){
		dojo.query("#" + this.pageName + "shoppingListDropDown.dropdown_list div").removeClass("focused");
		dojo.addClass(this.pageName + "ShoppingList_" +listId,"focused");
	};
	
	this.updateShoppingListAndAddItem = function(serviceResponse){
		if(serviceResponse.listName == storeNLS['DEFAULT_WISH_LIST_NAME']){
			this.updateDefaultListId(serviceResponse.listId);
		} else {
			this.updateShoppingList(serviceResponse.listId, serviceResponse.listName, serviceResponse.action);
		}
		
		if(this.addItemAfterCreate){
			this.addItemAfterCreate = false;
			if (this.orderItemId != "") {
				this.addToListAndDelete(serviceResponse.listId, this.orderItemId);
			} else {
				this.addToList(serviceResponse.listId);
			}
		} else {
			if (serviceResponse.action == 'add') {
				this.showSuccessDialog();
			}
		}
	};
	
	this.navigateDropDown = function(event){
		var shoppingListObj = this;
		if(event.keyCode == dojo.keys.UP_ARROW) {
			dojo.stopEvent(event);
			
			var focusChanged = false;
			dojo.query("#" + shoppingListObj.pageName + "shoppingListDropDown.dropdown_list div.created_list").forEach(function(node, index, arr){
				if(!focusChanged && (dojo.hasClass(node,"focused"))){
					if(0 == index){
						shoppingListObj.focusListByElementId(arr[arr.length-1].id);
					} else {
						shoppingListObj.focusListByElementId(arr[index-1].id);
					}
					focusChanged = true;
				}
			});
		} else if(event.keyCode == dojo.keys.DOWN_ARROW){
			dojo.stopEvent(event);
			
			var focusChanged = false;
			dojo.query("#" + shoppingListObj.pageName + "shoppingListDropDown.dropdown_list div.created_list").forEach(function(node, index, arr){
				if(!focusChanged && (dojo.hasClass(node,"focused"))){
					if(arr.length-1 == index){
						shoppingListObj.focusListByElementId(arr[0].id);
					} else {
						shoppingListObj.focusListByElementId(arr[index+1].id);
					}
					focusChanged = true;
				}
			});
		} else if(event.keyCode == dojo.keys.ESCAPE || event.keyCode == dojo.keys.TAB) {
			dojo.stopEvent(event);
			this.hideDropDown();
		}
	};
	
	this.hideIfNoFocus = function(){
		if(this.dropDownVisible && !this.dropDownInFocus && !this.mouseOnArrow){
			this.hideDropDown();
		}
	};
	
	this.hasFocus = function(event){
		if(dojo.mouseButtons.isRight(event)){
			this.dropDownInFocus = false;
		} else {
			this.dropDownInFocus = true;
		}
		
	};
	
	/**
	 * Method to update the name of an existing shopping list
	 * 
	 */
	this.edit = function(){
		// picks the new shopping list name and trims it
		var name = trim(dojo.byId("editListName").value);
		var maxlength = dojo.byId("editListName").maxLength;
		var defaultName = storeNLS['DEFAULT_WISH_LIST_NAME'];
		if (this.empty(name)) {
			// display error message saying list name is empty.
			this.showEditErrorMessage(storeNLS['ERR_NAME_EMPTY']);
		} else if(!MessageHelper.isValidUTF8length(name, maxlength)){
			// check for max length
			this.showEditErrorMessage(storeNLS['ERR_NAME_TOOLONG']);
		} else if(name == defaultName) {
			// show error message saying that DEFAULT cannot be used
			this.showEditErrorMessage(storeNLS['ERR_NAME_SHOPPING_LIST']);
		} else if(this.isDuplicate(name)){
			// show error message saying that DEFAULT cannot be used
			this.showEditErrorMessage(storeNLS['ERR_NAME_DUPLICATE']);
		} else if(!this.validateWishName(name)){
			// show error message saying that
			this.showEditErrorMessage(storeNLS['INVALID_NAME_SHOPPING_LIST']);
		} else {
			var params = this.setCommonParams();
			params.name = name;
			
			/* ECOCEA : nous n'avons plus une listbox			
			var dropdown = dojo.byId('multipleWishlistController_select');
			if((dropdown != null && dropdown != 'undefined') && dropdown.value != 0){
				// get wish list ID
				params["giftListId"] = dojo.byId("multipleWishlistController_select").value;
				this.nameToDelete = dojo.byId('multipleWishlistController_select').options[dropdown.selectedIndex].text
			}
			*/
			params["giftListId"] = dojo.byId("wishListId").value;
			this.nameToDelete = dojo.byId('wishListName').value;
			
			var popup = dijit.byId("editShoppingListPopup");
			if (popup !=null) {	
				popup.hide();
			}
			// For Handling multiple clicks.
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			// calling the service to save the new list name
			wc.service.invoke('ShoppingListServiceUpdate',params);
		}
	};
	
	/**
	 * Method to delete an existing shopping list
	 * 
	 */
	this.deleteList = function(){
		var params = this.setCommonParams();
/* ECOCEA : nous n'avons plus une listbox
 		var dropdown = dojo.byId('multipleWishlistController_select');
		if((dropdown != null && dropdown != 'undefined') && dropdown.value != 0){
			// get wish list ID
			params["giftListId"] = dojo.byId("multipleWishlistController_select").value;
			this.nameToDelete = dojo.byId('multipleWishlistController_select').options[dropdown.selectedIndex].text
		}
			*/
		params["giftListId"] = dojo.byId("wishListId").value;
		this.nameToDelete = dojo.byId('wishListName').value;

		var popup = dijit.byId("deleteShoppingListPopup");
		if (popup !=null) {	
			popup.hide();
		}
		// For Handling multiple clicks.
		if(!submitRequest()){
			return;
		}
		cursor_wait();
		// calling the service to save the new list name
		wc.service.invoke('ShoppingListServiceDelete',params);
	};
	
	/**
	 * Method that knows how to hide or un-hide the links to delete and rename a wish list in the my account
	 * wish list select controller area.
	 * 
	 */
	this.refreshLinkState = function() {
		var dropdown = dojo.byId('multipleWishlistController_select');
		if (dropdown != null) {
			var wName=dojo.byId('multipleWishlistController_select').options[dropdown.selectedIndex].text;
			var defaultName = storeNLS['DEFAULT_WISH_LIST_NAME'];
			if (wName == defaultName) {
				//hide the delete and rename links, default wish list cannot be changed nor deleted
				dojo.byId('editDivider').style.display='none';
				dojo.byId('edit_popup_link').style.display='none';
				dojo.byId('deleteDivider').style.display='none';
				dojo.byId('delete_popup_link').style.display='none';
			} else {
				dojo.byId('editDivider').style.display='block';
				dojo.byId('edit_popup_link').style.display='block';
				dojo.byId('deleteDivider').style.display='block';
				dojo.byId('delete_popup_link').style.display='block';
			}
		}
	};
	
	/**
	  * move an order item to the default wish list
	  * @param {string} listId id of the shopping list to add the item to
	  * @param {string} orderItemId the order item id of the item to be removed from shopping cart
	  */	  
	this.addToListAndDelete = function(listId, inOrderItemId, focusElement) {
		this.orderItemId = inOrderItemId;
		
		dojo.publish("modelChanged/AnalyticsConversionEvent");

		this.hideDropDown();
		
		var params = this.setCommonParams();
		params.giftListId = listId;
		params["catEntryId_1"] = this.catEntryParams.id;
		params["quantity_1"] = 1;

		// For Handling multiple clicks.
		if(!submitRequest()){
			return;
		}		
		cursor_wait();
		ShoppingListDialogJS.setDialogParams(this.storeParams, {catEntryId:this.catEntryParams.id, name:this.catEntryParams.name, image:this.catEntryParams.image, thumbnail: 'imgPath', focusElement: focusElement});
		wc.service.invoke('ShoppingListServiceAddItemAndRemoveFromCart',params);
	};
	
	/**
	 * delete an order item from the shopping cart
	*/
	this.deleteItemFromCart = function() {
		if (this.orderItemId != "") {
			var test = this.orderItemId;
			this.orderItemId = "";
			if (test != "" && !!window['CheckoutHelperJS']) {
				CheckoutHelperJS.deleteFromCart(test, true);
			}
		}
	};
	/**
	 * validate the wish name
	 */
	this.validateWishName = function(wishName) {
	    var invalidChars = "~!@#$%^&*()+=[]{};:,<>?/|`"; // invalid chars
	    invalidChars += "\t\'\"\\\/"; // escape sequences

	    // look for presence of invalid characters.  if one is
	    // found return false.  otherwise return true
	    for (var i=0; i<wishName.length; i++) {
	      if (invalidChars.indexOf(wishName.substring(i, i+1)) >= 0) {
	        return false;
	      }
	    }
	    return true;
	}
	
	/* ECOCEA : begin */
	this.doReplaceCart = function(storeId, orderId, ShoppingCartURL) {
		var addpopup = dijit.byId("addToCartPopup");
		if (addpopup !=null) {	
			addpopup.hide();
		}
		// For Handling multiple clicks.
		if(!submitRequest()){
			return;
		}
		cursor_wait();
		//empty first
		dojo.xhrPost({
				url: "OrderEmptyCart",
				content: {
					storeId: storeId,
					orderId: orderId
				},
				load: function(data,ioArgs) {
					//then add
					shoppingListJS.doAddToCart(true, ShoppingCartURL);
				},
				error: function(errObj,ioArgs) {
					alert("Le panier n'a pu �tre vid�");
					cursor_clear();
					MessageHelper.hideAndClearMessage();
				}
		});
		
	}
	
	this.doAddToCart = function(shouldNotCheckMultiSubmit,ShoppingCartURL) {
		var addpopup = dijit.byId("addToCartPopup");
		//console.log('ShoppingCartURL='+ShoppingCartURL);
		if (addpopup !=null) {	
			addpopup.hide();
		}
		// For Handling multiple clicks : shouldNotCheckMultiSubmit permet d'inclure des appels et de ne pas bloquer
		if(!shouldNotCheckMultiSubmit && !submitRequest()){
			return;
		}
		cursor_wait();
	
		qtyArray = new Array();
		buyableItems.forEach(function(entry) {
			qtyArray.push(1);
		});
		setDeleteCartCookie();
		//appel du service WC : shouldNotCheckMultiSubmit a du etre propage
	    categoryDisplayJS.AddItem2ShopCartAjax(buyableItems,qtyArray,null, true);
	    //document.location.href=ShoppingCartURL;
	}

	this.replaceOrAddToCart = function (nbProduitsCart, ShoppingCartURL) {
		//var qty = dojo.query('.minishopcart_total')[0].innerHTML;
		var isError=false;
		if(nbProduitsCart>0){
			dijit.byId('addToCartPopup').show();
		}else{
			this.doAddToCart(false,ShoppingCartURL);	
		}
	}
	
	/**
	 * Method to display error message pertaining to change shopping list name
	 * @param (string) msg The error/information message to be displayed
	 * 
	 */
	this.showDeleteProjectErrorMessage = function(msg){
		if(document.getElementById("DeleteProjectShoppingListErrorMessageArea")){
			document.getElementById("DeleteProjectShoppingListErrorMessageArea").style.display = "block";
		}
	}
	/**
	 * Method to hide error message display area
	 * 
	 */
	this.hideDeleteProjectErrorMessage = function(){
		if(document.getElementById("DeleteProjectShoppingListErrorMessageArea")){
			document.getElementById("DeleteProjectShoppingListErrorMessageArea").style.display = "none";
		}
	}

	this.deleteProject = function(){
		var popup = dijit.byId(this.pageName + "DeleteProjectShoppingListPopup");

		// For Handling multiple clicks.
		if(!submitRequest()){
			return;
		}
		var that = this;
		cursor_wait();
		
		$.ajax({
			type: "GET",
			url : getAbsoluteURL() + "DeleteProject",
				data: {"cartId": cartId,"cartLineId": cartLineId},
				success: function(event) {
					cursor_clear();
					if (popup !=null) {	
						popup.hide();
					}
					//reload page
					document.location.href=projectListUrl;
				},
				error: function(errObj,ioArgs) {
					cursor_clear();
					that.showDeleteProjectErrorMessage();
				}
		});
	}

		
	/* ECOCEA : end */
	dojo.connect(document.documentElement, "onmousedown", this, "hideIfNoFocus");
	for (baseItemId in this.catEntryParams.components) {
		// For each catEntry component, subscribe to SKU resolution
		dojo.topic.subscribe('DefiningAttributes_Resolved_' + baseItemId, function(catEntryId, productId){
			eval(jsObjectName + ".setResolved('" + productId + "', true)");
		});
		dojo.topic.subscribe('DefiningAttributes_Changed_' + baseItemId, function(catEntryId, productId) {
			if (catEntryId == 0) {
				// Some attribute has not been selected after SKU resolution
				eval(jsObjectName + ".setResolved('" + productId + "', false)");
			}
		});
	};
}

if(typeof(ShoppingListDialogJS) == "undefined" || ShoppingListDialogJS == null || !ShoppingListDialogJS) {
	
	ShoppingListDialogJS = {
		storeParams: null,
		dialogParams: null,
		
		setDialogParams: function(storeParams, dialogParams){
			this.storeParams = storeParams;
			this.dialogParams = dialogParams;
			if(this.dialogParams.image == null || this.dialogParams.image == ''){
				// when item image is not available, we need to fetch separately
				this.fetchAddedItem();
			} else {
				// when item is moved - the ones available in cart pages
				this.displayItemAddedWithoutFetching();
			}
		},
		
		fetchAddedItem: function(){
			var params = this.setCommonParams();
			params.productId = this.dialogParams.catEntryId;
			params.catalogEntryId = this.dialogParams.catEntryId;
			params.fetchParent = true;

			dojo.xhrPost({
				url: getAbsoluteURL() + "GetCatalogEntryDetailsByIDView",				
				handleAs: "json-comment-filtered",
				content: params,
				sync:true,
				service: this,
				load: ShoppingListDialogJS.displayItemAddedDialog,
				error: function(errObj,ioArgs) {
					console.debug("QuickInfoJS.selectItem: Unexpected error occurred during an xhrPost request.");
				}
			});
		},
		
		displayItemAddedDialog: function(serviceResponse, ioArgs) {
			var itemAddedPopup = dijit.byId("shoppingListItemAddedPopup");
			if (dojo.query('.popinAddedShopCartMobile', itemAddedPopup.domNode).length > 0) {
				return;
			}
			if(itemAddedPopup){
				dojo.byId("shoppingListItemAddedImg").src = serviceResponse.catalogEntry.description[0].fullImage.replace("160x160", "105x105");
				dojo.byId("shoppingListItemAddedImg").alt = serviceResponse.catalogEntry.description[0].name;			
				dojo.byId("shoppingListItemAddedName").innerHTML = serviceResponse.catalogEntry.description[0].name;

				
				dojo.byId("shoppingListItemAddedLink").href=serviceResponse.catalogEntry.description[0].url;
				ShoppingListDialogJS.updateCatalogEntryInformations(serviceResponse.catalogEntry);
			} else {
				console.debug("shoppingListItemAddedPopup does not exist");
			}
		},
		
		updateCatalogEntryInformations : function(catEntry) {
			var refSpan = dojo.query("span[id='shoppingListItemAddedSkuRef'] > span");
			if(refSpan != null && refSpan.length != 0) {
				refSpan[0].innerHTML = catEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
			}
			
			if(dojo.byId('sopphingListIdemAddedShortDesc') != null) {
				dojo.byId('sopphingListIdemAddedShortDesc').innerHTML = catEntry.description[0].shortDescription;
			}
				if(dojo.byId('seeMyShoppingList') != null) {
					var listId = document.getElementById('wishListID');
					if(listId!=null){
						dojo.byId('seeMyShoppingList').href = getAbsoluteURL() + "WishListResultDisplayView?catalogId=" + this.storeParams.catalogId + "&langId=" + this.storeParams.langId + "&storeId=" + this.storeParams.storeId + "&id="+listId.value;
					}
					else{
						dojo.byId('seeMyShoppingList').href = getAbsoluteURL() + "WishListDisplayView?catalogId=" + this.storeParams.catalogId + "&langId=" + this.storeParams.langId + "&wishListStyle=strong&storeId=" + this.storeParams.storeId;
					}
			}
		},
		
		/**
		 * This method can be used to display "Added to Wish List" popup in cart pages
		 * because cart has only items and no products, so no need to make another call to pick item image & name
		 */
		displayItemAddedWithoutFetching: function() {
			var itemAddedPopup = dijit.byId("shoppingListItemAddedPopup");
			if(itemAddedPopup != null){
				dojo.byId("shoppingListItemAddedImg").src = this.dialogParams.image;
				dojo.byId("shoppingListItemAddedImg").alt = this.dialogParams.name;
				dojo.byId("shoppingListItemAddedName").innerHTML = this.dialogParams.name;
			} else {
				console.debug("shoppingListItemAddedPopup does not exist");
			}
		},
		
		/**
		 * show popup
		 */
		showDialog: function(){
			var itemAddedPopup = dijit.byId("shoppingListItemAddedPopup");
			if(itemAddedPopup != null){
				itemAddedPopup.closeButtonNode.style.display='none';//hide the close button inherited from dijit.dialog
				itemAddedPopup.show();
			} else {
				console.debug("shoppingListItemAddedPopup does not exist");
			}
		},
		
		setCommonParams: function(){
			var params = new Object();
			params.storeId		= this.storeParams.storeId;
			params.catalogId	= this.storeParams.catalogId;
			params.langId		= this.storeParams.langId;
			return params;
		},
		
		close: function(){
			dijit.byId("shoppingListItemAddedPopup").hide();
			if (this.dialogParams.focusElement && this.dialogParams.focusElement != "") {
				dojo.byId(this.dialogParams.focusElement).focus();
			}
		}
	}
	/*
	 * itemAddedReadyForDelete applies to items in cart - since cart has only items and no products, 
	 * so no need to make another call to pick item image & name
	 */ 
	dojo.topic.subscribe("ShoppingListItem_Added", ShoppingListDialogJS.showDialog);
	
}
