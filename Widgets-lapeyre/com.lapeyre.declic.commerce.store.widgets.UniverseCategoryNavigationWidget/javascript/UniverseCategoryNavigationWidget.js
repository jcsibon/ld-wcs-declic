var UniverseCategoryNavigationWidget = (function(){
	
	function UniverseCategoryNavigationWidget() {
		
	}
	
	var categorySelect = null;
	
	UniverseCategoryNavigationWidget.prototype.attach = function(selectId) {
		categorySelect = document.getElementById(selectId)
		categorySelect.addEventListener("change", onSelectChangeHandler, false);
	}
	
	var onSelectChangeHandler = function(event) {
		var selectedCategory = event.target.value;
		if(selectedCategory != null && selectedCategory.toLowerCase() != 'none') {
			categorySelect.removeEventListener("change", onSelectChangeHandler, false);
			document.location.href = selectedCategory;	
		}
		
	}
	
	return UniverseCategoryNavigationWidget;
})();

var universeCategoryNavigation = new UniverseCategoryNavigationWidget();