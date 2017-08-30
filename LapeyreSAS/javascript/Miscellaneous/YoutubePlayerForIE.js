var youtubePlayer = (function () {
	
	var popupId = 'popupVideo',
	    videosQuery = '.youtubeVideo',
	    thumbQuery = '.thumb',
	    closeButtonQuery = '#youtubePlayerCloseButton',
	    playerId = 'youtubePlayer';
	
	return {
		
		init: function() {
			// Click handler on thumbnails
			// 1. Load video w/id, autoplay
			// 2. Show popup
			$.each($(videosQuery), function(i, video) {
				$(video).click(function(event) {
					var thumb = $(event.delegateTarget).children(thumbQuery);
					var videoId = null;
					if(thumb.data()){
						videoId = thumb.data().videoId; 
					} else {
						videoId = thumb.attr('alt'); 
					}
					
					var embedUrl = thumb.attr('data-embed-url');
					var ifr = document.getElementById(playerId);
					if(typeof(ifr) != 'undefined' && ifr != null) {
						ifr.contentWindow.location.replace(embedUrl);
						showPopup(popupId);
					}
				});
			});
			
			// Stop playback whenever popup is closed
			var popup = dijit.byId(popupId);
			$(closeButtonQuery).click(function(event) {
				hidePopup(popupId);
			});
			
			popup.connect(popup, "hide", function(e){
				var ifr = document.getElementById(playerId);
				if(typeof(ifr) != 'undefined' && ifr != null) {
					ifr.contentWindow.location.replace('/blank.jsp');
				}
			});
		}
	}
	
})();
