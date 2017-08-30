<wcf:url var="Logon_LogoutURLNearestShop" value="LogonForm">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${storeId}" />
  <wcf:param name="catalogId" value="${catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
<c:if test="${empty isAll || isAll == false}">
	<span class="titleBlock"><fmt:message key="StoreLocMagasinsProchesBlockTitle" bundle="${storeText}" />
		<span class="grayPin"></span>
	</span>
</c:if>
<c:if test="${isAll == true}">
	<span class="titleBlock"> ${fn:length(nearestShops)} <fmt:message key="StoreLocAllShopsBlockTitle" bundle="${storeText}" />
		<span class="grayPin"></span>
	</span>
</c:if>
<p id="nearestShopErrorMessage" data-noresults="<fmt:message key="noStoreResultMessage" bundle="${storeText}" />" data-affine="<fmt:message key="StoreLocatorPleaseSpecify" bundle="${storeText}" />">
	<c:if test="${empty nearestShops || fn:length(nearestShops) eq 0}">
		<fmt:message key="noStoreResultMessage" bundle="${storeText}" var="noStoreResultMessage"/>
		<c:out value="${noStoreResultMessage}"/>
	</c:if>
</p>
<c:if test="${!empty nearestShops && fn:length(nearestShops) gt 0}">
	<div class="shopContainer">
		<c:forEach items="${nearestShops}" var="shop">
			<%@include file="ShopDisplay.jsp" %>
		</c:forEach>
	</div>
</c:if>

<div id="nearestShopsScript">
	<script>
			<c:set var="hasFavorite" value="false" />
			function getFavoritesAndFirstShop(){
				if(typeof MapStoreLocatorJS != "undefined"){
					<c:forEach items="${nearestShops}" var="shop" varStatus="status">
						<c:set var="hasFavorite" value="${hasFavorite ? hasFavorite : shop.favorite}" />
						<c:choose>
						<c:when test="${status.first}">
							<c:set var="firstShopId" value="${shop.strLocId}" />
						</c:when>
						<c:when test="${status.count==2}">
						<c:set var="secondShopId" value="${shop.strLocId}" />
						</c:when>
<%-- 						<c:when test="${status.count==3}">
						<c:set var="thirdShopId" value="${shop.strLocId}" />
						</c:when> --%>
						</c:choose>
					</c:forEach>
				}
			}
			<c:if test="${not empty firstShopId}">
				if(typeof MapStoreLocatorJS != "undefined"){
					MapStoreLocatorJS.centerToRightShopSearch = function(){
						var shopId = '<c:out value="${firstShopId}" />';
						var shopId2 = '<c:out value="${secondShopId}" />';
						MapStoreLocatorJS.centerToShopById('\''+shopId+'\'');
						MapStoreLocatorJS.openInfoWindowById('\''+shopId+'\'');
						if(shopId2!='') MapStoreLocatorJS.setZoom(9);
		 				else MapStoreLocatorJS.setZoom(14);
					}
				}
				<c:if test="${hasFavorite eq 'false'}">
					<c:choose>
						<c:when test="${fn:length(extendedUserContext.defaultStores) > 0}">
							<c:set var="shopIdToCenter" value="${extendedUserContext.defaultStores[0].id}" />
						</c:when>
						<c:otherwise>
							<c:if test="${not empty firstShopId}">
								<c:set var="shopIdToCenter" value="${firstShopId}" />
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:if test="${not empty shopIdToCenter}">
						if(typeof MapStoreLocatorJS != "undefined"){
							MapStoreLocatorJS.centerToRightShop = function(){
								var shopId = '<c:out value="${shopIdToCenter}" />';
								MapStoreLocatorJS.centerToShopById('\''+shopId+'\'');
								MapStoreLocatorJS.openInfoWindowById('\''+shopId+'\'');
								MapStoreLocatorJS.setZoom(14);
							}
						}
					</c:if>
				</c:if>				
			</c:if>
			
			<c:if test="${!nearestShopsInitial && (empty nearestShops || fn:length(nearestShops) eq 0)}">
				SearchShopsJS.displayError(${ecocea:doubleQuote(noStoreResultMessage)});
				MapStoreLocatorJS.centerToRightShopSearch = function(){};
			</c:if>
	</script>
</div>