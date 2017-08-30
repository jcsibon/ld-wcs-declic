<tr>
	<td width="100%">
		<table border="0" cellpadding="0" cellspacing="0" width="61%" bgcolor="#f9f9f9">
			<tr height="140" bgcolor="#f9f9f9">
				<td width="3%" bgcolor="#f9f9f9"></td>
				<td width="77%" bgcolor="#f9f9f9">
					<p style="line-height:13px;">
						<font face="arial" color="#bf1e2e" style="font-size: 13px;">
							${shopBean.name}
						</font>
						<br>
						<font face="arial" color="#0000000" style="font-size: 11px;">
							${shopBean.type} <c:if test="${shopBean.retraitDrive eq 'true'}"><img src="${fullJspStoreImgDir}images/logoDrive.png"></c:if>
						</font>
						<br>
					</p>
					<img style="text-decoration: none; display: block; color:#cb0119; font-size:20px;" src="${fullJspStoreImgDir}images/separator_email_small.png" alt=".............." height="4" width="110">
					<p style="line-height:12px;">
						<font face="arial" color="#0000000" style="font-size: 11px;">
							${shopBean.address1}
							<br>
							${shopBean.cp} ${shopBean.city}
							<br>
							${shopBean.mainPhoneLibelle} : ${shopBean.mainPhone}
						</font>
					</p>
					<c:if test="${not empty shopBean.access}" >
						<p style="line-height:12px;">
							<font face="arial" color="#999999" style="font-size: 11px;">
								${shopBean.access}
							</font>
						</p>
					</c:if>
					<c:if test="${empty shopBean.access && not empty shopBean.secondaryPhone}" >
						<p>
							<c:forEach items="${shopBean.secondaryPhone}" var="secPhoneKey" varStatus="status">
									
										<font face="arial" color="#999999" style="font-size: 11px;">
										${secPhoneKey.key} : ${secPhoneKey.value}
										</font>
										<c:if test="${!status.last}">
											<br/>
										</c:if>
							</c:forEach>
						</p>
					</c:if>
				</td>
				<td width="0.4%" bgcolor="#ffffff">
				</td>
				<td width="19.6%" bgcolor="#f9f9f9" align="center" valign="top">
					<p style="line-height:12px;">
						<a href="${hostPath}${shopBean.seoUrl}" style="color: #000;text-decoration:none;">
							<img style="text-decoration: none; display: block; color:#cb0119; font-size:20px;" src="${fullJspStoreImgDir}images/shopBlockYaller.png" alt="" height="30" width="30"><br>
							<font face="arial" style="font-size: 11px;text-decoration:none; color:#000;">
								<fmt:message key="StoreLocYAller" bundle="${storeText}" />
							</font>
						</a>
						<c:if test="${not empty shopBean.distance}">
							<fmt:formatNumber var="distance" value="${shopBean.distance}" maxFractionDigits="1" />
							<br>
							<font face="arial" color="#999999" style="font-size: 11px;">
								<fmt:message key="StoreLocYAllerDistance" bundle="${storeText}" >
									<fmt:param value="${distance}" />
								</fmt:message>
							</font>
						</c:if>
					</p>
				</td>
			</tr>
		</table>
	</td>
</tr>