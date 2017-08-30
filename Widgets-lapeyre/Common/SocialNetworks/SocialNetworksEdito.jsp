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
<fmt:setLocale value="${CommandContext.locale}" />
<fmt:setBundle basename="/Widgets/Properties/widgettext" var="widgetText" />

<div class="${param.classToApply} shareSocialNetwork" id="ficheSocialNetworks">
	<ul>
		<li class="emailShare">
		    <a href="" class="recommendArticleButtonMail mailShareLink" onclick="">
		        <div></div>
		    </a>
	    </li>
	    <li class="facebookShare">
	    	<a href="" class="recommendArticleButtonFb facebookShareLink" onclick="">
	       	 <div></div>
	   	 </a>
	    </li>
	    <li class="twitterShare">
		    <a href="" class="recommendArticleButtonTwitter twitterShareLink" onclick="">
		        <div></div>
		    </a>
	    </li>
	</ul>
</div>
