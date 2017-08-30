//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2011, 2014 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

// Declare context and refresh controller which are used in pagination controls of SearchBasedNavigationDisplay -- both products and articles+videos
wc.render.declareContext("searchBasedNavigation_context", {"top_category":"", "contentBeginIndex":"0", "productBeginIndex":"0", "beginIndex":"0", "orderBy":"0", "facetId":"", "pageView":"", "pageViewContent":"", "resultType":"both", "orderByContent":"0", "searchTerm":"", "facet":"", "facetLimit":"", "minPrice":"", "maxPrice":"", "pageSize":"", "facetContent":"", "facetContentId":""}, "");

// Declare context and refresh controller which are used in pagination controls of SearchBasedNavigationDisplay to display content results (Products).
var searchBasedNavigation_controller_initProperties = {
	id: "searchBasedNavigation_controller",
	renderContext: wc.render.getContextById("searchBasedNavigation_context"),
	url: "",
	formId: ""

,renderContextChangedHandler: function(message, widget) {
	var controller = this;
	var renderContext = this.renderContext;
	/* Unbind the events before refreshing the widget */
	SearchBasedNavigationDisplayJS.unbindListeners();
	var resultType = renderContext.properties["resultType"];
	if((resultType == "products" || resultType == "both") && controller.url != ''){
		renderContext.properties["beginIndex"] = renderContext.properties["productBeginIndex"];
		widget.refresh(renderContext.properties);
	}
}

,postRefreshHandler: function(widget) {
    //Count Compare Product and keep Compare Button label up to date
    shoppingActionsJS.countCompareProducts();
    // Checks product compare box
    shoppingActionsJS.checkForCompare();
    
    //Closing the facet popup after updating the search criteria
    var facetPopup = dijit.byId('widget_mobile_facet_popup');
    if(facetPopup != undefined){
    	facetPopup.hide();
    }
     
	// Handle the new facet counts, and update the values in the left navigation.  First parse the script, and then call the update function.
	var facetCounts = byId("facetCounts" + widget.objectId);
	
	if(facetCounts != null) {
		var scripts = facetCounts.getElementsByTagName("script");
		var j = scripts.length;
		for (var i = 0; i < j; i++){
			var newScript = document.createElement('script');
			newScript.type = "text/javascript";
			newScript.text = scripts[i].text;
			facetCounts.appendChild(newScript);
		}
		SearchBasedNavigationDisplayJS.resetFacetCounts();
		
		//uncomment this if you want to hide zero facet values and the facet itself
		//SearchBasedNavigationDisplayJS.removeZeroFacetValues();
		SearchBasedNavigationDisplayJS.validatePriceInput();
	}
	SearchBasedNavigationDisplayJS.setListeners();
	SearchBasedNavigationDisplayJS.updateFilterButtonText();
	updateFacetCounts();
	SearchBasedNavigationDisplayJS.refreshFacetSections();
	SearchBasedNavigationDisplayJS.refreshCatalogGroupHierarchy();
	refreshTooltipster();
	
/*	ECO-MIN_MAX_FACET
 * Uncomment this to activate the recalculation of the min and max price on facet change
 * if(SearchBasedNavigationDisplayJS.mustRefreshPrice) {
		updateFacetPriceSlider();
		if(this.currentRCProperties.minPrice != "" && this.currentRCProperties.maxPrice != "") {
			facetNavigationSlider.setValues(this.currentRCProperties.minPrice, this.currentRCProperties.maxPrice);
		}
	}
*/
	if(SearchBasedNavigationDisplayJS.mustRefreshPrice) {
		dojo.query('script[id^="catalogEntryListRefreshPriceScript"]').forEach(function(node, index, nodelist){
			dojo.eval(node.innerHTML);
		});
	}

	var resultType = widget.controller.renderContext.properties["resultType"];
	if(resultType == "products" || resultType == "both"){
		var currentIdValue = currentId;
		cursor_clear();
		SearchBasedNavigationDisplayJS.initControlsOnPage(widget.objectId, widget.controller.renderContext.properties);
		shoppingActionsJS.updateSwatchListView();
		shoppingActionsJS.checkForCompare();
		var selectedFacet = dojo.query("#filter_" + currentIdValue +" > a")[0];
		var deSelectedFacet = dojo.query("li[id^='facet_" + currentIdValue + "']" + " .facetbutton")[0];
		
		if (selectedFacet != null && selectedFacet != 'undefined'){
			selectedFacet.focus();
		} else if(deSelectedFacet != null && deSelectedFacet != 'undefined'){ 
			deSelectedFacet.focus();
		}
		//0000943: [Search contenus] - Zone de tris et comportement étrange
		//		else if(currentIdValue == "orderBy"){
		//			byId("orderBy"+widget.objectId).focus();
		//		} 
		else {
			var posY = $('#ancreProduct').offset().top; 
			$("html, body").animate({ scrollTop: posY - 120},'fast');
		}
	}
	var pagesList = document.getElementById("pages_list_id");
	if (pagesList != null && !isAndroid() && !isIOS()) {
		dojo.addClass(pagesList, "desktop");
	}
	dojo.publish("CMPageRefreshEvent");
	var comp = dojo.query('.comparators');
	if(comp!=null){
		for(var i = 0; i < comp.length; i++){
			var compScript = comp[i].innerHTML;
			eval(compScript);
		}
	}
}
};

// Declare context and refresh controller which are used in pagination controls of SearchBasedNavigationDisplay to display content results (Articles and videos).
wc.render.declareRefreshController({
	id: "searchBasedNavigation_content_controller",
	renderContext: wc.render.getContextById("searchBasedNavigation_context"),
	url: "",
	formId: ""

,renderContextChangedHandler: function(message, widget) {
	var controller = this;
	var renderContext = this.renderContext;
	var resultType = renderContext.properties["resultType"];
	SearchBasedNavigationDisplayJS.unbindListeners();
	if((resultType == "content" || resultType == "both") && controller.url != ''){
		renderContext.properties["beginIndex"] = renderContext.properties["contentBeginIndex"];
		widget.refresh(renderContext.properties);
	}
}

,postRefreshHandler: function(widget) {
	var resultType = widget.controller.renderContext.properties["resultType"];
	if(resultType == "content" || resultType == "both"){
			var currentIdValue = currentId;
			cursor_clear();
			SearchBasedNavigationDisplayJS.initControlsOnPage(widget.objectId, widget.controller.renderContext.properties);
			//shoppingActionsJS.initCompare();
			//0000943: [Search contenus] - Zone de tris et comportement étrange
//			if(currentIdValue == "orderByContent"){
//				byId("orderByContent").focus();
//			}
		}
		
//	    //Count Compare Product and keep Compare Button label up to date
//	    shoppingActionsJS.countCompareProducts();
//	    // Checks product compare box
//	    shoppingActionsJS.checkForCompare();
	    
	    //Closing the facet popup after updating the search criteria
	    var facetPopup = dijit.byId('widget_mobile_facet_content_popup');
	    if(facetPopup != undefined){
	    	facetPopup.hide();
	    }
	    SearchBasedNavigationDisplayJS.setListeners();
	    SearchBasedNavigationDisplayJS.updateFilterButtonText();
		// Handle the new facet counts, and update the values in the left navigation.  First parse the script, and then call the update function.
		var facetCounts = byId("facetContentCounts"+ widget.objectId);

		if(facetCounts != null) {
			var scripts = facetCounts.getElementsByTagName("script");
			var j = scripts.length;
			for (var i = 0; i < j; i++){
				var newScript = document.createElement('script');
				newScript.type = "text/javascript";
				newScript.text = scripts[i].text;
				facetCounts.appendChild(newScript);
			}
			SearchBasedNavigationDisplayJS.resetFacetCounts("content");
			
			//uncomment this if you want to hide zero facet values and the facet itself
			//SearchBasedNavigationDisplayJS.removeZeroFacetValues();
		}
		updateFacetContentCounts();
		
		var pagesList = document.getElementById("pages_list_id");
		if (pagesList != null && !isAndroid() && !isIOS()) {
			dojo.addClass(pagesList, "desktop");
		}
		
		var facetResult = dojo.query('li[id^=facet_content_' + currentIdValue +']');
		if (facetResult.length > 0) {
			facetResult[0].focus();
		} else {
			var posY = $('#ancreContent').offset().top; 
			$("html, body").animate({ scrollTop: posY - 120},'fast');
		}
		
		dojo.publish("CMPageRefreshEvent");
	}
});



if(typeof(SearchBasedNavigationDisplayJS) == "undefined" || SearchBasedNavigationDisplayJS == null || !SearchBasedNavigationDisplayJS){

	SearchBasedNavigationDisplayJS = {

		/**
		 * This variable is an array to contain all of the facet ID's generated from the initial search query.  This array will be the master list when applying facet filters.
		 */
		contextValueSeparator: "&",
		contextKeySeparator: ":",
		widgetId: "",
		facetIdsArray: new Array,
		facetIdsParentArray: new Array,
		
		facetContentIdsArray: new Array,
		facetContentIdsParentArray: new Array,
		uniqueParentArray: new Array,
		mustRefreshPrice: true,
		mustDisplayPriceDisplay:true,
		
		top_category: "",

		init:function(widgetSuffix,searchResultUrl){
			var mycontroller = wc.render.getRefreshControllerById('searchBasedNavigation_controller'+widgetSuffix);
			if(mycontroller!=undefined){
				mycontroller.url = searchResultUrl;
				this.initControlsOnPage(widgetSuffix,WCParamJS);
				this.updateContextProperties("searchBasedNavigation_context", WCParamJS);
			}
//			var currentContextProperties = wc.render.getContextById('searchBasedNavigation_context').properties;
			this.setListeners();
		},

		initConstants:function(removeCaption, moreMsg, lessMsg, currencySymbol) {
			this.removeCaption = removeCaption;
			this.moreMsg = moreMsg;
			this.lessMsg = lessMsg;
			this.currencySymbol = currencySymbol;
		},

		initControlsOnPage:function(widgetSuffix,properties){
			//Set state of sort by select box..
			var selectBox = dojo.byId("orderBy"+widgetSuffix);
			if(selectBox != null && selectBox != 'undefined'){
				if(properties['orderBy'] != ''){
					dojo.byId("orderBy"+widgetSuffix).value = properties['orderBy'];
				}
			}

			selectBox = dojo.byId("orderByContent");
			if(selectBox != null && selectBox != 'undefined'){
				if(properties['orderByContent'] != ''){
					dojo.byId("orderByContent").value = properties['orderByContent'];
				}
			}
		},

		initContentUrl:function(contentUrl){
			wc.render.getRefreshControllerById('searchBasedNavigation_content_controller').url = contentUrl;
			this.updateContextProperties("searchBasedNavigation_context", WCParamJS);
		},

		findContainer:function(el) {
			//ajout d'une vérification si non null
			if(el){
				while (el.parentNode) {
					el = el.parentNode;
					if (el.className == 'optionContainer') {
						return el;
					}
				}
			}
			return null;
		},

		resetFacetCounts:function(type) {
			var tab = new Array;
			if(type!=null && type=="content")
			{
				tab = this.facetContentIdsArray;
			}
			else
			{
				tab = this.facetIdsArray;
			}
			for (var i = 0; i < tab.length; i++) {
				var facetValue = byId("facet_count" + tab[i]);
				var facetAcceValue = byId(tab[i] + "_ACCE_Label_Count");
				if (facetValue != null) {
					facetValue.innerHTML = 0;
				}
				if (facetAcceValue != null) {
					facetAcceValue.innerHTML = 0;
				}
				$('#facet_' + tab[i] + '[data-hierarchy-level]').removeAttr('data-has-results');
			}
		},
		removeZeroFacetValues:function(type) {
			var uniqueId = this.uniqueParentArray;
			var widget = this.widgetId;
			var tab = new Array;
			if(type!=null && type=="content")
			{
				tab = this.facetContentIdsArray;
			}
			else
			{
				tab = this.facetIdsArray;
			}
			for (var i = 0; i < tab.length; i++) {
				var facetId = "facet_" + tab[i];
				var parentId = this.facetIdsParentArray[i];
				var facetValue = byId("facet_count" + tab[i]);
				if(facetValue.innerHTML == '0') {
					document.getElementById(facetId + widget).style.display = 'none';
				}
				else if(facetValue.innerHTML != '0') {
					document.getElementById(facetId + widget).style.display = 'block';
					uniqueId[parentId] = uniqueId[parentId] + 1;
				}
			}
			for(var key in uniqueId){
				if(uniqueId[key] == 0){
					document.getElementById(key).style.display = 'none';
					uniqueId[key] = 0;//reset the count
				}
				else if(uniqueId[key] != 0){
					document.getElementById(key).style.display = 'block';
					uniqueId[key] = 0;//reset the count
				}
			}

		},
		pickTemplateByImage:function(image) {
			if(image != null && image != '' && image.indexOf("/swatch_generic") > -1) {
				return "facetGenericImageItemTemplate";
			} else if(image != null && image != "") {
				return "facetSwatchImageItemTemplate";
			} else {
				return "facetNoImageItemTemplate";
			}
		},

		closeOpenedHierarchy: function($topLevelElement, slideDuration) {
			$topLevelElement
				.siblings('[data-hierarchy-level][data-toggled]')
				.removeAttr('data-toggled')
				.find('[data-toggle-indicator]')
				.text('+')
				.parents('[data-hierarchy-level=1]')
				.nextUntil('[data-hierarchy-level=1]', '[data-hierarchy-level][data-has-results]')
				.slideUp(slideDuration);
		},

		toggleHierarchy: function($topLevelElement, siblingsFilter, slideDuration) {

			var slideDuration = slideDuration | 100;

			SearchBasedNavigationDisplayJS.closeOpenedHierarchy($topLevelElement, slideDuration);

			if ($topLevelElement.is('[data-toggled]')) {
				$topLevelElement
					.removeAttr('data-toggled')
					.find('[data-toggle-indicator]')
					.text('+');
				$topLevelElement
					.nextUntil('[data-hierarchy-level=1]', siblingsFilter)
					.slideUp(slideDuration)
			} else {
				$topLevelElement
					.attr('data-toggled', 'true')
					.find('[data-toggle-indicator]')
					.text('-');
				$topLevelElement
					.nextUntil('[data-hierarchy-level=1]', siblingsFilter)
					.slideDown(slideDuration)
			}
		},

		toggleShallowHierarchy: function(e) {
			SearchBasedNavigationDisplayJS.toggleHierarchy($(e.currentTarget), '[data-hierarchy-level=2][data-has-results]');
		},

		toggleFullHierarchy: function(e) {
			SearchBasedNavigationDisplayJS.toggleHierarchy($(e.currentTarget), '[data-hierarchy-level][data-has-results]');
		},

		refreshCatalogGroupHierarchy: function() {
			var $topLevelElementsWithResults = $('[data-hierarchy-level=1][data-has-results]');

			$topLevelElementsWithResults
				.find('[data-toggle-indicator]')
				.text('-');

			$topLevelElementsWithResults
				.nextUntil('[data-hierarchy-level=1]', '[data-hierarchy-level][data-has-results]')
				.show();

			$topLevelElementsWithResults
				.off('click')
				.on('click', this.toggleFullHierarchy);


			$('[data-hierarchy-level]:not([data-has-results])')
				.hide();


			// No catalog group selected, close all sections
			if ($('[data-hierarchy-level] input:checked').size() === 0) {
				$topLevelElementsWithResults
					.removeAttr('data-toggled')
					.off('click')
					.on('click', this.toggleShallowHierarchy)
					.find('[data-toggle-indicator]')
					.text('+')
					.parents('[data-hierarchy-level=1]')
					.nextUntil('[data-hierarchy-level=1]', '[data-hierarchy-level]')
					.hide();
			}
		},
		
		refreshFacetSections: function() {
			if ($('[data-hierarchy]').size() > 0) {
				var enabledProductFacets = SearchBasedNavigationDisplayJS.getEnabledProductFacets();
				if (enabledProductFacets[0].length > 0 || enabledProductFacets[3].length > 0) {
					//si pas de filtre categories, n'afficher que les facettes activees
					if($("#facetFilterList_parentCatgroup_id_search").length == 0){
						$("div[class^=xsection]").each(function(){
							
							//determiner l'id facet
							var classNames = $(this).attr('class').split(/\s+/);  
						     $.each(classNames, function(index, item) {
						        if(item.indexOf("xsection") == 0){
						        	facetid = item;
						        }
						     });
							facetid=facetid.substring(9);

							//masquer si ni facette activee, ni une des facettes par defaut (categorie,prix)
							if(facetid!='parentCatgroup_id_search' && facetid!='1' && $("#facetFilterList_"+facetid).length == 0 && $("#facetFilterList_price_"+facetid).length == 0) {
								$(this).hide();
							}
						});
					}
				} else {
					$('[data-facet-section]:not([data-hierarchy])').hide();
				}				
			}
		},
		
		updateFacetCountWithTemplate:function(id, count, value, label, image, contextPath, group, multiFacet, allowMultipleValueSelection){
			//0001177: [Zone de facette] Après une selection de facette, les facettes retournées ne sont pas cohérentes
            //Montre uniquement les facettes qui ne sont pas (0)
			var showMoreCheckbox = byId("morelink_" + group);
			var nodeLi = byId('facet_'+id);
			// Hierarchy
			if (group == "parentCatgroup_id_search") {		

				var $nodeLi = $(nodeLi);

				var noneChecked=(!$('.xsection_parentCatgroup_id_search .facetSelect li input:checked').length);
				
				// One facet count is > 0
				if (count > 0) {
					$('.xsection_' + group).show();
					//$('.facetSelect li input:checked')
					//only show if nothing checked or me checked ?
					if(noneChecked || $nodeLi.find('input:checked').length){
						$nodeLi.show();
						$nodeLi.attr('data-has-results', 'true');
						//et faire pareil avec les parents data-hierarchy-level="1"
						if (!noneChecked){
							var par=$nodeLi.prevUntil("[data-hierarchy-level='1']").prev().last();
							par.show();
							par.attr('data-has-results', 'true');
						}
					}else{
						$nodeLi.hide();
						$nodeLi.removeAttr('data-has-results');
					}

				} else {
					$nodeLi.hide();
					$nodeLi.removeAttr('data-has-results');
				}


			} else {

	            if(count > 0){
	            	dojo.query(".xfacet_"+id).style("display", "block");
					dojo.query(".xsection_"+group).style("display", "block");
					if(nodeLi != null) {
						$('#facet_' + id).attr("filtered",true);
						if(dojo.attr(nodeLi,'data-additionalvalues') != null) {
							if(showMoreCheckbox && showMoreCheckbox.type == 'checkbox' && !showMoreCheckbox.checked) { // si le bouton "Afficher tout" n'est pas cliqué, on cache les élements de type "MORE"
								$('#facet_' + id).hide();
							}
						}
	            	}
				}
			}
            	
			var facetValue = byId("facet_count" + id); 
			if(facetValue != null) {
				var checkbox = byId(id);
				var facetAcceValue = byId(id + "_ACCE_Label_Count");
				if(count > 0) {
					// Reenable the facet link
					checkbox.disabled = false;
					if(facetValue != null) {
						facetValue.innerHTML = count;
					}
					if(facetAcceValue != null) {
						facetAcceValue.innerHTML = count;
					}		
				}
			} else if(count > 0) {
				// there is no limit to the number of facets shown, and the user has exposed the show all link
				if(nodeLi == null) {
					if(value.indexOf('isOnSpecial') < 0) {
						// this facet does not exist in the list.  Insert it.
						var templateToUse = SearchBasedNavigationDisplayJS.pickTemplateByImage(image);
						var facetItemTemplateArray = dojo.query("script[id='" + templateToUse + "']");
						if(facetItemTemplateArray && facetItemTemplateArray.length > 0) {
							var facetItemTemplate = facetItemTemplateArray[0].innerHTML;
							facetItemTemplate = replaceAll(facetItemTemplate, "%id%", id);
							facetItemTemplate = replaceAll(facetItemTemplate, "%label%", label);
							facetItemTemplate = replaceAll(facetItemTemplate, "%group%", group);
							facetItemTemplate = replaceAll(facetItemTemplate, "%count%", count);
							facetItemTemplate = replaceAll(facetItemTemplate, "%role%", (allowMultipleValueSelection == 'true') ? "checkbox" : "button");
							facetItemTemplate = replaceAll(facetItemTemplate, "%imageUrl%", image);
							facetItemTemplate = replaceAll(facetItemTemplate, "%value%", value);
							
							if(showMoreCheckbox && showMoreCheckbox.type == 'checkbox' && !showMoreCheckbox.checked) {
								facetItemTemplate = replaceAll(facetItemTemplate, "%display%", 'none');
							} else {
								facetItemTemplate = replaceAll(facetItemTemplate, "%display%", 'block');
							}
							
							var divContainer = dojo.query("[id^='section_list_" + group + "']")[0];
							var grouping = dojo.query(" > ul.facetSelect", divContainer)[0];
							
							$(grouping).append(facetItemTemplate);
							
							//ajouter dans facet filter
							var pairs = location.hash.substring(1).split(this.contextValueSeparator);
							for(var k = 0; k < pairs.length; k++) {
								var pair = pairs[k].split(":");
								if(pair[0] == "facet") {
									var ids = pair[1].split(",");
									for(var i = 0; i < ids.length; i++) {
										var e = byId(ids[i]);
										if (e && !e.checked) {
											e.checked = true;
											this.appendFilterFacet(ids[i], "");
										}
									}
								}
							}
						}
						
					}
				}
			}
		},
		updateFacetCount:function(id, count, value, label, image, contextPath, group, multiFacet) {
			//Montre uniquement les facettes qui ne sont pas (0)
			dojo.query(".xfacet_"+id).style("display", "block");
			
			var facetValue = byId("facet_count" + id);
			if(facetValue != null) {
				var checkbox = byId(id);
				var facetAcceValue = byId(id + "_ACCE_Label_Count");
				if(count > 0) {
					// Reenable the facet link
					checkbox.disabled = false;
					if(facetValue != null) {
						facetValue.innerHTML = count;
					}
					if(facetAcceValue != null) {
						facetAcceValue.innerHTML = count;
					}		
				}
			}
			else if(count > 0) {
				// there is no limit to the number of facets shown, and the user has exposed the show all link
				if(byId("facet_" + id) == null) {
					// this facet does not exist in the list.  Insert it.
					var divContainer = dojo.query("[id^='section_list_" + group + "']")[0];
					var grouping = dojo.query(" > ul.facetSelect", divContainer)[0];
					if(grouping) {
						this.facetIdsArray.push(id);
						var newFacet = document.createElement("li");
						var facetClass = "";
						var section = "";
						if(!multiFacet) {
							if(image != ""){
							facetClass = "singleFacet";
							}
							// specify which facet group to collapse when multifacets are not enabled.
							section = group;
						}
						if(image != "") {
							facetClass = "singleFacet left";
						}
						newFacet.setAttribute("id", "facet_" + id);
						newFacet.setAttribute("class", facetClass);
						newFacet.setAttribute("data-additionalvalues", "More")
						var facetLabel = "<label for='" + id + "'>";
						if(image != "") {
							facetLabel = facetLabel + "<span class='swatch'><span class='outline'><span id='facetLabel_" + id + "'><img src='" + image + "' title='" + label + "' alt='" + label + "' class='color_swatch'/></span> <div class='facetCountContainer'>(<span id='facet_count" + id + "'>"+ count + "</span>)</div>";
						}
						else {
							facetLabel = facetLabel + "<span class='outline'><span id='facetLabel_" + id + "'>" + label + "<div class='facetCountContainer'>(<span id='facet_count" + id + "'>"+ count + "</span>)</div></span></span>";
						}
						facetLabel = facetLabel + "<span class='spanacce' id='" + id + "_ACCE_Label'>" + label + " (" + count + ")</span></label>";
						newFacet.innerHTML = "<input type='checkbox' aria-labelledby='" + id + "_ACCE_Label' id='" + id + "' value='" + value + "' onclick='javascript: SearchBasedNavigationDisplayJS.toggleSearchFilter(this, \"" + id + "\")'/>" + facetLabel;
						grouping.appendChild(newFacet);
					}
				}
			}
		},
		
		updateFacetPriceSlider:function(sliderId) {
            var slid;
            try{slid= eval('facetNavSlider'+sliderId);}catch(e){}
            if(slid != undefined) {
				// ECO-MIN_MAX_FACET
				slid.reset();
			}
		},
		
		updateFacetContentCount:function(id, count, label, group) {
			//Montre uniquement les facettes qui ne sont pas à (0)
			if(count > 0){
				//id may content special caracteres
				//the method getElementsByClassName auto escape these special caracteres
				var elems = document.getElementsByClassName("facet_content_"+id);
				for(var i = 0; i < elems.length; i++) {
				    elems[i].style.display = 'block';
				}
				var section = group-1;
				var elemsSection = document.getElementsByClassName("xfacet_section_"+section);
				for(var i = 0; i < elemsSection.length; i++) {
					elemsSection[i].style.display = 'block';
				}
			}
			var facetValue = byId("facet_count" + id);
			if(facetValue != null) {
				var checkbox = byId(id);
				var facetAcceValue = byId(id + "_ACCE_Label_Count");
				if(count > 0) {
					// Reenable the facet link
					checkbox.disabled = false;
					//ECOCEA: quand la facette est selectionnée il y a deux fois le même id. Obligé d'utiliser jquery pour les mettre à jour tous les deux
					$("[id=facet_count" + id+"]").html(count);

					if(facetAcceValue != null) {
						facetAcceValue.innerHTML = count;
					}		
				}
			}
			else if(count > 0) {
				// there is no limit to the number of facets shown, and the user has exposed the show all link
				if(byId("facet_" + id) == null) {
					// this facet does not exist in the list.  Insert it.
					var divContainer = dojo.query("[id^='section_content_list_" + group + "']")[0];
					var grouping = dojo.query(" > ul.facetSelect", divContainer)[0];
					if(grouping) {
						this.facetContentIdsArray.push(id);
						var newFacet = document.createElement("li");
						var facetClass = "";
						var section = "";
						newFacet.setAttribute("id", "facet_" + id);
						newFacet.setAttribute("class", facetClass);
						newFacet.setAttribute("data-additionalvalues", "More")
						var facetLabel = "<label for='" + id + "'><span class='outline facetbuttoncontent checkLP'><span id='facetLabel_" + id + "'>" + label + "</span> (<span id='facet_count" + id +"'>" + count + "</span>)</span>";
						facetLabel = facetLabel + "<span class='spanacce' id='" + id + "_ACCE_Label'>" + label + " (" + count + ")</span></label>";
						newFacet.innerHTML = "<input type='checkbox' aria-labelledby='" + id + "_ACCE_Label' id='" + id + "' value='" + value + "' onclick='javascript: SearchBasedNavigationDisplayJS.toggleSearchFilter(this, \"" + id + "\")'/>" + facetLabel;
						grouping.appendChild(newFacet);
					}
				}
			}
		},

		isValidNumber:function(n) {
			return !isNaN(parseFloat(n)) && isFinite(n) && n >= 0;
		},

		checkPriceInput:function(event) { //TODO generiser
			if(this.validatePriceInput() && event.keyCode == 13) {
				this.appendFilterPriceRange();
				this.doSearchFilter();
			}else if(byId("low_slider_input") != null && byId("high_slider_input") != null){
				var lowPrice = byId("low_slider_input").value;
				var highPrice = byId("high_slider_input").value;
				if((!this.isValidNumber(lowPrice) || !this.isValidNumber(highPrice)) && event.keyCode == 13) {
					MessageHelper.formErrorHandleClient("high_slider_input", storeNLS['ERROR_FACET_PRICE_INVALID']);
				}
			}
			return false;
		},

		validatePriceInput:function() {  //TODO generiser
			if(byId("low_slider_input") != null && byId("high_slider_input") != null && byId("price_range_go") != null) {
				var low = byId("low_slider_input").value;
				var high = byId("high_slider_input").value;
				var go = byId("price_range_go");
				if(this.isValidNumber(low) && this.isValidNumber(high) && parseFloat(high) > parseFloat(low)) {
					go.className = "go_button";
					go.disabled = false;
				}
				else {
					go.className = "go_button_disabled";
					go.disabled = true;
				}
				return !go.disabled;
			}
			return false;
		},

		toggleShowMore:function(index, show) {
			var list = byId('more_' + index);
			var morelink = byId('morelink_' + index);
			if(list != null) {
				if(show) {
					morelink.style.display = "none";
					list.style.display = "inline-block";
				}
				else {
					morelink.style.display = "inline-block";
					list.style.display = "none";
				}
			}
		},

		toggleSearchFilterOnKeyDown:function(event, element, id) {
			if (event.keyCode == dojo.keys.ENTER) {
				element.checked = !element.checked;
				this.toggleSearchFilter(element, id);
			}
		},

		toggleSearchFilter:function(element, id) {
			if(element.checked) {
				this.appendFilterFacet(id);
			}
			else {
				this.removeFilterFacet(id);
			}

			this.doSearchFilter();
		},

		appendFilterPriceRange:function(sliderId, currency) {  
			sliderId = (typeof sliderId === 'undefined') ? '' : sliderId;
			currency = (typeof currency === 'undefined') ? '' : currency;
			byId("AppliedFacetContainer").style.display = "block";
			byId("clear_all_filter").style.display = "block";
			window.scrollTo(0,300);

			var facetFilterList = byId("facetFilterList_price"+sliderId);
			// create facet filter list if it's not exist
			if (facetFilterList == null) {
				facetFilterList = SearchBasedNavigationDisplayJS.createElement("div", {
					"id": "facetFilterList_price"+sliderId,
					"class": "facetSelectedCont"
				});
				var facetFilterListWrapper = byId("facetFilterListWrapper");
				facetFilterListWrapper.appendChild(facetFilterList);
			}

			var filter = byId("pricefilter"+sliderId);
			if(filter != null) {
				facetFilterList.removeChild(filter);
			}
			var minValue = byId("low_slider_input"+sliderId).value;
			if(minValue == 0) {
				minValue = "<1";
			}
			
			var label = minValue + " "+currency+" - " + byId("high_slider_input"+sliderId).value + " "+currency; //&#8364; euro si price
			
			var innerFilterText = "<a role='button' href='#' onclick='dojo.topic.publish(\"Facet_Remove\",\""+sliderId+"\",true); return false;'>" + "<span class='filter-value'>" + label + "</span><span class=\"deleteFilter\"></span></a>";

			var innerFilterTitle =  SearchBasedNavigationDisplayJS.createElement("div", {"class": "critereCateg filter-name"}, byId("FacetLabelSlider"+sliderId).value);
			var innerFilterContent = SearchBasedNavigationDisplayJS.createElement("div",{"class": "critereRecherche"}, innerFilterText);

			filter = SearchBasedNavigationDisplayJS.createElement("div", {"id": "pricefilter"+sliderId});
			filter.appendChild(innerFilterTitle);
			filter.appendChild(innerFilterContent);
			
			facetFilterList.appendChild(filter);
			
			byId("AppliedFacetContainer").style.display = "block";
			byId("clear_all_filter").style.display = "block";
			window.scrollTo(0,300);
			SearchBasedNavigationDisplayJS.pushToGoogleTagManager(byId("FacetLabelSlider"+sliderId).value, label, "facetApplied", "add"); //ECOCEA etait price et non prix

			if(this.validatePriceInput()) {
				// Promote the values from the input boxes to the internal inputs for use in the request.
				byId("low_slider_value"+sliderId).value = byId("low_slider_input"+sliderId).value;
				byId("high_slider_value"+sliderId).value = byId("high_slider_input"+sliderId).value;
			}

		},

		removeFilterPriceRange:function(sliderId, refresh) { 
			sliderId = (typeof sliderId === 'undefined') ? '' : sliderId;
			refresh = (typeof refresh === 'undefined') ? true : refresh;

			if(byId("low_slider_value"+sliderId) != null && byId("high_slider_value"+sliderId) != null) {
				byId("low_slider_value"+sliderId).value = "";
				byId("high_slider_value"+sliderId).value = "";
			}
			var facetFilterList = byId("facetFilterList_price"+sliderId);
			var priceLabel = 'unknown';
			var filter = byId("pricefilter"+sliderId);
			if(filter != null) {
				var priceContainer = $(filter).find("a > span:first-of-type");
				if(priceContainer != null && priceContainer.length == 1) {
					priceLabel = priceContainer[0].innerHTML;
				}
				facetFilterList.removeChild(filter);
				dojo.destroy(facetFilterList);
			}
			
			var facetsContainerWrapper = byId("facetFilterListWrapper"); 

			if(facetsContainerWrapper.childNodes.length == 0) {
				byId("AppliedFacetContainer").style.display = "none";
				byId("clear_all_filter").style.display = "none";
				facetsContainerWrapper.innerHTML = "";
			}
            var slid;
            try{slid= eval('facetNavSlider'+sliderId);}catch(e){}
            if(slid != undefined) {
				slid.reset();
			}

			var el = byId("price_range_input"+sliderId);
			var section = this.findContainer(el);
			if(section && this.mustDisplayPriceDisplay) {
				byId(section.id).style.display = "block";
			}

			if(refresh){
				SearchBasedNavigationDisplayJS.pushToGoogleTagManager(byId("FacetLabelSlider"+sliderId).value, priceLabel, "facetRemoved", "remove"); 
				this.doSearchFilter();
			}
		},

		appendFilterFacet:function(id, type) {
			var facetSection = byId("facetSection_" + id).value;
			//détermination du type de facet
			var facetType = SearchBasedNavigationDisplayJS.getFacetType(type);
			
			var facetFilterList = SearchBasedNavigationDisplayJS.createElement("div", {
				"id" : facetType+"FilterList_" + id,
				"class" : "facetSelectedCont"
			});
			var facetFilterListWrapper = byId(facetType+"FilterListWrapper");
			facetFilterListWrapper.appendChild(facetFilterList);

			
			var filterListItemTitle = byId(facetType+"FilterListItemList_" + facetSection);
			if(filterListItemTitle == null) {
				filterListItemTitle = SearchBasedNavigationDisplayJS.createElement("span", {
					"id": facetType+"FilterListItemList_" + facetSection,
					"class": "filter-name"
				});
				var filterListItemTitleContent = SearchBasedNavigationDisplayJS.createElement("div", {
					"class" : "critereCateg"
				}, byId("facetParentLabel_" + facetSection).value);
				
				filterListItemTitle.appendChild(filterListItemTitleContent);
				facetFilterList.appendChild(filterListItemTitle);
			}
			
			var filter = byId("filter_" + id);
			
			if(filter == null) {
				filter = SearchBasedNavigationDisplayJS.createElement("span", {"id" : "filter_" + id});
				var label = byId("facetLabel_" + id).innerHTML;
				//cas des categories
				var idx=label.indexOf("<span");
				if(idx>-1){
					label=label.substring(0,idx-1);
				}
				var dojoRemovePublishFunction = (type!=null && type=="content") ? "Facet_Remove_Content" : "Facet_Remove"; 
				var filterDivContent = "<a role='button' href='#' onclick='javascript:setCurrentId(\"" + id + "\");dojo.topic.publish(\"" + dojoRemovePublishFunction + "\", \"" + id + "\", \"" + facetSection + "\"); return false;'>" + "<span class='filter-value'>" + label + "</span><span class=\"deleteFilter\"></span></a>";

				var filterDivContainer = SearchBasedNavigationDisplayJS.createElement("div", {"class" : "critereRecherche"}, filterDivContent);
				filter.appendChild(filterDivContainer);
				facetFilterList.appendChild(filter);
				
				// Tooltip
				var tooltipElement = $(filter).find('.tooltip');
				if (tooltipElement) {
					var tooltipLabel = tooltipElement.attr('alt');
					tooltipElement.tooltipster({
						content: tooltipLabel,
						multiple: true,
						position: 'bottom',
						touchDevices: false
					});
				}
			}

			var classFacetButton = (type!=null && type=="content") ? "facetbuttoncontent" : "facetbutton"; 
			byId("facetLabel_" + id).parentElement.setAttribute("class","outline "+classFacetButton+" checkLP active");
			var el = byId(id);
			var section = this.findContainer(el);
			if(section) {
				byId(section.id).style.display = "none";
			}
			byId(type+ "AppliedFacetContainer").style.display = "block";
			byId("clear_all" + type + "_filter").style.display = "block";
			window.scrollTo(0,300);
			
			SearchBasedNavigationDisplayJS.pushAppliedFacetToGoogleTagManager(byId("facetParentLabel_" + facetSection).value, "facetLabel_" + id, 'facetApplied', 'add');
			
			if(type!=null && type=="content"){
				this.doSearchFilter(type);
			}
		},
		
		pushAppliedFacetToGoogleTagManager : function(facetLabel, facetValueContainer, event, eventAction) {
			var facetValueContainerObject = dojo.query("span[id='" + facetValueContainer + "']");
			if(facetValueContainerObject.length == 0) {
				facetValueContainerObject = dojo.query("span[id='" + facetValueContainer + "'] > img");
			}
			if(facetValueContainerObject.length == 0) {
				facetValueContainerObject = dojo.query("span[id='" + facetValueContainer + "']");
			}
			facetValueContainerObject.forEach(function(node, index, nodeList) {
				var facetValue = (node.innerHTML != '') ? node.innerHTML.trim() : node.alt;
				SearchBasedNavigationDisplayJS.pushToGoogleTagManager(facetLabel, facetValue, event, eventAction);
			});
		},
		
		pushToGoogleTagManager : function(facetLabel, facetValue, event, eventAction) {
			if(typeof(dataLayer) != 'undefined' && dataLayer != null) {
				dataLayer.push({
					'event' : event,
					'eventCategory' : 'facet',
					'eventAction' : eventAction,
					'eventLabel' : facetLabel + '|' + facetValue,
					'eventValue' : {
						'label' : facetLabel,
						'value' : facetValue
					}
				});
			}
		},
		
		createElement: function(elementType, attributes, innerText) {
			var tempElement = document.createElement(elementType);
			if(attributes != null && typeof attributes == 'object') {
				var attrNames = Object.keys(attributes);
				for(var i = 0; i < attrNames.length ; i++) {
					var attrName = attrNames[i];
					tempElement.setAttribute(attrName, attributes[attrName]);
				}
			}
			if(innerText != null) {
				tempElement.innerHTML = innerText;
			}
			
			return tempElement;
		},

		removeFilterFacet:function(id, type) {
			var facetSection = byId("facetSection_" + id).value;
			
			var facetType = SearchBasedNavigationDisplayJS.getFacetType(type);  
			
			var facetFilterList = byId(facetType+"FilterList_" + id);
			var filter = byId("filter_" + id);
			
			var parent = filter.parentNode
			if(filter != null) {
				try{
					parent.removeChild(filter);
				}catch(err){
					console.error(err.message);
				}
				byId(id).checked = false;
			}

			dojo.destroy(facetFilterList);

			if(byId(facetType+"FilterListWrapper").childNodes.length == 0) {
				byId(type+ "AppliedFacetContainer").style.display = "none";
				byId("clear_all" + type + "_filter").style.display = "none";
				byId(facetType+"FilterListWrapper").innerHTML = "";
			}
			var classFacetButton = (type!=null && type=="content") ? "facetbuttoncontent" : "facetbutton"; 
			byId("facetLabel_" + id).parentElement.setAttribute("class","outline "+classFacetButton+" checkLP");

			var el = byId(id);
			var section = this.findContainer(el);
			if(section) {
				byId(section.id).style.display = "block";
			}
			
			SearchBasedNavigationDisplayJS.pushAppliedFacetToGoogleTagManager(byId("facetParentLabel_" + facetSection).value, "facetLabel_" + id, 'facetRemove', 'remove');
			
			this.doSearchFilter(type);
		},

		getFacetType:function(type) {
			return (type!=null && type=="content") ? "facetContent" : "facet";
		},

		getEnabledContentFacets:function() {
			
			var results = new Array();
			var facetForm = document.forms['contentsFacets'];
			if(facetForm == null) 
				return results;
			var elementArray = facetForm.elements;

			var facetContentArray = new Array();
			var facetContentIds = new Array();
			var currentFacet="";
			
			var find=false;
			if(typeof(_searchBasedNavigationFacetContext) != "undefined") {
				for(var i=0; i< _searchBasedNavigationFacetContext.length; i++) {
					facetContentArray.push(_searchBasedNavigationFacetContext[i]);
					//facetIds.push();
				}
			}
			for (var i=0; i < elementArray.length; i++) {
				var element = elementArray[i];
				if(element.type != null && element.type.toUpperCase() == "CHECKBOX") {
					if(element.title == "MORE") {
						// scan for "See More" facet enablement.
						if(element.checked) {
							facetLimits.push(element.value);
						}
					}
					else {
						// disable the checkbox while the search is being performed to prevent double clicks
						element.disabled = true;
						if(element.checked) {
							currentFacet=element.value;
							facetContentIds.push(element.id);
							find=true;
						}
					}
				}
				else{
					//Récupération de l'Id parent
					if(element.type.toUpperCase() == "HIDDEN" && find==true){
						facetContentArray.push(element.value+";"+currentFacet );
						currentFacet="";
						find = false;
					}
					
				}
			}

			results.push(facetContentArray);
			results.push(facetContentIds);
			return results;
		},
		
		getEnabledProductFacets:function() {
			var results = new Array();
			var facetForm = document.forms['productsFacets'] != null ? document.forms['productsFacets'] : document.forms['productsFacetsHorizontal'];
			if(facetForm != null){
				var elementArray = facetForm.elements;
	
				var facetArray = new Array();
				var facetIds = new Array();
				if(_searchBasedNavigationFacetContext != 'undefined') {
					for(var i=0; i< _searchBasedNavigationFacetContext.length; i++) {
						facetArray.push(_searchBasedNavigationFacetContext[i]);
						//facetIds.push();
					}
				}
				var facetLimits = new Array();
				for (var i=0; i < elementArray.length; i++) {
					var element = elementArray[i];
					if(element.type != null && element.type.toUpperCase() == "CHECKBOX") {
						if(element.title == "MORE") {
							// scan for "See More" facet enablement.
							//if(element.checked) {
								facetLimits.push(element.value);
							//}
						}
						else {
							// disable the checkbox while the search is being performed to prevent double clicks
//							element.disabled = true;
							if(element.checked) {
								facetArray.push(element.value);
								facetIds.push(element.id);
							}
						}
					}
				}
				// disable the price range button also
				if(byId("price_range_go") != null) {
					byId("price_range_go").disabled = true;
				}
				var sliders = new Array();
				$('li[id^="pricefilter_"]').each(function(){
					sliders.push($(this).attr("id").substring(12));
				});
				
				results.push(facetArray);
				results.push(facetLimits);
				results.push(facetIds);
				results.push(sliders);
			}
			return results;
		},
		
		getAllProductForShowMore: function () {
			//0001177: [Zone de facette] Aprés une selection de facette, les facettes retournées ne sont pas cohérentes
			// récupérer des éléments pour le bouton "Afficher tous"
			var facetForm = document.forms['productsFacets'] != null ? document.forms['productsFacets'] : document.forms['productsFacetsHorizontal'];
			if(facetForm != null){
				var elementArray = facetForm.elements;
				var facetLimits = new Array();
				for (var i=0; i < elementArray.length; i++) {
					var element = elementArray[i];
					if(element.type != null && element.type.toUpperCase() == "CHECKBOX") {
						if(element.title == "MORE") {
							// scan for "See More" facet enablement.
							facetLimits.push(element.value);
						}
					}
				}
				
				var minPrice = "";
				var maxPrice = "";

				if(byId("low_slider_value") != null && byId("high_slider_value") != null) {
					minPrice = byId("low_slider_value").value;
					maxPrice = byId("high_slider_value").value;
				}
				if(minPrice == '' && maxPrice == '')
				{
					minPrice = window.initialMinPrice;
					maxPrice = window.initialMaxPrice;
				}
				
				if(facetLimits.length > 0) {
					if(!submitRequest()){
						return;
					}
					cursor_wait();
					var facetArray = this.getEnabledProductFacets();
					wc.render.updateContext('searchBasedNavigation_context', {"productBeginIndex": "0", "facet": facetArray[0], "facetLimit": facetLimits, "facetId": facetArray[2] , "resultType":"products", "minPrice": minPrice, "maxPrice": maxPrice});
				}
			}
		},
		
		doSearchFilter:function(type) {
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			
			if (type!=null && type=="content") {
				var facetContentArray = this.getEnabledContentFacets();
				wc.render.updateContext('searchBasedNavigation_context', {"contentBeginIndex": "0" , "facetContent": facetContentArray[0], "facetContentId": facetContentArray[1], "resultType":"content"});
			}
			else{
				var facetArray = this.getEnabledProductFacets();
				var ctx = {"productBeginIndex": "0", "facet": facetArray[0], "facetLimit": facetArray[1], "facetId": facetArray[2] , "resultType":"products"};
				
				$("input[id^='low_slider_value']").each(function( index,val ) {
					var key=val.id.substring(16);
					var min=val.value;
					var max=byId("high_slider_value"+key).value;
					
					if(min == '' && max== '')
					{ //TODO generiser
						min = window.initialMinPrice;
						max = window.initialMaxPrice;
					}
					if(key=="") key='Price'; else key=key.substring(1);
					ctx['min'+key]=min;
					ctx['max'+key]=max;
				});
				wc.render.updateContext('searchBasedNavigation_context', ctx);
			}
			this.updateHistory();

			MessageHelper.hideAndClearMessage();
		},

		toggleShowMore:function(element, id, type) {
			var label = byId("showMoreLabel_" + id);
			var divContainer = dojo.query("[id^='section_list_" + id + "']")[0];
			var grouping = dojo.query(" > ul.facetSelect > li[data-additionalvalues]", divContainer);
			if(element.checked) {
				label.innerHTML = this.lessMsg;
				var group = dojo.query(" > ul.facetSelect", divContainer)[0];
				var clearFloat = dojo.query(" > div.clear_float", group)[0];
				if(clearFloat != undefined) {
					group.removeChild(clearFloat);
				}
				if(grouping) {
					for(var i = 0;i < grouping.length; i++) {
						if(byId(this.getFacetType() + "FilterListWrapper").innerHTML.length > 0) {
							if($('#' + grouping[i].id).attr('filtered')) {
								grouping[i].style.display="";
							} else {
								grouping[i].style.display="none";
							}							
						} else {
							grouping[i].style.display="";
						}
					}
				}
				//0001177: [Zone de facette] Après une selection de facette, les facettes retournées ne sont pas cohérentes
				//ne pas faire une recherche, car tous les facettes ont été récupérée au chargement de la page
				//this.doSearchFilter(type);
			}
			else {
				if(grouping) {
					for(var i = 0;i < grouping.length; i++) {
						grouping[i].style.display="none";
					}
				}
				label.innerHTML = this.moreMsg;
			}
		},


		clearAllFacets:function(execute, type) {
			if(byId("clear_all" + type + "_filter") != null){
				byId(type+ "AppliedFacetContainer").style.display = "none";
				byId("clear_all" + type + "_filter").style.display = "none";
			}
			if(byId(SearchBasedNavigationDisplayJS.getFacetType(type) + "FilterListWrapper") != null){
				byId(SearchBasedNavigationDisplayJS.getFacetType(type) + "FilterListWrapper").innerHTML = "";
			}
			if(byId("low_slider_value") != null && byId("high_slider_value") != null) {
				byId("low_slider_value").value = "";
				byId("high_slider_value").value = "";
			}
			
			var formNameByType = (type != null && type == 'content') ? "contentsFacets" : "productsFacets";
			var facetForm = document.forms[formNameByType] != null ? document.forms[formNameByType] : document.forms['productsFacetsHorizontal'];
			if(facetForm != null){
				var elementArray = facetForm.elements;
				for (var i=0; i < elementArray.length; i++) {
					var element = elementArray[i];
					if(element.type != null && element.type.toUpperCase() == "CHECKBOX" && element.checked && element.title != "MORE") {
						element.checked = false;
					}
				}
			}
			var elems = document.getElementsByTagName("*");
			if(elems != null){
				for (var i=0; i < elems.length; i++) {
					// Reset all hidden facet sections (single selection facets are hidden after one facet is selected from that facet grouping)
					// and clear all selected facet highlights.
					var element = elems[i];
					
					if (element.id != null) {
						if (element.id.indexOf("section_") == 0 && !(element.id.indexOf("section_list") == 0)) {
							element.style.display = "block";
						}
						if (element.id.indexOf("facetLabel_") == 0) {
							var facetButtonClass = (type != null && type == 'content') ? "facetbuttoncontent" : "facetbutton";
							element.parentElement.setAttribute("class","outline "+facetButtonClass+" checkLP");
						}
					}
				}
			}			
			
			SearchBasedNavigationDisplayJS.pushToGoogleTagManager('All', 'All', 'facetClear', 'clear');
			
			if(execute) {
				this.doSearchFilter(type);
			}
		},

		toggleSearchContentFilter:function() {
			if(!submitRequest()){
				return;
			}
			cursor_wait();

			var facetList = "";
			var facetForm = document.forms['contentsFacets'];
			var elementArray = facetForm.elements;
			for (var i=0; i < elementArray.length; i++) {
				var element = elementArray[i];
				if(element.type != null && element.type.toUpperCase() == "CHECKBOX" && element.checked && element.title != "MORE") {
					facetList += element.value + ";";
				}
			}

			wc.render.updateContext('searchBasedNavigation_context', {"facet": facetList, "resultType":"content"});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},


		updateContextProperties:function(contextId, properties){
			//Set the properties in context object..
			for(key in properties){
				wc.render.getContextById(contextId).properties[key] = properties[key];
			}
		},

		showResultsPageForContent:function(data){

			var pageNumber = data['pageNumber'];
			var pageSize = data['pageSize'];
			pageNumber = dojo.number.parse(pageNumber);
			pageSize = dojo.number.parse(pageSize);

			setCurrentId(data["linkId"]);

			if(!submitRequest()){
				return;
			}
			if(typeof(tagManager) != 'undefined' && tagManager != null) {
				tagManager.changePageNumber(pageNumber);
			}
			var beginIndex = pageSize * ( pageNumber - 1 );
			cursor_wait();
			wc.render.updateContext('searchBasedNavigation_context', {"contentBeginIndex": beginIndex, "resultType":"content"});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},

		showResultsPage:function(data){

			var pageNumber = data['pageNumber'];
			var pageSize = data['pageSize'];
			pageNumber = dojo.number.parse(pageNumber);
			pageSize = dojo.number.parse(pageSize);

			setCurrentId(data["linkId"]);

			if(!submitRequest()){
				return;
			}
			if(typeof(tagManager) != 'undefined' && tagManager != null) {
				tagManager.changePageNumber(pageNumber);	
			}

			var beginIndex = pageSize * ( pageNumber - 1 );
			cursor_wait();


			wc.render.updateContext('searchBasedNavigation_context', {"top_category": data['top_category'], "productBeginIndex": beginIndex, "resultType":"products"});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},

		toggleView:function(data){
			var pageView = data["pageView"];
			setCurrentId(data["linkId"]);
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			console.debug("pageView = "+pageView+" controller = +searchBasedNavigation_controller");
			wc.render.updateContext('searchBasedNavigation_context', {"pageView": pageView,"resultType":"products"});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},
		
		toggleViewForContent:function(data){
			var pageView = data["pageView"];
			setCurrentId(data["linkId"]);
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			console.debug("pageView = "+pageView+" controller = +searchBasedNavigation_controller");
			wc.render.updateContext('searchBasedNavigation_context', {"pageViewContent": pageView,"resultType":"content"});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},

		toggleExpand:function(id) {
			var icon = byId("icon_" + id);
			var section_list = byId("section_list_" + id);
			if(icon.className == "arrow") {
				icon.className = "arrow arrow_collapsed";
				section_list.setAttribute("aria-expanded", "false");
				section_list.style.display = "none";
			}
			else {
				icon.className = "arrow";
				section_list.setAttribute("aria-expanded", "true");
				section_list.style.display = "block";
			}
		},

		/* Function used to setup the listeners: enable the panel slider in mobile for example */
		setListeners:function(){
			$("#filterButtonProducts").on("click", function() {
				if(!$("#facetPanelNavigation").hasClass("enabled")) {
					$("#facetPanelNavigation").animate({right: '0px'});
					$("#facetPanelNavigation").addClass("enabled");
					$("#overlay").show();
				}
			});
			
			$("#filterButtonCrossContent").on("click", function() {
				if(!$("#facetPanelContent").hasClass("enabled")) {
					$("#facetPanelContent").animate({right: '0px'});
					$("#facetPanelContent").addClass("enabled");
					$("#overlay").show();
				}
			});
			
			$("#overlay").on("click", function() {
				if($("#facetPanelNavigation").hasClass("enabled")) {
					$("#facetPanelNavigation").animate({right: '-300px'});
					$("#facetPanelNavigation").removeClass("enabled");
					$("#overlay").hide();
				}
				if($("#facetPanelContent").hasClass("enabled")) {
					$("#facetPanelContent").animate({right: '-300px'});
					$("#facetPanelContent").removeClass("enabled");
					$("#overlay").hide();
				}
			});
			
			/* Set the close buttons for the facet panels */
			$(".panel-close").on("click", function() {
				if($("#facetPanelNavigation").hasClass("enabled")) {
					$("#facetPanelNavigation").animate({right: '-300px'});
					$("#facetPanelNavigation").removeClass("enabled");
					$("#overlay").hide();
				}
				if($("#facetPanelContent").hasClass("enabled")) {
					$("#facetPanelContent").animate({right: '-300px'});
					$("#facetPanelContent").removeClass("enabled");
					$("#overlay").hide();
				}
			});
			
			// Change the display of a catalog entry block on mouse over / out
			require(["dojo/mouse", "dojo/on", "dojo/query", "dojo/dom-class", "dojo/dom-style"], function(mouse, on, query, domClass, domStyle){
				query(".catentrydisplay-product").on(mouse.enter, function() {
					domClass.remove(query(".button-catentrydisplay", this)[0], "hidden");
					domClass.remove(query(".catentrydisplay-wishlist", this)[0], "hidden");
					domClass.add(query(".catentrydisplay-content", this)[0], "hidden");
					domStyle.set(query(".catentrydisplay-action-container", this)[0], "bottom", "25px");	
					domStyle.set(query(".catentrydisplay-price-container", this)[0], "top", "-150px");		
					domStyle.set(query(".catentrydisplay-price", this)[0], "position", "initial");		
				});
				query(".catentrydisplay-product").on(mouse.leave, function() {
					domClass.add(query(".button-catentrydisplay", this)[0], "hidden");
					domClass.add(query(".catentrydisplay-wishlist", this)[0], "hidden");
					domClass.remove(query(".catentrydisplay-content", this)[0], "hidden");
					domStyle.set(query(".catentrydisplay-action-container", this)[0], "bottom", "0");	
					domStyle.set(query(".catentrydisplay-price-container", this)[0], "top", "0px");
					domStyle.set(query(".catentrydisplay-price", this)[0], "position", "absolute");		
				});
			});
		},
		
		/* Function used to unbind the listeners */
		unbindListeners:function(){
			$("#filterButtonProducts").unbind();
			$("#filterButtonCrossContent").unbind();
			$("#overlay").unbind("click");		
			$(".catentrydisplay-product").unbind("mouseenter");		
			$(".catentrydisplay-product").unbind("mouseleave");	
		},
		
		/* Function used to display the number of filter selected */
		updateFilterButtonText:function(){
			var activeFacets = $("#facetFilterListWrapper > div").length;
			var activeFacetsCrossContent = $("#facetContentFilterListWrapper > div").length;
			
			if(activeFacets == 0) {
				$("#filterButtonProducts .filterQuantity").text("");
				$("#facetPanelNavigation .filterQuantity").text("");
			} else {
				$("#facetPanelNavigation .filterQuantity").text("("+activeFacets+")");
				$("#filterButtonProducts .filterQuantity").text("("+activeFacets+")");
			}
			
			if(activeFacetsCrossContent == 0) {
				$("#filterButtonCrossContent .filterQuantity").text("");
				$("#facetPanelContent .filterQuantity").text("");
			} else {
				$("#facetPanelContent .filterQuantity").text("("+activeFacetsCrossContent+")");
				$("#filterButtonCrossContent .filterQuantity").text("("+activeFacetsCrossContent+")");
			}
		},
		
		setPageSize:function(newPageSize){
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			console.debug("resultsPerPage = "+newPageSize+" controller = +searchBasedNavigation_controller");

			wc.render.updateContext('searchBasedNavigation_context', {"productBeginIndex": "0","resultType":"products","pageSize":newPageSize});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},

		sortResults:function(orderBy){
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			//Reset beginIndex = 1

			wc.render.updateContext('searchBasedNavigation_context', {"productBeginIndex": "0","orderBy":orderBy,"resultType":"products"});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},

		sortResults_content:function(orderBy){
			if(!submitRequest()){
				return;
			}
			cursor_wait();
			//Reset beginIndex = 1
			wc.render.updateContext('searchBasedNavigation_context', {"contentBeginIndex": "0","orderByContent":orderBy,"resultType":"content"});
			this.updateHistory();
			MessageHelper.hideAndClearMessage();
		},

		swatchImageClicked:function(id) {
			// This is a workaround for IE's bug for non-clickable label images.
			var e = byId(id);
			if(!e.checked) {
				e.click();
			}
		},

		clone:function(masterObj) {
			if (null == masterObj || "object" != typeof masterObj) return masterObj;
			var clone = masterObj.constructor();
			for (var attr in masterObj) {
				if (masterObj.hasOwnProperty(attr)) clone[attr] = masterObj[attr];
			}
			return clone;
		},

		updateHistory:function() {
/*
			var contextValues = "";
			for(var i = 0; i < facetArray[2].length; i++) {
				console.debug(facetArray[2][i]);
				contextValues= contextValues + facetArray[2][i] + "|";
			}
			*/

			var currentContextProperties = wc.render.getContextById('searchBasedNavigation_context').properties;

			var contextValues = "facet:" + currentContextProperties["facetId"] + this.contextValueSeparator;
			contextValues+= "facetContent:" + currentContextProperties["facetContentId"] + this.contextValueSeparator;
			contextValues+= "productBeginIndex:" + currentContextProperties["productBeginIndex"] + this.contextValueSeparator;
			contextValues+= "contentBeginIndex:" + currentContextProperties["contentBeginIndex"] + this.contextValueSeparator;
			contextValues+= "orderBy:" + currentContextProperties["orderBy"] + this.contextValueSeparator;
			contextValues+= "orderByContent:" + currentContextProperties["orderByContent"] + this.contextValueSeparator;
			contextValues+= "pageView:" + currentContextProperties["pageView"] + this.contextValueSeparator;
			contextValues+= "pageViewContent:" + currentContextProperties["pageViewContent"] + this.contextValueSeparator;
			contextValues+= "minPrice:" + currentContextProperties["minPrice"] + this.contextValueSeparator;
			contextValues+= "maxPrice:" + currentContextProperties["maxPrice"] + this.contextValueSeparator;
			contextValues+= "pageSize:" + currentContextProperties["pageSize"] + this.contextValueSeparator;

			var yScroll=document.body.scrollTop;
			if(history.pushState) {
				history.pushState(null,document.title,"#" + contextValues);
			}
			else {
				window.location.hash = contextValues;
			}
			document.body.scrollTop=yScroll;
		},

		/**
		 * Va récupérer les facettes appliquées en regardant dans l'URL ave le #
		 */
		restoreHistoryContext:function() {
			if(location.hash != null && location.hash != "" && location.hash != "#") {
				
				
				this.clearAllFacets(false, "");
				this.clearAllFacets(false, "content");
				
				var productBeginIndex = "";
				var contentBeginIndex = "";
				var orderBy = "";
				var orderByContent = "";
				var pageView = "";
				var pageViewContent = "";
				var minPrice = "";
				var maxPrice = "";
				var pageSize = "";

				var pairs = location.hash.substring(1).split(this.contextValueSeparator);
				for(var k = 0; k < pairs.length; k++) {
					var pair = pairs[k].split(":");
					if(pair[0] == "facet") {
						var ids = pair[1].split(",");
						for(var i = 0; i < ids.length; i++) {
							var e = byId(ids[i]);
							if (e) {
								e.checked = true;
								this.appendFilterFacet(ids[i], "");
							}
						}
					}
					
					else if(pair[0] == "facetContent") {
						var ids = pair[1].split(",");
						for(var i = 0; i < ids.length; i++) {
							var e = byId(ids[i]);
							if (e) {
								e.checked = true;
								this.appendFilterFacet(ids[i],"content");
							}
						}
					}
					
					else if(pair[0] == "productBeginIndex") {
						productBeginIndex = pair[1];
					}
					else if(pair[0] == "contentBeginIndex") {
						contentBeginIndex = pair[1];
					}
					else if(pair[0] == "orderBy") {
						orderBy = pair[1];
					}
					else if(pair[0] == "orderByContent") {
						orderByContent = pair[1];
					}
					else if(pair[0] == "pageView") {
						pageView = pair[1];
					}
					else if(pair[0] == "pageViewContent") {
						pageViewContent = pair[1];
					}
					else if(pair[0] == "minPrice") {
						if(byId("low_slider_input") != null && byId("low_slider_input") != undefined){
							byId("low_slider_input").value = pair[1];
							minPrice = pair[1];
						}
						
					}
					else if(pair[0] == "maxPrice") {
						if(byId("high_slider_input") != null && byId("high_slider_input") != undefined){
							byId("high_slider_input").value = pair[1];
							maxPrice = pair[1];
						}
						
					}
					else if(pair[0] == "pageSize") {
						pageSize = pair[1];
					}
				}
				if(!submitRequest()){
					return;
				}
				cursor_wait();

				if(minPrice != "" && maxPrice != "") {
					this.appendFilterPriceRange();
					if(facetNavSlider != null){
						facetNavSlider.setValues(minPrice, maxPrice);
					}
				}

				var facetArray = this.getEnabledProductFacets();
				var facetContentArray = this.getEnabledContentFacets();

				wc.render.updateContext('searchBasedNavigation_context', {"top_category": this.top_category, "productBeginIndex": productBeginIndex,"contentBeginIndex": contentBeginIndex, "orderBy": orderBy,"orderByContent": orderByContent, "pageView": pageView,"pageViewContent": pageViewContent, "facet": facetArray[0], "facetLimit": facetArray[1], "facetId": facetArray[2], "facetContent": facetContentArray[0], "facetContentId": facetContentArray[1], "minPrice": minPrice, "maxPrice": maxPrice, "pageSize": pageSize, "resultType":"both"});
			}
		},
		refreshSliderRanges:function(){
			// refresh sliders
			$("ul[id^=slidervaluelist_]").each(function(){
				var id=$(this).attr("id");
				var facetName=id.substring(16);
				var newmin, newmax;
				$(this).find("li .outline").each(function(){
					//only if some
					if($(this).find(".facetCountContainer span").text().trim()!="0"){
						if($(this).find(".color_swatch").length){
							var val = $(this).find(".color_swatch").text().trim();
						}else{
							var val = $(this).children("span").text().trim();
						}
						val=parseFloat(val);
						if(newmin==undefined){
							newmin=val;
							newmax=val;
						}else{
							if(val<newmin) newmin=val;
							if(val>newmax) newmax=val;
						}
					}
				});
				//TODO ajuster si min=max ou min<1
	
				if(newmin!=undefined){
					var mySlider=eval("facetNavSlider_"+facetName).innerslider;
	
					/* si position debordait du nouveau range, reduire position en consequence */ 
					formerMin=parseFloat(mySlider.nstSlider("get_current_min_value"));
					formerMax=parseFloat(mySlider.nstSlider("get_current_max_value"));
					var changed=false;
					if (formerMin<newmin){ changed=true; formerMin=newmin;}
					if (formerMax>newmax){ changed=true; formerMax=newmax;}
					if(changed){
						mySlider.nstSlider("set_position", formerMin, formerMax);
					}
	
					/* ajuster l'affichage */
					mySlider.nstSlider("set_range", newmin, newmax);
					dojo.query(".xsection_"+facetName).style("display", "block");
					mySlider.nstSlider('refresh');
				}else{
					/* masquer ce slider sans valeurs */
					console.log("masquer "+facetName);
					$(".xsection_"+facetName).hide();
				}
			});
		}
	};
}
