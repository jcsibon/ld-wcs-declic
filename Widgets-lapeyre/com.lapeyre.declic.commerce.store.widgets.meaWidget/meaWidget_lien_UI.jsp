<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%-- c'est une jsp qui determine l'url du lien et est commune � tous les liens MEA :
 vu que les liens sont quant � eux g�r�s de maniere diff�rente selon les liens, on a pr�f�r� ne faire
 qu'evaluer l'url et laisser a dispo de chaque mea la gestion de l'affichage du lien
--%>
<c:set var="linkUrl" value="" scope="request"/>
<c:choose>
	<c:when test="${param.type == 0}">
		<wcf:rest var="catGroup" url="${searchHostNamePath}${searchContextPath}/store/${storeId}/categoryview/${param.lien}" >
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="responseFormat" value="json" />
				<wcf:param name="catalogId" value="${catalogId}" />
				<wcf:param name="searchProfile" value="IBM_findCategoryByIdentifier" />
		</wcf:rest>
		<c:if test="${catGroup.recordSetTotal > 0}">
			<wcf:url var="linkUrl" patternName="CanonicalCategoryURL" value="Category3" scope="request">
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="storeId" value="${storeId}" />
				<wcf:param name="catalogId" value="${catalogId}" />
				<wcf:param name="categoryId" value="${catGroup.catalogGroupView[0].uniqueID}" />	
				<wcf:param name="urlLangId" value="${urlLangId}" />							
			</wcf:url>
		</c:if>
	</c:when>
	<c:when test="${param.type == 1}">
		<wcf:rest var="catEntry" url="${searchHostNamePath}${searchContextPath}/store/${storeId}/productview/${param.lien}" >
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="responseFormat" value="json" />
				<wcf:param name="catalogId" value="${catalogId}" />
				<wcf:param name="searchProfile" value="IBM_findProductByPartNumber_Summary" />
		</wcf:rest>
		<c:if test="${catEntry.recordSetTotal > 0}">
			<wcf:url var="linkUrl" patternName="ProductURL" value="ProductDisplay" scope="request">
				<wcf:param name="productId" value="${catEntry.catalogEntryView[0].uniqueID}" />
				<wcf:param name="langId" value="${langId}" />
				<wcf:param name="storeId" value="${WCParam.storeId}" />
				<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				<wcf:param name="urlLangId" value="${urlLangId}" />
			</wcf:url>
		</c:if>
	</c:when>
	<%-- Modifié côté CMS qui renvoie désormais l'URL content --%>
	<%-- <c:when test="${param.type == 2}">
		<c:set var="linkUrl" value="${param.lien}" scope="request"/>
	</c:when> --%>
	<c:otherwise>
		<c:set var="linkUrl" value="${param.lien}" scope="request"/>
	</c:otherwise>
</c:choose>

<c:if test="${not empty param.paramLien}">
	<c:set var="linkUrl" value="${linkUrl}${fn:contains(linkUrl, '?') ? '&' : '?'}${param.paramLien}" scope="request"/>
</c:if>