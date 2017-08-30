<div>
	<div class="row" id="ficheMagasin">
	<!-- EN-TÊTE  -->
		<div class="blockPresentation boutique">
			<div class="editoBackground">
				<c:if test="${isOnMobileDevice}"> 
					<img  itemprop="image" src="${imageUrl}${mag.imageMobile.url}" alt="${mag.imageMobile.alt}">
				</c:if> 
				<c:if test="${!isOnMobileDevice}">
					<img  itemprop="image" src="${imageUrl}${mag.imageLarge.url}" alt="${mag.imageLarge.alt}">
				</c:if>
			</div>
			<div class="textContainer">
				<h1 itemprop="legalName">
					<c:choose>	
						<c:when test="${isOnMobileDevice}">			
							<ecocea:crop value="${mag.titre}" length="45" />
						</c:when>
						<c:when test="${!isOnMobileDevice}">
							<ecocea:crop value="${mag.titre}" length="90" />		
						</c:when>
					</c:choose>
				</h1>
				<meta itemprop="brand" content="${storeName }"/>
			</div>
			<div class="shopRating" id="shopRatingGlobal">
				<div class="separtor"></div>
				<%-- <div class="rating_bar">
		MICRODATA RATING Commentés car non accessible en js		
<div class="rating_bar" itemprop="aggregateRating" itemscope itemtype="${MICRO_DATA_AGGREGATERATING}">
					<!-- div element that contains full stars with percentage width, which represents rating -->
					<div class="rating" id="rating" style="width: 0%;"></div>
					<meta itemprop="itemReviewed" content="${mag.titre}"/>
<!-- 					<meta id="metadataBestRating" itemprop="bestRating" content=""/> -->
<!-- 					<meta id="metadataRatingValue" itemprop="ratingValue" content=""/> -->
<!-- 					<meta id="metadataRatingCount" itemprop="ratingCount" content=""/>  -->
				</div> --%>
				<div class="separtor"></div>
			</div>
			<p class="shopType">
				<c:out value="${mag.type}" />
			</p>
			<div class="epinglage print-hidden">
				
				<wcbase:useBean id="shopDB" classname="com.lapeyre.declic.commerce.storelocator.beans.FullShopDataBean" scope="page">
					<c:set value="${mag.idMagasin}" target="${shopDB}" property="stlocId"/>
					<c:set value="${langId}" target="${shopDB}" property="languageId"/>
					<c:set value="${CommandContext}" target="${shopDB}" property="commandContext"/>
				</wcbase:useBean>
				
				<c:set var="epinglable" value="false" />
				<c:if test="${mag.modeLivraison['retraitMagasin'] eq 'true' || mag.modeLivraison['retraitDrive'] eq 'true' || mag.modeLivraison['livraisonColissimo'] eq 'true' || mag.modeLivraison['livraisonTransporteur'] eq 'true'}">
					<c:set var="epinglable" value="true"/>
					<c:set var="epinglableFiche" value="true" scope="request"/>
				</c:if>
				
				<c:set var="favorite" value="${false}"/>
				<c:if test="${shopDB.favorite or mag.idMagasin eq extendedUserContext.defaultStores[0].id}">
					<c:set var="favorite" value="${true}"/>
				</c:if>
				
					<c:choose>
						<c:when test="${not epinglable}">
				<a href="#" id="storeInfo${mag.idMagasin}" class="notepinglable${mag.idMagasin}" onclick="return false;">
						</c:when>
						<c:when test="${not favorite}">
				<a href="#" id="storeInfo${mag.idMagasin}" class="aepingler${mag.idMagasin}" onclick="SearchShopsJS.addFavoriteMag('${mag.idMagasin}', ${userType eq 'R'});return false;">
						</c:when>
						<c:when test="${favorite}">
				<a href="#" id="storeInfo${mag.idMagasin}" class="epingle${mag.idMagasin}" onclick="SearchShopsJS.removeFavoriteMag('${mag.idMagasin}', ${userType eq 'R'});return false;">
						</c:when>
					</c:choose>
					<img src="${jspStoreImgDir}/images/shopPin.png" alt="">
				</a>
				
			</div>
			<c:choose>
				<c:when test="${not epinglable}">
					<p id="aepingler${mag.idMagasin}Label" class="epinglageText"></p>
				</c:when>
				<c:when test="${not favorite}">
					<p id="aepingler${mag.idMagasin}Label" class="epinglageText" >
						<fmt:message bundle="${widgetText}" key="EPINGLER"/>
					</p>
					<p id="epingle${mag.idMagasin}Label" class="epinglageText" style="display:none">
						<fmt:message bundle="${widgetText}" key="EPINGLE"/>
					</p>
				</c:when>
				<c:when test="${favorite}">
					<p id="aepingler${mag.idMagasin}Label" class="epinglageText" style="display:none">
						<fmt:message bundle="${widgetText}" key="EPINGLER"/>
					</p>
					<p id="epingle${mag.idMagasin}Label" class="epinglageText" >
						<fmt:message bundle="${widgetText}" key="EPINGLE"/>
					</p>
				</c:when>
			</c:choose>
		</div>
	</div>
	<!-- FIN EN-TÊTE  -->
	
	<!-- ZONE DE CONTACT -->
	<div class="row" id="shopCoordonneesContainer">
	
		
		<c:set var="col1Class" value="col4 push2 bcol12 bpush0" />
		<c:set var="col2Class" value="col5 push1 bcol12 bpush0" />
		<c:if test="${!empty mag.adresse['acces']}">
			<c:set var="col1Class" value="col3 push1 bcol12 bpush0" />
			<c:set var="col2Class" value="col3 push1 bcol12 bpush0" />
		</c:if>
		
		<div class="${col1Class} shopCoordonnees" itemprop="address" itemscope itemtype="${MICRO_DATA_POSTALADDRESS}">
			<c:out value="${mag.adresse.numVoie}" />
			<br>
			<c:if test="${!empty mag.adresse.compl1 || !empty mag.adresse.compl2 || !empty mag.adresse.compl3}">
			<ul class="complementaryAddressList">
				<c:if test="${!empty mag.adresse.compl1}"><li><c:out value="${mag.adresse.compl1}" /></li></c:if>
				<c:if test="${!empty mag.adresse.compl2}"><li><c:out value="${mag.adresse.compl2}" /></li></c:if>
				<c:if test="${!empty mag.adresse.compl3}"><li><c:out value="${mag.adresse.compl3}" /></li></c:if>
			</ul>
			</c:if>
			<span itemprop="postalCode"><c:out value="${mag.adresse.codePostal}" /></span>
			<span itemprop="addressLocality"><c:out value="${mag.adresse.ville}" /></span>
			<span style="display:none;" itemprop="streetAddress">
				<c:out value="${mag.adresse.numVoie}" />
				<c:out value="${mag.adresse.compl1}" />
				<c:out value="${mag.adresse.compl2}" />
				<c:out value="${mag.adresse.compl3}" />
			</span>
			<span style="display:none;" itemprop="addressCountry" itemscope itemtype="${MICRO_DATA_COUNTRY}" >
				<meta itemprop="name" content="France"/>
			</span>
		</div>
		
		<hr class="bHorizontalDivider" />
		
		<div class="${col2Class} shopCoordonnees">
			<div class="mobile-hidden">
				<c:forEach var="num" items="${mag.contactsTelephoniques}">
					<c:choose>
						<c:when test="${num.defaut}">
							<p> <span class="bold"><c:out value="${num.libelle}" /> </span> : <span itemprop="telephone"><fmt:formatNumber pattern="##,##,##,##,##" value="${num.numero}" type="number" minIntegerDigits="10"/>&nbsp;${num.mentionLegale}</span> <br> </p>
						</c:when>
						<c:otherwise>
							<span class="bold"><c:out value="${num.libelle}" /> </span> : <span itemprop="telephone"><fmt:formatNumber pattern="##,##,##,##,##" value="${num.numero}" type="number" minIntegerDigits="10"/>&nbsp;${num.mentionLegale}</span> <br>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="shopContact desktop-hidden">
				<%-- N° de téléphone principal --%>
				<c:forEach var="num" items="${mag.contactsTelephoniques}">
					<c:if test="${num.defaut}">
						<a href="tel:${num.numero}" class="mainPhone" onclick="dataLayer.push({'event':'appelMagasin'}); return true;">
							<span class="bold"><c:out value="${num.libelle}" /></span> : <span itemprop="telephone"><fmt:formatNumber pattern="##,##,##,##,##" value="${num.numero}" type="number" minIntegerDigits="10"/>&nbsp;${num.mentionLegale}</span>
						</a>
					</c:if>
				</c:forEach>
				<%--Suite des numéro de téléphone en mobile --%>
				<c:forEach var="num" items="${mag.contactsTelephoniques}">
					<c:if test="${!num.defaut}">
						<a href="tel:${num.numero}">
							<span class="bold"><c:out value="${num.libelle}"/></span> : <fmt:formatNumber pattern="##,##,##,##,##" value="${num.numero}" type="number" minIntegerDigits="10"/><br/>
						</a>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<c:if test="${!empty mag.adresse['acces']}">
			<c:set var="col3Class" value="col3 push1"/>
			<div class="${col3Class} mobile-hidden shopCoordonnees">
				<span class="bold"><fmt:message bundle="${widgetText}" key="TRANSPORT_ACCESS" /></span><br>
				<c:out value="${mag.adresse['acces']}" escapeXml="false"; />
			</div>
		</c:if>
	</div>
	
	<script type="text/javascript">
		//TODO à revoir pour le positionnement 
		function FindXY(obj) {
			var x = 0;
			var y = 0;
			var s = obj.className;
			while ( obj && !isNaN(obj.offsetLeft) && !isNaN(obj.offsetTop)) {
				x += obj.offsetLeft;
				y += obj.offsetTop;
				obj = obj.offsetParent;
			}
			return {
				x : x,
				y : y
			};
		}
	
		function popover(elem, id) {
			var popover = document.getElementById(id);
			if (popover.style.display == "block") {
				popover.style.display = "none";
	
			} else {
				popover.style.display = "block";
				var img = $(elem).children('img');
				var left = Math.floor(img.offset().left + img.width()/2 - $('#' + id).offset().left);
				$('#' + id + ' .arrow').css('left', left + 'px');
			}
		}
	</script>
		
	<div class="row padding-bottom shopContact">
		<wcf:url var="contactUrl" patternName="ContactPageURL" value="ContactPageView">
			<wcf:param name="storeId"   value="${storeId}"  />
			<wcf:param name="catalogId" value="${catalogId}"/>
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
		<c:url var="contactViewUrl" value="${contactUrl}" >
			<c:param name="formName" value="contactServiceClient"/>
			<c:param name="idMagasin" value="${mag.idMetier}"/>
		</c:url>
		
		<div class="col12">
			<c:if test="${! empty mag.contactsEmail}"><a class="button" href="${contactViewUrl}"><fmt:message bundle="${widgetText}" key="MAIL_TO"/></a></c:if>
			<div class="shareShopContact">
				<a class="shareIcon" href="javascript:void(0);" tabindex="0" onclick="popover(this,'popoverSocial');">
					<img alt=""	src="${jspStoreImgDir}images/shareShopContact.png">
				</a>
				<c:if test="${!empty mag.qrCode}">
					<a href="#QR-code" class="mobile-hidden"><img alt="${mag.qrCode.alt}" src="${jspStoreImgDir}images/shareShopContactQR.png"></a>
					<script type="text/javascript">
						$(document).ready(function(){
							$('a[href="#QR-code"]').click( function() {
								var target = $(this).attr('href');
								$('html, body').animate( { scrollTop: $(target).offset().top - 120 }, 200 );
								return false;
							});
						});
					</script>
				</c:if>
				<fmt:message bundle="${widgetText}" key="PRINT_MAG" var="print"/>
				<a href="javascript:window.print();" class="mobile-hidden"><img alt="${print}" src="${jspStoreImgDir}images/shareShopContactPrint.png"></a>
				<%-- mantis 3202 : supprimer l'affichage des cooredonnees GPS
				<c:if test="${fn:length(mag.solutionsGps)>0}">
					<a href="#" onclick="javascript:showPopup('gpsButtonsPopin'); return false;"><img alt="GPS" src="${jspStoreImgDir}images/shareShopContactGPS.png"></a>
				</c:if> --%>
			</div>
			
			<%-- popup réseaux sociaux --%>
			<div class="popover fade bottom in" role="tooltip" id="popoverSocial" style="display:none; margin-top:0px;">
				<div class="arrow" style="left: 50%;"></div>
				<c:set var="socialNetworksWidgetPath" value="../../Widgets-lapeyre/Common/SocialNetworks/SocialNetworks.jsp"/>
				<div class="popover-content">
					<c:import url="${socialNetworksWidgetPath}">
						<c:param name="classToApply" value="ficheSocialNetworks shareSocialNetwork" />
						<c:param name="rootPath" value="${jspStoreImgDir}" />
					</c:import>
				</div>
			</div>
		</div>
		
		
	</div>
</div>
<!-- FIN ZONE DE CONTACT -->