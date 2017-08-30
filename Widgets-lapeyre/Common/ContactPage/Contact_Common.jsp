<c:choose>
	<c:when test="${WCParam.formName eq 'contactServiceClient' }">
		<fmt:message key="contactServiceClientAccroche" var="accroche" 	bundle="${widgetText}" />
		<fmt:message key="contactServiceClientSubTitle" var="subtitle" 	bundle="${widgetText}" />
		<fmt:message key="CONTACT_SUBJECT_SERVICE" 		var="subjects"	bundle="${widgetText}" />
	</c:when>
	<c:when test="${WCParam.formName eq 'contactSuiviCommande'}">
		<fmt:message key="contactSuiviCommandeWebAccroche"  var="accroche" 	bundle="${widgetText}" />
		<fmt:message key="contactSuiviCommandeWebSubTitle"  var="subtitle" 	bundle="${widgetText}" />
		<fmt:message key="CONTACT_SUBJECT_SUIVI" 			var="subjects"	bundle="${widgetText}" />
	</c:when>
	<c:when test="${WCParam.formName eq 'contactValidationCommande'}">
		<fmt:message key="contactValidateCommandeWebAccroche" var="accroche" 	bundle="${widgetText}" />
		<fmt:message key="contactValidateCommandeWebSubTitle" var="subtitle" 	bundle="${widgetText}" />
		<fmt:message key="CONTACT_SUBJECT_VALIDATION" 		  var="subjects"	bundle="${widgetText}" />
	</c:when>
	<c:when test="${WCParam.formName eq 'contactWebmaster'}">
		<fmt:message key="contactWebmasterAccroche" 	var="accroche"	 bundle="${widgetText}" />
		<fmt:message key="contactWebmasterSubTitle" 	var="subtitle"	 bundle="${widgetText}" />
		<fmt:message key="CONTACT_SUBJECT_WEBMASTER" 	var="subjects"	 bundle="${widgetText}" />
	</c:when>
	<c:when test="${WCParam.formName eq 'contactServiceExport'}">
		<fmt:message key="contactServiceExportAccroche" var="accroche" bundle="${widgetText}" />
		<fmt:message key="contactServiceExportSubTitle" var="subtitle" bundle="${widgetText}" />
	</c:when>
	<c:when test="${WCParam.formName eq 'contactPartner'}">
		<fmt:message key="contactPartenariatPropositionAccroche" var="accroche"  bundle="${widgetText}" />
		<fmt:message key="contactPartenariatPropositionSubTitle" var="subtitle"  bundle="${widgetText}" />
		<fmt:message key="CONTACT_FLOOR_LIST"					 var="floorList" 	 bundle="${widgetText}"  />
		<fmt:message key="CONTACT_BUSINESS_TYPE_LIST"			 var="businessList" 	 bundle="${widgetText}"  />
		<fmt:message key="CONTACT_SKILL_LIST"					 var="skillList" 	 bundle="${widgetText}"  />
		<fmt:message key="CONTACT_COMPANY_SIZE_LIST"			 var="companySizeList" 	 bundle="${widgetText}"  />
		<c:set var="companySizes" value="${fn:split(companySizeList, ',')}" />
		<c:set var="skills" value="${fn:split(skillList, ';')}" />
		<c:set var="businessTypeList" value="${fn:split(businessList, ',')}" />
		<fmt:message bundle='${widgetText}' key='DATE_BEFORE_MAX_YEAR' var="beforeMaxYear" />
		<fmt:message bundle='${widgetText}' key='DATE_MAX_YEAR' var="maxYear" />
		<jsp:useBean id="date" class="java.util.Date" />
		<fmt:formatDate value="${date}" pattern="yyyy" var="currentYear" />
	</c:when>
</c:choose>

<c:set var="contactImage" value="${isOnMobileDevice ? 'contact_mobile.png' : 'contact_dektop_960x147.png'}" />

<c:if test="${userType != 'G'}">
	<wcf:getData type="com.ibm.commerce.member.facade.datatypes.PersonType" 
					var="person" expressionBuilder="findCurrentPerson">
			<wcf:param name="accessProfile" value="IBM_All" />
	</wcf:getData>
	<c:set var="contact_personTitle" value="${person.contactInfo.contactName.personTitle}"/>
	<c:if test="${extendedUserContext.isPro ne true }">
		<c:set var="contact_firstName" value="${person.contactInfo.contactName.firstName}"/>
		<c:set var="contact_lastName" value="${person.contactInfo.contactName.lastName}"/>
	</c:if>
	<c:set var="contact_email" value="${person.credential.logonID}"/>
	
	<c:set var="contact_address1" value="${person.contactInfo.address.addressLine[0]}"/>
	<c:set var="contact_address2" value="${person.contactInfo.address.addressLine[1]}"/>
	<c:set var="contact_address3" value="${person.contactInfo.address.addressLine[2]}"/>
	<c:set var="contact_zipCode" value="${person.contactInfo.address.postalCode}"/>
	<c:set var="contact_city" value="${person.contactInfo.address.city}"/>
	<c:set var="contact_country" value="${person.contactInfo.address.country}"/>
	
	<c:set var="contact_mobilePhone" value="${person.contactInfo.mobilePhone1.value}"/>
	<c:set var="contact_phone" value="${person.contactInfo.telephone1.value}"/>
	<c:set var="contact_fax" value="${person.contactInfo.fax1.value}"/>
	
	<c:set var="companyName" value="${person.contactInfo.organizationName}"/>
	<c:set var="contact_codeEffectif" value="${person.personalProfile.attributes['userProfileField1']}"/>
	<c:set var="contact_companyType" value="${person.personalProfile.attributes['demographicField3']}"/>
	
	
	
</c:if>

<wcbase:useBean id="activeStoreLocationDB" classname="com.lapeyre.declic.commerce.storelocator.beans.FullActiveStoreLocationDataBean">
	<c:set value="${storeId}" target="${activeStoreLocationDB}" property="storeId" />
	<c:set value="${langId}" target="${activeStoreLocationDB}" property="languageId" />
</wcbase:useBean>

<c:set var="fullActiveStores" value="${activeStoreLocationDB.fullActiveStores}" />

<c:if test="${!empty subjects}">
	<c:set var="subjectList" value="${fn:split(subjects, ',')}" />
</c:if>

<fmt:message bundle="${widgetText}" key="CONTACT_PERSONTITLE_LIST" var="personTitles"/>
<c:set var="personTitleList" value="${fn:split(personTitles, ',')}" />

<div class="contactPresentation">
		<div class="contactBackground">
			<img class="full-width" alt="ContactHeader" src="${jspStoreImgDir}images/${contactImage}">
		</div>
		<div class="textContainer">
			<span class="surTitre"><fmt:message key="contactPageTitle" bundle="${widgetText}" /></span>
			<br clear="all">
			<img alt="separator" src="${jspStoreImgDir}images/separator.png">
			<h1 id="contactPresentation-details">${subtitle}</h1>
		</div>
</div>
<br />
<div class="contactAccroche">
	${accroche}
</div>
<br />
