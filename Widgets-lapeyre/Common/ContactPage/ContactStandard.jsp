<!-- BEGIN ContactStandard.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%@ include file="Contact_Common.jsp" %>


<script>

$().ready(function() {

	// validate signup form on keyup and submit
	$("#ContactForm").validate({
		rules: {
			subject: "required",
<c:if test="${extendedUserContext.isPro ne true }" >
			personTitle: "required",
			firstName:{
				required: true,
				maxlength:120
			},
</c:if>
			zipCode: {
				required: true,
				maxlength: 5
			},
			lastName:{
				required: true,
				maxlength:100
			},
			email: {
				required: true,
				email: true,
				maxlength: 100
			},
			message: {
				required: true,
				maxlength:4000
			},
			documentNumber:{
				digits:true
			}
		},
		messages: {
			personTitle: "<fmt:message bundle='${widgetText}' key='missingPersontitleErrorMessage' />",
			subject: "<fmt:message bundle='${widgetText}' key='missingSubjectErrorMessage' />",
			firstName: {
				required: "<fmt:message bundle='${widgetText}' key='missingFirstnameFieldErrorMessage' />",
				maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthFirstnameFieldErrorMessage' />"
			},
			lastName: {
				required: "<fmt:message bundle='${widgetText}' key='missingLastameFieldErrorMessage' />",
				maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthFirstnameFieldErrorMessage' />"
			},
			email: {
				required: "<fmt:message bundle='${widgetText}' key='missingEmailErrorMessage' />",
				email: "<fmt:message bundle='${widgetText}' key='InvalidEmailErrorMessage' />",
				maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthEmailErrorMessage' />"
			},
			zipCode: {
				required: "<fmt:message bundle='${widgetText}' key='missingZipCodeMessage' />",
				maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthZipCodeMessage' />"
			},
			message: {
				required: "<fmt:message bundle='${widgetText}' key='missingMessageErrorMessage' />",
				maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthMessageErrorMessage' />"
			},
			documentNumber:{
				digits: "<fmt:message bundle='${widgetText}' key='nonNumericErrorMessage' />"
			}
		},
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
	
	<c:if test="${WCParam.formName eq 'contactWebmaster'}" >
		$("#Contact_DocumentNumber_Container").hide();
	</c:if>
	
});


</script>
<div id="contentWrapper">
	<div id="content" role="main">
		<div class="rowContainer">
			<div class="row contactForms">
				<div class="sign_in_registration" id="ContactForm_Container">
					<form name="ContactForm" method="post" action="SendContactEmailCmd" id="ContactForm" novalidate="novalidate">
						<div class="form" id="ContactForm_SubContainer">
							<div class="content" id="ContactForm_Content">
								<div class="align" id="ContactForm_Align">
									<div class="form_3column" id="ContactForm_3Column">
										<input type="hidden" name="formName" value="${param.formName}" />
										<input type="hidden" name="viewName" value="AjaxContactFormResponseJsonView" />
										<input type="hidden" name="errorViewName" value="AjaxContactFormResponseJsonView" />
										<div class="column column_100 bcolumn_100" id="Contact_Subject_Container">
											<div id="Contact_Subject_Label" class="column_label">
											<fmt:message key="CONTACT_SUBJECT" bundle="${widgetText}" />
											<span class="required-field" id="Contact_StoreEntity_Required"> *</span>
											</div>
											<div class="dropdownLP contactForm-full-width-dropdown">
												<select id="Contact_Subject_Select" class="full-width contactForm-select" name="subject">
													<option value><fmt:message bundle="${widgetText}" key="SELECT_ONE" /></option>
													<c:forEach var="subject" items="${subjectList}">
														<option value="${subject}">${subject}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="clearAll"></div>
										<input type="hidden" name="isPro" value="${extendedUserContext.isPro}" />
										<c:choose>
											<c:when test="${extendedUserContext.isPro eq true }" >
												<div class="bcolumn_100" id="Contact_Name_Container">
													<div id="Contact_Name_Label" class="column_label">
														<fmt:message key="CONTACT_COMPANYNAME" bundle="${widgetText}" />
														<span class="required-field" id="Contact_Name_Required"> *</span> 
													</div>
													<input type="text" maxlength="100" size="100" aria-required="true" id="Contact_Name" name="lastName" value="<c:if test='${!empty contact_lastName }'>${contact_lastName}</c:if>" required />
												</div>
											</c:when>
											<c:otherwise>										
												<div class="column column_20 bcolumn_30" id="Contact_PersonTitle_Container">
													<div id="Contact_PersonTitle" class="column_label">
														<fmt:message key="CONTACT_PERSONTITLE" bundle="${widgetText}" />
														<span class="required-field" id="Contact_PersonTitle_Required"> *</span>
													</div>
													<div class="dropdownLP contactForm-dropdown">												
														<select class="contactForm-select" name="personTitle">
															<option value="">-</option>
															<c:forTokens items="${listCivilitePart}" delims="," var="token">
															    <option value="<fmt:message bundle="${storeListe}" key="Civilite_${token}" />" <c:if test="${token==contact_personTitle}">selected</c:if> >
																	<fmt:message bundle="${storeListe}" key="Civilite_${token}" />
																</option>
															</c:forTokens>
														</select>
													</div>
												</div>
												<div class="gutter"></div>
												<div class="column column_25-5 bcolumn_67" id="Contact_Firstname_Container">
													<div id="Contact_Firstname_Label" class="column_label">
														<fmt:message key="CONTACT_FIRSTNAME" bundle="${widgetText}" />
														<span class="required-field" id="Contact_Firstname_Required"> *</span> 
													</div>
													<input type="text" maxlength="120" size="22" id="Contact_Firstname" name="firstName" value="<c:if test='${!empty contact_firstName }'>${contact_firstName}</c:if>" required />
												</div>
												<div class="gutter mobile-hidden"></div>
												<div class="column column_48-5 bcolumn_100" id="Contact_Name_Container">
													<div id="Contact_Name_Label" class="column_label">
														<fmt:message key="CONTACT_LASTNAME" bundle="${widgetText}" />
														<span class="required-field" id="Contact_Name_Required"> *</span> 
													</div>
													<input type="text" maxlength="100" size="34" aria-required="true" id="Contact_Name" name="lastName" value="<c:if test='${!empty contact_lastName }'>${contact_lastName}</c:if>" required />
												</div>
											</c:otherwise>
										</c:choose>
										<div class="clearAll"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_Email_Container">
											<div class="column_label" id="Contact_Email_Label">
												<fmt:message key="CONTACT_EMAIL" bundle="${widgetText}" />
												<span class="required-field" id="Contact_Email_Required">*</span>
											</div>
											<input type="email" size="39" maxlength="100" aria-required="true" name="email" id="Contact_Email" value="<c:if test='${!empty contact_email }'>${contact_email}</c:if>" required />
										</div>
										<div class="gutter mobile-hidden"></div>
										<div class="column column_25-5 bcolumn_100" id="Contact_ZipCode_Container">
											<div id="Contact_ZipCode_Label" class="column_label">
												<fmt:message key="CONTACT_ZIPCODE" bundle="${widgetText}" />
												<span class="required-field" id="Contact_ZipCode_Required">*</span>
											</div>
											<input type="text" maxlength="5" size="15" aria-required="true" id="Contact_ZipCode" name="zipCode" value="<c:if test='${!empty contact_zipCode }'>${contact_zipCode}</c:if>" />
										</div>
										<div class="clearAll"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_StoreEntity_Container">
											<div id="Contact_StoreEntity_Label" class="column_label">
											<fmt:message key="CONTACT_STOREENTITY" bundle="${widgetText}" />
											<span class="required-field" id="Contact_StoreEntity_Required"></span>
											</div>
											<div class="dropdownLP contactForm-half-width-dropdown">
												<select class="full-width contactForm-select" name="storeEntity">
													<option value><fmt:message bundle="${widgetText}" key="SELECT_ONE" /></option>
													<c:forEach var="shop" items="${fullActiveStores}" >
														<c:set var="selectedAttribute" value="${shop.identifier eq param.idMagasin ? 'selected' : ''}" />
														<option value="${shop.identifier}" data-shop-name="${shop.name}" ${selectedAttribute}>${shop.cp} - ${shop.name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="gutter mobile-hidden"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_DocumentNumber_Container">
											<div class="column_label" id="Contact_DocumentNumber_Label">
												<fmt:message key="CONTACT_DOCUMENTNUMBER" bundle="${widgetText}" />
												<span class="required-field" id="Contact_DocumentNumber_Required"></span>
											</div>
											<input size="34" maxlength="50" aria-required="true" name="documentNumber" id="Contact_DocumentNumber" type="text" value="" />
										</div>
										<div class="clearAll"></div>
										<div class="column column_100 bcolumn_100" id="Contact_Message_Container">
											<div class="column_label" id="Contact_Message_Label">
												<fmt:message key="CONTACT_MESSAGE" bundle="${widgetText}" />
												<span class="required-field" id="Contact_Message_Required">*</span>
											</div>
											<textarea name="message" class="textarea-contact" id="Contact_Message"></textarea>
										</div>
										<script>
											<%--Autosize textarea: Copy the message in a hidden div, get its height and then assign it to the textarea --%>
											var txt = $('#Contact_Message'),
										    hiddenDiv = $(document.createElement('div')),
										    content = null;
											hiddenDiv.addClass('hiddendiv');
											$('#Contact_Message_Container').append(hiddenDiv);
											txt.on('keyup', function () {
											    content = $(this).val();
											    content = content.replace(/\n/g, '<br>');
											    hiddenDiv.html(content);
											    $(this).css('height', hiddenDiv.height()+50);
											});
										</script>
										<div class="clearAll"></div>
								</div>
								<div class="button_footer_line no_float" id="Contact_Button_Container">
									<fmt:message key="contactSubmitButtonlabel" var="sendLabel" bundle="${widgetText}" />
									<fmt:message key="contactCancelButtonLabel" var="cancelLabel" bundle="${widgetText}" />
									<a href="contact" class="button">${cancelLabel}</a>
									<input type="submit" id="submit" value="${sendLabel}" class="button green" onclick="dataLayer.push({'event':'contactRequest','requestType':$('#Contact_Subject_Select').val()});">
									<br clear="all" />
								</div>
								<div class="error alignCenter" id="mailNotSendMessageError" style="display:none;">
									<fmt:message bundle="${storeText}" key="akioEmailGenerationErrorMessage" />
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- END ContactStandard.jsp -->