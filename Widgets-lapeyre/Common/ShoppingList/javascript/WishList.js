var WishList = (function() {
	
	function WishList() {
		this.shoppingListObject = null;
	}
	
	WishList.prototype.initialize = function(slObj) {
		this.shoppingListObject = slObj;
	}
	
	WishList.prototype.goLogin = function(forcedUrl,returnPage) {
		this.shoppingListObject.redirectToSignOn(forcedUrl,returnPage);
	}
	
	WishList.prototype.openAddPopin = function(defaultWishList, catEntryId) {
		this.shoppingListObject.showPopup('addto');
		this.shoppingListObject.catEntryId = catEntryId;
		this.shoppingListObject.addItemAfterCreate = true;
	}
	
	WishList.prototype.createOrAddToList = function(listName, listId, orderItemId) {
		var listNameInput = document.getElementById(listName);
		var listIdSelect = document.getElementById(listId);
		
		if(listNameInput != null && listNameInput.value != null && listNameInput.value != '') {
			this.shoppingListObject.create();
		} else {
			var listId = document.getElementById('wishListID');
			if(listId!=null){
				listId.value = listIdSelect.value;
			}
			if(orderItemId != null && orderItemId != '') {
				this.shoppingListObject.addToListAndDelete(listIdSelect.value, orderItemId);
			} else {
				//var bufferItemId = this.shoppingListObject.itemBufferObject[this.catEntryParams.id];
				//this.shoppingListObject.setItemId((bufferItemId != null) ? bufferItemId : -1);
				this.shoppingListObject.addToList(listIdSelect.value);
			}
		}
	}
	
	return WishList;
	
})();

var wishList = new WishList();