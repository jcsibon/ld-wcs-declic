<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<div class="row mobile-hidden"  id="rateLabel" style="display:none">
	<span class="titleBlock">
		<fmt:message bundle="${widgetText}" key="avisClientMagasinTitle" />
	</span>
	<div class="nombreAvis" id="nbAvis">
	</div>
	<div id="notation" class="colContainer">
	</div>
</div>
<script>

		// Transpose une note magasin en note étoiles
		//
		//    rating : note magasin
		// maxRating : note maximale dans le système de notation du magasin (9)
		//  maxStars : note maximale dans le système de notation etoiles    (5)
		function toStarsRating(rating, maxRating, maxStars) {
			
			// Note sur 5, arrondie au centième
	  		var starsRating = Math.min(new Number((rating / maxRating * maxStars).toFixed(2)), maxStars);
	  		
	  		// Note sur 5, incrément de 0.5
	  		var starsHalfRoundedRating = Math.round(starsRating * 2) / 2;
	  		
	  		// Décomposition en nombre d'étoiles
	  		var nbOfFull  = starsHalfRoundedRating - starsHalfRoundedRating % 1;
  		    var nbOfHalf  = Math.round(starsHalfRoundedRating % 1);
  		    var nbOfEmpty = maxStars - nbOfFull - nbOfHalf;
	  		
	  		return {
				'rating': starsRating,
				'halfRoundedRating':  starsHalfRoundedRating,
				'nbOfFull': nbOfFull,
				'nbOfHalf':  nbOfHalf,
				'nbOfEmpty': nbOfEmpty
	  		}
		}

		<%-- Appel Ajax permettant de récupérer les différents avis sur le magasin --%>
		dojo.addOnLoad(function() {
			<%
				//
				String visitorBookUrl = ConfigTool.getConnectionPropertiesResource().getProperty("visitorsbook.ws.url");
				String scheme = pageContext.getRequest().getScheme();
				request.setAttribute("visitorBookUrl",scheme+"://"+visitorBookUrl);
			%>
			var url = "${visitorBookUrl}?webId=${mag.idMetier+2000}&callback=processJSON";
			
			$.getJSON(url, function( json ) {
				
				if (json.voteCount < 1) {
					$("#shopRatingGlobal").addClass("hide");
					$("#rateLabel").addClass("print-hidden");
					return;
				}
				
			  	var bestRating = 0, // Meileure note tous critères confondus
			  	     maxRating = 9, // Note maximale dans le système de notation du magasin
			  	      maxStars = 5; // Note maximale dans le système de notation etoiles
				
				//Affichage des notes
			  	var ratingBlock = "<div class=\"colBlock\">";
			  	
			  	$.each( json.ratings, function( index, val ) {
			  		
			  		// Note étoile
			  		var stars = toStarsRating(val.avgRating, maxRating, maxStars);
			  		
			  		// Meilleure note
			  		bestRating = Math.max(bestRating, stars.halfRoundedRating);
			  		
			  		// Libellé critère
			  		ratingBlock += "<p class=\"critere\"><span>" + val.label + "</span> (" + stars.rating.toString().replace('.', ',') + "/5)&nbsp;&nbsp;";
			  		
			  		//Affichage des étoiles pleines
				    for (i = 0; i < stars.nbOfFull; i++) {
				    	ratingBlock += "<img src=\"${jspStoreImgDir}/images/starFull.png\">";
				    }
			  		
				    //Affichage des demies-étoiles
				    for (i = 0; i < stars.nbOfHalf; i++) {
				    	ratingBlock += "<img src=\"${jspStoreImgDir}/images/starHalf.png\">";
				    }
				    
				    //Affichage des étoiles vides
				    for (i = 0; i < stars.nbOfEmpty; i++) {
				    	ratingBlock += "<img src=\"${jspStoreImgDir}/images/starEmpty.png\">";
				    }
				    
				    //Fin de ligne
				    ratingBlock += "</p>";
				    
				    //On rajoute une colonne tous les 3 labels	
				    if ( (index + 1) % 3 == 0 && index != json.ratings.length) {
				    	ratingBlock += "</div>";
				    	ratingBlock += "<div class=\"colBlock\">";
				    }
			    });
			  	
			  	// Affichage avis
			  	
					ratingBlock += "</div>";
					document.getElementById("notation").innerHTML += ratingBlock;
					document.getElementById("rateLabel").style.display="block";
					document.getElementById("nbAvis").innerHTML = json.voteCount + '&nbsp;<fmt:message bundle="${widgetText}" key="nbAvis" />';
	 				
					// Calcul largeur rating bar titre magasin
					var percent = Math.min(bestRating / 5 * 100, 100);
					document.getElementById("rating").style.width = percent.toFixed(0) + "%";
					
					// Metadata magasin
					$('#metadataBestRating').attr('content', maxStars);
					$('#metadataRatingValue').attr('content', bestRating);
					$('#metadataRatingCount').attr('content', json.voteCount);
			});

		});
	</script>