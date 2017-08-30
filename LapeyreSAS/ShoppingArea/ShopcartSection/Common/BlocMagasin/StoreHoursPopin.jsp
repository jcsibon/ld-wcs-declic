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
<div id="storeHoursPopin" data-dojo-type="lapeyre/widget/Dialog" title="<fmt:message bundle='${widgetText}' key='magasinsHorairesTitle' />" style="display:none;">
	<div class="widget_site_popup">
		<div class="content">
			<div class="header">
				<span><fmt:message bundle="${widgetText}" key="magasinsHorairesTitle" /></span>
				<a role="button" id="horaireMagasinPopinClose" href="#" onclick="javascript:dijit.byId('storeHoursPopin').hide();return false;" class="close" title="<fmt:message key="SL_CLOSE" bundle="${widgetText}" />" aria-label="<fmt:message key="SL_CLOSE" bundle="${widgetText}"/>"></a>
			</div>
			<div class="body alignLeft" dojoType="wc.widget.RefreshArea" id="storeHoursPopinId" objectId="storeHoursPopinId" controllerId="storeHoursPopin_controller">
				
			</div>
		</div>
	</div>
</div>		
<!-- END StoreHoursPopin.jsp -->
