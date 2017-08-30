<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<div class="mea-univers-home">
	<c:if test="${!empty meas[param.idx].titre}">
		<div class="mea-univers-home-title">
			<span>${meas[param.idx].titre}</span>
		</div>
	</c:if>
	<div class="row">
		<div class="mea-univers-container">
			<c:set var="count" value="${fn:length(meas[param.idx].contenus)}"/>
			<c:set var="elemPerColumn" value="${count/3}"/>
			<c:set var="columnCount" value="${-1}"/>
			
			<fmt:parseNumber var = "elemPerColumnInt" integerOnly = "true" type = "number" value = "${elemPerColumn}" />
			
			<!-- Get the fractional part, in order to calculate the right number per column when not multiple of 3 -->
			<c:set var="elemPerColumnFractional" value="${(elemPerColumn-elemPerColumnInt)*10}"/>
			<fmt:parseNumber var = "elemPerColumnFractionalInt" integerOnly = "true" type = "number" value = "${elemPerColumnFractional}" />
			
			<c:if test="${elemPerColumnFractionalInt > 0}">
				<c:set var="elemPerColumnInt" value="${elemPerColumnInt+1}"/>
			</c:if>
			
			<c:forEach var="contenu" items="${meas[param.idx].contenus}" varStatus="iter">
			
				<c:if test="${(iter.index+1) % elemPerColumnInt == 1}">
					<div class="mea-univers-column">
					<c:set var="columnCount" value="${columnCount+1}"/>
				</c:if>
				
				<div style="order: ${((iter.index) % elemPerColumnInt)+1};" data-col="${columnCount+1}" data-position="${((iter.index) % elemPerColumnInt)+1}" class="mea-univers-block">
					<c:if test="${contenu.template == '4' || contenu.template == '1'}">
						<div class="mea-free-html">${contenu.bodyDesktop}</div>
					</c:if>
					<c:if test="${contenu.template == '0' || contenu.template == '2' || contenu.template == '3'}">
						<div class="article" itemscope itemtype="${MICRO_DATA_ARTICLE}">
							
							<a class="hover_underline" href="${contenu.seo.url}">
								<div class="backgroundContainer article-content" >
									<img class="article-image responsive-img" itemprop="image" onerror="this.src='/wcsstore/LapeyreSAS/images/desktopList/defaultImage.png'" alt="${contenu.visuelMEA!=null?contenu.visuelMEA.alt:(contenu.visuelMea.alt!=null?contenu.visuelMea.alt:(contenu.visuelMobile!=null?contenu.visuelMobile.alt:contenu.visuelDesktop.alt))}" src="${imageUrl}${contenu.visuelMEA!=null?contenu.visuelMEA.url:(contenu.visuelMea.url!=null?contenu.visuelMea.url:(contenu.visuelMobile!=null?contenu.visuelMobile.url:contenu.visuelDesktop.url))}">
									<div class="article-text">
										<div class="article-type">${contenu.libelleType}</div>
										<h2 itemprop="headline" class="article-title" title="${contenu.titreMEA}">${contenu.titreMEA}</h2>
									</div>
								</div>
								
							</a>
							<meta itemprop="url" content=" ${env_absoluteUrlWithoutEndSlash }${contenu.url}"/>
							<meta itemprop="datePublished" content="${MICRO_DATA_TODAY}"/>
						</div>
					</c:if>
				</div>				
				<c:if test="${(iter.index+1) % elemPerColumnInt == 0 || (iter.index+1) == elemPerColumnInt}">
					</div>
				</c:if>	
				
			</c:forEach>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		
	    /* Calculate positions in tablet */
	    $(".mea-univers-container .mea-univers-block").each(function(key, value) {
	    	var addToCol = parseInt($(this).attr("data-position")) - 1;
	    	
	    	var col = parseInt($(this).attr("data-col"));
	    	var pos = parseInt($(this).attr("data-position"));
	    	
	    	col += addToCol;
	    	
	    	while(col >= 3) {
	    		col -= 2;
	    		pos ++;
	    	}
	    	
	    	$(this).attr("data-col-tablet", col);
	    	$(this).attr("data-position-tablet", pos);
	    });
	    
	    /* Calculate positions in mobile */
	    $(".mea-univers-container .mea-univers-block").each(function(key, value) {
	    	var addToCol = parseInt($(this).attr("data-position-tablet")) - 1;
	    	
	    	var col = parseInt($(this).attr("data-col-tablet"));
	    	var pos = parseInt($(this).attr("data-position-tablet"));
	    	
	    	col += addToCol;
	    	
	    	while(col >= 2) {
	    		col -= 1;
	    		pos ++;
	    	}
	    	
	    	$(this).attr("data-col-mobile", col);
	    	$(this).attr("data-position-mobile", pos);
	    });
	    		
		mediaPhone.addListener(function(changed) {
		    if(changed.matches) {
		    	reorganizeMeaUniverseMobile();
		    }
		});
		
		mediaTablet.addListener(function(changed) {
		    if(changed.matches) {
		    	reorganizeMeaUniverseTablet();
		    }
		});
		
		mediaDesktop.addListener(function(changed) {
		    if(changed.matches) {
		    	reorganizeMeaUniverseDesktop();
		    }
		});
		
		function reorganizeMeaUniverseDesktop() {
			$(".mea-univers-container .mea-univers-block").each(function(key, value) {
				  var pos = $(this).attr("data-position");
				  var col = $(this).attr("data-col");
				  
				  var column = $(".mea-univers-container > .mea-univers-column:nth-of-type("+col+")");
				  $(this).css("display", "block");
				  $(this).css("order", pos);
				  column.append($(this));
			});	
		}
		
		function reorganizeMeaUniverseTablet() {
			$(".mea-univers-container .mea-univers-block").each(function(key, value) {
				  var pos = $(this).attr("data-position-tablet");
				  var col = $(this).attr("data-col-tablet");
				  
				  var column = $(".mea-univers-container > .mea-univers-column:nth-of-type("+col+")");
				  $(this).css("order", pos);
				  column.append($(this));
				  
			});			
		}
		
		function reorganizeMeaUniverseMobile() {
			$(".mea-univers-container .mea-univers-block").each(function(key, value) {
				  var pos = $(this).attr("data-position-mobile");
				  var col = $(this).attr("data-col-mobile");
				  
				  var column = $(".mea-univers-container > .mea-univers-column:nth-of-type("+col+")");
				  if(pos>4) {
					  $(this).css("display", "none");
				  }
				  $(this).css("order", pos);
				  column.append($(this));
			});			
		}
		
		var myWinWidth = viewport().width;
		
		if(myWinWidth >= desktopBreakpoint) {
			reorganizeMeaUniverseDesktop();
		} else if (myWinWidth >= tabletBreakpoint) {
			reorganizeMeaUniverseTablet();
		} else {
			reorganizeMeaUniverseMobile();
		}
		
	});
</script>
