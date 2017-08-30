<%@ page trimDirectiveWhitespaces="true" %>
<div id="cookieConsentementContainer" class="consentement_cookie">
	<div>
	<p>
		${param.consentementCookieLabel}<br />
		<a href="${param.consentementCookieLink}">${param.consentementCookieLinkLabel}</a>
	</p>
	<div>
		<a class="button green" href="javascript:setCoookieForConsentement();">OK</a>
	</div>
	<div class="clearFloat"></div>
	</div>
</div>
<script>
	function setCoookieForConsentement() {
		dojo.cookie('cookieConsentement', 'true', {path:'/', expires: 365});
		$('#cookieConsentementContainer').fadeOut('slow', function(){
			$('#cookieConsentementContainer').remove();
		});
	}
</script>