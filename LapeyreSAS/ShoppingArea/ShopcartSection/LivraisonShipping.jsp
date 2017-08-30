		<%-- affichage de l'adresse principale --%>
		<c:set var="contact" value="${person.contactInfo}"/>
		<c:set var="prefix" value="${prefixLivraison}_${prefixSelect}"/>
		
		<%-- selectionner primary d'abord puis boucler sur les autres y compris self si ce n est pas la primary --%>
		<c:if test="${!empty shippingShopsForAddress}">
			<wcf:useBean var="tempautresAddresses" classname="java.util.ArrayList"/>
			<c:forEach items="${addressBookBean.contact}" var="adrForPrimary">
				<c:choose>
					<c:when test="${adrForPrimary.contactInfoIdentifier.uniqueID == primaryId}">
						<c:set var="primaryAddress" value="${adrForPrimary}" />
					</c:when>
					<c:otherwise>
						<wcf:set target="${tempautresAddresses}"  value="${adrForPrimary}"/>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${!empty selfAdress}">
				<wcf:set target="${tempautresAddresses}"  value="${selfAdress}"/>
			</c:if>
			<c:if test="${empty primaryAddress && contact.contactInfoIdentifier.uniqueID == primaryId }">
				<c:set var="primaryAddress" value="${contact}" />
			</c:if>
 		</c:if>
 		
 		<wcf:useBean var="autresAddresses" classname="java.util.ArrayList"/>
 		<wcf:set target="${autresAddresses}"  value="${primaryAddress}"/>
 		<c:forEach items="${tempautresAddresses}" var="autreAdresse">
			<wcf:set target="${autresAddresses}"  value="${autreAdresse}"/>
		</c:forEach>

		<%-- affichage les autres adresses --%>
		<c:forEach items="${autresAddresses}" var="contact" varStatus="varstat">
			<c:set var="prefix" value="${prefixLivraison}_${prefixSelect}"/>
			<c:set var="selected" value="${varstat.first}"/>	
			<c:set var="selectable" value="true"/>
			<c:set var="disable" value="false"/>
			<c:set var="eligible" value="true"/>
			<c:set var="adresseCourante" value="${shippingShopsForAddress[contact.contactInfoIdentifier.uniqueID]}" />
			<c:set var="editable" value="${!extendedUserContext.isPro || adresseCourante.self == '0'}"/>
			<c:choose>
				<c:when test="${empty isCatalogCommand || isCatalogCommand eq false}">
					<c:if test="${empty adresseCourante || adresseCourante.eligible eq false || empty adresseCourante.shops}">
						<c:set var="selected" value="false"/>
						<c:set var="selectable" value="false"/>
						<c:set var="disable" value="true"/>
					</c:if>
					<c:if test="${empty adresseCourante || adresseCourante.eligible eq false}">
						<c:set var="eligible" value="false"/>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${empty adresseCourante || adresseCourante.eligible eq false}">
						<c:set var="selected" value="false"/>
						<c:set var="selectable" value="false"/>
						<c:set var="disable" value="true"/>
						<c:set var="eligible" value="false"/>
					</c:if>
				</c:otherwise>
			</c:choose>
			<%-- 0002052: [Livraison] - Anomalie zone adresse de livraison --%>
			<c:remove var="supEtageTTC"/>
			<c:if test="${!empty adresseCourante && !empty adresseCourante.supEtage_TTC && sadresseCourante.supEtage_TTC > 0}">
				<fmt:formatNumber var="supEtageTTC" value="${adresseCourante.supEtage_TTC}" type="currency" maxFractionDigits="${env_currencyDecimal}" currencySymbol="<sup>${env_CurrencySymbolToFormat}</sup>"/>
			</c:if>
			<%@ include file="Common/BlocAdresse/BlocAdresse_UI.jsp" %>
		</c:forEach>
		