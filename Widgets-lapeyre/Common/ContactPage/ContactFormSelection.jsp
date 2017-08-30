<!-- BEGIN ContactFormSelection.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<fmt:message var="akioEmailGenerationErrorMessage" bundle="${storeText}" key="akioEmailGenerationErrorMessage" />
<c:set var="formName" value="${WCParam.formName}" />
<c:set var="isContactFormPresent" value="false"/>
<c:choose>
	<c:when test="${formName eq 'contactServiceClient' || formName eq 'contactSuiviCommande' || formName eq 'contactWebmaster'}">
		<c:set var="isContactFormPresent" value="true"/>
		<c:import url="/Widgets-lapeyre/Common/ContactPage/ContactStandard.jsp">
			<c:param name="formName" value="${formName}" />
		</c:import>
	</c:when>
	<c:when test="${formName eq 'contactValidationCommande'  || formName eq 'contactServiceExport'}">
		<c:set var="isContactFormPresent" value="true"/>
		<c:import url="/Widgets-lapeyre/Common/ContactPage/ContactOnline.jsp">
			<c:param name="formName" value="${formName}" />
		</c:import>
	</c:when>
	<c:when test="${formName eq 'contactPartner'}">
		<c:set var="isContactFormPresent" value="true"/>
		<c:import url="/Widgets-lapeyre/Common/ContactPage/ContactPartner.jsp" >
			<c:param name="formName" value="${formName}" />
		</c:import>
		<c:set var="doubleMandatoryFields" value="true" scope="request" />
	</c:when>
	<c:otherwise>
		<c:import url="/Widgets-lapeyre/Common/ContactPage/ContactForms.jsp" />
		<c:set var="noMandatoryArea" value="true" scope="request" />
	</c:otherwise>
</c:choose>

	<br/>
	<c:if test="${noMandatoryArea != 'true'}">
		<div class="footerBlock">
			<c:choose >
				<c:when test="${doubleMandatoryFields eq 'true'}">
					<fmt:message bundle="${storeText}" key='mandatoryFieldsLabel'/>
				</c:when>
				<c:otherwise>
					<fmt:message bundle="${storeText}" key='mandatoryFieldsLabelSingle'/>
				</c:otherwise>
			</c:choose>
			<br/>
			<br/>
			<fmt:message bundle="${storeText}" key='contactMentionsLegales'/>
		</div>
	</c:if>

<c:if test="${isContactFormPresent eq true}">

	<script>
	$().ready(function() {
	 	 $('#ContactForm').on('submit', function(e) {
	        e.preventDefault();
	 
	 		if(!$("#ContactForm").valid()) {
	 			return false;
	 		}
	 			
	 		if(!submitRequest()) {
				return false;
	 		}
	 		
			cursor_wait();	
			$('#mailNotSendMessageError').hide();	
			
	        var $this = $(this);
	        $.ajax({
	              url: $this.attr('action'),
	              type: $this.attr('method'),
	              data: $this.serialize(),
	              dataType: 'json', // JSON
	              success: function(json) {
	              	  cursor_clear();
	              	  if (json.status == 'success') {
	              	  		if (json.mailSent == true) {
	              	  			dijit.byId('mailSentPopup').show();
		              	  		$( "#ContactForm" ).get(0).reset();
	              	  		} else {
	              	  			$('#mailNotSendMessageError').html("${ecocea:escapeJS(akioEmailGenerationErrorMessage)}");
	                  			$('#mailNotSendMessageError').show();
	              	  		}
	              	  		
	                  } else {
	                  		$('#mailNotSendMessageError').html(json.errorMessage);
	                  		$('#mailNotSendMessageError').show();
	                  }
	              },
	              error : function(xhr, desc, err) {
	              	cursor_clear();
					console.error(err);
					$('#mailNotSendMessageError').html("${ecocea:escapeJS(akioEmailGenerationErrorMessage)}");
					$('#mailNotSendMessageError').show();
				  }
	         });
	    });
	
	});
	
	</script>
	
	<%@ include file="ContactMailSentPopup.jspf" %>
	
</c:if>
<!-- END ContactFormSelection.jsp -->