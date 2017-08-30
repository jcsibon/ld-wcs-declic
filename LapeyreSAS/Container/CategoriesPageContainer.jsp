<!-- BEGIN CategoriesPageContainer.jsp -->

<%@include file="../Common/EnvironmentSetup.jspf" %>
<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>
<link rel="stylesheet" href="${jsAssetsDir}css/redesign/univers.css" type="text/css" />
<link rel="stylesheet" href="${jsAssetsDir}css/redesign/univers-media.css" type="text/css" />

<wcf:rest var="categories" url="/store/${WCParam.storeId}/categoryview/byParentCategory/${categoryId}" />

<div id="container_${pageDesign.layoutID}">
	<div class="bannerContainer">
			<div class="col s12" data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
	 	<div class="row">
	 		<div class="meaUniversTopArea" id="meaTopArea" data-slot-id="2"><wcpgl:widgetImport slotId="2"/></div>
	 	</div>
	</div>
	<%-- On supprime la colonne de gauche sur la page univers --%>
	<div class="row" id="contentPageArea">
		<c:set var="isUniversePageLayout" value="${pageDesign.layoutName eq 'UniversePageLayout'}"/>		
		<c:set var="isFamilyPageLayout" value="${pageDesign.layoutName eq 'FamilyPageLayout'}" />		
		<c:choose>
		<c:when test="${isUniversePageLayout}">
			<div class="container">
				<div class="subUnivers hide-on-med-and-down">
					<c:forEach var="category" items="${categories.CatalogGroupView}">
						<a class="categoryName flex" href="#${category.identifier}">${category.name}<img class="arrowWhiteDown" alt="arrow_white_down" src="${jspStoreImgDir}images/redesign/arrow_white_down.png"></img></a>
					</c:forEach>
				</div>
				<div class="subUnivers hide-on-large-only">
					<a class="allProductsButton flex" href="#subUnivers"><fmt:message bundle="${widgetText}" key="showAllProducts"/><img class="arrowWhiteDown" alt="arrow_white_down" src="${jspStoreImgDir}images/redesign/arrow_white_down.png"></img></a>
				</div>
			</div>
			<div class="middleUniversContainer">
				<div class="container">
					<div class="row">
						<div class="col s12 right" data-slot-id="4"><wcpgl:widgetImport slotId="4"/></div>
					</div>
				</div>
			</div>
			<div id="subUnivers" class="container">
				<div class="col s12 right" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
			</div>
		</c:when>
		<c:when test="${isFamilyPageLayout}">
			<div class="container">
				<div id="leftColumnCategory" class="col s12 m12 l3" data-slot-id="3"><wcpgl:widgetImport slotId="3"/></div>
				<%-- <div class="col s12 m12 l9 right" data-slot-id="4"><wcpgl:widgetImport slotId="4"/></div> --%>
				<div class="col s12 m12 l9 right" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
			</div>
		</c:when>
		<c:otherwise>
		<div class="container">
				<div id="leftColumnCategory" class="col s12 m12 l3" data-slot-id="3"><wcpgl:widgetImport slotId="3"/></div>
				<div class="col s12 m12 l9 right" data-slot-id="4"><wcpgl:widgetImport slotId="4"/></div>
				<div class="col s12 m12 l9 right" data-slot-id="5"><wcpgl:widgetImport slotId="5"/></div>
			</div>
		</c:otherwise>
		</c:choose>
	</div>
	<div class="container">
		<div class="row padding-bottom">
			<div class="col s12" id="meaBottomArea" data-slot-id="6"><wcpgl:widgetImport slotId="6"/></div>
		</div>
		
		<%-- Zone de EMSpot non affichée sur mobile --%>
		<div class="row padding-bottom">
			<div class="col s12" id="widgetFooterArea" data-slot-id="7"><wcpgl:widgetImport slotId="7"/></div>
		</div>
	</div>
</div>

<!-- Pour afficher la description de la catégorie dans la colonne de gauche -->
<script>
	$(document).ready(function() {
		if(${isFamilyPageLayout}) {
			var categoryDescriptionText = $('#categoryDescriptionHidden').val();
	    	var htmlToAdd = "<p class='catentryDescription'>"+categoryDescriptionText+"</p>";
	    	$('#leftColumnCategory').append(htmlToAdd);
		}
	});
</script>
<!-- END CategoriesPageContainer.jsp -->