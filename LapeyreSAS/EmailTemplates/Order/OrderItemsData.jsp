<%-- BEGIN OrderItemsData.jsp --%>
<% //@page import="java.util.ArrayList" %>
<% //@page import="com.ibm.commerce.foundation.internal.client.taglib.RESTTag"%>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<%@include file="/Widgets-lapeyre/Common/ProductConstants.jspf" %>
<%-- Get the list of items present in the customers shopping cart --%>
<%@ taglib uri="ecocea.tld" prefix="ecocea" %>

<%
    //retrieve idMetier of shipping mode
    if(request.getAttribute("modeRetrait") == null) {
    	String modeRetrait = ConfigTool.getConfigurationPropertiesResource().getProperty("RetraitMagasinIdMetier");
    	request.setAttribute("modeRetrait",modeRetrait);
    }
    if(request.getAttribute("modeDrive") == null) {
    	String modeDrive = ConfigTool.getConfigurationPropertiesResource().getProperty("RetraitMagasinDriveIdMetier");
    	request.setAttribute("modeDrive",modeDrive);
    }
    if(request.getAttribute("modeTransporter") == null) {
    	String modeTransporter = ConfigTool.getConfigurationPropertiesResource().getProperty("LivraisonTransporterIdMetier");
    	request.setAttribute("modeTransporter",modeTransporter);
    }
    if(request.getAttribute("modeColissimo") == null) {
    	String modeColissimo = ConfigTool.getConfigurationPropertiesResource().getProperty("LivraisonColissimoIdMetier");
    	request.setAttribute("modeColissimo",modeColissimo);
    }
    if(request.getAttribute("modeLivraisonCatalog") == null) {
    	String modeLivraisonCatalog = ConfigTool.getConfigurationPropertiesResource().getProperty("LivraisonCatalogIdMetier");
    	request.setAttribute("modeLivraisonCatalog",modeLivraisonCatalog);
    }
 %>
<c:set var="orderQuantity" value="0"/>
<c:set var="tooManyItems" value="false"/>

<%-- X_ORDER DETAILS --%>
<ecocea:xOrderDetails var="xOrderDetails" orderId="${WCParam.orderId}" />
<c:if test="${!empty xOrderDetails.coupons }">
	<c:set var="orderExternalAdjusts" value="${ xOrderDetails.coupons}"/>
</c:if>

<ecocea:xOrderSummary var="xOrderSummary" orderDetails="${xOrderDetails}" pro="${extendedUserContext.isPro}" pageType="MAIL" />

<ecocea:orderShipping var="orderShippingData" orderId="${WCParam.orderId}" />

<ecocea:orderPromisedAvailabilityByItem var="orderPromisedAvailabilityByItem" orderId="${WCParam.orderId}" />

<%-- Items availability --%>

<c:forEach var="orderItem" items="${order.orderItem}" varStatus="status">
	<c:set var="orderQuantity" value="${orderQuantity + orderItem.quantity.value}"/>
</c:forEach>

<c:choose>
	<c:when test="${isPro}">
		<c:set var="orderAmountValue" value="${xOrderDetails.ORDERTOTALAMOUNT_HT}"/>
	</c:when>
	<c:otherwise>
		<c:set var="orderAmountValue" value="${xOrderDetails.ORDERTOTALAMOUNT_TTC}"/>
	</c:otherwise>
</c:choose>

<c:set var="orderAmountTVAValue" value="${xOrderDetails.ORDERTOTALAMOUNT_VAT}"/>
<c:if test="${empty orderAmountValue}">
	<c:set var="orderAmountValue" value="0.00" />
</c:if>
<c:set var="orderAmountCurrency" value="${order.orderAmount.totalProductPrice.currency}" />
<c:if test="${empty orderAmountCurrency}">
	<c:set var="orderAmountCurrency" value="${CommandContext.currency}" />
</c:if>


<%--fmt:formatNumber value="${orderQuantity}" var="orderQuantity"/--%>

<c:set var="totalNumberOfItems" value="${orderQuantity}"/>
<%-- List of orderItem objects present in the cart. Each object in the list represent one orderItem and is modelled as a HashMap --%>
<wcf:useBean var="orderItemsDetailsList" classname="java.util.ArrayList" scope="page"/>
<%-- List of orderItem objects recently added to the cart. Each object in the list represent one orderItem and is modelled as a HashMap --%>
<wcf:useBean var="discountReferences" classname="java.util.HashMap" scope="page" />
<wcf:useBean var="ecoPartTotalMap" classname="java.util.HashMap" scope="page" />
<c:if test="${!empty order.orderItem }" >
	<jsp:useBean id="today" class="java.util.Date" />
	<c:set var="orderAvailableDate"/>
	<c:forEach var="orderItem" items="${order.orderItem}" varStatus="status">
		<c:set var="orderItemTva" value="${xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].VAT_RATE}"/>
		<%-- Eco-part for orderItem--%>
		<ecocea:orderItemEcopart var="ecoPartOrderItem" orderItemId="${orderItem.orderItemIdentifier.uniqueID }" />
		<c:forEach var="ecopart" items="${ecoPartOrderItem}">
			<wcf:useBean var="ecoPartMap" classname="java.util.HashMap"/>
			<wcf:set target="${ecoPartMap}" key="type" value="${ecopart.type}"/>
			<wcf:set target="${ecoPartMap}" key="label" value="${ecopart.label}"/>
			<c:set var="ecopartValue">
				<%--ECOCEA: ajout de la TVA dans le montant de l'item --%>
				<c:choose>
					<c:when test="${isPro}">
						${ecopart.value_HT}
					</c:when>
					<c:otherwise>
						${ecopart.value_TTC}
					</c:otherwise>
				</c:choose>
			</c:set>
			<c:choose>
				<c:when test="${empty ecoPartTotalMap[ecopart.type]}">
					<wcf:set target="${ecoPartMap}" key="value" value="${ecopartValue}"/>
				</c:when>
				<c:otherwise>
					<wcf:set target="${ecoPartMap}" key="value" value="${ecoPartTotalMap[ecopart.type]['value'] + ecopartValue}"/>
				</c:otherwise>
			</c:choose>
			<wcf:set target="${ecoPartTotalMap}" key="${ecopart.type}" value="${ecoPartMap}"/>
			<c:remove var="ecoPartMap"/>
		</c:forEach>		
		<%-- Build itemDetailsMap with all the details and add it to orderItemsDetailsList ArrayList --%>
			<wcf:useBean var="itemDetailsMap" classname="java.util.HashMap"/>
			
			<wcf:url var="catEntryDisplayUrl" patternName="ProductURL" value="Product1">
				<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
				<wcf:param name="storeId" value="${storeId}"/>
				<wcf:param name="productId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
				<wcf:param name="langId" value="${WCParam.langId}"/>
				<wcf:param name="urlLangId" value="${WCParam.langId}" />
			</wcf:url>
			
			<fmt:formatNumber var="qty" value="${orderItem.quantity.value}"  pattern='#####'/> <%-- Display 1.0 as 1 --%>
			<wcf:set target="${itemDetailsMap}" key="productQty" value="${qty}"/>
			<wcf:set target="${itemDetailsMap}" key="catEntryId" value="${orderItem.catalogEntryIdentifier.uniqueID}"/>
			<wcf:set target="${itemDetailsMap}" key="productURL" value="${catEntryDisplayUrl}"/>
			<wcf:set target="${itemDetailsMap}" key="orderItemId" value="${orderItem.orderItemIdentifier.uniqueID}"/>
			<wcf:set target="${itemDetailsMap}" key="productName" value="${orderItem.catalogEntryIdentifier.externalIdentifier.partNumber}"/>
			<wcf:set target="${itemDetailsMap}" key="productSKU" value="${orderItem.catalogEntryIdentifier.externalIdentifier.partNumber}"/>
			<wcf:set target="${itemDetailsMap}" key="TVA" value="${orderItemTva}"/>
			<wcf:set target="${itemDetailsMap}" key="isAvailable" value="false"/>
			<wcf:set target="${itemDetailsMap}" key="willBeAvailable" value="false"/>
			
			<c:remove var="orderItemDateAvailable" />
			<c:if test="${!empty orderPromisedAvailabilityByItem[orderItem.catalogEntryIdentifier.externalIdentifier.partNumber]}">
			
				<fmt:parseDate var="orderItemAvailDate" value="${orderPromisedAvailabilityByItem[orderItem.catalogEntryIdentifier.externalIdentifier.partNumber]}" pattern="yyyy-MM-dd HH:mm:ss.SSS" timeZone="GMT"/>
				<c:if test="${empty orderAvailableDate}">
					<fmt:parseDate var="orderAvailableDate" value="${orderPromisedAvailabilityByItem[orderItem.catalogEntryIdentifier.externalIdentifier.partNumber]}" pattern="yyyy-MM-dd HH:mm:ss.SSS" timeZone="GMT"/>
				</c:if>
				<c:choose>
					<c:when test="${ecocea:dayBasedCompare(orderItemAvailDate, today) <= 0}">
						<wcf:set target="${itemDetailsMap}" key="isAvailable" value="true"/>
						<c:set var="orderAvailableDate" value="${today}"/>
					</c:when>
					<c:otherwise>
						<wcf:set target="${itemDetailsMap}" key="willBeAvailable" value="true"/>
						<wcf:set target="${itemDetailsMap}" key="dateAvailability" value="${orderItemAvailDate}"/>
						<c:if test="${ecocea:dayBasedCompare(orderAvailableDate, orderItemAvailDate) < 0}">
							<c:set var="orderAvailableDate" value="${orderItemAvailDate}"/>
						</c:if>
					</c:otherwise>
				</c:choose>
			</c:if>
			
			<c:set var="totalProductPrice">
				<c:choose>
					<c:when test="${extendedUserContext.isPro}">
						${xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].TOTALPRODUCT_HT + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].TOTALECOPART_HT + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].AJUSTMENT_HT + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].EXTAJUSTMENT_HT}
					</c:when>
					<c:otherwise>
						${xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].TOTALPRODUCT_TTC + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].TOTALECOPART_TTC + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].AJUSTMENT_TTC + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].EXTAJUSTMENT_TTC}
					</c:otherwise>
				</c:choose>
			</c:set>
			
			<%-- row to display product level discount --%>
			<c:if test="${!empty orderItem.orderItemAmount.adjustment}">
				<wcf:useBean var="discountReferencesOnItem" classname="java.util.HashMap"/>
				<%-- Loop through the discounts, summing discounts with the same code --%>
				<c:forEach var="discounts" items="${orderItem.orderItemAmount.adjustment}">
					<%-- only show the adjustment detail if display level is OrderItem, if display level is order, display it at the order summary section --%>
					<c:if test="${discounts.displayLevel == 'OrderItem' && discounts.usage == 'Remise'}">
						<wcf:set target="${discountReferencesOnItem}" key="${discounts.code}" value="${discounts}"/>
					</c:if>
				</c:forEach>
				<wcf:set target="${itemDetailsMap}" key="discountReferences" value="${discountReferencesOnItem}"/>
				<c:remove var="discountReferencesOnItem"/>
			</c:if>
			
			<c:set var="unitProductPrice">
				<c:choose>
					<c:when test="${extendedUserContext.isPro}">
						${xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].PRICE_HT}
					</c:when>
					<c:otherwise>
						${xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].PRICE_TTC}
					</c:otherwise>
				</c:choose>
			</c:set>
			<c:set var="unitProductPriceNumber" value="${unitProductPrice}" />
			

			<fmt:parseNumber var="unitProductPrice" type="number" value="${unitProductPrice}" parseLocale="en_US" />
			
			<c:set var="unitProductPriceWithEcoPart">
				<c:choose>
					<c:when test="${extendedUserContext.isPro}">
						${unitProductPrice + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].ECOPART_HT}
					</c:when>
					<c:otherwise>
						${unitProductPrice + xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].ECOPART_TTC}
					</c:otherwise>
				</c:choose>
			</c:set>
			<fmt:parseNumber var="unitProductPriceWithEcoPart" type="number" value="${unitProductPriceWithEcoPart}" parseLocale="en_US" />	

			<c:set var="originalPriceValueWithEcoPart">
				<c:choose>
					<c:when test="${extendedUserContext.isPro}">
						<c:if test="${!empty xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].ORIGINALPRICE_HT}">
							<fmt:parseNumber type="number" value="${xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].ORIGINALPRICE_HT}" parseLocale="en_US"/>
						</c:if>		
					</c:when>
					<c:otherwise>
						<c:if test="${!empty xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].ORIGINALPRICE_TTC}">
							<fmt:parseNumber type="number" value="${xOrderDetails.orderItems[orderItem.orderItemIdentifier.uniqueID].ORIGINALPRICE_TTC}" parseLocale="en_US"/>
						</c:if>	
					</c:otherwise>
				</c:choose>
			</c:set>
			<fmt:parseNumber var="originalPriceValueWithEcoPart" type="number" value="${originalPriceValueWithEcoPart}" parseLocale="en_US" />	
			
			<%-- Calcul prix barre --%>
			<c:if test="${!empty originalPriceValueWithEcoPart && unitProductPriceWithEcoPart < originalPriceValueWithEcoPart}">
				<wcf:set target="${itemDetailsMap}" key="prixBarre" value="true"/>
				<fmt:formatNumber var="oldUnitPrice" value="${originalPriceValueWithEcoPart}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
				<fmt:formatNumber var="oldTotalPrice" value="${originalPriceValueWithEcoPart * qty}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
				<wcf:set target="${itemDetailsMap}" key="oldUnitPrice" value="${oldUnitPrice}"/>
				<wcf:set target="${itemDetailsMap}" key="oldTotalPrice" value="${oldTotalPrice}"/>
			</c:if>
						
			<fmt:formatNumber var="totalFormattedProductPrice" value="${totalProductPrice}" type="currency" currencySymbol="" maxFractionDigits="${env_currencyDecimal}" />
			<fmt:formatNumber var="unitFormattedProductPrice" value="${unitProductPrice}" type="currency" currencySymbol="${env_CurrencySymbolToFormat }" maxFractionDigits="${env_currencyDecimal}" />
			
			
			<wcf:set target="${itemDetailsMap}" key="unitProductPrice" value="${unitFormattedProductPrice}"/>
			<wcf:set target="${itemDetailsMap}" key="totalProductPrice" value="${totalProductPrice}"/>
			<wcf:set target="${itemDetailsMap}" key="productPrice" value="${totalFormattedProductPrice}"/>
			
			<wcf:set target="${orderItemsDetailsList}" value="${itemDetailsMap}"/>
			<c:remove var="itemDetailsMap"/>
	</c:forEach>
</c:if>

<%-- Adjustments, promotions and discounts --%>
<%-- Loop through the discounts, summing discounts with the same code --%>
<c:forEach var="adjustment" items="${order.orderAmount.adjustment}">
	<c:if test="${adjustment.displayLevel.name == 'Order' && adjustment.usage == 'Discount'}">
		<wcf:useBean var="discountsMap" classname="java.util.HashMap"/>
		<wcf:set target="${discountsMap}" key="discountDescription" value="${adjustment.description.value}" />
		<c:if test="${empty adjustment.description.value}">
			<fmt:message bundle="${storeText}" var="defaultDescription" key="DISCOUNT_DETAILS_TITLE"/>
			<wcf:set target="${discountsMap}" key="discountDescription" value="${defaultDescription}" />
		</c:if>
		<wcf:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
			<wcf:param name="code" value="${adjustment.code}" />
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="storeId" value="${storeId}" />
			<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		</wcf:url>
		<wcf:set target="${discountsMap}" key="displayURL" value="${ecocea:replaceHost(DiscountDetailsDisplayViewURL,hostPath)}" />
		<c:set var="adjustValue">
			<c:choose>
				<c:when test="${isPro}">
					${xOrderDetails.adjustments[adjustment.code].AMOUNT_HT}
				</c:when>
				<c:otherwise>
					${xOrderDetails.adjustments[adjustment.code].AMOUNT_TTC}
				</c:otherwise>
			</c:choose>
		</c:set>
		<fmt:formatNumber var="formattedDiscountValue" value="${adjustValue}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
		<wcf:set target="${discountsMap}" key="aggregatedDiscount" value="${formattedDiscountValue}" />			
		<wcf:set key="${adjustment.code}" value="${discountsMap}" target="${discountReferences}" />
		<c:remove var="discountsMap"/>
	</c:if>	
</c:forEach>

<%
//ECOCEA: petit hack pour éviter l'exception de l'appel rest. En attente du PMR IBM 89692,999,706
//String cookie_header = RESTTag.class.getName() + ".cookieHeaders";
//request.setAttribute(cookie_header,new ArrayList<String>());
%>
<%-- Get more info for the catEntryIds which needs to be displayed in the miniCart page --%>
<c:if test="${!empty orderItemsDetailsList}">	
	<wcf:rest var="catalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${storeId}/productview/byIds">
		<c:forEach var = "itemDetailsMap" items = "${orderItemsDetailsList}" varStatus = "status">
			<wcf:param name="id" value="${itemDetailsMap['catEntryId']}"/>
		</c:forEach>
		<wcf:param name="langId" value="${WCParam.langId}" />
		<wcf:param name="currency" value="${env_currencyCode}" />
		<wcf:param name="responseFormat" value="json" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<%--ECOCEA --%>
		<%-- <wcf:param name="profileName" value="IBM_findProductByIds_Summary_WithNoEntitlementCheck" /> --%>
		<wcf:param name="profileName" value="ECO_findProductByIds_Summary_WithNoEntitlementCheck" />
		<wcf:param name="isProBTP" value="${isPro}" />
	</wcf:rest>
</c:if>

<c:set var="productStandardExists" value="false"/>
<c:set var="productCatalogExists" value="false"/>
<%-- Populate our hashMap stored in orderItemDetails list with the catEntry details like fullImage, name, shortDescription, isOnSpecial... --%>
<c:forEach items="${catalogNavigationView.catalogEntryView}" var="catalogEntryDetails">
	<c:forEach items="${orderItemsDetailsList}" var="itemDetailsMap">
		<c:if test="${itemDetailsMap.catEntryId == catalogEntryDetails.uniqueID}">
			<c:choose>
			<c:when test="${not empty catalogEntryDetails.fullImage && fn:trim(catalogEntryDetails.fullImage) !=''}">
				<c:set var="miniCartListImage" value="${catalogEntryDetails.fullImage}" />

				<c:if test="${!empty catalogEntryDetails.fullImage}">
					<astpush:assetPushUrl var="miniCartListImage" scope="page" urlRelative="${catalogEntryDetails.fullImage}" type="${catalogEntryDetails.type}" source="main" device="${device}" format="full"/>
				</c:if>
				
				<c:if test="${empty miniCartListImage}">
						<c:set var="keyDefaultImageMaps" value="GRID_ASSET_main_full"/>
						<astpush:assetPushUrl var="miniCartListImage" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="GRID_ASSET" source="main" device="${device}" format="full" defaultUrl="true"/>
				</c:if>
			</c:when>
			<c:otherwise>
				<c:set var="keyDefaultImageMaps" value="GRID_ASSET_main_full"/>
				<astpush:assetPushUrl var="miniCartListImage" urlRelative="${defaultImageMaps[keyDefaultImageMaps]}" type="GRID_ASSET" source="main" device="${device}" format="full" defaultUrl="true"/>
			</c:otherwise>
			</c:choose>
			
			
			<wcf:set target="${itemDetailsMap}" key="productImage" value="${ecocea:replaceHost(miniCartListImage,hostPath)}"/>
			<wcf:set target="${itemDetailsMap}" key="productName" value="${catalogEntryDetails.name}"/>
			<wcf:set target="${itemDetailsMap}" key="typeProduct" value="${catalogEntryDetails.type}"/>
			
			<%-- Checks if parent product actually exists --%>
			<c:if test="${not empty catalogEntryDetails.parentCatalogEntryID}">
				<wcf:rest var="catalogParentNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${storeId}/productview/byId/${catalogEntryDetails.parentCatalogEntryID}" >
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="currency" value="${env_currencyCode}" />
					<wcf:param name="responseFormat" value="json" />
					<wcf:param name="profileName" value="ECO_findProductByIdsWithAttributesAndAttachments" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				</wcf:rest>
			</c:if>
			
				<c:set var = "parentCatalogEntryDetails" value = "${catalogParentNavigationView.catalogEntryView[0]}"/>
				<wcf:set target="${itemDetailsMap}" key="productDescription" value="${parentCatalogEntryDetails.shortDescription}"/>
				<wcf:set target="${itemDetailsMap}" key="productLabel" value="${parentCatalogEntryDetails.name}"/>
			
			<%--  Chercher produit STANDARD et/or CATALOG_PAPER --%>			
			<c:if test="${!empty catalogEntryDetails.type && catalogEntryDetails.type eq STANDARD_PRODUCT}">
				<c:set var="productStandardExists" value="true"/>
			</c:if>
			<c:if test="${!empty catalogEntryDetails.type && catalogEntryDetails.type eq CATALOGUE_PAPIER_PRODUCT}">
				<c:set var="productCatalogExists" value="true"/>
			</c:if>
		</c:if>
	</c:forEach>
</c:forEach>

<c:set var="isMixteStandardCatalog" value="false"  scope="request"/>
<c:if test="${productStandardExists && productCatalogExists}">
	<c:set var="isMixteStandardCatalog" value="true"/>
</c:if>
	
<%--  APPLIQUER LE CODE AVANTAGE --%>
<%-- <c:if test="${!empty orderExternalAdjusts }">
	<c:forEach var="orderExternalAdjust" items="${orderExternalAdjusts}">
		<c:choose>
			<c:when test="${isPro}">
				<c:set var="orderAdjustAmount" value="${orderExternalAdjust.adjustAmount_HT}"/>
			</c:when>
			<c:otherwise>
				<c:set var="orderAdjustAmount" value="${orderExternalAdjust.adjustAmount_TTC}"/>
			</c:otherwise>
		</c:choose>
		<c:set var="orderAmountValue" value="${orderAmountValue + orderAdjustAmount}"/>
		<c:if test="${orderExternalAdjust.type eq 'RATE_ITEM'}">
			<c:forEach items="${orderItemsDetailsList}" var="itemDetailsMap">
				<c:if test="${itemDetailsMap['orderItemId']  eq orderExternalAdjust.orderItemId}">
					<c:set var="totalProductPrice" value="${itemDetailsMap['totalProductPrice'] + orderAdjustAmount}"/>
					
					<fmt:formatNumber var="totalFormattedProductPrice" value="${totalProductPrice}" type="currency" currencySymbol="" maxFractionDigits="${env_currencyDecimal }" />
					<wcf:set target="${itemDetailsMap}" key="totalProductPrice" value="${totalProductPrice}"/>
					<wcf:set target="${itemDetailsMap}" key="productPrice" value="${totalFormattedProductPrice}"/>
				</c:if>
			</c:forEach>
		</c:if>
	</c:forEach>
</c:if> --%>

<c:set var="orderSubTotal">
	<fmt:formatNumber value="${xOrderDetails.ORDERTOTALAMOUNT_TTC}" type="currency"  maxFractionDigits="${env_currencyDecimal}" currencySymbol="${env_CurrencySymbolToFormat}"/>
</c:set>

<!-- MODE DE LIVRAISON -->
<c:set var="shippingMode">
	<c:choose>
		<c:when test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeRetrait}">
			<fmt:message bundle="${storeText}" key="emailConfirmOrderModeRetrait" />
		</c:when>
		<c:when test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeDrive}">
			<fmt:message  bundle="${storeText}" key="emailConfirmOrderModeDrive" />
		</c:when>
		<c:when test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeTransporter}">
			<fmt:message bundle="${storeText}" key="emailConfirmOrderModeTransporter" />
		</c:when>
		<c:when test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeColissimo}">
			<fmt:message bundle="${storeText}" key="emailConfirmOrderModeColissimo" />
		</c:when>
	</c:choose>
</c:set>

<fmt:formatDate var="orderAvailableDateFormatted" value="${orderAvailableDate}" pattern="dd MMM yyyy"/>
<!-- HEURE DRIVE -->
<c:if test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeDrive && ! empty xOrderDetails.SHIPPINGINFOS.DRIVESCHEDULE}">
	<c:set var="driveSchedule" value="${fn:split(xOrderDetails.SHIPPINGINFOS.DRIVESCHEDULE, '_')}" />
	<c:set var="sDateDrive" value="${driveSchedule[0]}"/>
	<c:set var="sHeureDrive" value="${driveSchedule[1]}"/>
	<c:set var="heureDebutDrive" value="${fn:substring(sHeureDrive, 0, 2)}h${fn:substring(sHeureDrive, 2, 4)}" />
	<c:set var="heureFinDrive" value="${fn:substring(sHeureDrive, 4, 6)}h${fn:substring(sHeureDrive, 6, 8)}" />
	<fmt:parseDate var="dateDrive" value="${sDateDrive}" pattern="yyyyMMdd" timeZone="GMT"/>
	<fmt:formatDate var="orderAvailableDateFormatted" value="${dateDrive}" pattern="dd MMM yyyy"/>
</c:if>

<%-- END OrderItemsData.jsp --%>
