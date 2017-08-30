<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<%
	if(request.getAttribute("modeTransporter") == null) {
    	String modeTransporter = ConfigTool.getConfigurationPropertiesResource().getProperty("LivraisonTransporterIdMetier");
    	request.setAttribute("modeTransporter",modeTransporter);
    }
%>
<c:if test="${empty person}" >
 	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" var="person" expressionBuilder="findCurrentPerson">
	       <wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
</c:if>
<c:set var="addressBookBean" value="${person.addressBook}"/>

<c:set var="prefixSelect" value="select"/>
<c:set var="prefixDefault" value="default"/>
<c:set var="prefixFacturationAddress" value="facturation"/>

<c:set var="addressIds" value="${person.contactInfo.contactInfoIdentifier.uniqueID}"/>

<c:forEach items="${addressBookBean.contact}" var="contact" varStatus="status">
	<c:choose>
		<c:when test="${!empty addressIds }">
			<c:set var="addressIds" value="${addressIds},${contact.contactInfoIdentifier.uniqueID}"/>
		</c:when>
		<c:otherwise>
			<c:set var="addressIds" value="${contact.contactInfoIdentifier.uniqueID}"/>
		</c:otherwise>
	</c:choose>
</c:forEach>

<c:if test="${!empty addressIds && !empty orderId && !empty userId }">
<%-- Calcul du magasin de gestion pour la livraison --%>
	<ecocea:calculateShippingShopforAddress 
		var="shippingShopsForAddress" 
		addressIds="${addressIds}" 
		orderId="${orderId}" 
		langId="${langId}" 
		storeId="${WCParam.storeId}" 
		userId="${userId}"
	/>
</c:if>
<ecocea:orderShipping var="orderShippingData" orderId="${orderId}" scope="2"/>

		<c:set var="contact" value="${person.contactInfo}"/>
		<%-- la 1e adresse, par défaut, est la primary et non la self , et la self est a ajoutee si mari les shipping et pas la primary --%>
		<c:if test="${!empty shippingShopsForAddress}">
			<c:forEach var="adrForPrimary" items="${shippingShopsForAddress}">
				<c:choose>
				<c:when test="${adrForPrimary.value.primary == '1'}">
					<c:set var="primaryId" value="${adrForPrimary.key}"/>
				</c:when>
				<c:otherwise>
					<c:if test="${adrForPrimary.value.self == '1' }">
					<c:set var="selfAdress" value="${contact}" />
					</c:if>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			
		</c:if>
<c:forEach var="entry" items="${shippingShopsForAddress}">
   <c:if test="${entry.key eq primaryId}">
   		<c:forEach var="shop" items="${entry.value.shops}" varStatus="status">
   			<c:if test="${status.index eq '0'}">
   				<c:set var="defaultShopForShipping" value="${shop}"/>
   			</c:if>
   			<c:if test="${shop.strLocId eq fullStoreDB1.strLocId }">
   				<c:set var="defaultShopForShipping" value="${shop}"/>
   			</c:if>
   		</c:forEach>
   		<c:set var="ShopsListOfCurrentAddress" value="${entry.value.shops}"/>
  	</c:if>
</c:forEach>

<%-- <c:forEach items="${catalogNavigationView.catalogEntryView}" var="catalogEntryDetails">
			<c:if test="${!empty catalogEntryDetails.type && catalogEntryDetails.type eq STANDARD_PRODUCT}">
				<c:set var="productStandardExists" value="true"/>
			</c:if>
			<c:if test="${!empty catalogEntryDetails.type && catalogEntryDetails.type eq CATALOGUE_PAPIER_PRODUCT}">
				<c:set var="productCatalogExists" value="true"/>
			</c:if>
</c:forEach>

<c:if test="${!productStandardExists && productCatalogExists}">
	<c:set var="isCatalogCommand" value="true"/>
</c:if> --%>