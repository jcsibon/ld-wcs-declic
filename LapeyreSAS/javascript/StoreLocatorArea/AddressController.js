
dojo.require("dojo/query");

wc.render.declareContext("addressFormInTunnel_Context",{});
	
var refreshControllerAddressFormInTunnel = wc.render.declareRefreshController({
	id: "addressFormInTunnel_controller",
	renderContext : wc.render.getContextById("addressFormInTunnel_Context"),
	url: "",
	formId: ""
	,renderContextChangedHandler: function(message, widget) {
		var renderContext = this.renderContext;
		widget.refresh(renderContext.properties);
	}
	,postRefreshHandler: function(widget) {
		dojo.query('script[id^="addressFormInTunnelScript"]').forEach(function(node, index, nodelist){
			dojo.eval(node.innerHTML);
		 });
		dijit.byId('AddressFormPopin').show();
		dojo.publish("CMPageRefreshEvent");
	}
});