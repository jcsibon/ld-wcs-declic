
<wcf:url var="ProductDisplayURL" patternName="ProductURL" value="Product1">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="productId" value="${singleProduct.id}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>
<div class="linkToArticle" itemscope itemtype="${MICRO_DATA_PRODUCT}">
	<a class="hover_underline" href="${ProductDisplayURL}">
		<div class="backgroundContainer"><%-- TODO : format desktopList ou MobileList selon
		<astpush var="urlImage" url="${produit.fullImage}" device="${}" format="full" source="list" />
		--%>
		<img itemprop="image" alt="${singleProduct.name}" src="${singleProduct.imageURL}"></div> 
		<div class="title"><h2 itemprop="name" content="${singleProduct.name}" title="${singleProduct.name}"><ecocea:crop value="${singleProduct.name}" length="50" /></h2><span>${singleProduct.shortDesc}</span></div>
		<div class="linkArrow"></div> 
	</a>
	<meta itemprop="productId" content="${partNumber}" />
	<meta itemprop="manufacturer" content="${MICRO_DATA_MANUFACTURER}" />
	<meta itemprop="itemCondition" content="NewCondition" />
	<meta itemprop="url" content="${env_absoluteUrlWithoutEndSlash }${ProductDisplayURL}" />
	<meta itemprop="sku" content="${defaultProductSkuValue}" />
</div>
