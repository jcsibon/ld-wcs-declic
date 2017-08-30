<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2013, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN StaticContentPageDisplayContainer.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>

<div class="rowContainer" id="container_${pageDesign.layoutID}">
	<div class="row">
		<div data-slot-id="1" id="staticContentPageContainer"><wcpgl:widgetImport slotId="1"/></div>
	</div>
</div>

<script>
	/* Relocate the widget store search in the home page -> the location is different between mobile and desktop*/
	windowResizeHandleMobile = function() {
		var firstElement = $("#staticContentPageContainer > div:nth-child(1)");
		var storeSearch = $("#homeNearestStore");
		if(storeSearch !== null) {
			storeSearch.parent().parent().insertAfter(firstElement);
		}
	}
	
	windowResizeHandleDesktop = function() {
		var after = $("#staticContentPageContainer > div:nth-last-of-type(2)");
		var storeSearch = $("#homeNearestStore");
		if(storeSearch !== null) {
			storeSearch.parent().parent().insertAfter(after);
		}
	}

	var mediaPhone = window.matchMedia('(max-width: '+(tabletBreakpoint-1)+'px)');
	var mediaTablet = window.matchMedia('(max-width: '+(desktopBreakpoint-1)+'px) and (min-width: '+tabletBreakpoint+'px)');
	var mediaDesktop = window.matchMedia('(min-width: '+desktopBreakpoint+'px)');
	
	mediaPhone.addListener(function(changed) {
	    if(changed.matches) {
	    	windowResizeHandleMobile();
	    }
	});
	
	mediaTablet.addListener(function(changed) {
	    if(changed.matches) {
	    	windowResizeHandleMobile();
	    }
	});
	
	mediaDesktop.addListener(function(changed) {
	    if(changed.matches) {
	    	windowResizeHandleDesktop();
	    }
	});
	
	/* Init */
	if(viewport().width >= desktopBreakpoint) {
		windowResizeHandleDesktop();
	} else {
		windowResizeHandleMobile();
	}
		
</script>

<!-- END StaticContentPageDisplayContainer.jsp -->
