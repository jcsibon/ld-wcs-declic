<%@ page trimDirectiveWhitespaces="true"%>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- base sur ContentCarouselWidget --%>
<!-- div class="row"-->


<div class="meaBanniere col s12">
	<c:if test="${!empty meas[param.idx].titre}">
		<span class="titleBlock"> ${meas[param.idx].titre} </span>
	</c:if>

	<c:choose>
		<c:when test="${param.isHeaderMea }">
			<c:choose>
				<c:when test="${fn:length(meas[param.idx].bannieres) > 1}">
					<c:forEach items="${meas[param.idx].bannieres}" var="banniere"
						varStatus="status">
						<c:import
							url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
							<c:param name="type" value="${banniere.cible.type}" />
							<c:param name="lien" value="${banniere.cible.lien}" />
						</c:import>
						<div class="linkToArticle">
							<div class="backgroundContainer">
								<a href="${linkUrl}"><img alt="${banniere.visuelLarge.alt}"
									src="${imageUrl}${banniere.visuelLarge.url}" />
								</a>
							</div>
							<div class="title">
								<a href="${linkUrl}">${banniere.titre}<span>${banniere.sousTitre}</span>
								</a>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:when test="${fn:length(meas[param.idx].bannieres) == 1}">
					<c:import
						url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
						<c:param name="type"
							value="${meas[param.idx].bannieres[0].cible.type}" />
						<c:param name="lien"
							value="${meas[param.idx].bannieres[0].cible.lien}" />
					</c:import>
					<div class="linkToArticle">
						<div class="backgroundContainer">
							<a href="${linkUrl}"><img
								alt="${meas[param.idx].bannieres[0].visuelLarge.alt}"
								src="${imageUrl}${meas[param.idx].bannieres[0].visuelLarge.url}" />
							</a>
						</div>
						<div class="title">
							<a href="${linkUrl}">${meas[param.idx].bannieres[0].titre}<span>${meas[param.idx].bannieres[0].sousTitre}</span>
							</a>
						</div>
					</div>
				</c:when>
			</c:choose>
		</c:when>
		<c:otherwise>
		
		 <c:choose>
		        <c:when test="${fn:length(globalbreadcrumbsForTagManager.breadCrumbTrailEntryView) eq 0}">
		            <c:set var="bannerPage" value="Home"/>
		        </c:when>
		        <c:when test="${fn:length(globalbreadcrumbsForTagManager.breadCrumbTrailEntryView) eq 1}">
		            <c:set var="bannerPage" value="Univers"/>
		        </c:when>
		        <c:otherwise>
		            <c:set var="bannerPage" value="Famille"/>
		        </c:otherwise>
		    </c:choose>
		
			<c:choose>
				<c:when test="${fn:length(meas[param.idx].bannieres) > 1}">
					<!--  banniere "carrousel" -->

					<c:set var="carouselIdx" value="${carouselIdx+1}" scope="request" />
					<%-- l'idx increment� permet de g�rer le widget dojo, qui cr�e la pagination du carrousel sur la base de l'id HTML --%>
					<div id="contentCarouselWidgetmeaCarousel${carouselIdx}"
						class="contentCarouselWidget carousel"
						data-dojo-type="wc/widget/WCCarousel"
						data-dojo-props="speed:2000,auto:5000" lang="en"
						widgetid="contentCarouselWidgetmeaCarousel${carouselIdx}"
						dir="ltr">
						<div class="content" data-dojo-attach-point="content">
							<ul data-dojo-attach-point="ul"
								style="left: 0%; -webkit-transition: 2000ms; transition: 2000ms;">
								<c:forEach items="${meas[param.idx].bannieres}" var="banniere"
									varStatus="status">

									<c:choose>
										<c:when test="${isMobile && !empty banniere.visuelSmall.url}">
											<c:set var="altImg" value="${banniere.visuelSmall.alt}"/>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${meas[param.idx].largeur>=75 && !empty banniere.visuelLarge.url}">
													<c:set var="altImg" value="${banniere.visuelLarge.alt}"/>
												</c:when>
												<c:otherwise>
													<c:if test="${meas[param.idx].largeur>=33 && !empty banniere.visuelMedium.url}">
														<c:set var="altImg" value="${banniere.visuelMedium.alt}"/>
													</c:if>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>

									<c:import
										url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
										<c:param name="type" value="${banniere.cible.type}" />
										<c:param name="lien" value="${banniere.cible.lien}" />
										<c:param name="paramLien" value="origin=${bannerPage}-${altImg}" />
									</c:import>

									<li id="container_${status.index+1}"
										class="clickable hover_underline"
										onclick="javascript:window.location.assign('${linkUrl}');">
										<div class="left_espot">
											<div id="homeHero${status.index+1}"
												class="blockPresentation homeHero">
												<div id="homeHero${status.index +1}-background"
													class="homeHero-background" data-carousel-background=""
													style="${status.first?'-webkit-transition: 2000ms; transition: 2000ms;':'opacity: 0;'}">
													<c:choose>
														<c:when
															test="${isMobile && !empty banniere.visuelSmall.url}">
															<img id="homeHero${status.index+1}_img"
																alt="${banniere.visuelSmall.alt}"
																src="${imageUrl}${banniere.visuelSmall.url}" />
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when
																	test="${meas[param.idx].largeur>=75 && !empty banniere.visuelLarge.url}">
																	<img id="homeHero${status.index+1}_img"
																		alt="${banniere.visuelLarge.alt}"
																		src="${imageUrl}${banniere.visuelLarge.url}" />
																</c:when>
																<c:otherwise>
																	<c:if
																		test="${meas[param.idx].largeur>=33 && !empty banniere.visuelMedium.url}">
																		<img id="homeHero${status.index+1}_img"
																			alt="${banniere.visuelMedium.alt}"
																			src="${imageUrl}${banniere.visuelMedium.url}" />
																	</c:if>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</div>

												<div
													class="textContainer <c:if test="${((isMobile && empty banniere.sousTitreMobile) || (!isMobile && empty banniere.sousTitre))}">margin-bottom</c:if>">
													<c:choose>
														<c:when test="${isOnMobileDevice}">
															<h1 class="titleBanner">
																<ecocea:crop value="${banniere.titre}" length="38" />
															</h1>
														</c:when>
														<c:when test="${!isOnMobileDevice}">
															<h1 class="titleBanner">
																<ecocea:crop value="${banniere.titre}" length="61" />
															</h1>
														</c:when>
													</c:choose>
													<c:if
														test="${!empty banniere.titre && ((isMobile && !empty banniere.sousTitreMobile) || (!isMobile && !empty banniere.sousTitre))}">
														<img alt="separator"
															src="${jspStoreImgDir}images/separator.png">
													</c:if>
													<p id="homeHero${statut.index+1}-details"
														class="sousTitre truncate">${isMobile?banniere.sousTitreMobile:banniere.sousTitre}</p>

												</div>
												<c:if
													test="${!isMobile && banniere.cible.libelleBouton != null && banniere.cible.libelleBouton != ''}">
													<div class="buttonContainer">
														<a href="${linkUrl}" onclick="retrun false;" class="button">${banniere.cible.libelleBouton}</a>
													</div>
												</c:if>
											</div>
										</div></li>

								</c:forEach>
							</ul>
						</div>
						<div class="pageControl dot" id="pageControl"
							data-dojo-attach-point="pageControl">
							 <a href="#" title="Aller a la page {0}" data-id="{0}"></a>
						</div>
						<script>
                        	require(["dojo/ready"], function(ready){
	                            ready(function(){
	                                $("#pageControl > a").each(function( index ) {
	                                      $( this ).text($("#container_"+$( this ).attr("data-id")+" .button").text());
	                                });
	                              });
	                        });
                        </script>                
					</div>
				</c:when>
				<c:when test="${fn:length(meas[param.idx].bannieres) == 1}">
				
					<c:choose>
						<c:when 
							test="${isMobile && !empty meas[param.idx].bannieres[0].visuelSmall.url}">
							<c:set var="altImg" value="${meas[param.idx].bannieres[0].visuelSmall.alt}"/>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when 
									test="${meas[param.idx].largeur>=75 && !empty meas[param.idx].bannieres[0].visuelLarge.url}">
									<c:set var="altImg" value="${meas[param.idx].bannieres[0].visuelLarge.alt}"/>
								</c:when>
								<c:otherwise>
									<c:if 
										test="${meas[param.idx].largeur>=33 && !empty meas[param.idx].bannieres[0].visuelMedium.url}">
										<c:set var="altImg" value="${meas[param.idx].bannieres[0].visuelMedium.alt}"/>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					
					<c:import
						url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.meaWidget/meaWidget_lien_UI.jsp">
						<c:param name="type"
							value="${meas[param.idx].bannieres[0].cible.type}" />
						<c:param name="lien"
							value="${meas[param.idx].bannieres[0].cible.lien}" />
						<c:param name="paramLien" 
							value="origin=${bannerPage}-${altImg}" />
					</c:import>
					<div class="blockPresentation bannerContainer clickable"
						onclick="javascript:window.location.assign('${linkUrl}');">
						<div <c:choose>
								<c:when test="${isMobile && !empty meas[param.idx].bannieres[0].visuelSmall.url}">
									style="background-image: url('${imageUrl}${meas[param.idx].bannieres[0].visuelSmall.url}');" 
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when
											test="${meas[param.idx].largeur>=75 && !empty meas[param.idx].bannieres[0].visuelLarge.url}">
											style="background-image: url('${imageUrl}${meas[param.idx].bannieres[0].visuelLarge.url}');" 
										</c:when>
										<c:otherwise>
											<c:if
												test="${meas[param.idx].largeur>=33 && !empty meas[param.idx].bannieres[0].visuelMedium.url}">
												style="background-image: url('${imageUrl}${meas[param.idx].bannieres[0].visuelMedium.url}');" 
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose> class="editoBackground">
							<div class="flex flex-column textBannerContainer <c:if test="${((isMobile && empty meas[param.idx].bannieres[0].sousTitreMobile) || (!isMobile && empty meas[param.idx].bannieres[0].sousTitre))}">margin-bottom</c:if>">
								<c:choose>
									<c:when test="${isOnMobileDevice}">
										<h1 class="titleBanner">
											<ecocea:crop value="${meas[param.idx].bannieres[0].titre}"
												length="38" />
										</h1>
									</c:when>
									<c:when test="${!isOnMobileDevice}">
										<h1 class="titleBanner">
											<ecocea:crop value="${meas[param.idx].bannieres[0].titre}"
												length="61" />
										</h1>
									</c:when>
								</c:choose>
								<p class="sousTitreBanner truncate">${isMobile?meas[param.idx].bannieres[0].sousTitreMobile:meas[param.idx].bannieres[0].sousTitre}</p>
							</div>
							<c:if
								test="${!isMobile && meas[param.idx].bannieres[0].cible.libelleBouton != null && meas[param.idx].bannieres[0].cible.libelleBouton != ''}">
								<div class="buttonContainer">
									<a href="${linkUrl}" onclick="return false;" class="button">${meas[param.idx].bannieres[0].cible.libelleBouton}</a>
								</div>
							</c:if>

							<%-- 				<img alt="${(isMobile && !empty meas[param.idx].bannieres[0].visuelSmall.alt)?meas[param.idx].bannieres[0].visuelSmall.alt:(meas[param.idx].largeur>=75 && !empty meas[param.idx].bannieres[0].visuelLarge.alt)?meas[param.idx].bannieres[0].visuelLarge.alt:(meas[param.idx].largeur>=33 && !empty meas[param.idx].bannieres[0].visuelMedium.alt)?meas[param.idx].bannieres[0].visuelMedium.alt:meas[param.idx].bannieres[0].visuelSmall.alt}" 
					                       src="${imageUrl}${(isMobile && !empty meas[param.idx].bannieres[0].visuelSmall.url)?meas[param.idx].bannieres[0].visuelSmall.url:(meas[param.idx].largeur>=75 && !empty meas[param.idx].bannieres[0].visuelLarge.url)?meas[param.idx].bannieres[0].visuelLarge.url:(meas[param.idx].largeur>=33 && !empty meas[param.idx].bannieres[0].visuelMedium.url)?meas[param.idx].bannieres[0].visuelMedium.url:meas[param.idx].bannieres[0].visuelSmall.url}"> --%>
						</div>
					</div>
				</c:when>
			</c:choose>
		</c:otherwise>
	</c:choose>
</div>
<!-- /div-->
