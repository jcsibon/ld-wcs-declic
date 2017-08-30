//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2012 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

// Declare refresh controller which are used in pagination controls of SearchBasedNavigationDisplay -- both products and articles+videos
wc.render.declareRefreshController({
	id: "productContentRecommendationRefresh_controller",
	renderContext: wc.render.getContextById("searchBasedNavigation_context"),
	url: "",
	formId: ""

	,renderContextChangedHandler: function(message, widget) {
		var controller = this;
		var renderContext = this.renderContext;
		var resultType = renderContext.properties["resultType"];
		if(resultType == "products" || resultType == "both"){
			widget.refresh(renderContext.properties);
			console.log("espot refreshing");
		}
	}
	
	/**
	 * Clears the progress bar after a successful refresh.
	 *
	 * @param {Object} widget The refresh area widget.
	 */
	,postRefreshHandler: function(widget) {
		var controller = this;
		var renderContext = this.renderContext;
		cursor_clear();
		
		var refreshUrl = controller.url;
		var emsName = "";
		var indexOfEMSName = refreshUrl.indexOf("emsName=", 0);
		if(indexOfEMSName >= 0){
			emsName = refreshUrl.substring(indexOfEMSName+8);
			if (emsName.indexOf("&") >= 0) {
				emsName = emsName.substring(0, emsName.indexOf("&"));
				emsName = "script_" + emsName;
			}
		}
		
		if (emsName != "") {
			var espot = dojo.query('.genericESpot',dojo.byId(emsName).parentNode)[0];
			if (espot != null) {
				dojo.addClass(espot,'emptyESpot');
			}
		}
		dojo.publish("CMPageRefreshEvent");
	}
});

function handleWindowResize() {
	
}
_on = require("dojo/on");
has = require("dojo/has");
_on(window, "resize", function() {
	navPanelToggle();
	var myWinWidth = viewport().width;
	var divOverlay = document.getElementById("overlay");
	if(divOverlay) {
		if(myWinWidth >= 800) {
			var isVisible = document.getElementById("overlay").offsetHeight != 0;
			if (isVisible == true) {
				dojo.style("overlay", "display", "none");
			}
		}
		else {
			if (dojo.hasClass(myArrow, "show")) {
				dojo.style("overlay", "display", "none");
			}
			else {
				dojo.style("overlay", "display", "block");
			}			
		}
	}
});

/**
 *  Video display widget
 */	

window.onload=function() {   
	var video = document.getElementById("videoScreen");
	if (video) {
		if(video.canPlayType && (video.canPlayType('video/mp4') || video.canPlayType('video/ogg'))) {
			
			function startVideo() {
				this.removeEventListener('play', startVideo, false);
				document.getElementById('promotionTitle').style.display = 'none';
			}
			
			function endVideo() {
				this.removeEventListener('ended', endVideo, false);
				document.getElementById('videoScreen').style.display = 'none';
				document.getElementById('videoFinished').style.display = 'block';
			}
			
			if (!video.addEventListener) {
				video.attachEvent('play', startVideo, false);
				video.attachEvent('ended', endVideo, false);
			}
			else {
				video.addEventListener('play', startVideo, false);
				video.addEventListener('ended', endVideo, false);
			}
		}
		else {
			document.getElementById('promotionTitle').style.display = 'none';
		}
	}
}


