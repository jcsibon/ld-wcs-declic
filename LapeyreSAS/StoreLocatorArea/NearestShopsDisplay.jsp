<%@ page trimDirectiveWhitespaces="true" %>
<wcf:url var="NearestShopsDisplayViewURL" value="NearestShopsDisplayView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
</wcf:url>

<script>
	dojo.addOnLoad(function(){
		refreshControllerNearestShops.url = '<c:out value="${NearestShopsDisplayViewURL}" />';
		if(SearchShopsJS.currLatLng == null){
			<c:set var="geoLocRequired" value="true" />
			<c:choose>
				<c:when test="${userType eq 'G'}">
					<c:set var="geoLocRequired" value="true" />
				</c:when>
				<c:otherwise>
					<wcbase:useBean id="addressDB" classname="com.lapeyre.declic.commerce.usermanagement.commands.SelfAddressDataBean" scope="page" />
					<c:if test="${!empty addressDB.selfAddress}">
						<c:set var="geoLocRequired" value="false" />
						SearchShopsJS.currLatLng = ${empty addressDB.selfAddress.addressField2 ? 'null' : addressDB.selfAddress.addressField2} || null;
						if (SearchShopsJS.currLatLng == null) {
							SearchShopsJS.geoLocSearch(function() {
								SearchShopsJS.updateNearestShops();
							});
						} else {
							SearchShopsJS.updateNearestShops();
						}
					</c:if>
				</c:otherwise>
			</c:choose>
			<c:if test="${geoLocRequired eq 'true'}">
				SearchShopsJS.geoLocSearch(function(){
					SearchShopsJS.updateNearestShops();
				});
			</c:if>
		}
		else{
			SearchShopsJS.updateNearestShops();
		}
	});
</script>
<c:set var="nearestShopsInitial" value="true"/>
<div dojoType="wc.widget.RefreshArea" id="nearestShopsId" objectId="nearestShopsId" controllerId="nearestShops_controller">
	<%@include file="NearestShopsDisplay_UI.jsp" %>
</div>
<c:set var="nearestShopsInitial" value="false"/>