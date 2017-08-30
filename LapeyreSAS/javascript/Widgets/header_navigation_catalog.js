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
	var ajaxRefresh = "";
	activate = function(target) {
		if(this.ajaxRefresh == "true"){
			setAjaxRefresh(""); // No more refresh till shopper leaves this page
			// Update the Context, so that widget gets refreshed..
			wc.render.updateContext("departmentSubMenuContext", {"targetId":target.id});
			return;
		}

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
	
	var windowResizeHandle = function() {
		var myWinWidth = viewport().width;
		
		var departmentMenus = query(".departmentMenu");
		var departmentLinks = query(".departmentLinks, .editorialLinks");
		var menuContainer = dojo.byId("departmentsMenuContainer");
		var menuDepartmentsContainer = dojo.byId("departmentsMenu");

		/* We need to extract the departmentMenus to a new container due to the new design (megaMenu = 100% screen size)*/
		/* < 2 because it has at least 1 text node */
		if (myWinWidth >= desktopBreakpoint && menuContainer.childNodes.length < 2) {
			departmentMenus.forEach(function(menu, i) {
					var clone = dojo.clone(menu);
					dojo.create(clone, null, menuContainer, 0);
			});
		}
		

	};

	on(window, "resize", function() {
		windowResizeHandle();
	});	

	windowResizeHandle();

	setUpEventActions = function() {
		var departmentsMenu = document.getElementById("departmentsMenu");
		var departmentButtons = query(".departmentButton");
		var departmentMenus = query(".departmentMenu");
		var departmentLinks = query(".departmentMenu > h3 > .link");
		var departmentToggles = query(".departmentMenu > h3 > .toggle");
		var liDepartmentsMenu = query('#departmentsMenu > li');
		var menuContainer = document.getElementById("departmentsMenuContainer");
		
		var mouse = dojo.require("dojo.mouse");
		var myWinWidth = viewport().width;
		
		liDepartmentsMenu.forEach(function(li, i) {
			if(i >= 0 && i < liDepartmentsMenu.length && departmentButtons[i].getAttribute("aria-haspopup")=="true") {
				
				
				
				var handleIn, handleOut, fromLi;
				
				var mouseEnter = function() {
					if(viewport().width >= desktopBreakpoint){
						dojo.style("overlay", "display", "block");
						domClass.add(li, "on");
						var menu = query("#departmentsMenuContainer #"+li.getAttribute("data-target"));
						domClass.add(menu[0], "on");
					}
				};
				
				var mouseLeave = function(evt) {
					if(viewport().width > desktopBreakpoint){
		        		var menu = query("#departmentsMenuContainer #"+li.getAttribute("data-target"))[0];

		        		/* We leave the button, if the mouse is not over the menu, we need to hide it */
		        		var remove = true;
		        		var nextParent = evt.relatedTarget;
		        		while(nextParent!=null){
	        				if(nextParent.id == "departmentsMenuContainer"){
	        					remove = false;
	        				}
	        				nextParent = nextParent.parentElement;
	        			}
		        		if(remove){
		        			domClass.remove(menu, "on");
		        			domClass.remove(li, "on");
		        			dojo.style("overlay", "display", "none");
		        		}
					}
	        	};
				
				on(li, mouse.enter, function() {
					clearTimeout(handleOut);
					handleIn = setTimeout(mouseEnter, 500);
		        });
				
				on(li, mouse.leave, function(evt) {
		        	clearTimeout(handleIn);
		        	handleOut = setTimeout(mouseLeave(evt), 400);
		        });
				
			}
		});
		
		on(menuContainer, mouse.leave, function() {
			dojo.style("overlay", "display", "none");
			liDepartmentsMenu.forEach(function(li, i) {
				domClass.remove(li, "on");
			});
			var menus = query("#departmentsMenuContainer > div");
			menus.forEach(function(div, i) {
				domClass.remove(div, "on");
			});
        });
		
		
		var headerPopups = query('.headerPopup > .headerLayer');
		headerPopups.forEach(function(li,i){
			var handleOut;
			var mouseEnter = function() {
			};
			 on(li, mouse.enter, mouseEnter);
		});

		var closeheaderPopups = query('.headerPopup .close');
		closeheaderPopups.forEach(function(li,i){			
			li.click = function() {
				//TODO close me
			};
		});

		
		departmentButtons.forEach(function(departmentButton, i) {
			on(departmentButton, "keydown", function(e) {
				switch (e.keyCode) {
				case 37:
					departmentButtons[i == 0 ? departmentButtons.length - 1 : i - 1].focus();
					if (domClass.contains(this, "active")) {
						activate(departmentMenus[i == 0 ? departmentMenus.length - 1 : i - 1]);
					}
					event.stop(e);
					break;
				case 39:
					departmentButtons[(i + 1) % departmentButtons.length].focus();
					if (domClass.contains(this, "active")) {
						activate(departmentMenus[(i + 1) % departmentMenus.length]);
					}
					event.stop(e);
					break;
				case 40:
					activate(departmentMenus[i]);
					departmentLinks[i].focus();
					event.stop(e);
					break;
				}
			});
		});
		
		departmentMenus.forEach(function(departmentMenu, i) {
			on(departmentMenu, "keydown", function(e) {
				switch (e.keyCode) {
				case 37:
					departmentButtons[i == 0 ? departmentButtons.length - 1 : i - 1].focus();
					if (domClass.contains(this, "active")) {
						activate(departmentMenus[i == 0 ? departmentMenus.length - 1 : i - 1]);
					}
					event.stop(e);
					break;
				case 39:
					departmentButtons[(i + 1) % departmentButtons.length].focus();
					if (domClass.contains(this, "active")) {
						activate(departmentMenus[(i + 1) % departmentMenus.length]);
					}
					event.stop(e);
					break;
				}
			});
		});		
		
	};
	
	setUpEventActions();
	
	var header = document.getElementById("header");
	var direction = domStyle.getComputedStyle(header).direction;
	
	// Context and Controller to refresh department drop-down
	wc.render.declareContext("departmentSubMenuContext",{targetId: ""},"");
	wc.render.declareRefreshController({
	id: "departmentSubMenu_Controller",
	renderContext: wc.render.getContextById("departmentSubMenuContext"),
	url: "",
	formId: "",
	
	renderContextChangedHandler: function(message, widget) {
		cursor_wait();
		widget.refresh(this.renderContext.properties);
	},
		   
	postRefreshHandler: function(widget) {
		setUpEventActions();  // Again setup the events, since entire department listing HTML elements changed
 		 activate(document.getElementById( this.renderContext.properties.targetId)); // We have all the data.. Activate the menu...
   		 cursor_clear();
	} 
	});

	setAjaxRefresh = function(refresh){
		this.ajaxRefresh = refresh;
	}
});

dojo.addOnLoad(function() {
	setAjaxRefresh("${lazyLoad}"); // Default value in header_navigation_catalog.js is empty/false.
	if(wc.render.getRefreshControllerById("departmentSubMenu_Controller")){
		wc.render.getRefreshControllerById("departmentSubMenu_Controller").url = getAbsoluteURL()+"DepartmentDropdownViewRWD?storeId=<c:out value='${storeId}'/>&catalogId=<c:out value='${catalogId}'/>&langId=<c:out value='${langId}'/>";
	}
});

$(document).ready(function() {
	/* Toggle menu categories */
	$(".departmentLinks .departmentMenu .header").on("click", function(){
		var picto = $(".picto", $(this));
		if(picto != null && picto[0] != null){
			if(picto[0].className.search("plusPicto") != -1){
				picto.addClass("minusPicto").removeClass("plusPicto");
			} else {
				picto.addClass("plusPicto").removeClass("minusPicto");
			}
			
			var categoryList = $(this).parent().find(".categoryList");
			categoryList.slideToggle();
		}
	});
	
	/* Toggle my account */
	$("#headerMobile-account").on("click", function(){
		var pictoPlus = $(".plusPicto", $(this));
		var pictoMinus = $(".minusPicto", $(this));
		var headerMobileAccountMenu = $("#headerMobile-account-menu");
		
		if(pictoPlus != null && pictoPlus[0] != null){
			pictoPlus.addClass("minusPicto").removeClass("plusPicto");
			headerMobileAccountMenu.slideToggle();
		} else if (pictoMinus != null && pictoMinus[0] != null){
			pictoMinus.addClass("plusPicto").removeClass("minusPicto");
			headerMobileAccountMenu.slideToggle();
		}
		
	});
});
