<!-- BEGIN ContactPartner.jsp -->
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<%@ include file="Contact_Common.jsp" %>
<c:set var="country" value="${CommandContext.country}" scope="request" />
<%-- The following JS sets the required fields, validation methods and error messages --%>
<script>		
	var countryTagID = "countryField";
	$().ready(function() {
		
		// validate signup form on keyup and submit
		$("#ContactForm").validate({
			rules: {
				personTitle: "required",
				companyName: {
					required: true,
					maxlength:120
				},
				
				companyType: {
					required: true,
				},
				companySize: {
					required: true,
				},
				address1: {
					required: true,
					maxlength:38
				},
				address2: {
					maxlength:38
				},
				phone: {
					maxlength:20,
					require_from_group: [1, ".phone-group"],
					validatePhoneFR: [countryTagID]
				},
				mobilePhone: {
					maxlength:20,
					require_from_group: [1, ".phone-group"],
					validatePhoneFR: [countryTagID]
				},
				city: {
					required: true,
					maxlength:100
				},
				zipCode: {
					required: true,
					maxlength:20
				},
				firstName:{
					required: true,
					maxlength:100
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
				storeEntity1: {
					required: true,
				},
				insurerName: {
					required: true
				},
				insurancePolicyNumber: {
					required: true
				},
				companyEstablishment_day: {
					skip_or_fill_minimum: [3, ".companyEstablishment-group"]
			    },
			    companyEstablishment_month: {
			    	skip_or_fill_minimum: [3, ".companyEstablishment-group"]
			    },
			    companyEstablishment_year: {
			    	skip_or_fill_minimum: [3, ".companyEstablishment-group"]
			    },
			    insuranceTerm_day: {
			    	skip_or_fill_minimum: [3, ".insuranceTerm-group"]
			    },
			    insuranceTerm_month: {
			    	skip_or_fill_minimum: [3, ".insuranceTerm-group"]
			    },
			    insuranceTerm_year: {
			    	skip_or_fill_minimum: [3, ".insuranceTerm-group"]
			    }
			},
			messages: {
				personTitle: "<fmt:message bundle='${widgetText}' key='missingPersontitleErrorMessage' />",
				firstName: {
					required: "<fmt:message bundle='${widgetText}' key='missingFirstnameFieldErrorMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthFirstnameFieldErrorMessage' />"
				},
				
				lastName: {
					required: "<fmt:message bundle='${widgetText}' key='missingLastameFieldErrorMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthLastnameFieldErrorMessage' />"
				},
				email: {
					required: "<fmt:message bundle='${widgetText}' key='missingEmailErrorMessage' />",
					email: "<fmt:message bundle='${widgetText}' key='InvalidEmailErrorMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthEmailErrorMessage' />"
				},
				companyName: {
					required: "<fmt:message bundle='${widgetText}' key='missingRaisonSocialeErrorMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLegnthraisonSocialeErrorMessage' />"
				},
				companyType: {
					required: "<fmt:message bundle='${widgetText}' key='missingTypeEntrepriseErrorMessage' />"
				},
				address1: {
					required: "<fmt:message bundle='${widgetText}' key='missingStreetErrorMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthStreetErrorMessage' />"
				},
				address2: {
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />"
				},
				adress3: {
					required: "<fmt:message bundle='${widgetText}' key='missingFloorErrorMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthFloorErrorMessage' />"
				},
				phone: {
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />",
					require_from_group: "<fmt:message bundle='${widgetText}' key='missingPhoneErrorMessage' />",
					validatePhoneFR: "<fmt:message bundle='${widgetText}' key='InvalidPhoneFormatErrorMessage' />"
				},
				mobilePhone: {
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthErrorMessage' />",
					require_from_group: "<fmt:message bundle='${widgetText}' key='missingPhoneErrorMessage' />",
					validatePhoneFR: "<fmt:message bundle='${widgetText}' key='InvalidPhoneFormatErrorMessage' />"
				},
				city: {
					required: "<fmt:message bundle='${widgetText}' key='missingCityErrorMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthCityErrorMessage' />"
				},
				zipCode: {
					required: "<fmt:message bundle='${widgetText}' key='missingZipCodeMessage' />",
					maxlength: "<fmt:message bundle='${widgetText}' key='maxLengthZipCodeMessage' />"
				},
				companySize: {
					required : "<fmt:message bundle='${widgetText}' key='missingEffectifErrorMessage' />"
				},
				storeEntity1: {
					required: "<fmt:message bundle='${widgetText}' key='missingShopErrorMessage' />"
				},
				insurerName: {
					required: "<fmt:message bundle='${widgetText}' key='missingInsurerNameErrorMessage' />"
				},
				insurancePolicyNumber: {
					required: "<fmt:message bundle='${widgetText}' key='missingInsurancePolicyNumberErrorMessage' />"
				},
				companyEstablishment_day: {
					skip_or_fill_minimum: "<fmt:message bundle='${widgetText}' key='incompleteDate' />"	
				},
				companyEstablishment_month: {
					skip_or_fill_minimum: "<fmt:message bundle='${widgetText}' key='incompleteDate' />"	
				},
				companyEstablishment_year: {
					skip_or_fill_minimum: "<fmt:message bundle='${widgetText}' key='incompleteDate' />"	
				},
				insuranceTerm_day: {
					skip_or_fill_minimum: "<fmt:message bundle='${widgetText}' key='incompleteDate' />"	
				},
				insuranceTerm_month: {
					skip_or_fill_minimum: "<fmt:message bundle='${widgetText}' key='incompleteDate' />"	
				},
				insuranceTerm_year: {
					skip_or_fill_minimum: "<fmt:message bundle='${widgetText}' key='incompleteDate' />"	
				}
			},
			groups: {
				phones: "phone mobilePhone",
				companyEstablishment: "companyEstablishment_day companyEstablishment_month companyEstablishment_year",
				insuranceTerm: "insuranceTerm_day insuranceTerm_month insuranceTerm_year"
				
			},
			errorPlacement: function(error, element) {
				if (element.is("[name^='companyEstablishment']")) {
					error.appendTo($(".errorPlacement[for='Contact_CompanyEstablishment_Container']"));
				} else if (element.is("[name^='insuranceTerm']")) {
					error.appendTo($(".errorPlacement[for='Contact_InsuranceTerm_Container']"));
				} else if (element.is("select")) {
					//For select inputs, insert at the parent
					error.insertAfter(element.parent());
				} else if (element.attr("type") == "radio") {
					//for radio button, insert at the end of the grandparent
					error.appendTo(element.parent().parent());
				} else {
					error.insertAfter(element);
				}
			 }
		});
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
										<div class="column column_48-5 bcolumn_100" id="Contact_CompanyName_Container">
											<div id="Contact_CompanyName_Label" class="column_label">
												<fmt:message key="CONTACT_COMPANYNAME" bundle="${widgetText}" />
												<span class="required-field" id="Contact_CompanyName_Required">*</span>
											</div>
											<input type="text" maxlength="120" size="40" aria-required="true" id="Contact_CompanyName" name="companyName" value="<c:if test='${!empty companyName }'>${companyName}</c:if>" />
										</div>
										<div class="gutter mobile-hidden"></div>
										
										<div class="column column_20 bcolumn_100" id="Contact_CompanyType_Container">
											<div class="column_label" id="Contact_CompanyType_Label">
												<fmt:message key="CONTACT_COMPANYTYPE" bundle="${widgetText}" />
												<span class="required-field" id="Contact_CompanyType_Required"> *</span>
											</div>
											<div class="dropdownLP contactForm-dropdown">
												<select  class="contactForm-select" name="companyType">
													<option value="">-</option>
													<c:forTokens items="${listCivilitePro}" delims="," var="token">
														<option value="<fmt:message bundle="${storeListe}" key="Civilite_${token}" />" <c:if test="${token == contact_companyType}">selected</c:if>>
															<fmt:message bundle="${storeListe}" key="Civilite_${token}" />
														</option>
													</c:forTokens>
												</select>
											</div>
										</div>
										<div class="gutter mobile-hidden"></div>
										<div class="column column_25-5 bcolumn_100" id="Contact_CompanySize_Container">
											<div class="column_label" id="Contact_CompanySize_Label">
												<fmt:message key="CONTACT_COMPANYSIZE" bundle="${widgetText}" />
												<span class="required-field" id="Contact_CompanySize_Required"> *</span>
											</div>
											<div class="dropdownLP contactForm-dropdown">
												<select class="contactForm-select" name="companySize">
													<option value="" disabled selected>
														<fmt:message bundle="${storeText}" key="chooseListBoxValue" />
													</option>
													<c:forTokens items="${listEffectif}" delims="," var="token">
														<option value="<fmt:message bundle="${storeListe}" key="Effectif_${token}" />" <c:if test="${token == contact_codeEffectif}">selected</c:if>>
															<fmt:message bundle="${storeListe}" key="Effectif_${token}" />
														</option>
													</c:forTokens>
												</select>
											</div>
										</div>
										<div class="clearAll"></div>
										<div class="column column_48-5 bcolumn_100 margin-bottom" id="Contact_NF_C18-510_Certification_Container">
											<div class="column_label" id="Contact_NF_C18-510_Certification_Label">
												<span class="spanacce">
													<label for="Contact_NF_C18-510_Certification_Label">
														<fmt:message bundle="${widgetText}" key="CONTACT_NFC18510CERTIFICATION" />
													</label>
												</span>
												<fmt:message bundle="${widgetText}" key="CONTACT_NFC18510CERTIFICATION" /><span class="required-field" id="Contact_NF_C18-510_Certification_Required"> *</span>
											</div>
											<label class="radioButtonContainer" for="Contact_NF_C18-510_Certification_1"> 
												<input type="radio" class="radioLP" name="nfC18510Certification" id="Contact_NF_C18-510_Certification_1" value="Oui">
												<div></div> 
												<fmt:message bundle="${storeText}" key="confirm" />
											</label>
											<div class="gutter"></div>
											<label class="radioButtonContainer" for="Contact_NF_C18-510_Certification_0"> 
												<input type="radio" class="radioLP" name="nfC18510Certification" id="Contact_NF_C18-510_Certification_0" value="Non" checked>
												<div></div>
												 <fmt:message bundle="${storeText}" key="unconfirm" />
											</label>
										</div>
										<div class="gutter"></div>
										<div class="column column_48-5 bcolumn_100 margin-bottom" id="Contact_Qualibat_Certification_Container">
											<div class="column_label" id="Contact_Qualibat_Certification_Label">
												<span class="spanacce">
													<label for="Contact_Qualibat_Certification_Label">
														<fmt:message bundle="${widgetText}" key="CONTACT_QUALIBATCERTIFICATION" />
													</label>
												</span>
												<fmt:message bundle="${widgetText}" key="CONTACT_QUALIBATCERTIFICATION" /><span class="required-field" id="Contact_Qualibat_Certification_Required"> *</span>
											</div>
											<label class="radioButtonContainer" for="Contact_Qualibat_Certification_1"> 
												<input type="radio" class="radioLP" name="qualibatCertification" id="Contact_Qualibat_Certification_1" value="Oui">
												<div></div> 
												<fmt:message bundle="${storeText}" key="confirm" />
											</label>
											<div class="gutter"></div>
											<label class="radioButtonContainer" for="Contact_Qualibat_Certification_0"> 
												<input type="radio" class="radioLP" name="qualibatCertification" id="Contact_Qualibat_Certification_0" value="Non" checked>
												<div></div>
												 <fmt:message bundle="${storeText}" key="unconfirm" />
											</label>
										</div>
										<div class="clearAll"></div>
										<div class="column column_100 bcolumn_100" id="Contact_Skills_Container">
											<div id="Contact_Skils_Label" class="column_label">
												<fmt:message key="CONTACT_SKILLS" bundle="${widgetText}" />
											</div>
											<ul>
												<c:forEach var="skill" items="${skills}">
													<li>
														<label>
															<input type="checkbox" class="checkLP" value="${skill}" name="skills"/>
															<div></div>
															${skill}
														</label>
													</li>
												</c:forEach>
											</ul>
										</div>
										
										<div class="clearAll"></div>
										
										
										<div class="column column_50 bcolumn_100" id="Contact_CompanyEstablishment_Container">
											<div id="Contact_CompanyEstablishment" class="column_label">
												<fmt:message key="CONTACT_COMPANYESTABLISHMENT" bundle="${widgetText}" />
											</div>
											<div id="daySelecter" class="column column_30 bcolumn_30">
												<div class="dropdownLP contactForm-dropdown ">
													<select class="contactForm-select companyEstablishment-group" name="companyEstablishment_day">
														<option value="">--</option>
														<c:forEach begin="1" end="31" var="i">
															<fmt:formatNumber value="${i}" type="number" var="companyEstablishment_day" minIntegerDigits="2"/>
															<option value="${companyEstablishment_day}">${companyEstablishment_day}</option>							
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="gutter"></div>
											<div id="monthSelecter" class="column column_30 bcolumn_30">											
												<div class="dropdownLP contactForm-dropdown">
													<select class="contactForm-select companyEstablishment-group" name="companyEstablishment_month">
														<option value="">--</option>
														<c:forEach begin="1" end="12" var="i">
															<fmt:formatNumber value="${i}" type="number" var="companyEstablishment_month" minIntegerDigits="2"/>
															<option value="${companyEstablishment_month}">${companyEstablishment_month}</option>							
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="gutter"></div>
											<div id="yearSelecter" class="column column_30 bcolumn_30">
												<div class="dropdownLP contactForm-dropdown">
													<select class="contactForm-select companyEstablishment-group" name="companyEstablishment_year">
														<jsp:useBean id="beanDate" class="java.util.Date" />
														<fmt:formatDate value="${beanDate}" pattern="yyyy" var="curYear"/>
														<option value="">--</option>
														<c:forEach begin="${maxYear}" end="${curYear}" var="i" step="1" varStatus="status">
															<c:set var="companyEstablishment_year" value="${status.end - i+ status.begin}"	/>
															<option value="${companyEstablishment_year}">${companyEstablishment_year}</option>	
														</c:forEach>
														<option value="${beforeMaxYear}">${beforeMaxYear}</option>
													</select>
												</div>
											</div>
										</div>
										<label class="column column_100 errorPlacement" for="Contact_CompanyEstablishment_Container">
										</label>
										<div class="clearAll"></div>

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
											<div id="Contact_firtName_Label" class="column_label">
												<fmt:message key="CONTACT_FIRSTNAME" bundle="${widgetText}" />
												<span class="required-field" id="Contact_Firstname_Required"> *</span> 
											</div>
											<input type="text" maxlength="100" size="35" aria-required="true" id="Contact_Firstname" name="firstName" value="<c:if test='${!empty contact_firstName }'>${contact_firstName}</c:if>" required />
										</div>
										<div class="gutter mobile-hidden"></div>
                                       	<div class="column column_48-5 bcolumn_100" id="Contact_Lastname_Container">
                                            <div id="Contact_name_Label" class="column_label">
                                                <fmt:message key="CONTACT_LASTNAME" bundle="${widgetText}" />
                                                <span class="required-field" id="Contact_Lastname_Required"> *</span> 
                                            </div>
                                            <input type="text" maxlength="120" size="22" id="Contact_Lastname" name="lastName" value="<c:if test='${!empty contact_lastName }'>${contact_lastName}</c:if>" required />
                                        </div>
										<div class="clearAll"></div>
										

										<div class="column column_48-5 bcolumn_100" id="Contact_Email_Container">
											<div class="column_label" id="Contact_Email_Label">
												<fmt:message key="CONTACT_EMAIL" bundle="${widgetText}" />
												<span class="required-field" id="Contact_Email_Required"> *</span>
											</div>
											<input type="email" size="39" maxlength="100" aria-required="true" name="email" id="Contact_Email" value="<c:if test='${!empty contact_email }'>${contact_email}</c:if>" required />
										</div>
										<div class="clearAll"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_MobilePhone_Container">
											<div id="Contact_MobilePhone_Label" class="column_label">
												<fmt:message key="CONTACT_MOBILEPHONE" bundle="${widgetText}" />
												<span class="required-field" id="Contact_MobilePhone_Required"> **</span>
											</div>
											<input type="text" maxlength="20" size="35" aria-required="true" id="Contact_MobilePhone" name="mobilePhone" class ="phone-group" value="<c:if test='${!empty contact_mobilePhone }'>${contact_mobilePhone}</c:if>"  />
										</div>
										<div class="gutter mobile-hidden"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_Phone_Container">
											<div id="Contact_Phone_Label" class="column_label">
												<fmt:message key="CONTACT_PHONE" bundle="${widgetText}" />
												<span class="required-field" id="Contact_Phone_Required"> **</span>
											</div>
											<input type="text" maxlength="20" size="40" aria-required="true" id="Contact_Phone" name="phone" class ="phone-group" value="<c:if test='${!empty contact_phone }'>${contact_phone}</c:if>" />
										</div>
										<div class="clearAll"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_Address1_Container">
											<div id="Contact_Address1_Label" class="column_label">
												<fmt:message key="CONTACT_ADDRESS1" bundle="${widgetText}" />
												<span class="required-field" id="Contact_Address1_Required">*</span>
											</div>
											<input type="text" maxlength="38" size="40" aria-required="true" id="Contact_Address1" name="address1" value="<c:if test='${!empty contact_address1 }'>${contact_address1}</c:if>" />
										</div>
										<div class="gutter mobile-hidden"></div>
										<div class="column column_25-5 bcolumn_67" id="Contact_Address2_Container">
											<div id="Contact_Address2_Label" class="column_label">
												<fmt:message key="CONTACT_ADDRESS2" bundle="${widgetText}" />
												<span class="required-field" id="Contact_Address2_Required"></span>
											</div>
											<input type="text" maxlength="38" size="23" id="Contact_Adress2" name="address2" value="<c:if test='${!empty contact_address2 }'>${contact_address2}</c:if>" />
										</div>
										<div class="gutter"></div>
										<div class="column column_20 bcolumn_30" id="Contact_Address3_Container">
											<div id="Contact_Address3_Dropdown" class="column_label">
												<fmt:message key="CONTACT_ADDRESS3" bundle="${widgetText}" />
											</div>
											<div class="dropdownLP contactForm-dropdown">
												<select class="contactForm-select" name="address3">
													<c:forEach var="floor" items="${floorList}">
														<option value="${floor}" <c:if test='${!empty contact_address3 && floor==contact_address3 }'>selected</c:if>>${floor}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="clearAll"></div>
										<div class="column column_20 bcolumn_30" style="width: 120px" id="Contact_ZipCode_Container">
											<div id="Contact_ZipCode_Label" class="column_label">
												<fmt:message key="CONTACT_ZIPCODE" bundle="${widgetText}" />
												<span class="required-field" id="Contact_ZipCode_Required">*</span>
											</div>
											<input type="text" maxlength="20" size="15" aria-required="true" id="Contact_ZipCode" name="zipCode" value="<c:if test='${!empty contact_zipCode }'>${contact_zipCode}</c:if>" />
										</div>
										<div class="gutter"></div>
										<div class="column column_54 bcolumn_67" id="Contact_City_Container">
											<div id="Contact_City_Label" class="column_label">
												<fmt:message key="CONTACT_CITY" bundle="${widgetText}" />
												<span class="required-field" id="Contact_City_Required">*</span>
											</div>
											<input type="text" maxlength="100" size="30" aria-required="true" id="Contact_City" name="city" value="<c:if test='${!empty contact_city }'>${contact_city}</c:if>" />
										</div>
										<div class="gutter mobile-hidden"></div>
										
										<wcbase:useBean id="countryBean" classname="com.ibm.commerce.user.beans.CountryStateListDataBean">
												<c:set target="${countryBean}" property="countryCode" value="${country}"/>
										 </wcbase:useBean>
										<jsp:setProperty name="countryBean" property="countryCode" value="${country}" />
										<div class="column column_20 bcolumn_100 relative" id="Contact_Country_Container">
											<div id="Contact_Country_Label" class="column_label">
												<fmt:message bundle="${widgetText}" key="CONTACT_COUNTRY"/>
												<span class="required-field"  id="Contact_Country_Required">*</span>
											</div>
											<div class="dropdownLP contactForm-dropdown">
												<select class="drop_down_country contactForm-select" aria-required="true" id="countryField" name="countrySelect" disabled required onchange="javascript:document.getElementById('countryInput').value = this.value;">
													<c:forEach var="countryItem" items="${countryBean.countries}">
														<option value="<c:out value="${countryItem.code}"/>"
															<c:if test="${countryItem.code eq country || countryItem.displayName eq contact_country}">
																selected="selected"
															</c:if>
														><c:out value="${countryItem.displayName}"/></option>
													</c:forEach>
												</select>
												
											</div>
											<input type="hidden" value="${country}" name="country" id="textCountry" />
											<div class="editCountry" style="display: inline;"><a href="#" onClick="document.getElementById('countryField').disabled=false;return false;"><img src="${jspStoreImgDir}images/editCountry.png" alt=""></a></div>
										</div>
										<div class="clearAll"></div>
										<p class="bold"><fmt:message key="CONTACT_INSURANCE_SECTION_TITLE" bundle="${widgetText}" /></p>
										<div class="column column_48-5 bcolumn_100" id="Contact_InsurerName_Container">
												<div id="Contact_InsurerName_Label" class="column_label">
													<fmt:message key="CONTACT_INSURERNAME" bundle="${widgetText}" />
													<span class="required-field" id="Contact_InsurerName_Required">*</span>
												</div>
												<input type="text" maxlength="100" size="30" aria-required="true" id="Contact_InsurerName" name="insurerName" required />
										</div>
										<div class="gutter mobile-hidden"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_InsurancePolicyNumber_Container">
												<div id="Contact_InsurancePolicyNumber_Label" class="column_label">
													<fmt:message key="CONTACT_INSURANCEPOLICYNUMBER" bundle="${widgetText}" />
													<span class="required-field" id="Contact_InsurancePolicyNumber_Required">*</span>
												</div>
												<input type="text" maxlength="100" size="30" aria-required="true" id="Contact_InsurancePolicyNumber" name="insurancePolicyNumber" value="" required />
										</div>
										<div class="clearAll"></div>
										<div class="column column_50 bcolumn_100" id="Contact_InsuranceTerm_Container">
											<div id="Contact_InsuranceTerm" class="column_label">
												<fmt:message key="CONTACT_INSURANCETERM" bundle="${widgetText}" />
											</div>
											<div id="insuranceDaySelecter" class="column column_30 bcolumn_30">
												<div class="dropdownLP contactForm-dropdown">
													<select style="width: 72px;" class="contactForm-select insuranceTerm-group" name="insuranceTerm_day">
														<option value="">--</option>
														<c:forEach begin="1" end="31" var="i">
															<fmt:formatNumber value="${i}" type="number" var="insuranceTerm_day" minIntegerDigits="2"/>
															<option value="${insuranceTerm_day}">${insuranceTerm_day}</option>							
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="gutter"></div>
											<div id="insuranceMonthSelecter" class="column column_30 bcolumn_30">
												<div class="dropdownLP contactForm-dropdown">
													<select style="width: 72px;" class="contactForm-select insuranceTerm-group" name="insuranceTerm_month">
														<option value="">--</option>
														<c:forEach begin="1" end="12" var="i">
															<fmt:formatNumber value="${i}" type="number" var="insuranceTerm_month" minIntegerDigits="2"/>
															<option value="${insuranceTerm_month}">${insuranceTerm_month}</option>							
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="gutter"></div>
											<div id="insuranceYearSelecter" class="column column_30 bcolumn_30">
												<div class="dropdownLP contactForm-dropdown">
													<select style="width: 72px;" class="contactForm-select insuranceTerm-group" name="insuranceTerm_year">
														<option value="">--</option>
														<c:forEach begin="${currentYear - 10}" end="${currentYear + 10}" var="i" step="1" varStatus="status">
															<c:set var="insuranceTerm_year" value="${status.end - i + status.begin}"	/>
															<option value="${insuranceTerm_year}" ${currentYear == insuranceTerm_year ? 'selected' : '' }>${insuranceTerm_year}</option>	
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<label class="column column_100 bcolumn_100 errorPlacement" for="Contact_InsuranceTerm_Container">
										</label>
										<div class="clearAll"></div>
										<p class="bold"><fmt:message bundle="${widgetText}" key="CONTACT_STOREENTITY_SECTION_TITLE" /></p>
										<div class="column column_48-5 bcolumn_100" id="Contact_FirstStoreEntity_Container">
											<div id="Contact_FirstStoreEntity_Label" class="column_label">
											<fmt:message key="CONTACT_STOREENTITY1" bundle="${widgetText}" />
											<span class="required-field" id="Contact_InsurancePolicyNumber_Required">*</span>
											</div>
											<div class="dropdownLP contactForm-half-width-dropdown">
												<select class="full-width contactForm-select" name="storeEntity1">
													<option value><fmt:message bundle="${widgetText}" key="SELECT_ONE" /></option>
													<c:forEach var="shop" items="${fullActiveStores}" >
														<option value="${shop.identifier}" data-shop-name="${shop.name}">${shop.cp} - ${shop.name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="gutter mobile-hidden"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_SecondStoreEntity_Container">
											<div id="Contact_SecondStoreEntity_Label" class="column_label">
											<fmt:message key="CONTACT_STOREENTITY2" bundle="${widgetText}" />
											<span class="required-field" id="Contact_SecondStoreEntity_Required"></span>
											</div>
											<div class="dropdownLP contactForm-half-width-dropdown">
												<select class="full-width contactForm-select" name="storeEntity2">
													<option value><fmt:message bundle="${widgetText}" key="SELECT_ONE" /></option>
													<c:forEach var="shop" items="${fullActiveStores}" >
														<option value="${shop.identifier}" data-shop-name="${shop.name}">${shop.cp} - ${shop.name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="clearAll"></div>
										<div class="column column_48-5 bcolumn_100" id="Contact_ThirdStoreEntity_Container">
											<div id="Contact_ThirdStoreEntity_Label" class="column_label">
											<fmt:message key="CONTACT_STOREENTITY3" bundle="${widgetText}" />
											<span class="required-field" id="Contact_ThirdStoreEntity_Required"></span>
											</div>
											<div class="dropdownLP contactForm-half-width-dropdown">
												<select class="full-width contactForm-select" name="storeEntity3">
													<option value><fmt:message bundle="${widgetText}" key="SELECT_ONE" /></option>
													<c:forEach var="shop" items="${fullActiveStores}" >
														<option value="${shop.identifier}" data-shop-name="${shop.name}">${shop.cp} - ${shop.name}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="clear_float"></div>
									</div>
									<div class="button_footer_line no_float" id="Contact_Button_Container">
										<fmt:message key="contactSubmitButtonlabel" var="sendLabel" bundle="${widgetText}" />
										<fmt:message key="contactCancelButtonLabel" var="cancelLabel" bundle="${widgetText}" />
										<a href="contact" class="button">${cancelLabel}</a>
										<input type="submit" id="submit" value="${sendLabel}" class="button green">
										<br clear="all" />
									</div>
									<div class="error alignCenter" id="mailNotSendMessageError" style="display:none;">
										<fmt:message bundle="${storeText}" key="akioEmailGenerationErrorMessage" />
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="contactFooterMessage"><fmt:message bundle="${widgetText}" key="CONTACT_PARTNER_INFORMATION" /></div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- END ContactPartner.jsp -->