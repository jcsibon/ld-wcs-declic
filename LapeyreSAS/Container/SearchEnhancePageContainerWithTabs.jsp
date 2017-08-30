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

<!-- BEGIN SearchEnhancePageContainerWithTabs.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../Common/EnvironmentSetup.jspf"%>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>
<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/ProductTab/ProductTab.js?${versionNumber}"></script>
<link rel="stylesheet" href="${jspStoreImgDir}css/redesign/product/productDisplay.css" type="text/css">

<div class="subCat_page_tab_content" id="container_${pageDesign.layoutID}">
	<div class="full-background searchdisplay-breadcrumb">
		<div class="container">
			<div class="row margin-true">
				<div class="col s12" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
			</div>
		</div>
		
		<div class="row">
			<c:if test="${!empty WCParam.searchTerm || !empty WCParam.manufacturer}">
					<div class="hide-on-large-only centered-title">
						<c:import url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.SearchSummary/SearchSummary.jsp">
							<c:param name="type" value="mobile-title" />
						</c:import>
					</div>
			</c:if>
		</div>
		 
		 
		<div class="container">
			<div class="row searchdisplay-tabs">
				
				<wcf:useBean var="tabSlotIds" classname="java.util.ArrayList"/>
				<%-- Double loop to get the slots into the array list in proper order. The service does not return the child widgets in any predictable order. --%>
				<c:set var="tabSlotCount" value="0"/>
				<c:forEach var="slotNumber" begin="4" end="5">
					<c:set var="foundCurrentSlot" value="false"/>
					<c:forEach var="childWidget" items="${pageDesign.widget.childWidget}">
						<c:if test="${childWidget.slot.internalSlotId == slotNumber && !foundCurrentSlot}">
							<wcf:set target="${tabSlotIds}" value="${slotNumber}" />
							<c:set var="foundCurrentSlot" value="true"/>
							<c:set var="tabSlotCount" value="${tabSlotCount+1}"/>
						</c:if>
					</c:forEach>
				</c:forEach>
				<div class="col s12 tab_header tab_header_double">
					<c:forEach var="tabSlotId" items="${tabSlotIds}" varStatus="status">
						<c:set var="tabSlotName" value="Title${tabSlotId}"/>
						<c:forEach var="childWidget" items="${pageDesign.widget.childWidget}">
							<c:if test="${childWidget.slot.internalSlotId == tabSlotName}">
								<c:set var="tabWidgetDefIdentifier" value="${childWidget.widgetDefinitionId}"/>
								<c:set var="tabWidgetIdentifier" value="${childWidget.widgetId}"/>
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${status.first}">
								<c:set var="tabClass" value="first active_tab" />
								<c:set var="tabIndex" value="0" />
							</c:when>
							<c:otherwise>
								<c:set var="tabClass" value="inactive_tab" />
								<c:set var="tabIndex" value="-1" />
							</c:otherwise>
						</c:choose>
						<c:set var="tabNumber" value="${status.index+1}" scope="request"/>
						<div id="tab${status.count}" tabindex="${tabIndex}" class="tab_container col s6 ${tabClass}" 
								aria-labelledby="contentRecommendationWidget_${tabSlotName}_${tabWidgetDefIdentifier}_${tabWidgetIdentifier}" aria-controls="tab${status.count}Widget"
								onfocus="ProductTabJS.focusTab('tab${status.count}');" onblur="ProductTabJS.blurTab('tab${status.count}');" 
								role="tab" aria-setsize="${tabSlotCount}" aria-posinset="${status.count}" aria-selected="${status.first == true ? 'true' : 'false'}" 
								onclick="ProductTabJS.selectTab('tab${status.count}');" 
								onkeydown="ProductTabJS.selectTabWithKeyboard('${status.count}','${tabSlotCount}', event);">
								<wcpgl:widgetImport slotId="${tabSlotName}"/>
						</div>
						
						<c:remove var="tabNumber"/>
					</c:forEach>
					<script type="text/javascript">
					dojo.addOnLoad(function(){
						var onglet = '<c:out value="${WCParam.ongletSearch}"/>'
						var count = byId("searchTabProdCount");
						var countContenu = byId("searchTabContentCount");
						var prodCount = (count) ? parseInt(count.innerHTML) : 0;
						var contenuCount = (countContenu) ? parseInt(countContenu.innerHTML) : 0;
						var tab = byId("tab2");
						
						if((tab != null) 
							&& (((prodCount == 0) && (contenuCount == 0) && (onglet == 'contenu')) 
							|| ((prodCount == 0) && (contenuCount > 0)) 
							|| ((onglet == 'contenu') && (contenuCount > 0)))) {
							tab.click();
						}
						
					});
					</script>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<%-- <div class="col s9 offset-s3">
				<wcpgl:widgetImport slotId="3" />
			</div> --%>
		</div>
		<div class="row">
			<div class="tabButtonContainer col s12" role="tablist" style="float: initial;">
				<c:forEach var="tabSlotId" items="${tabSlotIds}" varStatus="status">
					<c:set var="tabStyle" value=""/>
					<c:if test="${!status.first}">
						<c:set var="tabStyle" value="style='display:none'" />
					</c:if>
					<%-- ici setter les variables et appeler l'include externalis� pour mise en commun avec folderedito --%>
					<c:set var="statusCount" value="${status.count}"/>
					<%@ include file="SearchTab.jsp" %>
					
					<c:remove var="tabStyle"/>
				</c:forEach>			
			</div>	
		</div>
		<c:if test="${ totalCount >1}">
			<div class="row">
				<div class="col s12 right" data-slot-id="6"><wcpgl:widgetImport slotId="6"/></div>
			</div>
		</c:if>
	</div>
</div>

<!-- END SearchEnhancePageContainerWithTabs.jsp -->
