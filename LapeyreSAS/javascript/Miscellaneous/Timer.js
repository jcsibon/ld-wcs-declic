var Timer = (function() {
	
	var timerHandle = null;
	
	function Timer() {
	}

	Timer.prototype.reset = function(timerfunc, delay) {
		if(timerHandle != null) {
			console.debug("Reseting timer for prevent multiple call");
			clearTimeout(timerHandle);
		}
		
		timerHandle = setTimeout(timerfunc, delay);
	}
	
	return Timer;
	
})();

var timer = new Timer();