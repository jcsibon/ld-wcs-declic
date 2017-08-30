var youtubePlayer = (function () {
	
	var player = null,
	    popupId = 'popupVideo',
	    videosQuery = '.youtubeVideo',
	    thumbQuery = '.thumb',
	    closeButtonQuery = '#youtubePlayerCloseButton',
	    playerId = 'youtubePlayer',
	    youtubeApiURL = 'https://www.youtube.com/iframe_api',
	    self = this;
	
	function loadAPI() {
		var tag = document.createElement('script');
	    	tag.src = "https://www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
     		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	} 
	
	return {
		
		init: function() {
			
			// Load you tube API and callback init afterwards
			if (!window.YT) {
				loadAPI();
				window.onYouTubeIframeAPIReady = function() {
					youtubePlayer.init();
				}
				return;
			}
			
			// Init youtube player w/options
			var options = {}
			if (isMobileDevice()) {
				var w = $(window).innerWidth() - 58;
				var h = Math.floor(w *0.5625);
				options = {
						width: w,
						height: h
				}
			}
			player = new YT.Player(playerId, options);
			
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
					
					player.loadVideoById(videoId);
					showPopup(popupId);
				});
			});
			
			// Stop playback whenever popup is closed
			var popup = dijit.byId(popupId);
			$(closeButtonQuery).click(function(event) {
				hidePopup(popupId);
			});
			popup.connect(popup, "hide", function(e){
				if (player && player.stopVideo) {
					player.stopVideo();
				}
			});
		}
	}
	
})();
