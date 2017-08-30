var Contrib = ( function() {
	
	var _url = "";

	function _mandatoryFields(form) {
		return [
			{name: 'to',      element: form.to},
			{name: 'subject', element: form.subject},
		];
	}

	function _isValued(field) {
		if (!field.element) {
			console.error('Missing mandatory field with name "%s"', field.name);
			return false;
		}
		if (!field.element.value) {
			console.error('Missing value for mandatory field with name "%s"', field.name);
			return false;
		}
		return true;
	}

	function _preprocess(form) {
		var $form = $(form),
			formData = $form.find('input:not([type=submit]), select, textarea').serializeArray(),
			jsonData = [];

		formData.forEach(function(field, index) {
			var fieldName = field.name,
				$formElementForName = $form.find('[name=' + fieldName +']');

			// Redéfinit le nom du champ comme étant le texte du libellé qui référence ce champ (via l'attribut for).
			if ($formElementForName.length === 1) {
				var $labelForField = $form.find('label[for="' + $formElementForName.attr('id') + '"]');
				if ($labelForField.length > 0) {
					fieldName = $labelForField.text();
				}
			}

			jsonData.push({name: fieldName, value: field.value});
		});
		return JSON.stringify(jsonData);
	}

	return {
		setEndpoint: function(url) {
			_url = url;
		},
		
		sendForm: function(formName,popupOK,popupKO) {

			var form = document.forms[formName];
			
			if (requestSubmitted) {
				console.log('Response pending ...');
				return;
		    } else {
		    	requestSubmitted = true;
		    }

			if (!form) {
				console.error('Cannot find form with name "%s"', formName);
				return;
			}

			if (!_mandatoryFields(form).every(_isValued)) {
				return;
			}

			$.ajax({
				url: _url,
				method: 'POST',
				contentType: 'application/json',
				data: _preprocess(form),
				success: function() {
					if(popupOK) showPopup(popupOK);
					else showPopup('mailSentPopup');
					form.reset();
				},
				error: function() {
					if(popupKO) showPopup(popupKO);
					else showPopup('mailNotSentPopup');
				},
				complete: function() {
					cursor_clear();
				}
			});
			
			cursor_wait(0);
		}
	}
})();
