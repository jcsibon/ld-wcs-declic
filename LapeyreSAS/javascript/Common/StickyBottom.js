/**
 *  - DEPRECATED -
 * ajout panier/wishlist en mobile de la fiche produit
 */
stickyNavFooterMobile = function() {
	var anchor = dojo.byId('highlight');
	var anchorInfo = dojo.position(anchor, true);
	var stickyNavTop = anchorInfo.y -screen.height;
	var scrollTop = dojo._docScroll().y;
	
	dojo.connect(window, 'onscroll', this, function(event) {
		scrollTop = dojo._docScroll().y;
		stickyNavMobile();
	});
	
	dojo.connect(window, 'click', this, function(event) {
		scrollTop = dojo._docScroll().y;
		stickyNavMobile();
	});
	
	dojo.connect(window, 'resize', this, function(event) {
		scrollTop = dojo._docScroll().y;
		stickyNavMobile();  
	});
	
	var stickyNavMobile = function(){
			anchorInfo = dojo.position(anchor, true);
			stickyNavTop = anchorInfo.y-screen.height;
		
			var mobileAction = dojo.byId('mobileActionFooter');
			var mobileActionInfo = dojo.position(mobileAction, true);
			var popinBottom = -(mobileActionInfo.y-dojo._docScroll().y-screen.height);
			
			if (scrollTop > stickyNavTop) { 
				if(scrollTop-stickyNavTop > 50){
					dojo.query("#mobileActionFooter").removeClass("stickyBottom"); 
				}
				require(["dojo/dom", "dojo/dom-style"], function(dom, domStyle){
					domStyle.set(dom.byId("MiniShopCartProductAddedWrapper"), "bottom", popinBottom+"px");
					domStyle.set(dom.byId("WishlistPopinAddedWrapper"), "bottom", popinBottom+"px");
				});
			} else {
				dojo.addClass(byId('mobileActionFooter'), "stickyBottom");
				require(["dojo/dom", "dojo/dom-style"], function(dom, domStyle){
					domStyle.set(dom.byId("MiniShopCartProductAddedWrapper"), "bottom", "50px");
					domStyle.set(dom.byId("WishlistPopinAddedWrapper"), "bottom", "50px");
				});
			}
	};  
	
	stickyNavMobile();
};
