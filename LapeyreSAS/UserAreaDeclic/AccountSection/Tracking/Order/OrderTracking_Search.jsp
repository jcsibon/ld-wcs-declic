<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../../Common/nocache.jspf" %>

<h2 class="titleBlock"><fmt:message bundle="${storeText}" key="searchOrderPageTitle" /></h2>
<div class="searchMessageLabel">
	<p><fmt:message bundle="${storeText}" key="searchOrderPageContent" /></p>
</div>
<wcf:url var="OrderTrackingSearchURL" patternName="SearchOrderPageURL" value="OrderTrackingSearchView" type="Ajax">
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>
<script>
	
	var onFormSubmitHandler = function() {
		require(['dojo/dom-form'], function(domForm){
			$('input[id="submit"]').attr('disabled', 'disabled');
			$.get('${OrderTrackingSearchURL}', domForm.toObject('searchOrderForm'), function(data) {
				$('#resultContainer').empty();
				$('#resultContainer').append(data);
				$('input[id="submit"]').removeAttr('disabled');
			}); 
		});
	}
</script>

<c:import url="Common/CommonTracking_SearchForm.jsp">
	<c:param name="trackingType" value="Order" />
	<c:param name="actionUrl" value="" />
</c:import>

<div id="resultContainer">
</div>
<div class="clearBoth"></div>
