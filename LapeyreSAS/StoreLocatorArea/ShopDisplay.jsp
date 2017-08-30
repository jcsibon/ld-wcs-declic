<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<div class="new-style shop-block">

	<div class="shop-block-info" id="shopBlockMain${shop.strLocId}">
		
		<div class="shop-block-info-title">
			<h3>
				<div class="truncate">
					<a class="hover_underline" title="${shop.name}" id="shopBlockLinkToMag${shop.strLocId}" href="${shop.seoUrl}">${shop.cp} - ${shop.name}</a>
				</div>
			</h3>
		</div>
		
		<div onclick="MapStoreLocatorJS.openInfoWindowById(${ecocea:quote(shop.strLocId)})" class="shop-block-info-description">
			<p>${shop.address1}</p>
			<p>${shop.address2}</p>
			<p>${shop.address3}</p>
			<p>${shop.address4}</p>
			<p>${shop.city}</p>
			<p>${ecocea:fmtPhone(shop.mainPhone)}</p>
		</div>
	</div>
	<div class="shop-block-links">
		<div class="shop-block-link">
			<c:choose>
				<c:when test="${not suiviCom}">
					<a href="${shop.seoUrl}">
				</c:when>
				<c:otherwise>
					<%
						String storeLocatorURL = ConfigTool.getConnectionPropertiesResource().getProperty("store.all.mag.url");
						request.setAttribute("storeLocatorURL","/"+storeLocatorURL);
					%>
					<a href="${storeLocatorURL}">		
				</c:otherwise>
			</c:choose>
				<span class="shop-block-link-underline">
					<fmt:message key="StoreLocVoirFiche" bundle="${storeText}" />
				</span>
				<%--span class="shopDistance">
					<c:set var="distance" value="${ecocea:toNumber(shop.distance)}" />
					<c:if test="${not empty shop.distance}">
						<c:choose>
							<c:when test="${distance < 1}">
								<fmt:formatNumber var="distance" value="${distance*1000}" maxFractionDigits="0" />
								<!-- formattedDistance: ${distance} -->
								<fmt:message key="StoreLocYAllerDistanceMetre" bundle="${storeText}" >
									<fmt:param value="${distance}" />
								</fmt:message>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber var="distance" value="${distance}" maxFractionDigits="1" />
								<!-- formattedDistance: ${distance} -->
								<fmt:message key="StoreLocYAllerDistance" bundle="${storeText}">
									<fmt:param value="${distance}" />
								</fmt:message>
							</c:otherwise>
						</c:choose>
					</c:if>
				</span --%>
			</a>
		</div>
		<div class="shop-block-link">
			<c:set var="classNameEpingler" value="aepingler" />
			<c:set var="epinglable" value="false" />			
			<c:set var="hrefEpingle" value="#" />
			
			<c:if test="${userType eq 'G' and shop.strLocId eq extendedUserContext.defaultStores[0].id}">
				<jsp:setProperty name="shop" property="favorite" value="${true}" />
			</c:if>
			
			<c:if test="${shop.favorite eq 'true'}">
				<c:set var="classNameEpingler" value="epingle" />
			</c:if> 
			
			<c:set var="addFavFunctName" value="${(shop.favorite) ? 'remove': 'add'}" />
			<c:set var="scriptOnClick" value="SearchShopsJS.${addFavFunctName}FavoriteMag('${shop.strLocId}', ${userType eq 'R'}); return false;" />

			<c:if test="${shop.retraitMagasin eq 'true' || shop.retraitDrive eq 'true' || shop.livraisonColissimo eq 'true' || shop.livraisonTransporteur eq 'true'}">
				<c:set var="epinglable" value="true" />
			</c:if>
			
			<c:if test="${epinglable eq 'false'}">
				<c:set var="hrefEpingle" value="#" />
				<c:set var="classNameEpingler" value="notepinglable" />
				<c:set var="scriptOnClick" value="return false;" />
			</c:if>
			
			
			<c:choose>
				<c:when test="${epinglable eq 'true'}">
					<a href="${hrefEpingle}" class="shop-block-button button-primary ${classNameEpingler}${shop.strLocId}" onclick="${scriptOnClick}">
						<c:if test="${shop.favorite eq 'true'}">
							<span class="shop-block-button-close"></span>
						</c:if>
						<c:if test="${shop.favorite  ne 'true'}">
							<fmt:message key="StoreLocEpinglagble" bundle="${storeText}" />
						</c:if>	
					</a>
				</c:when>
				
			</c:choose>
			
		</div>
	</div>
</div>


<!-- Quick Fix to keep the old style in old pages like StoreInfo.jsp -->
<div class="old-style shopBlock">

	<div class="left" id="shopBlockMain${shop.strLocId}">
		
		<h3>
			<div class="truncate">
				<a class="hover_underline" title="${shop.name}" id="shopBlockLinkToMag${shop.strLocId}" href="${shop.seoUrl}">${shop.name}</a>
			</div>
		</h3>
		<p>${shop.type} <%-- <c:if test="${shop.retraitDrive eq 'true'}"><img src="${jspStoreImgDir}images/logoDrive.png"></c:if> --%></p>
		<span class="shopBlocSeparator"></span>
		<p>${shop.address1}</p>
		<p>${shop.address2}</p>
		<p>${shop.address3}</p>
		<p>${shop.address4}</p>
		<p>${shop.cp} ${shop.city}</p>
		<p>${ecocea:fmtPhone(shop.mainPhone)}</p>
		<div class="transports">
			<c:if test="${not empty shop.access}" >
				<p>${shop.access}</p>
			</c:if>
			<c:if test="${empty shop.access && not empty shop.secondaryPhone}" >
				<c:forEach items="${shop.secondaryPhone}" var="secPhoneKey" varStatus="iter">
					<c:if test="${iter.count < 3}">
						<p>${secPhoneKey.key} : ${ecocea:fmtPhone(secPhoneKey.value)}</p>
					</c:if>
				</c:forEach>
			</c:if>
		</div>
	</div>
	<div class="right">
		<div class="row">
			<c:set var="classNameEpingler" value="aepingler" />
			<c:set var="epinglable" value="false" />			
			<c:set var="hrefEpingle" value="#" />
			
			<c:if test="${userType eq 'G' and shop.strLocId eq extendedUserContext.defaultStores[0].id}">
				<jsp:setProperty name="shop" property="favorite" value="${true}" />
			</c:if>
			
			<c:if test="${shop.favorite eq 'true'}">
				<c:set var="classNameEpingler" value="epingle" />
			</c:if> 
			
			<c:set var="addFavFunctName" value="${(shop.favorite) ? 'remove': 'add'}" />
			<c:set var="scriptOnClick" value="SearchShopsJS.${addFavFunctName}FavoriteMag('${shop.strLocId}', ${userType eq 'R'}); return false;" />

			<c:if test="${shop.retraitMagasin eq 'true' || shop.retraitDrive eq 'true' || shop.livraisonColissimo eq 'true' || shop.livraisonTransporteur eq 'true'}">
				<c:set var="epinglable" value="true" />
			</c:if>
			
			<c:if test="${epinglable eq 'false'}">
				<c:set var="hrefEpingle" value="#" />
				<c:set var="classNameEpingler" value="notepinglable" />
				<c:set var="scriptOnClick" value="return false;" />
			</c:if>
			
			<a href="${hrefEpingle}" class="${classNameEpingler}${shop.strLocId}" onclick="${scriptOnClick}">
				<c:choose>
					<c:when test="${epinglable eq 'true'}">
						<img src="${jspStoreImgDir}/images/shopBlockEpingle.png" alt="">
						<c:if test="${shop.favorite eq 'true'}">
							<fmt:message key="StoreLocEpingle" bundle="${storeText}" />
						</c:if>
						<c:if test="${shop.favorite  ne 'true'}">
							<fmt:message key="StoreLocEpinglagble" bundle="${storeText}" />
						</c:if>
						
					</c:when>
					<c:otherwise>
						<img src="${jspStoreImgDir}/images/shopBlockEpingleGrey.png" alt="">
					</c:otherwise>
				</c:choose>
				
			</a>
		</div>
		<div class="row">
			<c:choose>
				<c:when test="${not suiviCom}">
					<a href="#map-canvas" onclick="MapStoreLocatorJS.openPopupDirections(
						${ecocea:quote(shop.seoUrl)},
						${ecocea:quote(shop.strLocId)},
						${ecocea:quote(ecocea:escapeJS(shop.name))},
						${ecocea:quote(shop.type)},
						${ecocea:quote(ecocea:escapeJS(shop.address1))}, 
						${ecocea:quote(shop.cp)},
						${ecocea:quote(ecocea:escapeJS(shop.city))},
						${ecocea:quote(ecocea:fmtPhone(shop.mainPhone))},
						${ecocea:quote(shop.retraitDrive)},
						${shop.lat},
						${shop.lng})">
					</c:when>
				<c:otherwise>
					<%
						String storeLocatorURL = ConfigTool.getConnectionPropertiesResource().getProperty("store.all.mag.url");
						request.setAttribute("storeLocatorURL","/"+storeLocatorURL);
					%>
					<a href="${storeLocatorURL}">		
				</c:otherwise>
			</c:choose>
				<img src="${jspStoreImgDir}/images/shopBlockYaller.png" alt="">
				<fmt:message key="StoreLocYAller" bundle="${storeText}" />
				<%--span class="shopDistance">
					<c:set var="distance" value="${ecocea:toNumber(shop.distance)}" />
					<c:if test="${not empty shop.distance}">
						<c:choose>
							<c:when test="${distance < 1}">
								<fmt:formatNumber var="distance" value="${distance*1000}" maxFractionDigits="0" />
								<!-- formattedDistance: ${distance} -->
								<fmt:message key="StoreLocYAllerDistanceMetre" bundle="${storeText}" >
									<fmt:param value="${distance}" />
								</fmt:message>
							</c:when>
							<c:otherwise>
								<fmt:formatNumber var="distance" value="${distance}" maxFractionDigits="1" />
								<!-- formattedDistance: ${distance} -->
								<fmt:message key="StoreLocYAllerDistance" bundle="${storeText}">
									<fmt:param value="${distance}" />
								</fmt:message>
							</c:otherwise>
						</c:choose>
					</c:if>
				</span --%>
			</a>
		</div>
	</div>
</div>