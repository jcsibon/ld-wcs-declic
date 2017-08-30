function CollectionProductDisplayWidget() {
	this.lsContainer = null;
}

CollectionProductDisplayWidget.prototype.initDesktop = function(lsContainer) {
	var that = this;
	this.init(lsContainer, {
		item: 1,
		gallery: true,
		thumbItem: 3,
		slideMargin: 20,
		thumbMargin: 15,
		speed: 500,
		auto: false,
		pager: true,
		controls: true,
		loop: true,
		enableDrag: true,
		vertical: true,
		verticalHeight: 270,
		vThumbWidth: 100
	});
}

CollectionProductDisplayWidget.prototype.initMobile = function(lsContainer) {
	this.init(lsContainer, {
		item: 1,
		gallery: false,
		slideMargin: 10,
		speed: 500,
		auto: false,
		controls: true,
		pager: false,
		loop: true,
		enableDrag: false
	});
}

CollectionProductDisplayWidget.prototype.init = function(lsContainer, extraSettings) {
	var that = this;
	var settings = {
		addClass: 'ecoLSFullcontainer',
		useCSS: true,
		onSliderLoad: function() {
			$('.lSAction').detach().appendTo('#lSliderContainer');
			that.lsContainer.removeClass('cS-hidden');
		}
	}

	$.extend(settings, extraSettings);

	this.lsContainer = lsContainer;
	this.lsContainer.lightSlider(settings);
}

CollectionProductDisplayWidget.prototype.popThePopin = function(urlImage, label) {
	$('#productAdditionalImages').attr('src', urlImage);
	$('#productAdditionalImages').attr('alt', label);
	$('#productAdditionalImages').attr('title', label);
	showPopup('popupProductImage');
}

var collectionProductDisplay = new CollectionProductDisplayWidget();
