<!-- BEGIN ContactForms.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<c:set var="contactImage" value="${isOnMobileDevice ? 'contact_mobile.png' : 'contact_dektop_960x147.png'}" />

<div class="contactPresentation">
		<div class="contactBackground">
			<img class="full-width" alt="ContactHeader" src="${jspStoreImgDir}/images/${contactImage}">
		</div>
		<div class="textContainer">
			<h1><fmt:message key="contactPageTitle" bundle="${widgetText}" /></h1>
		</div>
</div>
<div class="contactAccroche">
	<fmt:message key="contactAccroche" bundle="${widgetText}" />
</div>

<div class="row">
	<h2 class="titleBlock">
		<fmt:message key="contactSubTitle" bundle="${widgetText}" />
	</h2>
</div>

<div class="contactForms">
	<div class="col8 bcol12 centered">
		<div class="col6 bcol12 left">
			<div class="ctaContainer">
				<a id="ContactServiceClientButton" class="button" tabindex="0" href="/contact?formName=contactServiceClient">
					<fmt:message bundle="${widgetText}" key='contactServiceClientButtonLabel'/>
				</a>
			</div>
			<div class="ctaContainer">
				<a id="ContactValidateCommandeButton" class="button" tabindex="0" href="/contact?formName=contactValidationCommande">
					<fmt:message bundle="${widgetText}" key='contactValidationCommandeButtonLabel'/>
				</a>
			</div>
			<div class="ctaContainer">
				<a id="ContactWebmasterButton" class="button" tabindex="0" href="/contact?formName=contactWebmaster">
					<fmt:message bundle="${widgetText}" key='contactWebmasterButtonLabel'/>
				</a>
			</div>
			<%--mantis 2789 : Attention URL en dur--%>
			<div class="ctaContainer">
				<a id="ContactServiceExportButton" class="button" tabindex="0" href="${env_absoluteUrl}c/h/retractation">
					<fmt:message bundle="${widgetText}" key='contactRetractationButtonLabel'/>
				</a>
			</div>
			<%-- /mantis 2789 --%>
		</div>
		<div class="col6 bcol12 left">
			<div class="ctaContainer">
				<a id="ContactSuiviCommandeWebButton" class="button" tabindex="0" href="/contact?formName=contactSuiviCommande">
					<fmt:message bundle="${widgetText}" key='contactSuiviCommandeButtonLabel'/>
				</a>
			</div>
			<div class="ctaContainer">
				<a id="ContactPartenariatPropositionButton" class="button" tabindex="0" href="/contact?formName=contactPartner">
					<fmt:message bundle="${widgetText}" key='contactPartnerButtonLabel'/>
				</a>
			</div>
			<div class="ctaContainer">
				<a id="ContactServiceExportButton" class="button" tabindex="0" href="/contact?formName=contactServiceExport">
					<fmt:message bundle="${widgetText}" key='contactServiceExportButtonLabel'/>
				</a>
			</div>
		</div>
	</div>
	<div class="clearAll"></div>
</div>

<div class="footerBlock">
	<p id="contactMentionsLegales"><fmt:message bundle="${storeText}" key='contactMentionsLegales'/></p>
</div>
<!-- END ContactForms.jsp -->