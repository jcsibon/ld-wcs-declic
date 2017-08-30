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
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN StoreHoursPopin.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="paymentInfoPopin" data-dojo-type="lapeyre/widget/Dialog" title="<fmt:message bundle='${widgetText}' key='infoCartePopinTitle' />" style="display:none;">
	<div class="widget_site_popup">
		<div class="content">
			<div class="header">
				<span>
					<img src="${jspStoreImgDir}/images/payment/logo_mercanet.png" /><div style="display:inline-block;width:30px"></div><img src="${jspStoreImgDir}/images/payment/cadenas.png" />
				</span>
				<a role="button" id="paymentInfoPopinClose" href="#" onclick="javascript:dijit.byId('paymentInfoPopin').hide();return false;" class="close" title="<fmt:message key="SL_CLOSE" bundle="${widgetText}" />" aria-label="<fmt:message key="SL_CLOSE" bundle="${widgetText}"/>"></a>
			</div>
			<div class="body centered">
				<div>
					<fmt:message bundle="${widgetText}" key="infoCartePopinBody" />
				</div>
			</div>
			<div class="footer centered">
				<a onclick="javascript:dijit.byId('paymentInfoPopin').hide();return false;" href="#" class="button green"><fmt:message bundle="${widgetText}" key="infoCartePopinButtonLabel" /></a>
			</div>
		</div>
	</div>
</div>		
<!-- END StoreHoursPopin.jsp -->
