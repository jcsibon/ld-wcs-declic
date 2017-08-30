function adjustHeightShippingModeArea() {
		$('#shippingCostArea div:nth-child(1) p').each(function(){
			var p = $('#shippingCostArea div:nth-child(2) p').get($(this).index());
			if($(p).height() < $(this).height()) {			
			   $(p).height($(this).height());
			   $(p).css('line-height',$(this).height() + 'px');
			} else {
				$(this).height($(p).height());
				$(this).css('line-height',$(p).height() + 'px');
			}
		});
}
