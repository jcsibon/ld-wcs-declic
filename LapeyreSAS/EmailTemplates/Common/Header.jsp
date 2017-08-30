<tr>
	<td align="center">
		<table width="100%" style="max-width:680px !important" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#f2f2f2">
			<!-- entete -->
			<tbody><tr>
				<td width="25%" align="center" height="60">
					<a href="${hostPath}${env_TopCategoriesDisplayURL}" target="_blank" style="text-decoration:none"><img style="text-decoration: none; color:#cb0119; font-size:20px;" src="${fullJspStoreImgDir}images/logo.png" alt="Lapeyre" height="60" width="150"></a>
				</td>
				<td valign="middle" width="74%" align="right" height="60">
					<h1 style="font-size:20px;font-weight:100;">
						${headerTitle}
					</h1>
				</td> 
				<td valign="middle" width="1%" height="60">
					
				</td> 
			</tr>
		</tbody></table>
	</td>
</tr>

<!-- bandeau image -->
<c:if test="${!empty imageHeaderFile}">
	<tr>
		<td height="150" width="100%" style="max-width:680px !important"><img style="text-decoration: none; display: block; color:#cb0119; font-size:20px;" src="${imageHeaderFile}"></td>
	</tr>
</c:if>