<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="25%" align="left" valign="top">
			<a href="${productURL}">
				<img style="text-decoration: none; display: block; color:#666666; font-size:12px;" src="${imageProduct}" height="56" width="56">
			</a>
		</td>
		<td width="75%" align="left">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="100%" height="70" valign="top">
						<p style="line-height:14px;margin:0;padding:0;">
							<font face="arial" color="#000000" style="font-size: 15px; font-weight: bold;">
								<a href="${productURL}"  style="color: #000000;text-decoration: none;"><ecocea:crop value="${labelProduct}" length="45" /></a><br>
								<font face="arial" color="#000000" style="font-size: 11px;">
									<fmt:message bundle="${storeText}" key="ficheProduitSkuLabel"/> : ${sku }
								</font>
								<br>
								<font face="arial" color="#000000" style="font-size: 11px;">
									<fmt:message bundle="${storeText}" key="emailConfirmOrderBodyPanierSKUQty" >
										<fmt:param value="${qtyProduct}" />
									</fmt:message>
								</font>
								<br>
								<font color="#cd0018" style="font-size: 11px; font-weight:bold;">${priceFormated}</font>
							</font>
						</p>
						<c:if test="${not empty itemDiscounts}">
							<p style="margin-top: 15px;padding: 3px 6px;display: inline-block;">
								<font style="font-weight: bold">
								<c:forEach var="discountsIterator" items="${itemDiscounts}">
									<c:set var="discounts" value="${discountsIterator.value}" />
									<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
										<c:param name="code" value="${discounts.code}" />
										<c:param name="langId" value="${langId}" />
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${WCParam.catalogId}" />
									</c:url>
									<c:set var="discountDetailsDisplayViewURL" value="${hostPath}/${DiscountDetailsDisplayViewURL}" />
									<c:set var="discountDescription" value="${discounts.description.value}" />
									 <a href="${discountDetailsDisplayViewURL}" style="color:#cd0018" >${discountDescription}</a><br/>
								</c:forEach>
								</font>
									</p>
								</c:if>
						<c:if test="${!empty couponRateItemDescription}">
							<p style="background: #cd0018; margin-top: 15px;padding: 3px 6px;display: inline-block;">
								<font color="#fff" style="font-size: 13px;">${couponRateItemDescription}</font>
							</p>
						</c:if>
					</td>
				</tr>
				<tr>
					<td height="8" width="100%"></td>
				</tr>
				<c:if test="${typeProduct ne CATALOGUE_PAPIER_PRODUCT}">
					<c:choose>
						<c:when test="${isAvailable}">
							<tr height="30" bgcolor="#59b956">
								<td width="215" align="center" height="30" valign="middle">
									<font face="arial" color="#ffffff" style="font-size: 13px;font-weight:bold;">
										<fmt:message bundle="${widgetText}" key="orderItemavailabilityInStockLabel" />
									</font>
								</td>
							</tr>
						</c:when>
						<c:when test="${willBeAvailable}">
							<tr height="30" bgcolor="#f1a117">
								<td width="215" align="center" height="30" valign="middle">
									<font face="arial" color="#ffffff" style="font-size: 13px;font-weight:bold;">
										<fmt:message bundle="${widgetText}" key="orderItemAvailabilityMessage" >
											<fmt:param value="${willBeAvailableDateFormatted}" />
										</fmt:message>
									</font>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr height="30" bgcolor="#cd0018">
								<td width="215" align="center" height="30" valign="middle">
									<font face="arial" color="#ffffff" style="font-size: 13px;font-weight:bold;">
										<fmt:message bundle="${widgetText}" key="noStockInformationErrorMessage" />
									</font>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:if>
			</table>
		</td>
	</tr>
</table>