<%@ page trimDirectiveWhitespaces="true" %>
<c:set var="canceled" value=""/>
<c:if test="${webOrderStatus.step eq 6 }">
	<c:set var="canceled" value="Canceled"/>
</c:if>
	
<c:choose>
	<c:when test="${shippingMode.delivery}">
		<fmt:message var="breadcrumbSteps" bundle="${storeText}" key="orderStatusBreadcrumbStepsDelivery${canceled }" />
	</c:when>
	<c:otherwise>
		<fmt:message var="breadcrumbSteps" bundle="${storeText}" key="orderStatusBreadcrumbStepsPickup${canceled }" />
	</c:otherwise>
</c:choose>

<c:set var="breadcrumbStepsArray" value="${fn:split(breadcrumbSteps, ';')}"/>
<c:set var="liWidth" value="${100/fn:length(breadcrumbStepsArray)}%"/>

<c:set var="currentbcStepLabel" value=""/>
<div class="col12 slot1">
	<ul class="etapes suiviCom">
	
		<!-- bcStep a pour format stepCode:steplabel -->
		<c:forEach var="bcStep" items="${breadcrumbStepsArray}" varStatus="loop">
			<c:set var="stepLabelArray" value="${fn:split(bcStep, ':')}"/>
			
			<c:choose>
				<c:when test="${webOrderStatus.step eq stepLabelArray[0]}">
					<li style="width:${liWidth};"><div class="current"><span>${loop.count}</span><c:if test="${!isOnMobileDevice}">${stepLabelArray[1]}</c:if></div></li>
					<c:if test="${isOnMobileDevice}"><c:set var="currentbcStepLabel" value="${stepLabelArray[1]}"/></c:if>
				</c:when>
				<c:otherwise>
					<li style="width:${liWidth};"><div><span>${loop.count}</span><c:if test="${!isOnMobileDevice}">${stepLabelArray[1]}</c:if></div></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</ul>
	<c:if test="${isOnMobileDevice}">
		<p class="etapeTitle title${webOrderStatus.step}">
			${currentbcStepLabel }
		</p>
	</c:if>
	
</div>
