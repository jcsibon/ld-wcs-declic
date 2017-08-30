<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN NearestShopsDisplay.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<wcf:url var="NearestShopsDisplayViewURL" value="NearestShopsInTunnelLivraisonDisplayView" type="Ajax">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="view" value="NearestShopsInTunnelLivraisonDisplayView" />
</wcf:url>

<script>
	function fetchNearestShopsInTunnelLivraison() {
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
						<c:set var="address" value="${addressDB.selfAddress.address1}" />
						<c:set var="address" value="${address}+${addressDB.selfAddress.city}" />
						<c:set var="address" value="${address}+${addressDB.selfAddress.state}" />
						<c:set var="address" value="${address}+${addressDB.selfAddress.zipCode}" />
						SearchShopsJS.doSearchShopFromAddress('<c:out value="${address}" />',function(){
							SearchShopsJS.updateNearestShops();
						});
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
	}
	
	dojo.addOnLoad(function(){
		refreshControllerNearestShopsInTunnelLivraison.url = '<c:out value="${NearestShopsDisplayViewURL}" />'+"&retraitLivraison="+retraitLivraison +"&orderId="+orderId;
		
		fetchNearestShopsInTunnelLivraison();
	});
	
</script>
<div dojoType="wc.widget.RefreshArea" id="nearestShopsInTunnelLivraisonId" objectId="nearestShopsInTunnelLivraisonId" controllerId="nearestShopsInTunnelLivraison_controller">
	<%@include file="NearestShopsDisplay_UI.jsp" %>
</div>

<!-- END NearestShopsDisplay.jsp -->