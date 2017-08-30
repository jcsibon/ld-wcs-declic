RNVPService = {
		
		zipByCity:null,
		cityByZipURL: null,
		cityByZipLightURL: null,
		zipByCityURL: null,
		
		_elementCity: null,
		_elementCityHidden: null,
		_elementZip: null,
		_elementZipLight: null,
		elementStreet: null,
		
		_oldCity:null,
		_oldCodePostale:null,
		
		elementZipSelector: null,
		_elementCitySelector: null,
		_elementCityHiddenSelector: null,
		_elementStreetSelector: null,
		
		_requestSubmitted: false,
		
		errorMessage: new Object(),
		
		initLight: function(cityByZipURL,cityByZipLightURL,zipByCityURL){
			this.cityByZipURL = cityByZipURL;
			this.cityByZipLightURL = cityByZipLightURL;
			this.zipByCityURL = zipByCityURL;
			this.errorMessage = new Object();
		},
		
		init: function(cityByZipURL,zipByCityURL){
			this.cityByZipURL = cityByZipURL;
			this.zipByCityURL = zipByCityURL;
			this.errorMessage = new Object();
		},
//		//City methods
		onblurCity: function(field,oldCodePostale){
			this._elementCity = field;
			if(typeof oldCodePostale!=="undefined"){
				RNVPService.oldCodePostale = oldCodePostale;
			}
			this._elementCity.setAttribute('onchange','RNVPService.getZipByCity();');
		},
		
		onchangedCitySelector: function(field){
			this._elementCitySelector = field;
			this._elementCitySelector.setAttribute('onchange','RNVPService.citySelectorChanched();');			
		},
		onchangedZipSelector: function(field){
			this._elementZipSelector = field;
			this._elementZipSelector.setAttribute('onclick','RNVPService.zipSelectorChanged();');			
		},
		
		toggleLoadingForElement: function(element){
			if(element!=null)
				{
					var id = element.id;
					var elementLoading = $('#'+id+" ~ img.loading");
					if(elementLoading){
						if(elementLoading.css('display') == 'none'){
							elementLoading.css('display','block');
						}
						else if(elementLoading.css('display') == 'block'){
							elementLoading.css('display','none');
						}
					}
				}
		},
		
		checkCountry : function() {
			var elementCountry = $('#countryField');
			if(!elementCountry) {
				return false;
			}
			
			if(elementCountry.val() == null || trim(elementCountry.val()).length == 0) {
				return false;
			}
			
			if(trim(elementCountry.val()) != 'FR') {
				return false;
			}
			
			return true;
		},
		
		getCityByZip: function(){
			if(!this.checkCountry()) {
				return;
			}
			
			if(this._requestSubmitted){
				return;
			}
			RNVPService.setrequestSubmitted(true);
			var zipCode = this._elementZip.value;
			if(zipCode != ''){
				this.toggleLoadingForElement(this._elementCity);
				$.ajax({
					url : this.cityByZipURL,
					type : 'POST',
					dataType : 'json',
					data : 'zip='+zipCode,
					success : this.callBackSuccessCityByZip,
					error : this.callBackErrorCityByZip
				});
			}
			else{
				this.resetCity();
			}
		},
		
		getCityByZipLight: function(){
			if(!this.checkCountry()) {
				return;
			}
			
			if(this._requestSubmitted){
				return;
			}
			RNVPService.setrequestSubmitted(true);
			var zipCodeLight = this._elementZipLight.value;
			if(zipCodeLight != ''){
				$.ajax({
					url : this.cityByZipLightURL,
					type : 'POST',
					dataType : 'json',
					data : 'zip='+zipCodeLight,
					success : this.callBackSuccessCityByZipLight,
					error : this.callBackErrorCityByZipLight
				});
			}
			else{
				this.resetCity();
			}
		},
		
		callBackSuccessCityByZip: function(response,statut){
			if(response.status == 'OK'){
				var cities = response.cities;
				if(cities.length==1){
					RNVPService.elementCity.value = cities[0];
					RNVPService.elementCity.setAttribute('style','display:block');
					RNVPService.elementCitySelector.parentNode.setAttribute('style','display:none');
					RNVPService.setrequestSubmitted(false);
					clearErrorForElement(RNVPService.elementCity);
				}else if(cities.length > 0){
					RNVPService.elementCity.setAttribute('style','display:none');
					RNVPService.elementCitySelector.parentNode.setAttribute('style','display:block');
					while (RNVPService.elementCitySelector.firstChild) {
						RNVPService.elementCitySelector.removeChild(RNVPService.elementCitySelector.firstChild);
					}
					RNVPService.elementCity.value = cities[0];
					for(var i = 0;i<cities.length;i++){
						var city = cities[i];
						var elementOption = document.createElement('option');
						elementOption.setAttribute('value',city);
						elementOption.innerHTML = city;
						RNVPService.elementCitySelector.appendChild(elementOption);
					}
					RNVPService.setrequestSubmitted(false);
					RNVPService.showDropdown(RNVPService.elementCitySelector);
					RNVPService.showErrorByCode(9992);
				}
				else{
					RNVPService.resetCity();
					RNVPService.showErrorByCode(1001);
				}
			}
			else{
				
				RNVPService.resetCity();
				if("TIMEOUT"!=response.status && "ERR"!=response.status) RNVPService.showErrorByCode(1001);
			}
			RNVPService.toggleLoadingForElement(RNVPService._elementCity);
		},	
		callBackSuccessCityByZipLight: function(response,statut){
			if(response.status == 'OK' || "TIMEOUT"==response.status || "ERR"==response.status){
				var cities = response.cities;
				if(cities.length==1){
					RNVPService.elementCityHidden.value = cities[0];
					RNVPService.elementCityHidden.setAttribute('style','display:block');
					RNVPService.elementCityHiddenSelector.parentNode.setAttribute('style','display:none');
					RNVPService.setrequestSubmitted(false);
					clearErrorForElement(RNVPService.elementCityHidden);
				}else if(cities.length > 0){
					RNVPService.elementCityHidden.setAttribute('style','display:none');
					RNVPService.elementCityHiddenSelector.parentNode.setAttribute('style','display:block');
					while (RNVPService.elementCityHiddenSelector.firstChild) {
						RNVPService.elementCityHiddenSelector.removeChild(RNVPService.elementCityHiddenSelector.firstChild);
					}
					RNVPService.elementCityHidden.value = cities[0];
					for(var i = 0;i<cities.length;i++){
						var city = cities[i];
						var elementOption = document.createElement('option');
						elementOption.setAttribute('value',city);
						elementOption.innerHTML = city;
						RNVPService.elementCityHiddenSelector.appendChild(elementOption);
					}
					RNVPService.setrequestSubmitted(false);
					RNVPService.showDropdown(RNVPService.elementCityHiddenSelector);
					RNVPService.showErrorByCode(9992);
				}
				else{
					RNVPService.resetCityHidden();
					RNVPService.showErrorByCode(1051);
				}
			}
			else{
				RNVPService.resetCityHidden();
				RNVPService.showErrorByCode(1051);
			}
			RNVPService.toggleLoadingForElement(RNVPService._elementCityHidden);
		},
		
		callBackErrorCityByZip: function(xhr, desc, err){
			RNVPService.resetCity();
			RNVPService.toggleLoadingForElement(RNVPService._elementCity);
			$(':input').eq($(':input').index($(RNVPService.elementCity)) + 1).focus();
		},
		
		callBackErrorCityByZipLight: function(xhr, desc, err){
			RNVPService.resetCity();
			RNVPService.toggleLoadingForElement(RNVPService._elementCity);
			$(':input').eq($(':input').index($(RNVPService.elementCity)) + 1).focus();
		},
		
		resetCity:function(){
			this.setrequestSubmitted(false);
			RNVPService.elementCity.setAttribute('style','display:block');
			RNVPService.elementCitySelector.parentNode.setAttribute('style','display:none');
		},
		
		resetCityHidden:function(){
			RNVPService.elementCityHidden.value = "";
			RNVPService.elementCityHidden.setAttribute('style','display:block');
			RNVPService.elementCityHiddenSelector.parentNode.setAttribute('style','display:none');
			RNVPService.setrequestSubmitted(false);
		},
		
		//Zip methods
		onblurZip: function(field){
			this._elementZip = field;
			this._elementZip.setAttribute('onblur','RNVPService.getCityByZip();');
		},
		
		onblurZipLight: function(field){
			this._elementZipLight = field;
			this._elementZipLight.setAttribute('onblur','RNVPService.getCityByZipLight();');
		},

		getZipByCity: function(){
			if(!this.checkCountry()) {
				return;
			}
			
			if(this._requestSubmitted){
				return;
			}
			RNVPService.setrequestSubmitted(true);
			if(this._elementCity.value!='')
			{
				var newcity = this._elementCity.value.toUpperCase();
					this.toggleLoadingForElement(this._elementZip);
					$.ajax({
						url : this.zipByCityURL,
						type : 'POST',
						dataType : 'json',
						data : 'city='+newcity,
						success : this.callBackSuccessZipByCity,
						error : this.callBackErrorZipByCity
					});
			}
			else
			{
				this.resetZip(false);
			}
		},
		
		callBackSuccessZipByCity: function(response,statut){
			var zipCode=null;
			if(RNVPService.oldCodePostale != null)
			 zipCode = RNVPService.oldCodePostale;
			var exists = false;

			if(response.status == 'OK' || response.status == 'MANY')
			{
				zipByCity = response.zipByCity;
				if(Object.keys(zipByCity).length==1)
				{
					RNVPService.elementZip.value = Object.keys(zipByCity)[0];
					RNVPService.elementZip.setAttribute('style','display:block');
					RNVPService.elementZipSelector.parentNode.setAttribute('style','display:none');
					RNVPService.setrequestSubmitted(false);
					clearErrorForElement(RNVPService.elementZip);
					RNVPService.elementCity.value=zipByCity[RNVPService.elementZip.value];
				}
				else if(Object.keys(zipByCity).length > 0)
				{
					RNVPService.elementZip.setAttribute('style','display:none');
					RNVPService.elementZipSelector.parentNode.setAttribute('style','display:block');
					while (RNVPService.elementZipSelector.firstChild) {
						RNVPService.elementZipSelector.removeChild(RNVPService.elementZipSelector.firstChild);
					}
					
					for(var zip in zipByCity){
						if(RNVPService.oldCodePostale == zip)
							exists=true;
					}
					
					if(exists==false)
					{
						RNVPService.elementZip.value = Object.keys(zipByCity)[0];
						for(var zip in zipByCity){
							var city = zipByCity[zip];
							var elementOption = document.createElement('option');
							elementOption.setAttribute('value',zip);
							elementOption.innerHTML = zip;
							RNVPService.elementZipSelector.appendChild(elementOption);
							}
						RNVPService.setrequestSubmitted(false);					
						RNVPService.showDropdown(RNVPService.elementZipSelector);
						RNVPService.zipSelectorChanged();
						RNVPService.showErrorByCode(9991);
					}
					else
					{
						RNVPService.elementZip.value = RNVPService.oldCodePostale;
						var selectedIndex = 0;
						for(var zip in zipByCity){
							selectedIndex++;
							if(RNVPService.oldCodePostale != zip)
								{
									var city = zipByCity[zip];
									var elementOption = document.createElement('option');
									elementOption.setAttribute('value',zip);
									elementOption.innerHTML = zip;
									RNVPService.elementZipSelector.appendChild(elementOption);
								}
							else
								{
									var elementOption = document.createElement('option');
									elementOption.setAttribute('value',zip);
									elementOption.setAttribute('selected', 'selected');
									elementOption.innerHTML = zip;
									RNVPService.elementZipSelector.appendChild(elementOption);
									
								}
						}
						RNVPService.setrequestSubmitted(false);					
						RNVPService.showDropdown(RNVPService.elementZipSelector);
						RNVPService.zipSelectorChanged();
					}
				}
				else{
					RNVPService.resetZip();
				}
			}
			else{
				RNVPService.resetZip("TIMEOUT"!=response.status && "ERR"!=response.status);
			}
			RNVPService.toggleLoadingForElement(RNVPService._elementZip);
		},
		callBackErrorZipByCity: function(xhr, desc, err){
			RNVPService.resetZip();
			RNVPService.toggleLoadingForElement(RNVPService._elementZip);
			$(':input').eq($(':input').index($(RNVPService.elementZip)) + 1).focus();
		},
		
		resetZip:function(isToEmpty){
			if(isToEmpty) RNVPService.elementZip.value="";
			RNVPService.setrequestSubmitted(false);
			RNVPService.elementZip.setAttribute('style','display:block');
			RNVPService.elementZipSelector.parentNode.setAttribute('style','display:none');
		},
		
		//Tools
		setrequestSubmitted: function(value){
			this._requestSubmitted = value;
			if(value){
				this._elementZip.setAttribute('disabled','true');
				this._elementCity.setAttribute('disabled','true');
			}
			else{
				this._elementZip.removeAttribute('disabled');
				this._elementCity.removeAttribute('disabled');
			}
		},
		
		showDropdown: function(element){
		    var evt = document.createEvent("MouseEvents");
		  	evt.initMouseEvent("mousedown", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
		  	element.dispatchEvent(evt);
		},
		
		
		//RNVP Selection handling
		onchangedStreetSelector: function(field){
			this._elementStreetSelector = field;
			this._elementStreetSelector.setAttribute('onchange','RNVPService.streetSelectorChanged();');			
		},
		
		streetSelectorChanged: function(){
			this.elementStreet.value = this.elementStreetSelector.value;
			var selectedIndex = this.elementStreetSelector.selectedIndex;
			var optionSelected = this.elementStreetSelector.childNodes[selectedIndex];
			var zip = optionSelected.getAttribute('data-zip');
			
			this.elementZip.value = zip;
			this.elementZipSelector.value = zip;
			clearErrorForElement(this.elementStreet);
		},
		
		citySelectorChanched: function(){
			this.elementCity.value = this.elementCitySelector.value;
			var selectedIndex = this.elementCitySelector.selectedIndex;
			var optionSelected = this.elementCitySelector.childNodes[selectedIndex];
			
			var zip = optionSelected.getAttribute('data-zip');
			if(zip && zip != ''){
				this.elementZip.value = zip;
				this.elementZipSelector.value = zip;
			}
			clearErrorForElement(this.elementCity);
		},
		zipSelectorChanged: function(){
			this.elementZip.value = this.elementZipSelector.value;
			this.elementCity.value=zipByCity[this.elementZip.value];
			clearErrorForElement(this.elementZip);
		},
		
		showStreetSelection: function(choices){
			this.elementStreet.setAttribute('style','display:none');
			this.elementStreetSelector.parentNode.setAttribute('style','display:block');
			while (this.elementStreetSelector.firstChild) {
				this.elementStreetSelector.removeChild(this.elementStreetSelector.firstChild);
			}
			this.elementStreet.value = choices[0].street;
			for(var i = 0;i<choices.length;i++){
				var choice = choices[i];
				var elementOption = document.createElement('option');
				elementOption.setAttribute('value',choice.street);
				elementOption.setAttribute('data-zip',choice.zip);
				elementOption.innerHTML = choice.street;
				this.elementStreetSelector.appendChild(elementOption);
			}
			this.showDropdown(this.elementStreetSelector);
		},
		
		showCitySelection: function(choices){
			this.elementCity.setAttribute('style','display:none');
			this.elementCitySelector.parentNode.setAttribute('style','display:block');
			while (this.elementCitySelector.firstChild) {
				this.elementCitySelector.removeChild(this.elementCitySelector.firstChild);
			}
			this.elementCity.value = choices[0].city;
			for(var i = 0;i<choices.length;i++){
				var choice = choices[i];
				var elementOption = document.createElement('option');
				elementOption.setAttribute('value',choice.city);
				elementOption.setAttribute('data-zip',choice.zip);
				elementOption.innerHTML = choice.city;
				this.elementCitySelector.appendChild(elementOption);
			}
			this.showDropdown(this.elementCitySelector);
		},
		
		//Error handling
		addErrorMessage: function(errorCode,elmt,errorMessage){
			var elmtErrorMessage = {
					element : elmt,
					message : errorMessage
			};
			var arrayElmtErrorMessage = this.errorMessage[errorCode];
			if(arrayElmtErrorMessage != undefined){
				
			}
			else{
				arrayElmtErrorMessage = new Array();
			}
			arrayElmtErrorMessage.push(elmtErrorMessage);
			this.errorMessage[errorCode] = arrayElmtErrorMessage;
		},
		
		showErrorByCode: function(errorCode){
			var arrayElmtErrorMessage = this.errorMessage[errorCode];
			if(arrayElmtErrorMessage != undefined){
				for(var i = 0;i<arrayElmtErrorMessage.length;i++){
					var elmtError = arrayElmtErrorMessage[i];
					var element = elmtError.element;
					var message = elmtError.message;
					showErrorMessageForElement(element,message);
				}
			}
		}
}
