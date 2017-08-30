/**
 * Manage the "full image" widget slider
 */

ProductFullImageJS = {

	numberOfThumbnails: 0,

	numberOfThumbnailByPage: 1,
	
	heightOfAThumbnail: 0,
	
	isMobile: false,
	
	marginType: 'marginTop',
	
	currentAngleImgId: 'productAngleLi0',
	
	init: function(numberOfThumbnails, numberOfThumbnailByPage, heightOfAThumbnail, isMobile) {
		this.numberOfThumbnails = numberOfThumbnails;
		this.numberOfThumbnailByPage = numberOfThumbnailByPage;
		this.heightOfAThumbnail = heightOfAThumbnail;
		this.isMobile = isMobile;

		ProductFullImageJS.imageViewer(numberOfThumbnails, numberOfThumbnailByPage, heightOfAThumbnail, isMobile);
	},
	
	imageViewer: function(numberOfThumbnails, numberOfThumbnailByPage, heightOfAThumbnail, isMobile) {
		
		require(["dojo/on", "dojo/dom", "dojo/dom-attr","dojo/dom-style", "dojo/mouse", "dojo/query", "dojo/dom-class"],
		function(on, dom, domAttr, domStyle, mouse, query, domClass) {
			
	        var sliderWrapper = query(".fullImage-slider-wrapper-in")[0];
	        var currentPage = 0;
	        var maxPage = Math.ceil(numberOfThumbnails / numberOfThumbnailByPage) - 1;
	        var theoricMargin = 0;
	        var adjustMargin = 0;
	        var marginType;
	        var wrapperDimension;
	        
	        
	        if (isMobile) {
	        	wrapperDimension = 'width'; 
	        	marginType = 'marginLeft';
	        	// An adjustment is required on mobile to display well the thumbnails
	        	adjustMargin = -7;
	        } else {
	        	wrapperDimension = 'height';
	        	marginType = 'marginTop';
	        }
	        
	        // Init the wrapper dimension
	        domStyle.set(sliderWrapper, wrapperDimension, ((numberOfThumbnailByPage+1) * (maxPage + 1) * heightOfAThumbnail) + "px");
	       
	        /**
	         * Move the slider according to the direction
	         */
	        function ProductSliderMove(direction ) {
	        		        	
	        	if (currentPage >= maxPage && direction < 0) {
	        		domStyle.set(sliderWrapper, marginType, "0px");
	        		theoricMargin = 0;
	        		currentPage = 0;
	        	} else if (currentPage == 0 && direction > 0) {
	        		domStyle.set(sliderWrapper, marginType, (- maxPage * heightOfAThumbnail * numberOfThumbnailByPage + adjustMargin) + "px");
	        		theoricMargin = -maxPage * heightOfAThumbnail*numberOfThumbnailByPage;
	        		currentPage = maxPage;
	        	} else {	        		
	        		domStyle.set(sliderWrapper, marginType, (theoricMargin + heightOfAThumbnail * numberOfThumbnailByPage * direction + adjustMargin) + "px");
	        		theoricMargin = theoricMargin + heightOfAThumbnail * numberOfThumbnailByPage * direction;
	        		currentPage += - direction;
	        	}
	        }
	        
	        // Previous button behavior
	        var previous = dom.byId("fullImagePrevious");	        
	        if(previous != undefined) {
		        on(previous, "click", function() {
		        	ProductSliderMove(1);
		        });
	        }
	        
	        // Next button behavior
	        var next = dom.byId("fullImageNext");
	        if(next != undefined) {
		        on(next, "click", function() {		        	
		        	ProductSliderMove(-1);
		        });
	        }
	        
	        // Add event listener on thumbnails container
	        var hiddenClass = 'hidden';
	        var selectedClass = "thumbnail-selected";
	        var thumbnails = query(".fullImage-thumbnails-container");
	        on(thumbnails, "click", function(){	
				// Display image in the main container
				if (domAttr.get(this, "data-type") === "image") {
					domClass.add(dom.byId("fullImageVideoContainer"), hiddenClass);
    				domClass.remove(dom.byId("fullImageImageContainer"), hiddenClass);
    			} 
				// Display video in the main container
				else if (domAttr.get(this, "data-type") === "video" && !domClass.contains(this, selectedClass)) {					
    				domClass.remove(dom.byId("fullImageVideoContainer"), hiddenClass);
    				domClass.add(dom.byId("fullImageImageContainer"), hiddenClass);
    				domAttr.set(dom.byId("youtubePlayer"), "src", domAttr.get(query("img", this)[0], "data-embed-url"));
    			}
				// Highlight the selected thumbnail
				thumbnails.removeClass(selectedClass);
	            domClass.add(this, selectedClass);
	        });
		});
	},
	
	changeThumbNail: function (imgsrc, displayType, imageZoomsrc) {
		dojo.byId("productMainImage"+displayType).src = imgsrc;
        dojo.byId("productMainImage" + displayType + "Preview").src = imageZoomsrc;
    }
}

