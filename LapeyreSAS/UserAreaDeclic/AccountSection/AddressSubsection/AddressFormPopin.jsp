<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/RNVPErrorMessageSetup.jspf"%>

<fmt:setBundle basename="/${sdb.jspStoreDir}/storelist" var="storeListe" scope="request"/>

<c:set var="country" value="${CommandContext.country}" scope="request" />

<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressBookForm.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js?${versionNumber}"/>"></script>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
	
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/StoreLocatorArea/AddressController.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/jquery.validate.js?${versionNumber}"></script>
<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>
<script type="text/javascript" src="${jsAssetsDir}javascript/Validation/dist/additional-methods.js?${versionNumber}"></script>
<script type="text/javascript" src="${jspStoreImgDir}UserAreaDeclic/javascript/RNVPService.js?${versionNumber}"></script>



<script>
	dojo.subscribe("ChangeAddressFormPopinPageTitle",function(isEditing){
		if(isEditing == true) {
			$('#addressFormPopinPageTitle').html('<fmt:message bundle="${storeText}" key="myAddressesEditPageTitle"/>');
		} else {
			$('#addressFormPopinPageTitle').html('<fmt:message bundle="${storeText}" key="myAddressesAddPageTitle"/>');
		}
	});
</script>

<!-- Page Start -->
<div id="AddressFormPopin" data-dojo-type="lapeyre/widget/Dialog" style="display: none">
	<div class="widget_site_popup">
		<div class="content">
			<div class="header" id="AddressFormPopinHeader">
<%-- 					<% java.util.Map monMap = ((java.util.Map)request.getAttribute("WCParam")); --%>
<!-- 					java.util.Iterator iterator = monMap.keySet().iterator();  // keySet() renvoie un Set de toutes les clés contenues dans le Map -->
<!-- 					while(iterator.hasNext()){ -->
<!-- 					   String maCle = (String) iterator.next(); -->
<!-- 					   Object maValeur = monMap.get(maCle); -->
<%-- 					   %><%=maCle %> : <%=maValeur %><br /> --%>
<%-- 					<%}%> --%>
					<span id="addressFormPopinPageTitle">
						<c:choose>
							<c:when test="${empty WCParam.addressId}">
								<fmt:message bundle="${storeText}" key="myAddressesAddPageTitle"/>
							</c:when>
							<c:otherwise>
								<fmt:message bundle="${storeText}" key="myAddressesEditPageTitle"/>
							</c:otherwise>
						</c:choose>
					</span>
					<p><fmt:message bundle="${storeText}" key="mandatoryFieldsLabel"/></p>
					<a role="button" id="AddressFormPopinClose" href="#" onclick="javascript:dijit.byId('AddressFormPopin').hide();return false;" class="close" title="<fmt:message key="SL_CLOSE" bundle="${widgetText}" />" aria-label="<fmt:message key="SL_CLOSE" bundle="${widgetText}"/>"></a>
					<div class="clear_float"></div>
			</div>
			
			<div class="row" dojoType="wc.widget.RefreshArea" id="addressFormInTunnelId" objectId="addressFormInTunnelId" controllerId="addressFormInTunnel_controller">
				<%@ include file="AddressForm_UI.jspf" %>	
			</div>
		</div>
	</div>
</div>
