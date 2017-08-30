<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../../Common/nocache.jspf" %>

<wcbase:useBean id="activeStoreLocationDB" classname="com.lapeyre.declic.commerce.storelocator.beans.FullActiveStoreLocationDataBean">
	<c:set value="${storeId}" target="${activeStoreLocationDB}" property="storeId" />
	<c:set value="${langId}" target="${activeStoreLocationDB}" property="languageId" />
</wcbase:useBean>

<c:set var="fullActiveStores" value="${activeStoreLocationDB.fullActiveStores}" />

<c:set var="formName" value="search${param.trackingType}Form" />
<script>
	$().ready(function() {
		var formId = 'search${param.trackingType}Form';
		// validate signup form on keyup and submit
		$("#" + formId).validate({
			rules: {
				documentNumber: {required:true},
				storeEntity: {required:true}
			},
			messages: {
				documentNumber: "<fmt:message bundle='${storeText}' key='missing${param.trackingType}NumberErrorMessage' />",
				storeEntity: "<fmt:message bundle='${storeText}' key='missingStoreErrorMessage' />",
			},
			submitHandler: onFormSubmitHandler,
			errorPlacement: function(error, element) {
				if (element.is("select")) {
					//For select inputs, insert at the parent
					error.insertAfter(element.parent());
				} else if (element.attr("type") == "radio") {
					//for radio button, insert at the end of the grandparent
					error.appendTo(element.parent().parent());
				}else {
					error.insertAfter(element);
				}
			 }
		});
		
		$('#${formName}-submit-button').on('click', function(e) {
			e.preventDefault();
			$(document.forms.${formName}).submit();
		});
	
	});
</script>


<form id="${formName}" class="searchTrackingForm${param.inlineClass}" action="${param.actionUrl}" method="get" novalidate="novalidate">
	<div class="column <c:if test="${!empty param.inlineClass}">column_30 left bcolumn_100</c:if>">
		<div class="column_label">
			<c:if test="${!empty param.inlineClass}">
				<fmt:message bundle="${storeText}" key="${fn:toLowerCase(param.trackingType)}NumberFieldLabel" var="documentNumberPlaceHolder" />
			</c:if>
			<fmt:message bundle="${storeText}" key="${fn:toLowerCase(param.trackingType)}NumberFieldLabel" />
			<span class="required-field" id="Tracking_DocumentNumber_Required">*</span>
		</div>
		<%-- Escape XML tags to avoid XSS --%>
		<c:set var="escapeDoc"><c:out value="${WCParam.documentNumber}"/></c:set>
		<input type="text" size="30" maxlength="30" name="documentNumber" value="${escapeDoc}" id="Tracking_DocumentNumber" placeholder="${documentNumberPlaceHolder}<c:if test="${!empty param.inlineClass}"> *</c:if>"/>
	</div>
	<c:if test="${!empty param.inlineClass}"><div class="gutter mobile-hidden"></div></c:if>
	<div class="column <c:if test="${!empty param.inlineClass}">column_20 left bcolumn_100</c:if>">
		<div class="column_label">
			<fmt:message key="storeFieldlabel" bundle="${storeText}" />
			<span class="required-field" id="Tracking_storeEntity_Required">*</span>
		</div>
		<!--[if lt IE 10]>
		   	<div class="dropdownLPIE89">
		<![endif]-->
		<![if ! lt IE 10]>
		   	<div class="dropdownLP">
		<![endif]>
			<select class="full-width contactForm-select" name="storeEntity">
				<option value>
					<c:choose>
						<c:when test="${!empty param.inlineClass}">
							<fmt:message bundle="${widgetText}" key="CONTACT_STOREENTITY" /> *
						</c:when>
						<c:otherwise>
							<fmt:message bundle="${widgetText}" key="LAP034_SELECT" />
						</c:otherwise>
					</c:choose>	
				</option>
				<c:forEach var="shop" items="${fullActiveStores}">
					<c:choose>
						<c:when test="${!empty WCParam.storeEntity && WCParam.storeEntity eq shop.identifier}">
							<option value="${shop.identifier}" data-shop-name="${shop.name}" selected>${shop.cp} - ${shop.name}</option>
						</c:when>
						<c:otherwise>
							<option value="${shop.identifier}" data-shop-name="${shop.name}">${shop.cp} - ${shop.name}</option>
						</c:otherwise>
					</c:choose>
					
				</c:forEach>
			</select>
		</div>
	</div>
	<c:if test="${!empty param.inlineClass}"><div class="gutter mobile-hidden"></div></c:if>
	<div class="button_footer_line <c:if test="${!empty param.inlineClass}">column_20 left bcolumn_100</c:if>" id="SubmitButton">
		<a href="#" id="${formName}-submit-button" class="button green column_100 bcolumn_100">
		<c:choose>
				<c:when test="${!empty param.inlineClass}">
						<fmt:message bundle="${storeText}" key="search${param.trackingType}InlineSubmitButtonLabel" />
				</c:when>
				<c:otherwise>
						<fmt:message bundle="${storeText}" key="search${param.trackingType}SubmitButtonLabel" />
				</c:otherwise>
			</c:choose>
		</a>
	</div>
	<c:if test="${!empty param.inlineClass}">
		<span class="mandatoryFieldText"><fmt:message bundle="${storeText}" key="mandatoryFieldLabel"/></span>
	</c:if>
</form>
<div class="clearAll"></div>