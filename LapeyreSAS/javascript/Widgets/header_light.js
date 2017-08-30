//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2013 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

require([
		"dojo/_base/event",
		"dojo/_base/lang",
		"dojo/dom-class",
		"dojo/dom-style",
		"dojo/has",
		"dojo/on",
		"dojo/query",
		"dojo/_base/sniff",
		"dojo/domReady!",
		"dojo/NodeList-dom",
		"dojo/NodeList-traverse"
	], function(event, lang, domClass, domStyle, has, on, query) {
	var active = {};
	activate = function(target) {
		var parent = target.getAttribute("data-parent");
		if (parent && active[parent]) {
			deactivate(active[parent]);
		}
		if (parent) {
			activate(document.getElementById(parent));
		}
		domClass.add(target, "active");
		query("a[data-activate='" + target.id + "']").addClass("selected");
		query("a[data-toggle='" + target.id + "']").addClass("selected");
		active[parent] = target;
	};
	deactivate = function(target) {
		if (active[target.id]) {
			deactivate(active[target.id]);
		}
		domClass.remove(target, "active");
		query("a[data-activate='" + target.id + "']").removeClass("selected");
		query("a[data-toggle='" + target.id + "']").removeClass("selected");
		var parent = target.getAttribute("data-parent");
		delete active[parent];
	};
	toggle = function(target) {
		if (domClass.contains(target, "active")) {
			deactivate(target);
		}
		else {
			activate(target);
		}
	};

	setUpEventActions = function(){
		query("a[data-activate]").on("click", function(e) {
			var target = this.getAttribute("data-activate");
			activate(document.getElementById(target));
			event.stop(e);
		});
		query("a[data-deactivate]").on("click", function(e) {
			var target = this.getAttribute("data-deactivate");
			deactivate(document.getElementById(target));
			event.stop(e);
		});
		query("a[data-toggle]").on("click", function(e) {
			var target = this.getAttribute("data-toggle");
			toggle(document.getElementById(target));
			event.stop(e);
		});
		query("a[data-toggle]").on("keydown", function(e) {
			if (e.keyCode == 27) {
				var target = this.getAttribute("data-toggle");
				deactivate(document.getElementById(target));
				event.stop(e);
			}
		});

		if (has("ie") < 10) {
			query("input[placeholder]").forEach(function(input) {
				var placeholder = input.getAttribute("placeholder");
				if (placeholder) {
					var label = document.createElement("label");
					label.className = "placeholder";
					label.innerHTML = placeholder;
					input.parentNode.insertBefore(label, input);
					var updatePlaceholder = function() {
						label.style.display = (input.value ? "none" : "block");
					};
					window.setTimeout(updatePlaceholder, 200);
					on(input, "blur, focus, keyup", updatePlaceholder);
				}
			});
		}
	};

	setUpEventActions();
});


dojo.ready(function(){
});