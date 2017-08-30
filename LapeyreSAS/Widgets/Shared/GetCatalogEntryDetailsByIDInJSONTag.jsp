<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--Cette JSP est la m�me que GetCatalogEntryDetailsByID.jsp sauf qu'elle cr�e une div (defaultItemDetailJSON_catentryID) avec le JSON dedans. 
Elle a besoin des variables:
-defaultProductSkuID
-defaultSKUFullAttributes
--%>
<!-- BEGIN GetCatalogEntryDetailsByIDInJSONTag.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<c:if test="${!empty defaultProductSkuID }">
<c:set var="catalogNavigationViewURL" value="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${defaultProductSkuID}" />
<wcf:rest var="catalogNavigationView"  url="${catalogNavigationViewURL}">	
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="currency" value="${env_currencyCode}"/>
	<wcf:param name="responseFormat" value="json"/>		
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="isProBTP" value="${extendedUserContext.isPro}" />
	<%--ECOCEA perf: ici pas besoin des attributs car ils sont d�finis dans la JSP parente --%>
	<wcf:param name="profileName" value="ECO_findProductByIds_Details_Without_Attachment_Nor_SKU_Nor_Attribute" />
</wcf:rest>

<c:set var="catalogEntryDefault" value="${catalogNavigationView.catalogEntryView[0]}"/>
<%--ECOCEA: ne pas appeler l'url catEntryDisplayUrl car ce nom de variable est d�ja appel� plus bas dans la page--%>
<wcf:url var="catEntryDefaultDisplayUrl" patternName="ProductURL" value="Product1">
	<wcf:param name="langId" value="${langId}" />
    <wcf:param name="storeId" value="${WCParam.storeId}"/>
    <wcf:param name="catalogId" value="${WCParam.catalogId}"/>
    <wcf:param name="productId" value="${catalogEntryDefault.uniqueID}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>
<%-- catalogIdEntry is used in CatalogEntrySetPriceDisplay.jspf, hence using this variable --%>
<c:set var="catalogIdEntry" value="${catalogEntryDefault}"/>

<%@ include file="../../Snippets/Search/CatalogEntrySetPriceDisplay.jspf" %>

<%-- Application des prix promotionn�s --%>
<c:set var="hasPromotionPriceToDisplay" value="false"/>
<c:set var="finalPromotionnalPrice" value="-1"/>
<c:forEach items="${promoPricesList}" var="item" varStatus="status">
	<c:if test="${status.first}">
		<c:set var="hasPromotionPriceToDisplay" value="true"/>
	</c:if>
	<c:set var="finalPromotionnalPrice" value="${item.PRICE_REDUCED}"/>
</c:forEach>



<c:if test="${hasPromotionPriceToDisplay eq 'true'}">
	<c:if test="${empty listPrice}">
		<c:set var="listPrice" value="${priceNumeric}"/>
	</c:if>
	<c:set var="priceString" value="${finalPromotionnalPrice}"/>
</c:if>

<fmt:message bundle="${widgetText}" var="emptyPriceLabel" key="noPriceLabel" />
<c:set var="offerPrice">
	<c:choose> 
		<c:when test="${extendedUserContext.isPro eq true}">
			<fmt:formatNumber value="${priceString}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
		</c:when>
		<c:otherwise>
			<fmt:formatNumber value="${priceString}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
		</c:otherwise>
	</c:choose>
</c:set>
<fmt:formatNumber var="offerPriceWithoutSymbol" value="${priceString}" type="currency" currencySymbol="" maxFractionDigits="${env_currencyDecimal}"/>
<c:if test="${not empty listPrice}">
	<c:set var="listPrice">
		<c:choose>
			<c:when test="${extendedUserContext.isPro eq true}">
				<fmt:formatNumber value="${listPrice.value}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
			</c:when>
			<c:otherwise>
				<fmt:formatNumber value="${listPrice.value}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}" maxFractionDigits="${env_currencyDecimal}"/>
			</c:otherwise>
		</c:choose>
	</c:set>
<%-- 	<fmt:formatNumber var="listPrice" value="${listPrice.value}" type="currency" currencySymbol="<sup>${env_CurrencySymbolToFormat}</sup>" maxFractionDigits="${env_currencyDecimal}"/> --%>
</c:if>
<c:if test="${not empty calculatedPrice and not empty calculatedPrice.contractIdentifier and not empty calculatedPrice.contractIdentifier.externalIdentifier}">
	<c:set var="ownerID" value="${calculatedPrice.contractIdentifier.externalIdentifier.ownerID}"/>
</c:if>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value='&quot;'/>

<c:set var="catalogEntryId" value="${WCParam.catalogEntryId}"/>
<%--<%@ include file="/Widgets/com.ibm.commerce.store.widgets.PDP_Discounts/Discounts_Data.jspf" %>--%>
	
<c:set var="endLineReturn" value="<%= \"\r\n\" %>"/>
<c:set var="endLine" value="<%= \"\r\" %>" />
<c:set var="newline" value="<%= \"\n\" %>" />

<c:set var="COEFF_QUANTITE" value="<%=com.lapeyre.declic.commerce.messaging.commands.attributes.AttributeConstants.COEFF_QUANTITE %>" />
<c:set var="COEFF_PRIX" value="<%=com.lapeyre.declic.commerce.messaging.commands.attributes.AttributeConstants.COEFF_PRIX %>" />
<c:set var="UNITE_SECONDAIRE_CODE" value="<%=com.lapeyre.declic.commerce.messaging.commands.attributes.AttributeConstants.UNITE_SECONDAIRE_CODE %>" />
<c:set var="UNITE_VENTE_LEGALE_CODE" value="<%=com.lapeyre.declic.commerce.messaging.commands.attributes.AttributeConstants.UNITE_VENTE_LEGALE_CODE %>" />
<c:set var="PRICE_LABEL" value="<%=com.lapeyre.declic.commerce.messaging.commands.attributes.AttributeConstants.PRICE_LABEL %>" />
<c:set var="CONTRAINTE_COLISAGE" value="<%=com.lapeyre.declic.commerce.messaging.commands.attributes.AttributeConstants.CONTRAINTE_COLISAGE %>" />
<c:set var="ATOUT_PRIX" value="<%=com.lapeyre.declic.commerce.messaging.commands.attributes.AttributeConstants.ATOUT_PRIX %>" />
 
<c:set var="catenttype" value="${catalogEntryDefault.type}" />
<c:set var="isOnSpecial" value="${catalogEntryDefault.isOnSpecial}" />




<c:forEach var="attr" items="${defaultSKUFullAttributes}">
	<c:if test="${attr.identifier eq GOOGLE_CATEGORY_ATTRIBUTE_NAME}">
		<c:set var="googleCategory" value="${attr.name}" scope="request"/>
	</c:if>
	<c:if test="${attr.usage eq 'Descriptive' && attr.identifier eq 'isSoldes'}">
            <c:set var="soldeFlagProduct" value="${attr.values[0].value}" scope="request" />
    </c:if>
    <c:if test="${ attr.storeDisplay eq true && attr.usage ne 'Defining' }">
    	<c:set var="id" value="${attr.identifier }" />
    	<c:set var="value" value="${attr.values[0].value}" />
    </c:if>
    
	<c:choose>
		<c:when test="${attr.identifier eq COEFF_QUANTITE}">
			<c:set var="coeffConversionQuantite" value="${attr.values[0].value}" scope="request"/>
		</c:when>
		<c:when test="${attr.identifier eq COEFF_PRIX}">
			<c:set var="coeffConversionPrix" value="${attr.values[0].value}" scope="request"/>
		</c:when>
		<c:when test="${attr.identifier eq UNITE_SECONDAIRE_CODE}">
			<c:set var="uniteSecondaire" value="${attr.values[0].value}" scope="request"/>
		</c:when>
		<c:when test="${attr.identifier eq UNITE_VENTE_LEGALE_CODE}">
			<c:set var="uniteVenteLegale" value="${attr.values[0].value}" scope="request"/>
		</c:when>
		<c:when test="${attr.identifier eq PRICE_LABEL}">
			<c:set var="priceLabel" value="${attr.values[0].value}" scope="request"/>
		</c:when>
		<c:when test="${attr.identifier eq CONTRAINTE_COLISAGE}">
			<c:set var="contrainteColisage" value="${attr.values[0].value}" scope="request"/>
		</c:when>
		<c:when test="${attr.identifier eq ATOUT_PRIX}">
			<c:set var="atoutPrix" value="${attr.values[0].value}" scope="request"/>
		</c:when>
	</c:choose>
</c:forEach>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>
<c:if test="${uniteVenteLegale!=null}">
	<c:set var="libellesUnit" value="${ecocea:getLibelles(uniteVenteLegale,contrainteColisage)}" scope="request" />
</c:if>
<c:set var="parentCatalogEntryID" value="${catalogEntryDefault.parentCatalogEntryID}"/>
<c:set var="parentFetched" value="false"/>
<c:if test="${not empty parentCatalogEntryID}">
	<c:set var="catalogNavigationViewParentURL" value="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${parentCatalogEntryID}" />
	<wcf:rest var="catalogNavigationViewParent"  url="${catalogNavigationViewParentURL}">	
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="currency" value="${env_currencyCode}"/>
		<wcf:param name="responseFormat" value="json"/>		
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="isProBTP" value="${extendedUserContext.isPro}" />
		<%--ECOCEA perf: on prend un profile light --%>
		<wcf:param name="profileName" value="ECO_findProductByIds_Light" />
	</wcf:rest>
	<c:set var="parentFetched" value="true"/>
	<c:set var="catalogEntryParent" value="${catalogNavigationViewParent.catalogEntryView[0]}"/>
</c:if>

<c:choose>
	<c:when test="${not empty catalogEntryDefault.fullImage}">
		<astpush:assetPushUrl var="fullImage" scope="page" urlRelative="${catalogEntryDefault.fullImage}" type="${catalogEntryDefault.type}" source="main" device="${device}" format="full"/>
	</c:when>
	<c:otherwise>
		<c:set var="keyDefaultImageMaps" value="${catalogEntryDefault.type}_main_full"/>
		<astpush:assetPushUrl var="fullImage" scope="page" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="${catalogEntryDefault.type}" source="main" device="${device}" format="full" defaultUrl="true"/>
	</c:otherwise>
</c:choose>
<c:set var="auxDescription2" value="${fn:replace(fn:replace(fn:replace(fn:replace(catalogEntryDefault.auxDescription2, search, replaceStr), endLineReturn, '<br/>' ), newline , '<br/>'),endLine ,'')}"/>
<c:set var="shortDescription" value="${fn:replace(fn:replace(fn:replace(fn:replace(catalogEntryDefault.shortDescription, search, replaceStr), endLineReturn, '<br/>' ), newline , '<br/>'),endLine ,'')}"/>
<c:set var="longDescription" value="${fn:replace(fn:replace(fn:replace(fn:replace(catalogEntryDefault.longDescription, search, replaceStr), endLineReturn, '<br/>' ), newline , '<br/>'),endLine ,'')}"/>
<c:set var="brand" value="${fn:escapeXml(catalogEntryDetails.manufacturer)}"/>

<c:if test="${!empty globalbreadcrumbsForTagManager.breadCrumbTrailEntryView}">
	<c:choose>
		<c:when test="${fn:length(globalbreadcrumbsForTagManager.breadCrumbTrailEntryView) eq 1}">
			<c:set var="pageCat1" value="${fn:escapeXml(globalbreadcrumbsForTagManager.breadCrumbTrailEntryView[0].label)}"/>
		</c:when>
		<c:when test="${fn:length(globalbreadcrumbsForTagManager.breadCrumbTrailEntryView) ge 2}">
			<c:set var="pageCat1" value="${fn:escapeXml(globalbreadcrumbsForTagManager.breadCrumbTrailEntryView[0].label)}"/>
			<c:set var="pageCat2" value="${fn:escapeXml(globalbreadcrumbsForTagManager.breadCrumbTrailEntryView[1].label)}"/>
		</c:when>
	</c:choose>
</c:if>
<div id="defaultItemDetailJSON_<c:out value='${catalogEntryDefault.uniqueID}'/>" style="display:none;">
	{"catalogEntry": {
		"catalogEntryIdentifier": {
			"uniqueID": "${catalogEntryDefault.uniqueID}",
			"externalIdentifier": {
				"partNumber": "${catalogEntryDefault.partNumber}"
			}
		},
		"description": [{
			"name": "${fn:replace(catalogEntryDefault.name, search, replaceStr)}",
			"fullImage": "${fullImage}",
			"auxDescription2": "<c:out value="${auxDescription2}"/>",
			"shortDescription": "<c:out value="${shortDescription}"/>",
			"longDescription": "<c:out value="${longDescription}"/>",
			"keyword": "${fn:replace(catalogEntryDefault.keyword, search, replaceStr)}",
			"language": "${langId}",
			"url":"${catEntryDefaultDisplayUrl}"
		}],
		"type":"${catenttype }",
		"offerPrice": "${offerPrice}",
		"offerPriceWithoutSymbol": "${offerPriceWithoutSymbol}",
		"offerPriceValueNumber":"${offerPriceValueNumber}",
		"emptyPriceLabel":"${emptyPriceLabel }",
		"priceLabel":"${priceLabel}",
		"listPrice": "${listPrice}",
		"listPriced": "${not empty listPrice}",
		"ecopart": "${ecoPart}",
		"ecopartList": "${ecoPartList}",
		"priceAdjustments" : [
		<c:forEach items="${promoPricesList}" var="item" varStatus="status">
			<c:if test="${!status.first}">,</c:if>
			{"promo_price":"${item.PRICE_REDUCED}", "promo_desc":"<c:out value="${item.PROMO_DESC}"/>"}		
		</c:forEach>
		],
		"coeffConversionQuantite":"${coeffConversionQuantite}",
		"coeffConversionPrix":"${coeffConversionPrix}",
		"uniteSecondaire":"${uniteSecondaire}",
		"isOnSpecial":"${isOnSpecial }",
		"soldeFlagProduct":"${soldeFlagProduct }",
		"ribonAds": [{
			"id":"${id }",
			"val":"${ value}"
		
		}],
		"atoutPrix":"${atoutPrix}",
		"contrainteColisage":"${contrainteColisage}",
		"brand":"<c:out value="${brand}"/>",
		"pageCat1":"<c:out value="${pageCat1}"/>",
		"pageCat2":"<c:out value="${pageCat2}"/>"
	<c:if test="${libellesUnit!=null}">
		,"uniteSecondaireLabel":"${libellesUnit.uniteSecondaireLabel}",
		"uniteVenteLegale":"${libellesUnit.uniteVenteLegaleCode}",
		"uniteVenteLegaleLabel":"${libellesUnit.uniteVenteLegaleLabel}",
		"colisagePriceLabel":"${libellesUnit.colisagePriceLabel}",

		"quantityLegaleFieldLabel":"${libellesUnit.quantityLegaleFieldLabel}"
	</c:if>
		<c:if test="${parentFetched}">
		,"parent": {
			"name": "${fn:replace(catalogEntryParent.name, search, replaceStr)}"
		}
		</c:if>
	}
}
</div>
</c:if>
<!-- END GetCatalogEntryDetailsByIDInJSONTag.jsp -->