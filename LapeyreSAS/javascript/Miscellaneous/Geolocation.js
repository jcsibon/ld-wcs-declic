/* *
 * 
 * Le module Geolocation permet de g�rer les appels � la fonctionnalit� de g�olocalisation.
 * 
 * - La position de l'utilisateur est mise en cache.
 * - Un �v�nement est publi� sur le sujet 'Geolocation.onPositionSucceed' lorsque la position de l'utilisateur est r�solue
 * - Un �v�nement est publi� sur le sujet 'Geolocation.onPositionFailed' lorsque la g�olocalisation a �chou�e.
 *  
 * */



/* *
 * GeolocationCache
 */
function GeolocationCache() {
	
	var position = null;
	var positionKey = 'position';
	var positionError = null;
	var positionErrorKey = 'positionError';
	
	/* private */
	function storeObject(name, value) {
		require(['dojo/cookie'], function(cookie) {
		   cookie(name, JSON.stringify(value));
		});
	}
	
	/* private */
	function readObject(name) {
		var cookieValue;
		require(['dojo/cookie'], function(cookie) {
			cookieValue = cookie(name);
		});
		return cookieValue === undefined ? cookieValue : JSON.parse(cookieValue);
	}
	
	/* privileged */
	this.isEmpty = function() {
		return !(this.hasPositionError() || this.hasPosition());
	}
	
	/* privileged */
	this.hasPosition = function() {
		return this.getPosition() !== undefined;
	}
	
	/* privileged */
	this.getPosition = function() {
		if (position === null) {
			position = readObject(positionKey);
		}
		return position;
	}
		
	/* privileged */
	this.setPosition = function(pos) {
		position = pos;
		storeObject(positionKey, {
			timestamp: pos.timestamp,
			coords: {
				latitude: pos.coords.latitude,
				longitude: pos.coords.longitude,
				// altitude: pos.coords.altitude,
				// accuracy: pos.coords.accuracy,
				// altitudeAccuracy: pos.coords.altitudeAccuracy,
				// heading: pos.coords.heading,
				// speed: pos.coords.speed
			}
		});
	}
	
	/* privileged */
	this.hasPositionError = function() {
		return this.getPositionError() !== undefined;
	}
	
	/* privileged */
	this.getPositionError = function() {
		if (positionError === null) {
			positionError = readObject(positionErrorKey);
		}
		return positionError;
	}
	
	/* privileged */
	this.setPositionError = function(posError) {
		positionError = posError;
		storeObject(positionErrorKey, true);
	}

	/* privileged */
	this.clear = function() {
		position = null;
		positionError = null;
		require(['dojo/cookie'], function(cookie) {
			cookie(positionKey, null, {expires: -1});
			cookie(positionErrorKey, null, {expires: -1});
		});
	}
}

/* public static */
GeolocationCache.firstCall = true;



/* *
 * Geolocation
 */
function Geolocation() {
	
	var successCallback = null;
	var successHandle = null;
	var errorCallback = null;
	var errorHandle = null;
	var cache = new GeolocationCache();
	
	/* private */
	function customSuccessCallback(position) {
		if (successCallback != null) {
			successCallback(position);
		}
		cache.setPosition(position);
		dojo.publish('Geolocation.onPositionSucceed', position);				
	};
	
	/* private */
	function customErrorCallback(positionError) {
		if (errorCallback != null) {
			errorCallback(positionError);
		}
		if (positionError.code && positionError.code === 1) {
			cache.setPositionError(positionError);
		}
		dojo.publish('Geolocation.onPositionFailed', positionError);
	};
	
	/* privileged */
	this.unavailable = function(fallback) {
		if (!navigator.geolocation) {
			console.log('[Geolocation] navigator.geolocation is undefined');
			fallback();
		}
		return this;
	}
	
	/* privileged */
	/* Force l'appel � navigator.geolocation.getCurrentPosition, par cons�quence rafra�chit le cache */
	this.askForPosition = function(success, error, options) {
		successCallback = success;
		errorCallback = error;
		if (navigator.geolocation) {
			cache.clear();
			console.log('[Geolocation] navigator.geolocation.getCurrentPosition called');
			navigator.geolocation.getCurrentPosition(customSuccessCallback, customErrorCallback, options);
		}
		return this;
	};
	
	/* privileged */
	/* �x�cute le callback <success|error> en fournissant la <position|positionError> en cache,
	 * appelle askForPosition si le cache est vide */
	this.getCurrentPosition = function(success, error, options) {
		
		successCallback = success;
		errorCallback = error;
		
		// On est obligé d'utiliser ask for postition pour le premier appel
		/*if (cache.isEmpty() && GeolocationCache.firstCall) {
			console.log('[Geolocation] cache is empty, asking for position');
			GeolocationCache.firstCall = false;
			return this.askForPosition(success, error, options);
		}*/
		
		// Tous les autres appels
		
		// PositionError en cache
		if (cache.hasPositionError()) {
			console.log('[Geolocation] positionError retrieved from cache');
			customErrorCallback(cache.getPositionError());
			return this;
		}
		
		// Position en cache
		if (cache.hasPosition()) {
			console.log('[Geolocation] position retrieved from cache: %s, %s', cache.getPosition().coords.latitude, cache.getPosition().coords.longitude);
			customSuccessCallback(cache.getPosition());
			return this;
		}
			
		// Le cache est vide
		// Les callbacks sont mis en attente de r�solution de la g�olocalisation
		successHandle = dojo.subscribe('Geolocation.onPositionSucceed', function(position) {
			successHandle.remove();
			if (success != null) {
				success(position);
			}
		});
		
		errorHandle = dojo.subscribe('Geolocation.onPositionFailed', function(positionError) {
			errorHandle.remove();
			if (error != null) {
				error(positionError);
			}
		});
		
		return this;
	}
    
	/* privileged */
    this.getResolvedPosition = function() {
        return cache.hasPosition() ? cache.getPosition() : undefined;
    }
}


dojo.subscribe('Geolocation.onPositionSucceed', function(position) {
	console.log('[Geolocation] onPositionSucceed event received: %s, %s', position.coords.latitude, position.coords.longitude);
});

dojo.subscribe('Geolocation.onPositionFailed', function(positionError) {
	console.log('[Geolocation] onPositionFailed event received');
});
