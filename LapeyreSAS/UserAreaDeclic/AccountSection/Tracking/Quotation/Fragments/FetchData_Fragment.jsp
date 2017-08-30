<c:remove var="definingAttributes"/>
<c:remove var="productShortDescription"/>
<c:remove var="isOnSpecial"/>
<c:remove var="listPrice"/>
<c:remove var="offerPrice"/>
<c:remove var="buyableItem"/>
<c:remove var="catEntryDisplayUrl"/>

<c:set var="keyDefaultImageMaps" value="GRID_ASSET_main_full"/>
<astpush:assetPushUrl var="defaultProductImage" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="GRID_ASSET" source="list" device="${device}" format="full" defaultUrl="true"/>
			
<c:choose>
	<c:when test="${quotationDetail.presentInDB}">
			<wcf:rest var="catalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${quotationDetail.reference}" >
			    <wcf:param name="langId" value="${langId}" />
			    <wcf:param name="currency" value="${env_currencyCode}" />
			    <wcf:param name="responseFormat" value="json" />
			    <wcf:param name="catalogId" value="${WCParam.catalogId}" />
<!-- 			    <wcf:param name="profileName" value="ECO_findProductByIdsWithAttributesAndAttachments" /> -->
			    <wcf:param name="profileName" value="ECO_findProductByIds_Details" />
			    <wcf:param name="isProBTP" value="${extendedUserContext.isPro}" />
			</wcf:rest>
			
			<c:set var="itemResult" value="${catalogNavigationView.catalogEntryView[0]}" />
			
			<wcf:url var="catEntryDisplayUrl" patternName="ProductURL" value="Product2">
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="storeId" value="${WCParam.storeId}"/>
				<wcf:param name="productId" value="${quotationDetail.reference}"/>
				<wcf:param name="langId" value="${langId}"/>
				<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
				<wcf:param name="urlLangId" value="${urlLangId}" />
			</wcf:url>
			
			<c:set var="productThumbNail" value="${itemResult.thumbnail}" />
			<c:set var="productName" value="${itemResult.name}"  />
			<c:set var="highlightedName" value="${itemResult.name}"  />
			<c:set var="productShortDescription" value="${itemResult.shortDescription}"  />
			<c:set var="itemFullImage" value="${itemResult.fullImage}"  />
			<c:set var="productType" value="${itemResult.type}"  />
	
			<%-- Recuperer les infos du product parent si besoin --%>
			<c:if test="${empty itemResult.shortDescription && itemResult.catalogEntryTypeCode eq 'ItemBean'}">
				<wcf:rest var="catalogParentNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${itemResult.parentCatalogEntryID}" >
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="currency" value="${env_currencyCode}" />
					<wcf:param name="responseFormat" value="json" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				</wcf:rest>
				<c:set var = "parentCatalogEntryDetails" value = "${catalogParentNavigationView.catalogEntryView[0]}"/>
				<c:set var="productShortDescription" value="${parentCatalogEntryDetails.shortDescription}"  />
				<c:set var="productLabel" value="${parentCatalogEntryDetails.name}"  />
			</c:if>
			
			<%--IsOnSpecial of the item --%>
			<c:set var="isOnSpecial" value="false"/>
			<c:if test="${!empty itemResult.isOnSpecial}">
				<c:set var="isOnSpecial" value="${catalogEntryDetails.isOnSpecial}"/>
			</c:if>
			
			<%-- price --%>
			<c:forEach var="price" items="${itemResult.price}" >
			    <c:choose>
			        <c:when test="${price.description == 'I'}">
			            <fmt:parseNumber var="offerPrice" value="${price.value}" parseLocale="en_US"/>
			        </c:when>
			        <c:when test="${price.description == 'L'}">
			            <fmt:parseNumber var="listPrice" value="${price.value}" parseLocale="en_US"/>
			        </c:when>
			    </c:choose>
			</c:forEach>
							
			<%--  --%>
			
			<c:choose>
				<c:when test="${not empty itemResult.fullImage && fn:trim(itemResult.fullImage) !=''}">
					<c:set var="productFullImage" value="${catalogEntryDetails.fullImage}" />
			
					<c:if test="${!empty itemResult.fullImage}">
						<astpush:assetPushUrl var="productFullImage" scope="page" urlRelative="${itemResult.fullImage}" type="${itemResult.type}" source="list" device="${device}" format="full"/>
					</c:if>
					
					<c:if test="${empty productFullImage}">
							<c:set var="keyDefaultImageMaps" value="GRID_ASSET_main_full"/>
							<astpush:assetPushUrl var="productFullImage" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="GRID_ASSET" source="list" device="${device}" format="full" defaultUrl="true"/>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:set var="keyDefaultImageMaps" value="GRID_ASSET_main_full"/>
					<astpush:assetPushUrl var="productFullImage" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="GRID_ASSET" source="list" device="${device}" format="full" defaultUrl="true"/>
				</c:otherwise>
			</c:choose>
			
			<wcf:useBean var="definingAttributes" classname="java.util.ArrayList" />
			
			<c:forEach var="attribute" items="${itemResult.attributes}">
				<c:if test="${attribute.usage eq 'Defining'}">
					<wcf:set target="${definingAttributes}" value="${attribute}" />
				</c:if>
			</c:forEach>
			
			<c:set var="buyableItem" value="${itemResult.buyable == 'true' && productType eq 'STANDARD' && !empty offerPrice && offerPrice >0}" />
			
			<c:if test="${buyableItem}">
				<script type="text/javascript">buyableItems.push("<c:out value="${itemResult.uniqueID}" />");</script>
				<c:set var="someBuyable" value="${someBuyable + 1}" scope="request"/>
			</c:if>
	</c:when>
	<c:otherwise>
			<c:set var="productLabel" value="${quotationDetail.name}"  />
			<c:set var="highlightedName" value="${quotationDetail.name}"  />
			<c:set var="productType" value="STANDARD"  />
			<c:set var="keyDefaultImageMaps" value="GRID_ASSET_main_full"/>
			<astpush:assetPushUrl var="productFullImage" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="GRID_ASSET" source="list" device="${device}" format="full" defaultUrl="true"/>
			
			<c:choose>
				<c:when test="${extendedUserContext.isPro}">
					<c:if test="${!empty quotationDetail.priceHT}">
						<fmt:parseNumber var="offerPrice" value="${quotationDetail.priceHT}" parseLocale="en_US"/>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${!empty quotationDetail.priceTTC}">
						<fmt:parseNumber var="offerPrice" value="${quotationDetail.priceTTC}" parseLocale="en_US"/>
					</c:if>
				</c:otherwise>
			</c:choose>
						
	</c:otherwise>
</c:choose>
