<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../../Common/nocache.jspf" %>

<div class="row">
	<div class="col12">
		<h2 class="titleBlock"><fmt:message bundle="${storeText}" key="searchQuotationPageTitle" /></h2>
		
		
		<div class="searchMessageLabel">
			<p><fmt:message bundle="${storeText}" key="searchQuotationPageContent" /></p>
		</div>
		
		<script>
			var onFormSubmitHandler = null;
		</script>
		
		<c:import url="Common/CommonTracking_SearchForm.jsp">
			<c:param name="trackingType" value="Quotation" />
			<c:param name="actionUrl" value="" />
		</c:import>
		
		<c:choose>
			<c:when test="${TimeoutError}">
					<div id="WStimeoutErrorContainer">
						<fmt:message bundle="${storeText}" key="technicalErrorMessage" />
					</div>
			</c:when>
			<c:otherwise>
				<c:if test="${!empty devisFound && !devisFound }">
					<div class="errorOrderNotFoundContainer clearAll">
						<fmt:message bundle="${storeText}" key="quotationNotFoundErrorMessage"></fmt:message>
					</div>
				</c:if>
			</c:otherwise>
		</c:choose>	
	</div>
</div>


