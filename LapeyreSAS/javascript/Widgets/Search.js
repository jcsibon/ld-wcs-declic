//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2013, 2015 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

// change lenient search
var defaultDiacriticsRemovalMap = [
    {'base':'A', 'letters':/[\u0041\u24B6\uFF21\u00C0\u00C1\u00C2\u1EA6\u1EA4\u1EAA\u1EA8\u00C3\u0100\u0102\u1EB0\u1EAE\u1EB4\u1EB2\u0226\u01E0\u00C4\u01DE\u1EA2\u00C5\u01FA\u01CD\u0200\u0202\u1EA0\u1EAC\u1EB6\u1E00\u0104\u023A\u2C6F]/g},
    {'base':'AA','letters':/[\uA732]/g},
    {'base':'AE','letters':/[\u00C6\u01FC\u01E2]/g},
    {'base':'AO','letters':/[\uA734]/g},
    {'base':'AU','letters':/[\uA736]/g},
    {'base':'AV','letters':/[\uA738\uA73A]/g},
    {'base':'AY','letters':/[\uA73C]/g},
    {'base':'B', 'letters':/[\u0042\u24B7\uFF22\u1E02\u1E04\u1E06\u0243\u0182\u0181]/g},
    {'base':'C', 'letters':/[\u0043\u24B8\uFF23\u0106\u0108\u010A\u010C\u00C7\u1E08\u0187\u023B\uA73E]/g},
    {'base':'D', 'letters':/[\u0044\u24B9\uFF24\u1E0A\u010E\u1E0C\u1E10\u1E12\u1E0E\u0110\u018B\u018A\u0189\uA779]/g},
    {'base':'DZ','letters':/[\u01F1\u01C4]/g},
    {'base':'Dz','letters':/[\u01F2\u01C5]/g},
    {'base':'E', 'letters':/[\u0045\u24BA\uFF25\u00C8\u00C9\u00CA\u1EC0\u1EBE\u1EC4\u1EC2\u1EBC\u0112\u1E14\u1E16\u0114\u0116\u00CB\u1EBA\u011A\u0204\u0206\u1EB8\u1EC6\u0228\u1E1C\u0118\u1E18\u1E1A\u0190\u018E]/g},
    {'base':'F', 'letters':/[\u0046\u24BB\uFF26\u1E1E\u0191\uA77B]/g},
    {'base':'G', 'letters':/[\u0047\u24BC\uFF27\u01F4\u011C\u1E20\u011E\u0120\u01E6\u0122\u01E4\u0193\uA7A0\uA77D\uA77E]/g},
    {'base':'H', 'letters':/[\u0048\u24BD\uFF28\u0124\u1E22\u1E26\u021E\u1E24\u1E28\u1E2A\u0126\u2C67\u2C75\uA78D]/g},
    {'base':'I', 'letters':/[\u0049\u24BE\uFF29\u00CC\u00CD\u00CE\u0128\u012A\u012C\u0130\u00CF\u1E2E\u1EC8\u01CF\u0208\u020A\u1ECA\u012E\u1E2C\u0197]/g},
    {'base':'J', 'letters':/[\u004A\u24BF\uFF2A\u0134\u0248]/g},
    {'base':'K', 'letters':/[\u004B\u24C0\uFF2B\u1E30\u01E8\u1E32\u0136\u1E34\u0198\u2C69\uA740\uA742\uA744\uA7A2]/g},
    {'base':'L', 'letters':/[\u004C\u24C1\uFF2C\u013F\u0139\u013D\u1E36\u1E38\u013B\u1E3C\u1E3A\u0141\u023D\u2C62\u2C60\uA748\uA746\uA780]/g},
    {'base':'LJ','letters':/[\u01C7]/g},
    {'base':'Lj','letters':/[\u01C8]/g},
    {'base':'M', 'letters':/[\u004D\u24C2\uFF2D\u1E3E\u1E40\u1E42\u2C6E\u019C]/g},
    {'base':'N', 'letters':/[\u004E\u24C3\uFF2E\u01F8\u0143\u00D1\u1E44\u0147\u1E46\u0145\u1E4A\u1E48\u0220\u019D\uA790\uA7A4]/g},
    {'base':'NJ','letters':/[\u01CA]/g},
    {'base':'Nj','letters':/[\u01CB]/g},
    {'base':'O', 'letters':/[\u004F\u24C4\uFF2F\u00D2\u00D3\u00D4\u1ED2\u1ED0\u1ED6\u1ED4\u00D5\u1E4C\u022C\u1E4E\u014C\u1E50\u1E52\u014E\u022E\u0230\u00D6\u022A\u1ECE\u0150\u01D1\u020C\u020E\u01A0\u1EDC\u1EDA\u1EE0\u1EDE\u1EE2\u1ECC\u1ED8\u01EA\u01EC\u00D8\u01FE\u0186\u019F\uA74A\uA74C]/g},
    {'base':'OI','letters':/[\u01A2]/g},
    {'base':'OO','letters':/[\uA74E]/g},
    {'base':'OU','letters':/[\u0222]/g},
    {'base':'P', 'letters':/[\u0050\u24C5\uFF30\u1E54\u1E56\u01A4\u2C63\uA750\uA752\uA754]/g},
    {'base':'Q', 'letters':/[\u0051\u24C6\uFF31\uA756\uA758\u024A]/g},
    {'base':'R', 'letters':/[\u0052\u24C7\uFF32\u0154\u1E58\u0158\u0210\u0212\u1E5A\u1E5C\u0156\u1E5E\u024C\u2C64\uA75A\uA7A6\uA782]/g},
    {'base':'S', 'letters':/[\u0053\u24C8\uFF33\u1E9E\u015A\u1E64\u015C\u1E60\u0160\u1E66\u1E62\u1E68\u0218\u015E\u2C7E\uA7A8\uA784]/g},
    {'base':'T', 'letters':/[\u0054\u24C9\uFF34\u1E6A\u0164\u1E6C\u021A\u0162\u1E70\u1E6E\u0166\u01AC\u01AE\u023E\uA786]/g},
    {'base':'TZ','letters':/[\uA728]/g},
    {'base':'U', 'letters':/[\u0055\u24CA\uFF35\u00D9\u00DA\u00DB\u0168\u1E78\u016A\u1E7A\u016C\u00DC\u01DB\u01D7\u01D5\u01D9\u1EE6\u016E\u0170\u01D3\u0214\u0216\u01AF\u1EEA\u1EE8\u1EEE\u1EEC\u1EF0\u1EE4\u1E72\u0172\u1E76\u1E74\u0244]/g},
    {'base':'V', 'letters':/[\u0056\u24CB\uFF36\u1E7C\u1E7E\u01B2\uA75E\u0245]/g},
    {'base':'VY','letters':/[\uA760]/g},
    {'base':'W', 'letters':/[\u0057\u24CC\uFF37\u1E80\u1E82\u0174\u1E86\u1E84\u1E88\u2C72]/g},
    {'base':'X', 'letters':/[\u0058\u24CD\uFF38\u1E8A\u1E8C]/g},
    {'base':'Y', 'letters':/[\u0059\u24CE\uFF39\u1EF2\u00DD\u0176\u1EF8\u0232\u1E8E\u0178\u1EF6\u1EF4\u01B3\u024E\u1EFE]/g},
    {'base':'Z', 'letters':/[\u005A\u24CF\uFF3A\u0179\u1E90\u017B\u017D\u1E92\u1E94\u01B5\u0224\u2C7F\u2C6B\uA762]/g},
    {'base':'a', 'letters':/[\u0061\u24D0\uFF41\u1E9A\u00E0\u00E1\u00E2\u1EA7\u1EA5\u1EAB\u1EA9\u00E3\u0101\u0103\u1EB1\u1EAF\u1EB5\u1EB3\u0227\u01E1\u00E4\u01DF\u1EA3\u00E5\u01FB\u01CE\u0201\u0203\u1EA1\u1EAD\u1EB7\u1E01\u0105\u2C65\u0250]/g},
    {'base':'aa','letters':/[\uA733]/g},
    {'base':'ae','letters':/[\u00E6\u01FD\u01E3]/g},
    {'base':'ao','letters':/[\uA735]/g},
    {'base':'au','letters':/[\uA737]/g},
    {'base':'av','letters':/[\uA739\uA73B]/g},
    {'base':'ay','letters':/[\uA73D]/g},
    {'base':'b', 'letters':/[\u0062\u24D1\uFF42\u1E03\u1E05\u1E07\u0180\u0183\u0253]/g},
    {'base':'c', 'letters':/[\u0063\u24D2\uFF43\u0107\u0109\u010B\u010D\u00E7\u1E09\u0188\u023C\uA73F\u2184]/g},
    {'base':'d', 'letters':/[\u0064\u24D3\uFF44\u1E0B\u010F\u1E0D\u1E11\u1E13\u1E0F\u0111\u018C\u0256\u0257\uA77A]/g},
    {'base':'dz','letters':/[\u01F3\u01C6]/g},
    {'base':'e', 'letters':/[\u0065\u24D4\uFF45\u00E8\u00E9\u00EA\u1EC1\u1EBF\u1EC5\u1EC3\u1EBD\u0113\u1E15\u1E17\u0115\u0117\u00EB\u1EBB\u011B\u0205\u0207\u1EB9\u1EC7\u0229\u1E1D\u0119\u1E19\u1E1B\u0247\u025B\u01DD]/g},
    {'base':'f', 'letters':/[\u0066\u24D5\uFF46\u1E1F\u0192\uA77C]/g},
    {'base':'g', 'letters':/[\u0067\u24D6\uFF47\u01F5\u011D\u1E21\u011F\u0121\u01E7\u0123\u01E5\u0260\uA7A1\u1D79\uA77F]/g},
    {'base':'h', 'letters':/[\u0068\u24D7\uFF48\u0125\u1E23\u1E27\u021F\u1E25\u1E29\u1E2B\u1E96\u0127\u2C68\u2C76\u0265]/g},
    {'base':'hv','letters':/[\u0195]/g},
    {'base':'i', 'letters':/[\u0069\u24D8\uFF49\u00EC\u00ED\u00EE\u0129\u012B\u012D\u00EF\u1E2F\u1EC9\u01D0\u0209\u020B\u1ECB\u012F\u1E2D\u0268\u0131]/g},
    {'base':'j', 'letters':/[\u006A\u24D9\uFF4A\u0135\u01F0\u0249]/g},
    {'base':'k', 'letters':/[\u006B\u24DA\uFF4B\u1E31\u01E9\u1E33\u0137\u1E35\u0199\u2C6A\uA741\uA743\uA745\uA7A3]/g},
    {'base':'l', 'letters':/[\u006C\u24DB\uFF4C\u0140\u013A\u013E\u1E37\u1E39\u013C\u1E3D\u1E3B\u017F\u0142\u019A\u026B\u2C61\uA749\uA781\uA747]/g},
    {'base':'lj','letters':/[\u01C9]/g},
    {'base':'m', 'letters':/[\u006D\u24DC\uFF4D\u1E3F\u1E41\u1E43\u0271\u026F]/g},
    {'base':'n', 'letters':/[\u006E\u24DD\uFF4E\u01F9\u0144\u00F1\u1E45\u0148\u1E47\u0146\u1E4B\u1E49\u019E\u0272\u0149\uA791\uA7A5]/g},
    {'base':'nj','letters':/[\u01CC]/g},
    {'base':'o', 'letters':/[\u006F\u24DE\uFF4F\u00F2\u00F3\u00F4\u1ED3\u1ED1\u1ED7\u1ED5\u00F5\u1E4D\u022D\u1E4F\u014D\u1E51\u1E53\u014F\u022F\u0231\u00F6\u022B\u1ECF\u0151\u01D2\u020D\u020F\u01A1\u1EDD\u1EDB\u1EE1\u1EDF\u1EE3\u1ECD\u1ED9\u01EB\u01ED\u00F8\u01FF\u0254\uA74B\uA74D\u0275]/g},
    {'base':'oi','letters':/[\u01A3]/g},
    {'base':'ou','letters':/[\u0223]/g},
    {'base':'oo','letters':/[\uA74F]/g},
    {'base':'p','letters':/[\u0070\u24DF\uFF50\u1E55\u1E57\u01A5\u1D7D\uA751\uA753\uA755]/g},
    {'base':'q','letters':/[\u0071\u24E0\uFF51\u024B\uA757\uA759]/g},
    {'base':'r','letters':/[\u0072\u24E1\uFF52\u0155\u1E59\u0159\u0211\u0213\u1E5B\u1E5D\u0157\u1E5F\u024D\u027D\uA75B\uA7A7\uA783]/g},
    {'base':'s','letters':/[\u0073\u24E2\uFF53\u00DF\u015B\u1E65\u015D\u1E61\u0161\u1E67\u1E63\u1E69\u0219\u015F\u023F\uA7A9\uA785\u1E9B]/g},
    {'base':'t','letters':/[\u0074\u24E3\uFF54\u1E6B\u1E97\u0165\u1E6D\u021B\u0163\u1E71\u1E6F\u0167\u01AD\u0288\u2C66\uA787]/g},
    {'base':'tz','letters':/[\uA729]/g},
    {'base':'u','letters':/[\u0075\u24E4\uFF55\u00F9\u00FA\u00FB\u0169\u1E79\u016B\u1E7B\u016D\u00FC\u01DC\u01D8\u01D6\u01DA\u1EE7\u016F\u0171\u01D4\u0215\u0217\u01B0\u1EEB\u1EE9\u1EEF\u1EED\u1EF1\u1EE5\u1E73\u0173\u1E77\u1E75\u0289]/g},
    {'base':'v','letters':/[\u0076\u24E5\uFF56\u1E7D\u1E7F\u028B\uA75F\u028C]/g},
    {'base':'vy','letters':/[\uA761]/g},
    {'base':'w','letters':/[\u0077\u24E6\uFF57\u1E81\u1E83\u0175\u1E87\u1E85\u1E98\u1E89\u2C73]/g},
    {'base':'x','letters':/[\u0078\u24E7\uFF58\u1E8B\u1E8D]/g},
    {'base':'y','letters':/[\u0079\u24E8\uFF59\u1EF3\u00FD\u0177\u1EF9\u0233\u1E8F\u00FF\u1EF7\u1E99\u1EF5\u01B4\u024F\u1EFF]/g},
    {'base':'z','letters':/[\u007A\u24E9\uFF5A\u017A\u1E91\u017C\u017E\u1E93\u1E95\u01B6\u0225\u0240\u2C6C\uA763]/g}
];


if(typeof(SearchJS) == "undefined" || SearchJS == null || !SearchJS){

	SearchJS = {

		/**
		 * This variable controls the timer handler before triggering the autoSuggest.  If the user types fast, intermittent requests will be cancelled.
		 * The value is initialized to -1.
		 */
		autoSuggestTimer: -1,

		/**
		 * This variable controls the delay of the timer in milliseconds between the keystrokes before firing the search request.
		 * The value is initialized to 400.
		 */
		autoSuggestKeystrokeDelay : 400,

		/**
		 * This variable indicates whether or not the user is hovering over the autoSuggest results popup display.
		 * The value is initialized to false.
		 */
		autoSuggestHover : false,

		/**
		 * This variable stores the old search term used in the auto suggest search box
		 * The value is initialized to empty string.
		 */
		autoSuggestPreviousTerm : "",

		/**
		 * This variable stores the URL of currently selected static autosuggest recommendation
		 * The value is initialized to empty string.
		 */
		autoSuggestURL : "",

		/**
		 * This variable stores the index of the selected auto suggestion item when using up/down arrow keys.
		 * The value is initialized to -1.
		 */
		autoSelectOption : -1,

		/**
		 * This variable stores the index offset of the first previous history term
		 * The value is initialized to -1.
		 */
		historyIndex : -1,

		/**
		 * This variable indicates whether a the cached suggestions have been retrieved.
		 * The value is initialized to false.
		 */
		retrievedCachedSuggestions : false,

		/**
		 * This variable sets the total number of static autosuggest recommendations used for each static category/grouping.
		 * The value is initialized to 4.
		 */
		TOTAL_SUGGESTED : 4,

		/**
		 * This variable sets the total number of previous search history terms.
		 * The value is initialized to 2.
		 */
		TOTAL_HISTORY : 2,

		/**
		 * This variable controls when to trigger the auto suggest box.  The number of characters greater than this threshold will trigger the auto suggest functionality.
		 * The static/cached auto suggest will be performed if this threshold is exceeded.
		 * The value is initialized to 1.
		 */
		AUTOSUGGEST_THRESHOLD : 1,

		/**
		 * This variable controls when to trigger the dynamic auto suggest.  The number of characters greater than this threshold will trigger the request for keyword search.
		 * The static/cached auto suggest will be be displayed if the characters exceed the above config parameter, but exceeding this threshold will additionally perform the dynamic search to add to the results in the static/cached results.
		 * This value should be greater or equal than the AUTOSUGGEST_THRESHOLD, as the dynamic autosuggest is secondary to the static/cached auto suggest.
		 * The value is initialized to 1.
		 */
		DYNAMIC_AUTOSUGGEST_THRESHOLD : 1,

		/**
		 * This variable is an internal constant used in the element ID's generated in the autosuggest content.
		 * The value is initialized to 1000.
		 */
		CACHED_AUTOSUGGEST_OFFSET : 1000,

		/**
		 * This variable is used to indicate whether or not the auto suggest selection has reached the end of the list.
		 * The value is initialized to false.
		 */
		END_OF_LIST : false,
		/**
		  * The auto suggest container ID's
		 */
		STATIC_CONTENT_SECTION_DIV: ["autoSuggestStatic_1", "autoSuggestStatic_2", "autoSuggestStatic_3"],


		/**
		 * NLS message for header
		*/
		staticContentHeaderHistory:"",

		/**
		 * URL to retrieve Cached suggestions
		*/
		CachedSuggestionsURL:"",

		/**
		 * URL to retrieve auto suggest keywords
		*/
		SearchAutoSuggestServletURL:"",

		/**
		 * Timeout variable for department dropdown list
		*/
		searchDepartmentHoverTimeout:"",
		/**
		 * Timeout variable for suggestions dropdown list
		*/
		searchSuggestionHoverTimeout:"",
		/**
		 * Handle for dojo.connect onmousedown event.
		 */
		mouseDownConnectHandle: null,

		searchDepartmentSelect: function(categoryId, lel){
			byId('searchDepartmentLabel').innerHTML=lel.innerHTML;
			byId('search_categoryId').value = categoryId;
			this.hideSearchDepartmentList();
			return false;
		},

		cancelEvent: function(e) {
			var event = e || window.event;
			if (event.stopPropagation) {
				event.stopPropagation();
			}
			if (event.preventDefault) {
				event.preventDefault();
			}
			event.cancelBubble = true;
			event.cancel = true;
			event.returnValue = false;
		},

		searchDepartmentKeyPressed: function(event, pos, size, categoryId, item){
			if (event.keyCode == 13) { // enter
				this.searchDepartmentSelect(categoryId, item);
				var scrElement = document.getElementById("mobileSearchDropdown");
				if (scrElement != null && scrElement.style.display == 'block'){
					dojo.byId("MobileSimpleSearchForm_SearchTerm").focus();
				}else{
					document.CatalogSearchForm.searchTerm.focus();
				}
			} else if (event.keyCode == 38) { // up arrow
				if (pos != 0) {
					dojo.byId('searchDepartmentList_' + (pos - 1)).focus();
					this.cancelEvent(event);
				}
			} else if (event.keyCode == 40) { // down arrow
				if (pos != size) {
					dojo.byId('searchDepartmentList_' + (pos + 1)).focus();
					this.cancelEvent(event);
				}
			} else if (event.keyCode == 27) { // escape
				var scrElement = document.getElementById("mobileSearchDropdown");
				if (scrElement != null && scrElement.style.display == 'block'){
					dojo.byId("MobileSimpleSearchForm_SearchTerm").focus();
				}else{
					document.CatalogSearchForm.searchTerm.focus();
				}
				this.hideSearchDepartmentList();
			} else if (event.shiftKey && event.keyCode == 9) { // tab
				var scrElement = document.getElementById("mobileSearchDropdown");
				if (scrElement != null && scrElement.style.display == 'block'){
					dojo.byId("MobileSimpleSearchForm_SearchTerm").focus();
				}else{
					document.CatalogSearchForm.searchTerm.focus();
				}
				this.cancelEvent(event);
				this.hideSearchDepartmentList();
			} else if (event.keyCode == 9) { // tab
				dojo.byId('search_submit').focus();
				this.cancelEvent(event);
				this.hideSearchDepartmentList();
			}

			return false;
		},

		hideSearchDepartmentList: function(){
			byId('searchDepartmentList').style.display="none";
		},

		init:function(){
			dojo.connect(document.CatalogSearchForm.searchTerm, "onfocus", SearchJS, SearchJS._onFocus);
			dojo.connect(document.CatalogSearchForm.searchTerm, "onkeydown", SearchJS, SearchJS._onKeyDown);
			dojo.connect(document.CatalogSearchForm.searchTerm, "onkeyup", SearchJS, SearchJS._onKeyUp);
			dojo.connect(document.getElementById("searchDropdown"), "onkeyup", SearchJS, SearchJS._onKeyTab);
// do not uncomment - regression sur les liens href
//			dojo.connect(dojo.byId("Mobilesearch_submit"), "onclick", SearchJS, SearchJS._MobileonClick);
//			dojo.connect(dojo.byId("navSearchMobile"), "onclick", SearchJS, SearchJS._showMobileSearchComponent);
//			dojo.connect(dojo.byId("search_submit"), "onclick", SearchJS, SearchJS._onClick);

			this.staticContentHeaderHistory = storeNLS["HISTORY"];
		},

		showSearchComponent:function(){
			var srcElement = document.getElementById("searchDropdown");
			if(srcElement != null) {
				srcElement.style.display= 'block';
			}
		  },

		hideSearchComponent:function(){
			console.debug('hideSearchComponent');
			var srcElement = document.getElementById("searchDropdown");
			if(srcElement != null) {
				srcElement.style.display= 'none';
			}
		},

		_showMobileSearchComponent:function(){
			var srcElement = document.getElementById("mobileSearchDropdown");
			if(srcElement != null) {
			  if(srcElement.style.display == "block") {
				  DepartmentJS.close('mobileSearchDropdown');
				srcElement.style.display= 'none';
			  }
			  else
			  {
				dojo.query(".subDeptDropdown ").forEach(function(node){
					DepartmentJS.close(node.id);
				});
				DepartmentJS.close("departmentsDropdown");
				srcElement.style.display='block';
			  }
			}
		  },

		setCachedSuggestionsURL:function(url){
			this.CachedSuggestionsURL = getAbsoluteURL() + url;
		},

		setAutoSuggestURL:function(url){
			this.SearchAutoSuggestServletURL = getAbsoluteURL() + url;
		},

		_onFocus:function(evt){
			this.showSearchComponent();
			this.retrieveCachedSuggestions();
		},

		_MobileonFocus:function(evt){
			this.showSearchComponent();
			this.retrieveCachedSuggestions();
		},

		_MobileonBlur:function(evt){
			clearTimeout(this.searchSuggestionHoverTimeout);
			this.searchSuggestionHoverTimeout = setTimeout("SearchJS.showAutoSuggest(false)",100);
		},

		_onKeyPress:function(evt){
			return evt.keyCode != dojo.keys.ENTER;
		},
		_onKeyDown:function(evt){
			if(evt.keyCode == dojo.keys.ENTER) {
				this._handleEnterKey();
				this.cancelEvent(evt);
			}
			else if (evt.keyCode == '9' || evt.which == '9') {
				clearTimeout(this.searchSuggestionHoverTimeout);
				this.searchSuggestionHoverTimeout = setTimeout("SearchJS.showAutoSuggest(false)",200);
			}
		},
		_onKeyUp:function(evt){
			var srcElement = document.getElementById("searchDropdown");
			srcElement.style.display='block';
			this.doAutoSuggest(evt, this.SearchAutoSuggestServletURL, document.CatalogSearchForm.searchTerm.value);
		},
		_onKeyTab:function(evt){
			if(evt.keyCode == '9' || evt.which == '9'){
				dojo.byId("searchFilterButton").focus();
			}
		},
		_MobileonKeyUp:function(evt){
			var srcElement = document.getElementById("mobileSearchDropdown");
			srcElement.style.display='block';
			this.doAutoSuggest(evt, this.SearchAutoSuggestServletURL, dojo.byId("MobileSimpleSearchForm_SearchTerm").value);
		},

		_handleEnterKey:function() {
			document.CatalogSearchForm.searchTerm.value = trim(document.CatalogSearchForm.searchTerm.value);
			if(document.CatalogSearchForm.searchTerm.value.length > 0) {
				if(this.END_OF_LIST) {
					this.gotoAdvancedSearch(byId("advancedSearch").href);
				}
				else if(this.autoSuggestURL != "" &&  this.autoSuggestURL != (document.location.href + "#")) {
					//When enter key is hit with one of the suggested keywords or results highlighted, then go to the URL specified for that result..
					// go to suggested URL
					document.location.href = appendWcCommonRequestParameters(this.autoSuggestURL);
				}
				else {
					//Enter key is hit, when the focus was in search term input box.. Submit the form and get the results..
					document.CatalogSearchForm.searchTerm.value = trim(document.CatalogSearchForm.searchTerm.value);
					submitSpecifiedForm(document.CatalogSearchForm);
				}
			}

		},


		_onClick:function(evt){
			document.CatalogSearchForm.searchTerm.value = trim(document.CatalogSearchForm.searchTerm.value);
			if(document.CatalogSearchForm.searchTerm.value.length > 0) {
				if(typeof TealeafWCJS != "undefined"){
					TealeafWCJS.processDOMEvent(evt);
				}
				submitSpecifiedForm(document.CatalogSearchForm);
			}
			return false;
		},

		_MobileonClick:function(evt){
			document.MobileCatalogSearchForm.searchTerm.value = trim(document.MobileCatalogSearchForm.searchTerm.value);
			if(document.MobileCatalogSearchForm.searchTerm.value.length > 0) {
				if(typeof TealeafWCJS != "undefined"){
					TealeafWCJS.processDOMEvent(evt);
				}
				submitSpecifiedForm(document.MobileCatalogSearchForm);
			}
			return false;
		},

		doDynamicAutoSuggest:function(url, searchTerm, showHeader) {
			// if pending autosuggest triggered, cancel it.
			if(this.autoSuggestTimer != -1) {
				clearTimeout(this.autoSuggestTimer);
				this.autoSuggestTimer = -1;
			};

			// call the auto suggest
			this.autoSuggestTimer = setTimeout(function() {
				wc.render.getRefreshControllerById("AutoSuggestDisplayController").url = url + "&term=" + encodeURIComponent(searchTerm) + "&showHeader=" + showHeader;
				console.debug("update autosuggest "+url);
				wc.render.updateContext("AutoSuggest_Context", {});
				this.autoSuggestTimer = -1;
			}, this.autoSuggestKeystrokeDelay);
		},

		gotoAdvancedSearch:function(url) {
			var searchTerm = byId("SimpleSearchForm_SearchTerm").value;
			document.location.href = appendWcCommonRequestParameters(url) + '&searchTerm=' + searchTerm;

		},

		showAutoSuggest:function(display) {
			var autoSuggest_Result_div = document.getElementById("autoSuggest_Result_div");
			if (dojo.isIE < 7){
				var autoSuggest_content_div = document.getElementById("autoSuggest_content_div");
				var autoSuggestDropDownIFrame = document.getElementById("autoSuggestDropDownIFrame");
			}

			if(autoSuggest_Result_div != null) {
				if(display) {
					autoSuggest_Result_div.style.display = "block";
					if (dojo.isIE < 7) {
						autoSuggestDropDownIFrame.style.height = autoSuggest_content_div.scrollHeight;
						autoSuggestDropDownIFrame.style.display = "block";
					}
					this.registerMouseDown();
				}
				else {
					if (dojo.isIE < 7) {
						autoSuggestDropDownIFrame.style.display = "none";
						autoSuggestDropDownIFrame.style.height = 0;
					}
					autoSuggest_Result_div.style.display = "none";
					this.unregisterMouseDown();
				}
			}
			else {
				this.unregisterMouseDown();
			}
		},

		showAutoSuggestIfResults:function() {
			// if no results, hide the autosuggest box

			var scrElement = document.getElementById("mobileSearchDropdown");
			if(typeof(staticContent) != "undefined" && document.getElementById(this.STATIC_CONTENT_SECTION_DIV[0]).innerHTML == "" && document.getElementById("autoSuggestHistory").innerHTML == "" && document.getElementById("dynamicAutoSuggestTotalResults") == null) {
				this.showAutoSuggest(false);
			}
			else if(scrElement != null && scrElement.style.display == 'block')
			{
					if(document.getElementById("MobileSimpleSearchForm_SearchTerm").value.length <= this.AUTOSUGGEST_THRESHOLD)
					{
						this.showAutoSuggest(false);
					}
					else
					{
						this.showAutoSuggest(true);
					}
			}
			else {
					if(document.CatalogSearchForm.searchTerm.value.length <= this.AUTOSUGGEST_THRESHOLD)
					{
						this.showAutoSuggest(false);
					}
					else
					{
						this.showAutoSuggest(true);
					}
			}
		},

		selectAutoSuggest:function(term) {
			var scrElement = document.getElementById("mobileSearchDropdown");
			if (scrElement != null && scrElement.style.display == 'block'){
				var searchBox = document.getElementById("MobileSimpleSearchForm_SearchTerm");
			}else{
				var searchBox = document.CatalogSearchForm.searchTerm;
			}

			searchBox.value = term;
			searchBox.focus();
			this.autoSuggestPreviousTerm = term;
			if(typeof TealeafWCJS != "undefined"){
				TealeafWCJS.createExplicitChangeEvent(searchBox);
			}
			submitSpecifiedForm(document.CatalogSearchForm);
		},

		highLightSelection:function(state, index) {
			var selection = document.getElementById("autoSelectOption_" + index);
			if(selection != null) {

				if(state) {
					selection.className = "autoSuggestSelected";
					var scrElement = document.getElementById("mobileSearchDropdown");
					if (scrElement != null && scrElement.style.display == 'block'){
						var searchBox = document.getElementById("MobileSimpleSearchForm_SearchTerm");
					}else{
						var searchBox = document.CatalogSearchForm.searchTerm;
					}
					searchBox.setAttribute("aria-activedescendant", "suggestionItem_" + index);
					var totalDynamicResults = document.getElementById("dynamicAutoSuggestTotalResults");
					if((totalDynamicResults != null && index < totalDynamicResults.value) || (index >= this.historyIndex)) {
						searchBox.value = selection.title;
						this.autoSuggestPreviousTerm = selection.title;
					}
						this.autoSuggestURL = selection.href;
					}
				else {
					selection.className = "";
				}
				return true;
			}
			else {
				return false;
			}
		},

		enableAutoSelect:function(index) {
			this.highLightSelection(false, this.autoSelectOption);
			var item = document.getElementById('autoSelectOption_' + index);
			item.className = "autoSuggestSelected";
			this.autoSelectOption = index;
		},

		resetAutoSuggestKeyword:function() {
			var originalKeyedSearchTerm = document.getElementById("autoSuggestOriginalTerm");
			if(originalKeyedSearchTerm != null) {
				var scrElement = document.getElementById("mobileSearchDropdown");
				if (scrElement != null && scrElement.style.display == 'block')
				{
					var searchBox = document.getElementById("MobileSimpleSearchForm_SearchTerm");
				}else{
					var searchBox = document.CatalogSearchForm.searchTerm;
				}
				searchBox.value = originalKeyedSearchTerm.value;
				this.autoSuggestPreviousTerm = originalKeyedSearchTerm.value;
			}
		},


		clearAutoSuggestResults:function() {
			// clear the static search results.
			for (var i = 0; i < staticContent.length; i++) {
				document.getElementById(this.STATIC_CONTENT_SECTION_DIV[i]).innerHTML = "";
			}
			this.autoSuggestPreviousTerm = "";
			this.autoSuggestURL = "";
			// clear the dynamic search results;
			document.getElementById("autoSuggestDynamic_Result_div").innerHTML = "";
			this.showAutoSuggest(false);
		},

		doAutoSuggest:function(event, url, searchTerm) {
			searchTerm = searchTerm.trim();
			if(searchTerm.length <= this.AUTOSUGGEST_THRESHOLD ) {
				this.showAutoSuggest(false);
			}

			if(event.keyCode == dojo.keys.ENTER) {
				return;
			}

			if(event.keyCode == dojo.keys.TAB) {
				this.autoSuggestHover = true;
				return;
			}

			if(event.keyCode == dojo.keys.ESCAPE) {
				this.showAutoSuggest(false);
				return;
			}

			if(event.keyCode == dojo.keys.UP_ARROW) {
				var totalDynamicResults = document.getElementById("dynamicAutoSuggestTotalResults");
				if(this.END_OF_LIST) {
					dojo.removeClass("autoSuggestAdvancedSearch", "autoSuggestSelected");
					this.END_OF_LIST = false;
					this.autoSelectOption--;
					if(!this.highLightSelection(true, this.autoSelectOption)) {
						if(this.autoSelectOption == this.CACHED_AUTOSUGGEST_OFFSET && totalDynamicResults != null) {
							this.autoSelectOption = totalDynamicResults.value-1;
							this.highLightSelection(true, this.autoSelectOption);
						}
					}
				}
				else if (this.highLightSelection(true, this.autoSelectOption-1)) {
					this.highLightSelection(false, this.autoSelectOption);
					if(this.autoSelectOption == this.historyIndex) {
						this.resetAutoSuggestKeyword();
					}
					this.autoSelectOption--;
				}
				else if(this.autoSelectOption == this.CACHED_AUTOSUGGEST_OFFSET && totalDynamicResults != null) {
					this.highLightSelection(false, this.CACHED_AUTOSUGGEST_OFFSET);
					this.autoSelectOption = totalDynamicResults.value-1;
					this.highLightSelection(true, this.autoSelectOption);
				}
				else {
					// up arrow back to the very top
					this.highLightSelection(false, this.autoSelectOption);
					this.autoSelectOption = -1;
					var originalKeyedSearchTerm = document.getElementById("autoSuggestOriginalTerm");
					this.resetAutoSuggestKeyword();
				}
				return;
			}

			if(event.keyCode == dojo.keys.DOWN_ARROW) {
				if(this.highLightSelection(true, this.autoSelectOption+1)) {
					this.highLightSelection(false, this.autoSelectOption);
					this.autoSelectOption++;
				}
				else if(this.autoSelectOption < this.CACHED_AUTOSUGGEST_OFFSET && this.highLightSelection(true, this.CACHED_AUTOSUGGEST_OFFSET)) {
					// down arrow into the cached autosuggest section
					this.highLightSelection(false, this.autoSelectOption);
					this.autoSelectOption = this.CACHED_AUTOSUGGEST_OFFSET;
					this.resetAutoSuggestKeyword();
				}
				else if(!this.END_OF_LIST) {
					dojo.addClass("autoSuggestAdvancedSearch", "autoSuggestSelected");
					this.highLightSelection(false, this.autoSelectOption);
					this.autoSelectOption++;
					this.END_OF_LIST = true;
					var scrElement = document.getElementById("mobileSearchDropdown");
					if (scrElement != null && scrElement.style.display == 'block'){
						var searchBox = document.getElementById("MobileSimpleSearchForm_SearchTerm");
					}else{
						var searchBox = document.CatalogSearchForm.searchTerm;
					}
					searchBox.setAttribute("aria-activedescendant", "advancedSearch");
				}
				return;
			}

			if(searchTerm.length > this.AUTOSUGGEST_THRESHOLD && searchTerm == this.autoSuggestPreviousTerm) {
				return;
			}
			else {
				this.autoSuggestPreviousTerm = searchTerm;
			}

			if(searchTerm.length <= this.AUTOSUGGEST_THRESHOLD) {
				return;
			};

			// cancel the dynamic search if one is pending
			if(this.autoSuggestTimer != -1) {
				clearTimeout(this.autoSuggestTimer);
				this.autoSuggestTimer = -1;
			}

			if(searchTerm != "") {
				this.autoSelectOption = -1;
				var hasResults = this.doStaticAutoSuggest(searchTerm);
				if(searchTerm.length > this.DYNAMIC_AUTOSUGGEST_THRESHOLD) {
					var showHeader = true; // hasResults;
					this.doDynamicAutoSuggest(url, searchTerm, showHeader);
				}
				else {
					// clear the dynamic results
					document.getElementById("autoSuggestDynamic_Result_div").innerHTML = "";
				}
			}
			else {
				this.clearAutoSuggestResults();
			}
		},

		tokenizeForBidi:function(displayName, searchName, searchTerm, searchTermLower) {
			var tokens = displayName.split( " > " );
			var html = "";
			var str = "";
			if(tokens.length > 0) {
				html = html + "<div class='category_list'>";
				for(i = 0; i < tokens.length; i++) {
					if(i!=0) {
						// not the first token
						html = html + "<span class='gt'>&nbsp; > &nbsp;</span>";
					}
					if(i == tokens.length - 1) {
						// last token
						// change lenient search - begin
						//var index = searchName.toLowerCase().indexOf(searchTermLower);
						var index = SearchJS.removeDiacritics(searchName).toLowerCase().indexOf(SearchJS.removeDiacritics(searchTermLower));
						// change lenient search - end
						var subStringBefore = searchName.substr(0, index);
						var subStringAfter =  searchName.substr(index + searchTerm.length);
						var highLighted = "<span class='highlight'>" + searchName.substr(index,searchTerm.length ) + "</span>";
						str = subStringBefore + highLighted + subStringAfter;
					}
					else {
						str = tokens[i];
					}
					html = html + str;
				}
				html = html + "</div>";
			}
			return html;
		},

		// change lenient search - begin
		changes:-1,
		removeDiacritics :function(str) {
		
    			if(changes=-1) {
        			changes = defaultDiacriticsRemovalMap;
    			}
    			for(var i=0; i<changes.length; i++) {
        			str = str.replace(changes[i].letters, changes[i].base);
    			}
    			return str;
		},
		// change lenient search - end

		
		doStaticAutoSuggest:function(searchTerm) {
			var resultList = ["", "", "", "", "", ""];
			var emptyCell = 0;
			var searchTermLower = searchTerm.toLowerCase();
			var listCount = this.CACHED_AUTOSUGGEST_OFFSET;
			var divStart = "<div class='list_section'><div";
			var divEnd =   "</div></div>";

			for(var i = 0; i < staticContent.length; i++) {
				var count = 0;
				for(var j = 0; j < staticContent[i].length; j++) {
					var searchName = staticContent[i][j][0];
					var searchURL = staticContent[i][j][1];
					var displayName = staticContent[i][j][2];
					// change lenient search - begin
					//var index = searchName.toLowerCase().indexOf(searchTermLower);
					var index = SearchJS.removeDiacritics(searchName).toLowerCase().indexOf(SearchJS.removeDiacritics(searchTermLower));
					// change lenient search - end
					if(index != -1) {

						var htmlDisplayName = this.tokenizeForBidi(displayName, searchName, searchTerm, searchTermLower);

						resultList[i] = resultList[i] + "<ul class='autoSuggestDivNestedList'><li id='suggestionItem_" + listCount + "' role='listitem' tabindex='-1'><a id='autoSelectOption_" + listCount + "' title='" + searchName + "' onmouseout='this.className=\"\"; this.autoSuggestURL=\"\";' onmousedown='SearchJS.cancelEvent(event);' onmouseup='SearchJS.hideSearchComponent();' onmouseover='SearchJS.enableAutoSelect(" + listCount + "); this.autoSuggestURL=this.href;' href=\"" + searchURL + "\">" + htmlDisplayName + "</a></li></ul>";
						count++;
						listCount++;
						if(count >= this.TOTAL_SUGGESTED) {
							break;
						}
					}
				}
			}

			for (var i = 0; i < staticContent.length; i++) {
				document.getElementById(this.STATIC_CONTENT_SECTION_DIV[i]).innerHTML = "";
				if(resultList[i] != "") {
					var heading =  "<ul class='autoSuggestDivNestedList'><li class='heading'><span>" + staticContentHeaders[i] + "</span></li></ul>";
					document.getElementById(this.STATIC_CONTENT_SECTION_DIV[emptyCell]).innerHTML = heading + divStart + " role='list' title='" + staticContentHeaders[i] + "' aria-label='" + staticContentHeaders[i] + "'>" + resultList[i] + divEnd;
					emptyCell++;
				}
			}

			var historyList = "";
			var searchHistorySection = document.getElementById("autoSuggestHistory");
			searchHistorySection.innerHTML = "";
			var historyArray = new Array();
			this.historyIndex = listCount;

			var searchHistoryCookie = getCookie("searchTermHistory");
			if(typeof(searchHistoryCookie) != 'undefined') {
				searchHistoryCookie=decodeURIComponent(escape(searchHistoryCookie));
				var termsArray = searchHistoryCookie.split("|");
				var count = 0;
				for(var i = termsArray.length - 1; i > 0; i--) {
					var theTerm = termsArray[i];
					var theLowerTerm = theTerm.toLowerCase();
					if(theLowerTerm.match("^"+searchTermLower) == searchTermLower) {
						var repeatedTerm = false;
						for(var j = 0; j < historyArray.length; j++) {
							if(historyArray[j] == theLowerTerm) {
								repeatedTerm = true;
								break;
							}
						}
						if(!repeatedTerm) {
							if(count >= this.TOTAL_HISTORY) {
								break;
							}
							historyList = historyList + "<ul class='autoSuggestDivNestedList'><li id='suggestionItem_" + listCount + "' role='listitem' tabindex='-1'><a href='#' onmouseout='this.className=\"\"' onmouseover='SearchJS.enableAutoSelect(" + listCount + ");' onmousedown='SearchJS.cancelEvent(event);' onmouseup='SearchJS.selectAutoSuggest(this.title); return false;' title='" + theTerm + "' id='autoSelectOption_" + listCount+ "'><strong>" + searchTerm + "</strong>" + theTerm.substring(searchTerm.length, theTerm.length) + "</a></li></ul>";
							historyArray.push(theLowerTerm);
							count++;
							listCount++;
						}
					}
				}
			}


			/*if(historyList != "") {
				var heading =  "<ul class='autoSuggestDivNestedList'><li class='heading'><span>" + this.staticContentHeaderHistory + "</span></li></ul>"
				searchHistorySection.innerHTML = heading + divStart + " title='" + this.staticContentHeaderHistory + "'>" + historyList + divEnd;
				emptyCell++;
			}*/

			if(emptyCell > 0) {
				this.showAutoSuggest(true);
				return true;
			}

			return false;
		},

		retrieveCachedSuggestions:function() {
			if(!this.retrievedCachedSuggestions) {
				wc.render.getRefreshControllerById("AutoSuggestCachedSuggestionsController").url = this.CachedSuggestionsURL;
				console.debug("update cache sugg "+this.CachedSuggestionsURL);
				wc.render.updateContext("CachedSuggestions_Context", {});
			}
		},

		/**
		 * Updates the searchTermHistory cookie value...
		 */
		updateSearchTermHistoryCookie:function(updatedSearchTerm){
			var cookieKey = "searchTermHistory";
			var cookieValue = "|" + updatedSearchTerm;
			var searchTermHistoryCookie = getCookie(cookieKey);
			if(typeof(searchTermHistoryCookie) != 'undefined') {
				cookieValue =  dojo.cookie(cookieKey) + cookieValue;
			}
			setCookie(cookieKey, cookieValue, {path:'/', domain:cookieDomain});
		},

		updateSearchTermHistoryCookieAndRedirect:function(updatedSearchTerm, redirectURL){
			this.updateSearchTermHistoryCookie(updatedSearchTerm);
			if (navigator.userAgent.toLowerCase().indexOf('firefox') == -1) {document.location.href = appendWcCommonRequestParameters(redirectURL);}
		},

		isValidNumber:function(n) {
			return !isNaN(parseFloat(n)) && isFinite(n) && n >= 0;
		},

		/**
		 * Validation method for advanced search form
		 */
		validateForm: function(form) {
			form["minPrice"].value = trim(form["minPrice"].value);
			form["maxPrice"].value = trim(form["maxPrice"].value);

			var minValue = form["minPrice"].value;
			var maxValue = form["maxPrice"].value;

			var minIsValid = this.isValidNumber(minValue);
			var maxIsValid = this.isValidNumber(maxValue);

			if(minValue.length > 0 && !minIsValid) {
				MessageHelper.formErrorHandleClient(form["minPrice"].id, MessageHelper.messages["EDPPaymentMethods_AMOUNT_NAN"]);
				return false;
			}
			else if(maxValue.length > 0 && !maxIsValid) {
				MessageHelper.formErrorHandleClient(form["maxPrice"].id, MessageHelper.messages["EDPPaymentMethods_AMOUNT_NAN"]);
				return false;
			}
			else if (minValue.length > 0 && maxValue.length > 0 && parseFloat(minValue) > parseFloat(maxValue)) {
				MessageHelper.formErrorHandleClient(form["maxPrice"].id, MessageHelper.messages["ERROR_PRICE_RANGE"]);
				return false;
			}
			
			form["searchTerm"].value = trim(form["searchTerm"].value);
			form["filterTerm"].value = trim(form["filterTerm"].value);
			form["manufacturer"].value = trim(form["manufacturer"].value);
			
			var searchTerm = form["searchTerm"].value;
			var filterTerm = form["filterTerm"].value;
			var manufacturer = form["manufacturer"].value;
			
			if (searchTerm.length == 0 && filterTerm.length == 0 && manufacturer.length == 0) {
				MessageHelper.formErrorHandleClient(form["searchTerm"].id, MessageHelper.messages["ERROR_EMPTY_SEARCH_FIELDS"]);
				return false;
			}
			
			processAndSubmitForm(form);
		},
		
		registerMouseDown: function() {
			if (this.mouseDownConnectHandle == null) {
				this.mouseDownConnectHandle = dojo.connect(document.documentElement, "onmousedown", this, "handleMouseDown");
		}
		},
		
		unregisterMouseDown: function() {
			if (this.mouseDownConnectHandle != null) {
				dojo.disconnect(this.mouseDownConnectHandle);
				this.mouseDownConnectHandle = null;
			}
		},

		handleMouseDown: function(evt) {
			var node = evt.target;
			if (node != document.documentElement) {
				var searchDropdown = document.getElementById("searchDropdown");
				var searchTerm = document.CatalogSearchForm.searchTerm;
				var close = true;
				while (node) {
					if (node == searchDropdown || node == searchTerm) {
						close = false;
						break;
					}
					node = node.parentNode;
				}
				if (close) {
					this.showAutoSuggest(false);
				}
			}
		}
	};

	/**
	 * Declares a new render context for the AutoSuggest display.
	 */
	wc.render.declareContext("AutoSuggest_Context",null,"");

	/**
	 * Declares a new render context for the Cached Suggestions.
	 */
	wc.render.declareContext("CachedSuggestions_Context",null,"");

	/**
	 * Declares a new refresh controller for Cached Suggestions
	 */
	wc.render.declareRefreshController({
	   id: "AutoSuggestCachedSuggestionsController",
	   renderContext: wc.render.getContextById("CachedSuggestions_Context"),
	   url: "",
	   formId: ""

	   /**
		* Retrieves the cached suggestions used in the autosuggest box.
		* This function is called when a render context changed event is detected.
		*
		* @param {string} message The render context changed event message
		* @param {object} widget The registered refresh area
		*/
	   ,renderContextChangedHandler: function(message, widget) {
			  var controller = this;
			  var renderContext = this.renderContext;
			  widget.refresh(renderContext.properties);
	   }

	   /**
		* Updates the cached suggestions.
		*
		* @param {object} widget The registered refresh area
		*/
	   ,postRefreshHandler: function(widget) {
			  var controller = this;
			  var renderContext = this.renderContext;
			  var response = document.getElementById('cachedSuggestions');
			  if(response == null) {
					 // No response or an error page.   Clear the contents.
					 document.getElementById("autoSuggestCachedSuggestions_div").innerHTML = "";
			  }
			  else {
					 var scripts = response.getElementsByTagName("script");
					 var j = scripts.length;
					 for (var i = 0; i < j; i++){
							var newScript = document.createElement('script');
							newScript.type = "text/javascript";
							newScript.text = scripts[i].text;
							document.getElementById('autoSuggestCachedSuggestions_div').appendChild (newScript);
					 }
					 SearchJS.retrievedCachedSuggestions = true;
					 var scrElement = document.getElementById("mobileSearchDropdown");
					 if (scrElement != null && scrElement.style.display == 'block')
					 {
						 searchTerm = document.getElementById("MobileSimpleSearchForm_SearchTerm").value;
					 }
					 else
					 {
						 searchTerm = document.CatalogSearchForm.searchTerm.value;
					 }
					 if(searchTerm.length > SearchJS.AUTOSUGGEST_THRESHOLD) {
							SearchJS.doStaticAutoSuggest(searchTerm);
					 }
			  }
	   }
	});

		/**
		 * Declares a new refresh controller for Auto Suggest
		 */
	wc.render.declareRefreshController({
		   id: "AutoSuggestDisplayController",
		   renderContext: wc.render.getContextById("AutoSuggest_Context"),
		   url: "",
		   formId: ""

		   /**
			* Displays the keyword suggestions from the search index
			* This function is called when a render context changed event is detected.
			*
			* @param {string} message The render context changed event message
			* @param {object} widget The registered refresh area
			*/
		   ,renderContextChangedHandler: function(message, widget) {
				  var controller = this;
				  var renderContext = this.renderContext;
				  widget.refresh(renderContext.properties);
		   }

		   /**
			* Display the results.
			*
			* @param {object} widget The registered refresh area
			*/
		   ,postRefreshHandler: function(widget) {
				  var controller = this;
				  var renderContext = this.renderContext;
				  var response = document.getElementById('suggestedKeywordResults');
				  var productsResponse = document.getElementById('suggestedProductsResults');
				  if(response == null && productsResponse == null) {
					// No response or an error page.   Clear the contents.
					document.getElementById("autoSuggestDynamic_Result_div").innerHTML = "";
				  }
				  SearchJS.showAutoSuggestIfResults();
		   }
	});

}
