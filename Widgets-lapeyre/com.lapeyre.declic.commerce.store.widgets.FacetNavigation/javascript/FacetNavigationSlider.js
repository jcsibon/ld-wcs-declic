	function FacetNavigationSlider(slidId) {
		this.sliderId = null;
		this.innerslider = null;
		this.initSlider = true;
		this.currency = " \u20AC";//Euro
		this.minRange = 0;
		this.maxRange = 2000;
		
		this.reloadMin = 0;
		this.reloadMax = 0;

		if (slidId==null || slidId=='') this.sliderId='';
		else this.sliderId="_"+slidId;

		this.setHiddenInput = function(minValue, maxValue) {
			if(minValue != null && maxValue != null) {
				min = minValue;
				max = maxValue;
			} else {
				min = minRange;
				max = maxRange;
			}
			if(byId('low_slider_value'+this.sliderId)) byId('low_slider_value'+this.sliderId).value = min;
			if(byId('low_slider_input'+this.sliderId)) byId('low_slider_input'+this.sliderId).value = min;
			if(byId('high_slider_value'+this.sliderId)) byId('high_slider_value'+this.sliderId).value = max;
			if(byId('high_slider_input'+this.sliderId)) byId('high_slider_input'+this.sliderId).value = max;
		}
		
		this.destroySlider = function(newPriceFacetRange) {
			
		}
		
		this.showOrHide = function(minPrice, maxPrice) {
			if(minPrice+2>=maxPrice){
				$(".facetSlider"+this.sliderId).hide();
			} else {
				$(".facetSlider"+this.sliderId).show();
			}
		}
	}
	
	FacetNavigationSlider.prototype.init = function(zeSlider, ranges, zeCurrency) {
		//Set default range for reset later
		var range = ranges.split(";");
		if(range.length == 2) {
			this.minRange = parseFloat(range[0]);
			this.maxRange = parseFloat(range[1]);
		}
		
		this.currency = zeCurrency;
		
		//Init the nstSlider object
		var self = this;
		this.innerslider = zeSlider.nstSlider({
		    "left_grip_selector": "#leftGrip"+self.sliderId,
		    "right_grip_selector": "#rightGrip"+self.sliderId,
		    "value_bar_selector": "#bar"+self.sliderId,
		    "user_mouseup_callback":function(vmin, vmax, left_grip_moved) {
		    	//Update facet when the mouse is released
				var selectedValues = [vmin,vmax];
				if(selectedValues[0] === "<1") selectedValues[0] = 0;
				var min = selectedValues[0];
				var max = selectedValues[1];
				self.showOrHide(min, max);
				self.setHiddenInput(min, max);
				dojo.topic.publish('Facet_Add', 'facetPrice'+self.sliderId);
			 },
		    "value_changed_callback": function(cause, leftValue, rightValue, prevLeft, prevRight) {
		    	//Update values display
		    	if(leftValue<1){
		    		$('#leftGripValue'+self.sliderId).text("<1"+self.currency);
		    	}
		    	else{
		    		$('#leftGripValue'+self.sliderId).text(leftValue+self.currency);
		    	}
		        $('#rightGripValue'+self.sliderId).text(rightValue+self.currency);
		    }
		});
	}
	
	FacetNavigationSlider.prototype.reset = function() {
		//Reset when deselect facet_price
		if(this.innerslider != null){
			this.innerslider.nstSlider("set_range", this.minRange, this.maxRange);
			this.innerslider.nstSlider("set_position", this.minRange, this.maxRange);
			this.showOrHide(this.minRange, this.maxRange);
		}
	}
	
	
	
	FacetNavigationSlider.prototype.setRanges = function(ranges) {

		//When add/remove another facet, price range changes
		if(this.innerslider != null){
			if(this.reloadMin != 0 && this.reloadMax != 0){
				var self = this;
				//reload from URL
				this.innerslider.nstSlider("set_range", this.reloadMin, this.reloadMax);
				this.innerslider.nstSlider("set_position", this.reloadMin, this.reloadMax);
				this.setHiddenInput(this.reloadMin, this.reloadMax);
				dojo.topic.publish('Facet_Add', 'facetPrice'+self.sliderId);
				this.showOrHide(this.reloadMin, this.reloadMax);
				
				//Reset to default values
				this.reloadMin = 0;
				this.reloadMax = 0;
			} else {
				var range = ranges.split(";");
				if(range.length == 2) {
					this.minRange = parseFloat(range[0]);
					this.maxRange = parseFloat(range[1]);
				}
				
				this.innerslider.nstSlider("set_range", this.minRange, this.maxRange);
				this.innerslider.nstSlider("set_position", this.minRange, this.maxRange);
				this.showOrHide(this.minRange, this.maxRange);
			}
			this.innerslider.nstSlider("refresh");
		}
	}
	
	FacetNavigationSlider.prototype.bindEvent = function() {
		// Reconstruction du slider pour afficher le min et max price en fonction des facettes selectionnes.
		//TODO
//		$(this).on('mixMaxPriceChanged_Event', function(event, newPriceFacetRange){
//			
//		})
	}
	
	FacetNavigationSlider.prototype.setValues = function(minValue, maxValue) {
		//When the page is reloaded with facet in parameters
		if(this.innerslider != null){
			var min = parseInt(minValue);
			var max = parseInt(maxValue);
			this.minRange = min;
			this.maxRange = max;
			this.innerslider.nstSlider("set_range", min, max);
			this.innerslider.nstSlider("set_position", min, max);
			
			this.reloadMin = this.minRange;
			this.reloadMax = this.maxRange;
		}
	}
