<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf"%>
<c:choose>
	<c:when test="${result.name eq 'NONE'}">
		<div class="nodefaultStoreFoundArea vCenteredHeaderBlock">
			<div class="picto storePicto"></div>
			<div class="headerDataContainer">
				<span class="noneShopFound"><fmt:message key="LAP038_NOSHOP_FOUND" bundle="${widgetText}" /></span>
				<fmt:message key="headerStoreLocatorNoGeoIPLinkLabel" var="storeLocLinkLabel" bundle="${widgetText}" />
				<span><a href="${storeLocatorURL}">${storeLocLinkLabel}</a></span>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="defaultStoreContainerArea vCenteredHeaderBlock">
			<div class="picto storePicto"></div>
			<div class="headerDataContainer">
				<fmt:message key="headerStoreLocatorLinkLabel" var="storeLocLinkLabel" bundle="${widgetText}" />
				<span><a id="storeQuickLink" href="${result.seoUrl}"><ecocea:crop value="${result.name}" length="60"></ecocea:crop></a></span>
				<c:out value="${ecocea:fmtPhone(result.mainPhone)}"/>
				<script>var headerStoreId = '${result.strLocId}';</script>
			</div>
		</div>
		
		<div id="monMagPopup" class="popover-frame">
			<div class="popover-frame-arrow"></div>
			<div class="header">
				<h2 class="title">
					<fmt:message key="headerStoreLocatorLabel" bundle="${widgetText}" />
				</h2>
				<a class="subtitle hover_underline" href="${storeLocatorURL}"><fmt:message key="headerStoreLocatorLinkLabel" bundle="${widgetText}" /></a>
				<a class="closeButton" onclick="javascript:$('#monMagPopup').fadeToggle(300);"></a>
			</div>
			<div class="body">
				<div class="col-container">
					<div class="col shop-address">
						<h3 class="title">
							<a title="${result.name}" href="${result.seoUrl}">${result.name}</a>
						</h3>
						<p>${result.type}</p>
						<hr class="horizontalDivider" />
						<p>${result.address1}</p>
						<c:if test="${not empty result.address2}"><p>${result.address2}</p></c:if>
						<c:if test="${not empty result.address3}"><p>${result.address3}</p></c:if>
						<c:if test="${not empty result.address4}"><p>${result.address4}</p></c:if>
						<p>${result.cp} ${result.city}</p>
						<p>${ecocea:fmtPhone(result.mainPhone)}</p>

						<br/>
						
					</div>
				</div>
				<p class="cta">
					<img class="icon" src="${jspStoreImgDir}images/shopBlockYaller.png" alt="Se rendre au magasin" />
					<a class="goToShop black underline" href="${result.seoUrl}">Se rendre au magasin</a>
				</p>
			</div>
		</div>
	</c:otherwise>
</c:choose>
