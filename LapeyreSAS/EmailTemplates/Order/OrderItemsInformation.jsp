<%-- This file is the WCS 7 version and it is currently used. --%>


<%@include file="OrderItemsData.jsp" %>

<!-- contenu panier -->
<tr>
	<td width="100%" style="max-width:680px !important">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#efefef">
			<tr>
				<td width="7%"></td>
				<td width="86%">
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<!-- separateur horizontal -->
						<tr>
							<td height="15" width="100%"></td>
						</tr>
						<tr>
							<td width="100%" align="center">
								<font face="arial" color="#000000" style="font-size: 20px; font-weight: bold;">
									<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyPanierTitle" />
								</font>
							</td> 
						</tr>
						<tr>
							<td width="100%" align="center">
								<font face="arial" color="#333333" style="font-size: 17px;font-weight:100;">
									<c:if test="${orderQuantity > 1}">
										<!-- SI SUP 1 -->
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyPanierNProduits" >
											<fmt:param value="${orderQuantity}" />
										</fmt:message>
									</c:if>
									<c:if test="${orderQuantity == 1}">
										<!-- SI 1 -->
										<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyPanierUnProduit" />
									</c:if>
								</font>
							</td> 
						</tr>
						<!-- separateur horizontal -->
						<tr>
							<td height="20" width="100%"></td>
						</tr>
						<%@include file="OrderItemsDisplay.jsp" %>
					</table>
				</td>
				<td width="7%"></td>
			</tr>			
		</table>
	</td>
</tr>	
<tr>
	<td height="1" width="100%" style="max-width:680px !important" bgcolor="#ccc"></td>
</tr>
<tr bgcolor="#efefef">
	<td width="100%" style="max-width:680px !important">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="45">
			<c:forEach var="line" items="${xOrderSummary.lines}" varStatus="index">
				<c:set var="height" value="25" />
				<c:set var="labelBgColor" value="" />
				<c:set var="valueBgColor" value="#fff" />
				<c:set var="labelStyle" value="color: #666; font-size: 13px; font-weight: normal;"/>
				<c:set var="valueStyle" value="${labelStyle}"/>
				<%-- Coupons, R�ductions, ... --%>
				<c:if test="${line.special}">
					<c:set var="labelStyle" value="color: #cd0018; font-size: 13px; font-weight: bold;"/>
					<c:set var="valueStyle" value="${labelStyle}"/>	
				</c:if>
				<%-- Montant total --%>
				<c:if test="${line.main}">
					<c:set var="height" value="45" />
					<c:set var="labelBgColor" value="" />
					<c:set var="valueBgColor" value="#cd0018" />
					<c:set var="labelStyle" value="color: #cd0018; font-size: 20px; font-weight: bold; text-transform: uppercase;"/>
					<c:set var="valueStyle" value="color: #fff; font-size: 20px; font-weight: bold;"/>
				</c:if>
				
				<tr>
					<c:if test="${index.first}">
					<td width="4%" height="${height}" bgColor="${labelBgColor}" rowspan="${fn:length(xOrderSummary.lines)}"></td>
					<td width="15%" height="${height}" bgColor="${labelBgColor}" rowspan="${fn:length(xOrderSummary.lines)}">
						<img alt="${xOrderSummary.paymentMethod}" src="${jspStoreImgDir}/images/card_${fn:toLowerCase(xOrderSummary.paymentMethod)}.png">
					</td>
					</c:if>
					<%-- Label --%>
					<td width="46%" height="${height}" bgColor="${labelBgColor}" align="right" valign="middle">
						<font face="arial" style="${labelStyle}">
							${line.label}
						</font>
					</td>
					
					<%-- Spacer --%>
					<td width="4%" height="${height}" bgColor="${labelBgColor}"></td>
					
					<%-- Value --%>
					<td width="31%" height="${height}" bgColor="${valueBgColor}" align="right" valign="middle" style="padding-right: 10px;">
						<font face="arial" style="${valueStyle}">
							<c:choose>
								<c:when test="${line.free}">
									<span class=special>${line.value }</span>
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${line.value}" type="currency"  maxFractionDigits="${env_currencyDecimal}"  currencySymbol="" />
									<span class=currency>${env_CurrencySymbolToFormat}</span>
									<c:if test="${line.main && line.vatFree}"> <sup style="vertical-align: text-top">HT</sup></c:if>
								</c:otherwise>
							</c:choose>
						</font>
					</td>
				</tr>
			</c:forEach>
		</table>
	</td>
</tr>