// Sliding side panel
slidingAuthorDescription = function() {
	var myAuthorDesc = dojo.byId("authorDescription");
	var myAuthorDescTextInfos = dojo.position("authorDescText", true);
	var myAuthorHeight = myAuthorDescTextInfos.h + 45;
	var myToggleBtn = dojo.byId("authorToggle");
	var myAuthorInitialHeight = myAuthorDesc.offsetHeight;
	

	_on = require("dojo/on");
	_on(window, "resize", function() {
		myAuthorDescTextInfos = dojo.position("authorDescText", true);
		myAuthorHeight = myAuthorDescTextInfos.h + 45;
		if(dojo.hasClass(myToggleBtn, "show")){
			dojo.animateProperty({
				node:myAuthorDesc,
				properties: {
					height: myAuthorHeight
				}
			}).play();
		}
	});
	
	dojo.connect(myToggleBtn, "onclick", function(e) {
		if(dojo.hasClass(myToggleBtn, "show")){
			dojo.animateProperty({
				node:myAuthorDesc,
				properties: {
					height: myAuthorInitialHeight
				}
			}).play();
			dojo.removeClass(myToggleBtn, "show"); 
			dojo.removeClass("arrowAuthor", "open"); 
		}
		else {
			dojo.animateProperty({
				node:myAuthorDesc,
				properties: {
					height: myAuthorHeight
				}
			}).play();
			dojo.removeClass(myToggleBtn, "hide"); 
			dojo.addClass(myToggleBtn, "show");
			dojo.addClass("arrowAuthor", "open");
		}
	});
}

dojo.ready(function(){
	if(dojo.byId("authorDescription"))
		slidingAuthorDescription();
});
