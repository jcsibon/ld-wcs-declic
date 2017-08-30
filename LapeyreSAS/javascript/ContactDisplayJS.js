 dojo.require("wc.service.common");

ContactDisplayJS={ 

	setFormName: function(formName){
		wc.render.updateContext('contactForm_context',{'formName':formName});
	}

},

/**
 * Declares a new render context for contact form selection.
 */
wc.render.declareContext("contactForm_context",{FormName:"contactForms"},"");

wc.render.declareRefreshController({
	id: "contactForm_controller",
	renderContext: wc.render.getContextById("contactForm_context"),
	url: "ContactFormView",
	formId: ""

	,modelChangedHandler: function(message, widget) {
	var controller = this;
	var renderContext = this.renderContext;
	widget.refresh(renderContext.properties);
	}
	,renderContextChangedHandler: function(message, widget) {
	var controller = this;
	var renderContext = this.renderContext;
	widget.refresh(renderContext.properties);
	}
	,postRefreshHandler: function(widget) {
	var controller = this;
	var renderContext = this.renderContext;
	cursor_clear();
	}
});