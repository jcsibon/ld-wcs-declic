<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN BlocAdresse_UI.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%-- URL pour �dition--%>
	<wcf:url var="AddressModifFormURL" value="AjaxAccountAddressFormPopin" type="Ajax">
		<wcf:param name="langId" value="${langId}" />
		<wcf:param name="storeId" value="${WCParam.storeId}" />
		<wcf:param name="catalogId" value="${WCParam.catalogId}" />
		<wcf:param name="addressId" value="${contact.contactInfoIdentifier.uniqueID}" />
		<wcf:param name="URL" value="AjaxAccountAddressFormResponseJsonView" />
		<wcf:param name="errorViewName" value="AjaxAccountAddressFormResponseJsonView" />
	</wcf:url>
	<div class="shopBlock adress ${(!empty selected && selected eq true)?'selected':''} ${(!empty selectable && selectable eq true)?'selectable':''} ${(!empty disable && disable eq true)?'disable':''}">
		<div class="left ${(!empty selectable && selectable eq true)?'selectable':''}" id="${prefix}_address_${contact.contactInfoIdentifier.uniqueID}" data-address-id="${contact.contactInfoIdentifier.uniqueID}">
			<%-- Escape unwanted XML tags by default to avoid XSS --%>
			<h3><c:out value="${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}" /></h3>
			<span class="shopBlocSeparator"></span>
			<p id="blocAddress_identity_${contact.contactInfoIdentifier.uniqueID}" class="bold"><fmt:message bundle="${storeListe}" key="Civilite_Abreviation_${contact.contactName.personTitle}" var="civ" /><c:if test="${not fn:startsWith(civ,'???')}">${civ}</c:if>&nbsp;<ecocea:crop value="${contact.contactName.firstName} ${contact.contactName.lastName}" length="41" /></p>
			<p id="blocAddress_telephone_${contact.contactInfoIdentifier.uniqueID}">${!empty contact.mobilePhone1?ecocea:fmtPhone(contact.mobilePhone1.value) : (!empty contact.telephone1? ecocea:fmtPhone(contact.telephone1.value) :(!empty contact.telephone2? ecocea:fmtPhone(contact.telephone2.value) :''))}</p>
			<p id="blocAddress_email_${contact.contactInfoIdentifier.uniqueID}">${contact.emailAddress1.value}</p>
			<div class="addresse">
				<p id="blocAddress_addressLine0_${contact.contactInfoIdentifier.uniqueID}"><ecocea:crop value="${contact.address.addressLine[0]}" length="35" /></p>
				<p id="blocAddress_addressLine1_${contact.contactInfoIdentifier.uniqueID}">
					<c:if test="${!empty contact.address.addressLine[1]}">	
						<fmt:message bundle="${storeText}" key="addressBatimentFieldLabel" />&nbsp;: &nbsp;<ecocea:crop value="${contact.address.addressLine[1]}" length="35" />
					</c:if>
				</p>
				<p id="blocAddress_addressLine2_${contact.contactInfoIdentifier.uniqueID}">
				<c:choose>
					<c:when test="${empty contact.address.addressLine[2]}">
						<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" />&nbsp;:&nbsp;<fmt:message bundle="${storeListe}" key="Etage_-1" /><br />
					</c:when>
					<c:otherwise>
						<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" />&nbsp;:&nbsp;<fmt:message bundle="${storeListe}" key="Etage_${contact.address.addressLine[2]}" /><br />
					</c:otherwise>
				</c:choose>
				</p>
				<p>
					<span id="blocAddress_zipCode_${contact.contactInfoIdentifier.uniqueID}"><c:out value="${contact.address.postalCode}"/>
					</span>&nbsp;<span id="blocAddress_City_${contact.contactInfoIdentifier.uniqueID}"><c:out value="${contact.address.city}"/></span>
				</p>
				<%--mantis 2108 : afficher le pays si diff�rent de FR --%>
					<c:if test="${contact.address.country ne 'FR' }" >
						<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
							<c:set target="${countryBean}" property="countryCode" value="${CommandContext.country}" />
						</wcbase:useBean>
						<c:forEach var="countryItem" items="${countryBean.countries}">
							<c:if test="${countryItem.code eq contact.address.country}">
								<p class="uppercase">${countryItem.displayName }</p>
							</c:if>
						</c:forEach>
					</c:if>
				
				
			</div>
		</div>
		<c:if test="${!empty editable && editable eq true}">
			<a class="bottom" onclick="javascript:openAddressForm('<c:out value="${AddressModifFormURL}" />',true);return false;" href="#"></a>
		</c:if>
		<c:if test="${!empty contact.address.addressLine[2]}">
<%-- TODO rafraichir le bloc adresse au clic sur onglet livraison (mantis 3443)
Solution d�grad� : masquer l'info suppl�ment �tage (modeTransporterInhibe au lieu de mode Transporter
  --%>
			<c:if test="${(empty isBillingAddress || isBillingAddress eq false) && !empty orderShippingData && orderShippingData.shippingMode_idClient eq modeTransporter }">
				<c:choose>
					<c:when test="${!empty eligible && eligible eq true && !empty disable && disable eq true}">
						<div id="supEtage_${contact.contactInfoIdentifier.uniqueID}" class="left priceEtageInfo noStoreFound" style="display:block">${noStoreForAddressMessageTop}</div>
					</c:when>
					<c:when test="${!empty eligible && eligible eq false && !empty disable && disable eq true}">
						<div id="supEtage_${contact.contactInfoIdentifier.uniqueID}" class="left priceEtageInfo noStoreFound" style="display:block">${addressNotEligibleErrorMessage}</div>
					</c:when>
				<%--suppression du bloc information pour les supplements d'etage--%>
					<%-- <c:otherwise>
						<div id="supEtage_${contact.contactInfoIdentifier.uniqueID}" class="left priceEtageInfo">--%>
							<%-- 0002052: [Livraison] - Anomalie zone adresse de livraison --%>
							<%-- <c:choose>
								<c:when test="${!empty supEtageTTC}">
									<fmt:message key="supEtageInfoMessage" bundle="${widgetText}">
										<fmt:param value="${supEtageTTC}"/>
									</fmt:message>
								</c:when>
								<c:otherwise>
									<fmt:message key="supEtageInfoMessageFree" bundle="${widgetText}"/>
								</c:otherwise>
							</c:choose>
						</div>	
					</c:otherwise>--%>
				</c:choose>
				
	  		</c:if>
		</c:if>
	</div>
<!-- END BlocAdresse_UI.jsp -->
