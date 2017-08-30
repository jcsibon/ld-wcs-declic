
/**
 * Surcharge la classe dijit.Dialog en ajoutant le comportement suivant:
 * - Fermeture de la fenêtre modale lorsque l'utilisateur clique en dehors de la fen�tre
 */

define(
	[
		"dojo/_base/declare",
		"dojo/_base/lang", 
		"dojo/on",
		"dojo/dom-class",
		"dojo/dom-style",
		"dojo/dom-geometry",
		"dojo/window",
		"dijit/registry",
		"dijit/Dialog",
		"dijit/DialogUnderlay"
		
	], function(declare, lang, on, domClass, domStyle, domGeometry, winUtils, registry, Dialog, DialogUnderlay) {
		
	return declare(Dialog, {
		
        show: function (event) {
            this.inherited("show", arguments);
            this._modalconnects.push(on(this.domNode, "click", lang.hitch(this, "_onMouseClick")));
            if (event != null || event != undefined) {
            	dojo.stopEvent(event);
            }
//            dojo.style(dojo.body(), "overflow", "hidden");
            this._toggleAutoScrollingCarousels();
        },
        
        hide: function() {
            this.inherited("hide", arguments);
//            dojo.style(dojo.body(), "overflow", "auto");
            this._toggleAutoScrollingCarousels();
        },
        
        // Pause every auto-scrolling carousels on page
        _toggleAutoScrollingCarousels: function() {
        	registry.forEach(function(widget) {
            	if (new RegExp("WCCarousel").test(widget.declaredClass)) {
            		widget.toggleAutoScroll();
            	}
            });
        },
        
        _onMouseClick: function (event) {
        	var node = event.target;
        	while (node) {
        		if (domClass.contains(node, "dijitDialogPaneContent")) {
        			return false;
        		}
        		node = node.parentNode;
        	}
        	this.hide();
        }
	});
});
