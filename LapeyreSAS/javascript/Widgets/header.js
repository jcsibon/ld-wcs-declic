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

require([
		"dojo/_base/event",
		"dojo/_base/html",
		"dojo/dom",
		"dojo/dom-class",
		"dojo/dom-style",
		"dojo/dom-geometry",
		"dojo/dom-construct",
		"dojo/has",
		"dojo/on",
		"dojo/query",
		"dojo/topic",
		"dojo/_base/sniff",
		"dojo/domReady!",
		"dojo/NodeList-dom",
		"dojo/NodeList-traverse"
	], function(event, lang, dom, domClass, domStyle, domGeom, domConstruct, has, on, query, topic) {
	var mouseDownConnectHandle = null;
	var activeMenuNode = null;
	var toggleControlNode = null;
	var active = {};
	var ajaxRefresh = "";
	
	var registerMouseDown = function() {
		if (mouseDownConnectHandle == null) {
			mouseDownConnectHandle = on(document.documentElement, "mousedown", handleMouseDown);
		}
	};
	
	var unregisterMouseDown = function() {
		if (mouseDownConnectHandle != null) {
			mouseDownConnectHandle.remove();
			mouseDownConnectHandle = null;
		}
	};
	
	var handleMouseDown = function(evt) {
		var node = evt.target;
		if (activeMenuNode != null && node != document.documentElement) {
			var close = true;
			var parent = activeMenuNode.getAttribute("data-parent");
			while (node && node != document.documentElement) {
				if (node == activeMenuNode || node == toggleControlNode || domClass.contains(node, "dijitPopup") || parent == node.getAttribute("data-parent")) {
					close = false;
					break;
				}
				node = node.parentNode;
			}
			if (node == null) {
				var children = query("div", activeMenuNode);
				for (var i = 0; i < children.length; i++) {
					var position = domGeometry.position(children[i]);
					if (evt.clientX >= position.x && evt.clientX < position.x + position.w &&
						evt.clientY >= position.y && evt.clientY < position.y + position.h) {
						close = false;
						break;
					}
				}
			}
			if (close) {
				deactivate(activeMenuNode);
			}
		}
	};
	
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
		var toggleControl = query("a[data-toggle='" + target.id + "']");
		toggleControl.addClass("selected");
		if (parent) {
		active[parent] = target;
			if (activeMenuNode == null) {
				activeMenuNode = target;
				toggleControlNode = toggleControl.length > 0 ? toggleControl[0] : null;
				registerMouseDown();
			}
		}
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
		if (target == activeMenuNode) {
			activeMenuNode = null;
			toggleControlNode = null;
			unregisterMouseDown();
		}
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
		
		/* Setup search button in mobile */
		var searchMobile = document.getElementById("headerMobile-search");
		var searchBarMobile = document.getElementById("mobileSearch");
		
		on(searchMobile, "click", function() {
			if(searchBarMobile.className.search("on") === -1){
				domClass.add(searchBarMobile, "on");
				dojo.animateProperty({
					node:searchBarMobile,
					properties: {
						top: 0
					}
				}).play();
				dojo.animateProperty({
					node:"page",
					properties: {
						top: 100
					}
				}).play();
			}else{
				dojo.animateProperty({
					node:searchBarMobile,
					properties: {
						top: -100
					}
				}).play();
				dojo.animateProperty({
					node:"page",
					properties: {
						top: 0,
						onEnd: function(){domClass.remove(searchBarMobile, "on");}
					}
				}).play();
			}			
		});
		
	};

	
	setUpEventActions();
	
	var header = document.getElementById("header");
	var direction = domStyle.getComputedStyle(header).direction;
	
	query("#searchFilterMenu > ul > li > a").on("click", function(e) {
		document.getElementById("searchFilterButton").innerHTML = this.innerHTML;
		document.getElementById("categoryId").value = this.getAttribute("data-value");
		deactivate(document.getElementById("searchFilterMenu"));
	});
	query("#searchBox > .submitButton").on("click", function(e) {
		launchSearch();
	});
	
	var searchBox = document.getElementById("searchBox");
	if (searchBox) {
		on(searchBox, "submit", function(e) {
			updateFormWithWcCommonRequestParameters(e.target);
			var searchTerm = document.getElementById("SimpleSearchForm_SearchTerm");
			var origTerm = searchTerm.value;
			var unquote = lang.trim(searchTerm.value.replace(/'|"/g, ""));
			searchTerm.value = unquote;
		
			if (!searchTerm.value) {
				event.stop(e);
				return false;
			}
			searchTerm.value= lang.trim(origTerm);
		});
	}
	
	/* Function to test if the device is mobile or tablet using the screen size */
	function isMobile() {
		var isMobile = false;
		if (window.matchMedia) {
			var mediaQuery = window.matchMedia("(max-width: "+(desktopBreakpoint-1)+"px)");
			isMobile = mediaQuery ? mediaQuery.matches : viewport().width <= desktopBreakpoint;
		}
		return isMobile;
	}
	
    // Overlay management
    var overlay = {
    	element: dom.byId('overlay'),
	    inDesktopHeaderContainer: dom.byId('headerContainer'),
	    inMobileHeaderContainer: dom.byId('headerContainer'),
	    atPosition: 'first',
	    
	    windowHasResized: function(mediaQuery) {
	    	var isMobile = mediaQuery ? mediaQuery.matches : viewport().width <= desktopBreakpoint;
    		if (isMobile) {
    			domConstruct.place(this.element, this.inMobileHeaderContainer, this.atPosition);
    		} else {
    			domConstruct.place(this.element, this.inDesktopHeaderContainer, this.atPosition);
    		}
	    },
	    
	    init: function() {
	    	if (window.matchMedia) {
				var mediaQuery = window.matchMedia("(max-width: "+(desktopBreakpoint-1)+"px)");
				mediaQuery.addListener(
					dojo.hitch(this, function(mediaQuery) {
						this.windowHasResized(mediaQuery);
					})
				);
			}
	    	this.windowHasResized();
	    }
    }
    overlay.init();

    // Header popover management
	headerPopovers = {

		popovers: [],
		header: $('#headerRow1'),
		fadeDuration: 200,
		hoverDuration: 500,
		zIndexBase: 200,

		position: function(popover) {
			var frame = popover.frame,
				winWidth = viewport().width,
				bodyWidth = $('body').outerWidth(),
				popoverWidth = frame.outerWidth(),
				top  = Math.round(this.header.position().top + this.header.height()),
				left = Math.round(popover.parent.offset().left + popover.parent.outerWidth() / 3 - frame.outerWidth() / 2);

			frame.css('top', top + 'px');
			frame.css('left', left + 'px');
			
			var a = Math.round((winWidth - bodyWidth) / 2);

			if (left + popoverWidth > a + bodyWidth) {
				left = a + bodyWidth - popoverWidth - 8;
				frame.css('left', left + 'px');
				frame.find('.popover-frame-arrow').css('left', '80%');

			} else {
				frame.find('.popover-frame-arrow').css('left', '52%');
			}
		},
		
		positionAll: function() {
			$.each(this.popovers, $.proxy(function(i, popover) {
				this.position(popover);
			}, this));
		},

		hideAll: function() {
			$.each(this.popovers, function(i, popover) {
				popover.frame.hide();
			});
		},

		add: function (popover) {
			// Skip if the popover is already registered
			for (p in this.popovers) {
				if (p === popover) {
					return;
				}
			}

			// Register and position the popover
			popover.active = false;
			popover.focused = false;
			popover.frame.addClass('popover-frame');
			this.popovers.push(popover);
			this.position(popover);

			// Manage display of the popover and link interaction
			var handle,
				z = this.zIndexBase,
				fadeDuration = this.fadeDuration,
				hoverDuration = this.hoverDuration,
				otherPopovers = $.grep(this.popovers, function(otherPopover) {
					return otherPopover !== popover;
				});

			function onMouseEnter() {
				if (handle) {
					clearTimeout(handle);
				}
				$.each(otherPopovers, function hideOtherPopovers(i, otherPopover) {
					otherPopover.frame.css('z-index', z);
					otherPopover.frame.fadeOut(fadeDuration);
				});
				popover.frame.css('z-index', z + 1);
				popover.frame.fadeIn(fadeDuration, function fadeInComplete() {
					var mouseLeavingHandle;
					popover.frame.on('mouseenter', function mouseLeavingPopover() {
						popover.active = true;
						if (mouseLeavingHandle) {
							clearTimeout(mouseLeavingHandle);
						}
					});
					popover.frame.on('mouseleave', function mouseLeavingPopover() {
						popover.active = false;
						mouseLeavingHandle = setTimeout(function() {
							if (!popover.active && !popover.focused) {
								popover.frame.fadeOut(fadeDuration);
							}
						}, hoverDuration);
					});
				});
			}

			function onMouseLeave() {
				popover.frame.css('z-index', z);
				handle = setTimeout(function() {
					if (!popover.active && !popover.focused) {
						popover.frame.fadeOut(fadeDuration);
					}
				}, hoverDuration);
			}
			
			function onPopoverFieldFocus() {
				popover.focused = true;
			}
			
			function onPopoverFieldBlur() {
				popover.focused = false;
			}

			popover.link
				.on('mouseenter', onMouseEnter)
				.on('mouseleave', onMouseLeave);
			
			popover.frame.find('a, input, select, textarea')
				.on('focus', onPopoverFieldFocus)
				.on('blur', onPopoverFieldBlur);

			// The popover is a direct child of the body
			$('body').append(popover.frame.detach());
		},

		init: function() {
			$(window).on('resize scroll touchmove', $.proxy(this.hideAll, this));
			$(window).on('resize scroll touchmove', $.proxy(this.positionAll, this));
			topic.subscribe('headerHasChanged', dojo.hitch(this, function() {
				this.positionAll();
			}));
			headerPopovers.add({
				frame: $('#monMagPopup'),
				link: $('#storeQuickLink'),
				parent: $('#StoreChosenInfos')
			});
			headerPopovers.add({
				frame: $('#monComptePopup'),
				link: $('#signInOutQuickLink, #myAccountQuickLink'), // Guest, Registered
				parent: $('#MyAccountInOut')
			});				
		}
	}
	headerPopovers.init();
	
	// Launch search
	launchSearch = function(){
		var searchTerm = document.getElementById("SimpleSearchForm_SearchTerm");
		searchTerm.value = searchTerm.value.trim();
		var unquote = searchTerm.value.replace(/'|"/g, "").trim();
		if (searchTerm.value && unquote != "") {
			processAndSubmitForm(document.getElementById("searchBox"));
		}
	};
	
	changeArrow = function(arrow, toMove) {
		var myArrow = dojo.byId(arrow);
		var myWinWidth = viewport().width;
		dojo.connect(myArrow, "onclick", function(e) {
			/* Commenté pour le moment, potentiellemnt réutilisable */
			/*if(arrow == "slider-arrow") {
				var otherArrow = dojo.byId("slider-arrow1");
				// si connecte et que le hamburger myaccount est affiche
				if(!dojo.byId("guestAccount") && dojo.hasClass(otherArrow, "alreadyLoaded")) {
					var otherToMove = dojo.byId("navMonCompte");
					dojo.animateProperty({
						node:otherToMove,
						properties: {
							left: -260
						}
					}).play();
					dojo.removeClass(otherArrow, "burgerShown");
				}
			}*/
			/*if(arrow == "slider-arrow1") {
			var otherArrow = dojo.byId("slider-arrow");
			// si le hamburger menu est affiche
			if(dojo.hasClass(otherArrow, "alreadyLoaded")) {
				var otherToMove = dojo.byId("headerWidget");
				dojo.animateProperty({
					node:otherToMove,
					properties: {
						left: -260
					}
				}).play();
				dojo.removeClass(otherArrow, "burgerShown");
			}
			}*/
			
			/* We need to check if the footer is inside or outside the page in order to move it while clicking the menu */
			var footer = dojo.query("#footer");
			var moveFooter = true;
    		var nextParent = footer.parent();
    		while(nextParent[0]!=undefined){
				if(nextParent[0].id == "page"){
					moveFooter = false;
				}
				nextParent = nextParent.parent();
			}
    		if(footer.length == 0) {
    			moveFooter = false;
    		}
			
			var toMoveRightAnimation = dojo.animateProperty({
				node:toMove,
				properties: {
					left: 0
				}
			})

			var headerMobileSlideRightAnimation = dojo.animateProperty({
				node:"headerMobileContainer",
				properties: {
					left: 260,
					width: { end: viewport().width, start: viewport().width, units: "px"}
				}
			})
			
			var pageSlideRightAnimation = dojo.animateProperty({
				node:"page",
				properties: {
					left: 260
				}
			})
			
			var footerSlideRightAnimation = dojo.animateProperty({
				node:"footer",
				properties: {
					left: 260
				}
			})
			
			
			
			//if(!dojo.byId("guestAccount")) $("#monComptePopup").show();
			
			/* Slide to right */
			if (!dojo.hasClass(myArrow, "burgerShown")){	
				toMoveRightAnimation.play();
				headerMobileSlideRightAnimation.play();
				pageSlideRightAnimation.play();
				if(moveFooter) {
					footerSlideRightAnimation.play();
				}
				dojo.query(myArrow).addClass("alreadyLoaded"); 	
			}
			
			dojo.style("overlay", "display", "block");
			require(["dojo/_base/window", "dojo/dom-class"], function(win, domClass) {
			    domClass.add(win.body(), "navPanel-open");
			});
			
			if (dojo.isObject(dojo.byId("departmentMenu") == true)) {
				if(dojo.hasClass("departmentMenu","active")) {
					dojo.removeClass("departmentMenu","active");
				}
			}
			dojo.addClass(myArrow, "burgerShown");
		});
		
		var overlay = document.getElementById("overlay");
		dojo.connect(overlay, "onclick",function(e) {
			if (dojo.hasClass(myArrow, "burgerShown")){
				
				/* We need to check if the footer is inside or outside the page in order to move it while clicking the menu */
				var footer = dojo.query("#footer");
				var moveFooter = true;
	    		var nextParent = footer.parent();
	    		while(nextParent[0]!=undefined){
					if(nextParent[0].id == "page"){
						moveFooter = false;
					}
					nextParent = nextParent.parent();
				}
	    		if(footer.length == 0) {
	    			moveFooter = false;
	    		}
				
				var toMoveSlideToLeftAnimation = dojo.animateProperty({
					node:toMove,
					properties: {
						left: -260
					}
				})

				var headerMobileSlideToLeftAnimation = dojo.animateProperty({
					node:"headerMobileContainer",
					properties: {
						left: 0,
						width: { start: viewport().width, end: viewport().width, units: "px"}
					}
				})
				
				var pageSlideToLeftAnimation = dojo.animateProperty({
					node:"page",
					properties: {
						left: 0
					}
				})
				
				var footerSlideToLeftAnimation = dojo.animateProperty({
					node:"footer",
					properties: {
						left: 0
					}
				})
				
				pageSlideToLeftAnimation.play();
				headerMobileSlideToLeftAnimation.play();
				toMoveSlideToLeftAnimation.play();
				
				if(moveFooter) {
					footerSlideToLeftAnimation.play();
				}
				
				/* Reset the header mobile width to 100% */
				on(headerMobileSlideToLeftAnimation, "End", function(){
					document.getElementById("headerMobileContainer").style.width = "100%";
				  });
				
				
				dojo.removeClass(myArrow, "burgerShown");
				require(["dojo/_base/window", "dojo/dom-class"], function(win, domClass) {
				    domClass.remove(win.body(), "navPanel-open");
				});
				dojo.style("overlay", "display", "none");
			}
		});
	}
	
	// Sliding side panel
	slidingSidePanel = function() {
		var myHeader = dojo.byId("headerWidget");
		var myAccountBar = dojo.byId("navMonCompte");
		
		has = require("dojo/has");
		
		navPanelToggle = function () {
			var myWinWidth = viewport().width;
			var qlbar = dojo.byId("quickLinksBar");
			var sbar = dojo.byId("searchBar");
			var menu = dojo.byId("departmentsMenu");
			var headerRow2 = dojo.byId("headerRow2");
			var editorialLinks = dojo.query(".editorialLinks");
			var departmentLinks = dojo.query(".departmentLinks");
			var headerStore = dojo.byId("StoreChosenInfos");
			var headerMobileRightSide = dojo.byId("mobileRightHeader");
			var headerRow1 = dojo.byId("headerRow1");
			var menuPromo = dojo.query("#departmentMenu_promos");

			/* StoreLocator management
			 * First we hide the temporary store locator. Temp is used to have store display in mobile before it is loaded.
			 * Then the store locator is moved according to the width of the screen
			 */
			dojo.setStyle(dojo.byId("StoreChosenInfosTemp"), "display", "none");
			
			if(myWinWidth < tabletBreakpoint) {
				/* Move Store locator to the second position of the menu */	
				dojo.place(headerStore, headerRow2, 4);
				dojo.replaceClass(headerStore, "mobileMenuButton desktop-hidden print-hidden");
			} else if(myWinWidth < desktopBreakpoint) {
				/* Move Store locator to the right header mobile */	
				dojo.replaceClass(headerStore, "vCenteredHeaderContainer print-hidden col m6 hide-on-small-only");
				dojo.place(headerStore, headerMobileRightSide, "first");
			} else {
				/* Move Store locator to the desktop header */	
				dojo.replaceClass(headerStore, "right vCenteredHeaderContainer print-hidden");
				dojo.place(headerStore, headerRow1, "last");
			}
			if(myWinWidth < desktopBreakpoint) {
				dojo.addClass(myHeader, "navPanel");
				dojo.destroy("sbar");
				dojo.place(qlbar, dojo.byId("wc_widget_RefreshArea_0"), "after");
				
				dojo.byId("mobileSearch").appendChild(sbar);

				/* Place Promo to the top of the mobile menu */
				if(menuPromo.length > 0){
					dojo.place(menuPromo.parent()[0], menu, 0);
				}
				if(myAccountBar != null) {
					dojo.addClass(myAccountBar, "navPanel");
				}
				if (has("ie") > 8) {
					var divContenWrapper = document.getElementsByClassName("content_wrapper");
					for (var i = 0; i < divContenWrapper.length; i++) {
						divContenWrapper[i].style.margin = '100px 0px 0px 0px';
					}
					if(dojo.byId("contentWrapper") != null) {
						dojo.style('contentWrapper','margin','100px 0px 0px 0px');
					}			
				}
			}
			else {
				dojo.query(myHeader).removeClass("navPanel");
				dojo.destroy("sbar");
				dojo.place(qlbar, dojo.byId("quickLinksBarContainer"), "first");
				dojo.place(sbar, dojo.byId("headerRow1"), 10);
				/* Place Promo in first position in the menu */
				if(menuPromo.length != 0){					
					dojo.place(menuPromo.parent()[0], departmentLinks[departmentLinks.length-1], "after");
				}
				if(myAccountBar != null) {
					dojo.query(myAccountBar).removeClass("navPanel");
				}
				if (has("ie") > 8) {
					var divContenWrapper = document.getElementsByClassName("content_wrapper");
					for (var i = 0; i < divContenWrapper.length; i++) {
						divContenWrapper[i].style.margin = '0px 0px 0px 0px';
					}
					if(dojo.byId("contentWrapper") != null) {
						dojo.style('contentWrapper','margin','0px 0px 0px 0px');
					}
				}
			}
		};
		
		windowResizeHandle = function() {
			var myArrow = dojo.byId("slider-arrow");
			
			var myWinWidth = viewport().width;
			var divOverlay = document.getElementById("overlay");
			if(divOverlay) {
				/*if(myWinWidth >= desktopBreakpoint) {
					var isVisible = document.getElementById("overlay").offsetHeight != 0;
					if (isVisible == true) {
						dojo.style("overlay", "display", "none");
						require(["dojo/_base/window", "dojo/dom-class"], function(win, domClass) {
							domClass.remove(win.body(), "navPanel-open");
						});
					}
					$('.navigation_edito_mobile').addClass('navigation_edito_desktop').removeClass('navigation_edito_mobile');
					$('.LPProMobile').addClass('LPProDesktop').removeClass('LPProMobile');
				}
				else {
					$('.navigation_edito_desktop').addClass('navigation_edito_mobile').removeClass('navigation_edito_desktop');
					$('.LPProDesktop').addClass('LPProMobile').removeClass('LPProDesktop');
					if (dojo.hasClass(myArrow, "hide") || (myArrow1 && dojo.hasClass(myArrow1, "hide"))) {
						dojo.style("overlay", "display", "block");
					}
					else {
						if (dojo.hasClass(myArrow, "show") || (myArrow1 && dojo.hasClass(myArrow1, "show"))) {
							dojo.style("overlay", "display", "none");
						}
						else {
							dojo.style("overlay", "display", "block");
						}	
					}				
				}*/
			}
		};
		
		on(window, "resize", function() {
			windowResizeHandle();
		});
	
		windowResizeHandle();
		navPanelToggle();
		
		var mediaPhone = window.matchMedia('(max-width: '+(tabletBreakpoint-1)+'px)');
		var mediaTablet = window.matchMedia('(max-width: '+(desktopBreakpoint-1)+'px) and (min-width: '+tabletBreakpoint+'px)');
		var mediaDesktop = window.matchMedia('(min-width: '+desktopBreakpoint+'px)');
		
		mediaPhone.addListener(function(changed) {
		    if(changed.matches) {
		    	navPanelToggle();
		    }
		});
		
		mediaTablet.addListener(function(changed) {
		    if(changed.matches) {
		    	navPanelToggle();
		    }
		});
		
		mediaDesktop.addListener(function(changed) {
		    if(changed.matches) {
		    	navPanelToggle();
		    }
		});
		
		changeArrow("slider-arrow","headerWidget");
		//if(myAccountBar != null) { changeArrow("slider-arrow1","navMonCompte"); }
	}
	
	var stickyHeader = {
			wrapperElement: null,
			waypointTopPosition: 92,
			delta: 10,
			_mobileWidthBreakpoint: 800,
			_prevScrollPosition: domGeom.docScroll().y,
			_handler: null,

			windowHasScrolled: debounce(function() {
				if (!isMobile()) {
					var scrollPosition = domGeom.docScroll().y;
					// Scroll minimum
					if (Math.abs(this._prevScrollPosition - scrollPosition) <= this.delta) {
						return;
					}
					// Scroll Down
					if (scrollPosition > this._prevScrollPosition && scrollPosition > this.waypointTopPosition) {
						$("#headerContainer").slideUp(100);
						topic.publish("headerHasChanged", true);
					// Scroll Up
					} else {
						var viewportHeight = viewport().height;
						var body = document.body,
						html = document.documentElement;
						var documentHeight = Math.max(body.scrollHeight,
								body.offsetHeight, html.clientHeight,
								html.scrollHeight, html.offsetHeight);

						if (scrollPosition + viewportHeight < documentHeight) {
							$("#headerContainer").slideDown(100);
							topic.publish("headerHasChanged", false);
						}
					}
					this._prevScrollPosition = scrollPosition;
				}
			}, 50),

			pause: function() {
				this._handler.pause();
			},
			
			resume: function() {
				this._handler.resume();
			},
			
			init: function() {
				this._handler = on.pausable(window, 'scroll, resize, touchmove, wheel, mousewheel', 
					dojo.hitch(this, function() {
						this.windowHasScrolled();
					})
				);
			}
	    }
	    stickyHeader.init();
});

dojo.ready(function(){
	dojo.subscribe("/MiniShopCartDisplayRefresh", function(data){
	   document.getElementById('minishopcart_total_mobile').innerHTML = data.total;
	});
	
	var divOverlay = document.getElementById("overlay");
	if(!divOverlay) {
		divOverlay=document.createElement('div');
		divOverlay.setAttribute('id','overlay');
		document.body.appendChild(divOverlay);
	}
	slidingSidePanel();
	$("#dropDownMenuCategories").change(function(){
		$( "select option:selected" ).each(function() {
			document.href= $( this ).text();
		});
	});
});

wc.render.declareRefreshController({
	id:"HeaderStoreLocationRefreshArea",
	renderContext: wc.render.getContextById("HeaderStoreLocation_Context"),
	url: "",
	formId: "",
	renderContextChangedHandler: function(message, widget) {
		widget.refresh(this.renderContext.properties);
	},
	postRefreshHandler: function(widget) {
		headerPopovers.add({
			frame: $('#monMagPopup'),
			link: $('#storeQuickLink'),
			parent: $('#StoreChosenInfos')
		});
	}
});

// Nominal header height 
if (!isMobileDevice() && !dojo.style(document.body, 'padding-top')) {
	dojo.style(document.body, 'padding-top', '0px');
}
