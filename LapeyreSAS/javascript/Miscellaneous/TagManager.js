var TagManager = (function() {
	
	function TagManager() {
	}

	TagManager.prototype.removeItemFromCart = function(orderItemId) {
		if(typeof(dataLayer) != 'undefined' && dataLayer != null) {
			dataLayer.forEach(function(node, index, nodeList) {
				if(node.hasOwnProperty('basket_products')) {
					for(var i = 0; i < node['basket_products'].length; i++) {
						if(node['basket_products'][i].orderItemId == orderItemId) {
							pushToTagManager(node['basket_products'][i]);
						}
					}
				}
			});
		}
	}
	
	function pushToTagManager(object) {
		if(typeof(dataLayer) != 'undefined' && dataLayer != null) {
			dataLayer.push({
				'event' : 'removeFromCart',
				'eventCategory' : 'orderItemId',
				'eventAction' : 'remove',
				'eventLabel': object.sku + '|' + object.name + '|' + object.price,
				'eventValue': object
			});
		}
	}
	
	
	TagManager.prototype.changePageNumber = function(pageNumber) {
		if(typeof(dataLayer) != 'undefined' && dataLayer != null) {
			var pageName = '';
			dataLayer.forEach(function(node, index, nodeList) {
				if(node.hasOwnProperty('page_name')) {
					pageName = node['page_name'];
				}
			});
			dataLayer.push({
				'event' : 'ChangePageNumber',
				'eventCategory' : 'pageNumber',
				'eventAction' : 'change',
				'eventLabel' : pageName + '|' + pageNumber,
				'eventValue' : pageNumber
			});
		}
	}
	
	
	return TagManager;
	
})();

var tagManager = new TagManager();