<td width="47%" valign="top">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" align="center">
				<font face="arial" color="#333333" style="font-size: 18px;">${addressTypeName}</font>
			</td>
		</tr>
		<!-- separateur horizontal -->
		<tr>
			<td height="10" width="100%"></td>
		</tr>
		<tr bgcolor="#f7f7f7">
			<td width="100%" height="7"></td>
		</tr>
		<tr bgcolor="#f7f7f7">
			<td width="100%" align="center">
				<font face="arial" color="#bf1e2e" style="font-size: 13px;">${contact.contactInfoIdentifier.externalIdentifier.contactInfoNickName}</font>
			</td>
		</tr>
		<tr bgcolor="#f7f7f7">
			<td width="100%" height="7"></td>
		</tr>
		<tr bgcolor="#f7f7f7">
			<td width="100%" align="center">
				<img style="text-decoration: none; display: block; color:#cb0119; font-size:20px;" src="${fullJspStoreImgDir}images/separator_email_small.png" alt=".............." height="4" width="110">
				<p style="line-height:12px;">
					<font face="arial" color="#0000000" style="font-size: 11px;">
						<font style="font-weight:bold;">
							<fmt:message bundle="${storeListe}" key="Civilite_Abreviation_${contact.contactName.personTitle}" var="civ" /><c:if test="${not fn:startsWith(civ,'???')}">${civ}</c:if>
							${contact.contactName.firstName} 
							${contact.contactName.lastName}
						</font>
						<br>
						<c:out value="${!empty contact.mobilePhone1?ecocea:fmtPhone(contact.mobilePhone1.value) : (!empty contact.telephone1? ecocea:fmtPhone(contact.telephone1.value) : (!empty contact.telephone2? ecocea:fmtPhone(contact.telephone2.value) : ''))}" />
						<br/>
						<c:out value="${contact.emailAddress1.value}" />
					</font>
				</p>
				<p style="line-height:12px;">
					<font face="arial" color="#0000000" style="font-size: 11px;">
						${contact.address.addressLine[0]} ${contact.address.addressLine[1]}<br/>
						<c:set var="etageField" value="${contact.address.addressLine[2]}"/>
						<c:if test="${empty etageField}">
							<c:set var="etageField" value="-1"/>
						</c:if>
						<c:if test="${etageField != 0 && etageField != 25 && etageField != -1 }">
							<fmt:message bundle="${storeListe}" key="Etage_${etageField}" />&nbsp;<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" /><br />
						</c:if>
						<c:if test="${etageField == 0 || etageField == 25 || etageField == -1 }">
							<fmt:message bundle="${storeText}" key="addressFloorFieldLabel" />&nbsp;:&nbsp;	<fmt:message bundle="${storeListe}" key="Etage_${etageField}" /><br />
						</c:if>
						${contact.address.postalCode} ${contact.address.city}
					</font>
				</p>
			</td>
		</tr>
		<!-- separateur horizontal -->
		<tr>
			<td height="10" width="100%"></td>
		</tr>
	</table>
</td>
