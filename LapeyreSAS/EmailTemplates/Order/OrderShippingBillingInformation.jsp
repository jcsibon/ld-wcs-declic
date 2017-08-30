<!-- contenu texte -->

<c:set var="isLivraison" value="${(xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeTransporter ||  xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeColissimo)? true : false }" />
<c:set var="isRetrait" value="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeRetrait ? true : false }" />
<c:set var="isDrive" value="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeDrive ? true : false }" />


<wcf:url var="ContactPageViewURL" patternName="ContactPageURL" value="ContactPageView" >
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="formName" value="contactSuiviCommande" />
</wcf:url>

<tr>
	<td width="100%" style="max-width:680px !important">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="7%"></td>
				<td width="86%">
					<table border="0" cellpadding="0" cellspacing="0">
						<!-- separateur horizontal -->
						<tr>
							<td height="15" width="100%"></td>
						</tr>
						<c:if test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE ne modeLivraisonCatalog}">
							<tr>
								<td width="100%" align="left">
									<font face="arial" color="#333333" style="font-size: 18px; font-weight: bold;">
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementTitle" />
									</font>
								</td> 
							</tr>
							<!-- separateur horizontal -->
							<tr>
								<td height="15" width="100%"></td>
							</tr>
							<tr>
								<td width="100%">
									<font face="arial" color="#666666" style="font-size: 13px;">
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementDetail" >
											<fmt:param value="${shippingMode}" />
											<fmt:param value="${shopBean.name}" />
										</fmt:message>
										<c:if test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeDrive}">
											<!--  SI DRIVE -->
											<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementDetailDrivePart" >
												<fmt:param value="${heureDebutDrive}" />
												<fmt:param value="${heureFinDrive}" />
											</fmt:message>
										</c:if>
									</font>
								</td>
							</tr>
						</c:if>
						<!-- separateur horizontal -->
						<tr>
							<td height="20" width="100%"></td>
						</tr>
						<tr>
							<td height="1" width="100%" bgcolor="#9a9a9a"></td>
						</tr>
						<!-- separateur horizontal -->
						<tr>
							<td height="15" width="100%"></td>
						</tr>
						<tr>
							<td width="100%">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<c:if test="${isLivraison}">
											<c:remove var="addressTypeName" />
											<c:remove var="contact" />
											<fmt:message var="addressTypeName" bundle="${storeText}" key="emailConfirmOrderBodyShippingTypeName" />
											<c:set var="contact" value="${order.orderItem[0].orderItemShippingInfo.shippingAddress}"/>
											<%@include file="OrderAddressDisplay.jsp" %>
											<td width="6%"></td>
										</c:if>
										<c:remove var="addressTypeName" />
										<c:remove var="contact" />
										<fmt:message var="addressTypeName" bundle="${storeText}" key="emailConfirmOrderBodyBillingTypeName" />
										<c:if test="${!empty orderShippingData && !empty orderShippingData.facturationAddressId}">
											<c:choose>
												<c:when test="${orderShippingData.facturationAddressId eq person.contactInfo.contactInfoIdentifier.uniqueID}">
													<c:set var="contact" value="${person.contactInfo}"/>
												</c:when>
												<c:otherwise>
													<c:forEach items="${addressBookBean.contact}" var="contactItem">
														<c:if test="${orderShippingData.facturationAddressId eq contactItem.contactInfoIdentifier.uniqueID}">
															<c:set var="contact" value="${contactItem}"/>
														</c:if>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${!empty contact}">
											<%@include file="OrderAddressDisplay.jsp" %>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
						<!-- separateur horizontal -->
						<tr>
							<td height="15" width="100%"></td>
						</tr>
						<c:if test="${isLivraison}">
							<tr>
								<td width="100%" align="left">
									<p>
										<font face="arial" color="#666666" style="font-size: 13px;">
											<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementLivraisonDate" >
												<fmt:param value="${orderAvailableDateFormatted}" />
											</fmt:message>
										</font>
									</p>
									<c:if test="${xOrderDetails.SHIPPINGINFOS.SHIPPINGMODE eq modeTransporter}">
									<p>
										<font face="arial" color="#666666" style="font-size: 13px;">
											<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementLivraisonMagasin" >
												<fmt:param value="${shopBean.name}" />
											</fmt:message>
										</font>
									</p>
									</c:if>
								</td> 
							</tr>
						
							<!-- separateur horizontal -->
							<tr>
								<td height="20" width="100%"></td>
							</tr>
						</c:if>
						<tr>
							<td height="1" width="100%" bgcolor="#9a9a9a"></td>
						</tr>
						<!-- separateur horizontal -->
						<tr>
							<td height="15" width="100%"></td>
						</tr>
						<c:if test="${isRetrait}">
							<tr>
								<td width="100%" align="left">
									<font face="arial" color="#333333" style="font-size: 18px;">
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementRetrait" />
									</font>
								</td> 
							</tr>
							<!-- separateur horizontal -->
							<tr>
								<td height="15" width="100%"></td>
							</tr>
						</c:if>
						<tr>
							<td width="100%">
								<c:if test="${isRetrait || isDrive}">
									<p>
										<font face="arial" color="#666666" style="font-size: 13px;">
											<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementRetraitMagasin" >
												<fmt:param value="${shopBean.name}" />
												<fmt:param value="${orderAvailableDateFormatted}" />
											</fmt:message>
											<c:if test="${isDrive}">
												<!--  SI DRIVE -->
												<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementDetailDrivePart" >
													<fmt:param value="${heureDebutDrive}" />
													<fmt:param value="${heureFinDrive}" />
												</fmt:message>
												<c:choose>
													<c:when test="${isPro }">
														<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementDetailDriveStepsForPro" >
															<fmt:param value="${shopBean.name}" />
														</fmt:message>
													</c:when>
													<c:otherwise>
														<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyModeEnlevementDetailDriveStepsForPart" >
															<fmt:param value="${shopBean.name}" />
														</fmt:message>
													</c:otherwise>
												</c:choose>
											</c:if>
										</font>
									</p>
								</c:if>
								<p>
									<font face="arial" color="#666666" style="font-size: 13px;">
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyAvancementCommande" />
									</font>
								</p>
							</td>
						</tr>
						<!-- separateur horizontal -->
						<tr>
							<td height="20" width="100%"></td>
						</tr>
						<c:if test="${!empty shopBean }">
							<%@include file="OrderShopDisplay.jsp" %>
						</c:if>
						<!-- separateur horizontal -->
						<tr>
							<td height="20" width="100%"></td>
						</tr>
						<tr>
							<td width="100%">
								<p>
									<font face="arial" color="#666666" style="font-size: 13px;">
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyContact1" >
											<fmt:param value="${ecocea:replaceHost(ContactPageViewURL,hostPath)}?formName=contactSuiviCommande" />
										</fmt:message>
									</font>
								</p><p style="text-align:center">
										<img src="${fullJspStoreImgDir}images/callus_tel.png" alt="08 11 91 00 38, 0,06E/min" />
								</p><p>
									<font face="arial" color="#666666" style="font-size: 13px;">
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyContact2" />
									</font>
								</p>
							</td>
						</tr>
					</table>
				</td>
				<td width="7%"></td>
			</tr>
		</table>
	</td>
</tr>