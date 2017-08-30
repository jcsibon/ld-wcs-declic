$(document).ready(function(){
	//on remonte de 80px pour afficher le titre sous le header
	window.onhashchange = function () {
	    $(window).scrollTop( $(window).scrollTop() - 80 );
	}	
	
	 $(".anchorNav a").click(function (e) {
	        e.preventDefault(); 
	        //on retire l'ancre de l'url pour d�clencher lehashchange
	        window.history.pushState("", document.title, window.location.pathname);
	 });
});


addRemoveToggleClass = function() {
    toggleOrNotToggle = function () {
        var myWinWidth = viewport().width;
        if(myWinWidth <= 800) {
            require(["dojo/query"], function(query){
                var nl = query(".titleBlock");
                nl.forEach(function(node){
                    dojo.addClass(node, "toggle");
                });
            });
        }
        else {
            require(["dojo/query"], function(query){
                var nl = query(".titleBlock");
                nl.forEach(function(node){
                    dojo.addClass(node, "toggle");
                });
            });
        }
    };
    toggleOrNotToggle();
    _on = require("dojo/on")
    _on(window, "resize", function() { 
        toggleOrNotToggle();
    })
}
dojo.ready(function(){
    addRemoveToggleClass();
});