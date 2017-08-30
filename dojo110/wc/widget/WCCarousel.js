//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/**
 * @version 1.0
 */
dojo.provide("wc.widget.WCCarousel");

/* Import dojo classes */
dojo.require("wc.widget.Carousel");
dojo.require("dojo.query");
dojo.require("dojo.on");

dojo.declare(
    "wc.widget.WCCarousel",
    [wc.widget.Carousel], {
    	
    	_setColumnCountAttr: function(columnCount) {
			var items = dojo.query(this.ul).children("li");
			this._set("columnCount", columnCount);
			items.style("width", ((100 / columnCount)) + "%");
		},
		
		toggleAutoScroll: function() {
			if (!this.auto) {
				return;
			}
			
			if (this.autoInterval) {
				window.clearInterval(this.autoInterval);
				this.set("autoInterval", null);
				return;
			}
			
			var autoInterval = window.setInterval(dojo.hitch(this, "nextPage", true), this.auto);
			this.set("autoInterval", autoInterval);
		}
    }
);
