<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${env_inPreview }">
	<c:if test="${not empty cookie.WC_TOOLLOCALE.value }">
		<fmt:setLocale value="${cookie.WC_TOOLLOCALE.value}"/>
	</c:if>
	<c:if test="${empty cookie.WC_TOOLLOCALE.value }">
	<%-- 
		The TOOLLOCALE will be empty if the preview launched from Accelerator 
	--%>
		<fmt:setLocale value="${CommandContext.locale}" />
	</c:if>
	<fmt:setBundle basename="/Widgets/Properties/widgettext" var="widgetPreviewText"/>
	<fmt:setBundle basename="com.ibm.commerce.stores.preview.properties.StorePreviewer" var="previewText" />
</c:if>

<script type="text/javascript">
	function pushSocialNetworkName(socialNetworkName){
		dataLayer.push({"event" : "socialShare", "nom_reseau_social" : socialNetworkName});
	}
</script>

<fmt:setLocale value="${CommandContext.locale}" />
<fmt:setBundle basename="/Widgets/Properties/widgettext" var="widgetText" />

<c:set var="nbCols" value="6" />
<c:if test="${!empty isPageEdito}"><c:set var="nbCols" value="${nbCols-1}" /></c:if>
<c:if test="${!empty isNoMail}"><c:set var="nbCols" value="${nbCols-1}" /></c:if>
<c:if test="${!empty param.isNoGooglePlus}"><c:set var="nbCols" value="${nbCols-1}" /></c:if>
<div class="${param.classToApply} col s12" id="ficheSocialNetworks">
	<ul>
		<li class="facebookShare">
			<a href="${socialSharingURL}" class="facebookShareLink shareLink" target="_blank">
				<div onclick="pushSocialNetworkName('Facebook')"></div>
			</a>
		</li>
		<c:if test="${empty isPageEdito}">
			<li class="pinterestShare">
				<c:set var="pinterestUrlSharing" value="http://www.pinterest.com/pin/create/button" />
				<c:url var="pinterestFullUrlSharing" value="${pinterestUrlSharing}" >
					<c:param name="url" value="${socialSharingURL}" />
					<c:param name="media" value="${socialSharingImage}" />
					<c:param name="description" value="${socialSharingDescription}" />
				</c:url>
				<a href="${pinterestFullUrlSharing}" target="_blank" class="pinterestShareLink shareLink" title="${socialSharingTitle}">
					<div onclick="pushSocialNetworkName('Pinterest')"></div>
				</a>
			</li>
		</c:if>
		<li class="twitterShare">
			<a href="${socialSharingURL}" class="twitterShareLink shareLink" target="_blank" title="${socialSharingTitle}">
				<div onclick="pushSocialNetworkName('Twitter')"></div>
			</a>
		</li>
		<c:if test="${empty param.isNoGooglePlus}">
		<li class="googleplusShare">
			<c:set var="googlePlusUrlSharing" value="http://plus.google.com/share" />
			<c:url var="googlePlusFullUrlSharing" value="${googlePlusUrlSharing}" >
				<c:param name="url" value="${socialSharingURL}" />
			</c:url>
			<a href="${googlePlusFullUrlSharing}" class="googlePlusShareLink shareLink" target="_blank" title="${socialSharingTitle}">
				<div onclick="pushSocialNetworkName('Google+')"></div>
			</a>
		</li>
		</c:if>
		<c:if test="${empty isNoMail}">
		<li class="emailShare">
			<a href="${socialSharingURL}" class="mailShareLink shareLink" title="${socialSharingTitle}" onclick="return false;">
				<div onclick="pushSocialNetworkName('Email')"></div>
			</a>
		</li>
		</c:if>
		<c:if test="${empty isNoInstagram}">
		<li class="instagramShare">
			<a href="${socialSharingURL}" class="instagramShareLink shareLink" title="${socialSharingTitle}" onclick="return false;">
				<div onclick="pushSocialNetworkName('Instagram')"></div>
			</a>
		</li>
		</c:if>
	</ul>
</div>
