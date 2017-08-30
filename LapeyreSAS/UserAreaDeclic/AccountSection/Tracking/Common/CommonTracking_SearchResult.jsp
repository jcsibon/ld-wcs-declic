<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../../Common/nocache.jspf" %>
<c:choose>
	<c:when test="${notGranted}">
		<wcf:url var="OrderTrackingDetailsURL" value="OrderTrackingDetailsView" type="Ajax" >
			<wcf:param name="storeId" value="${storeId}" />
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="catalogId" value="${catalogId}" />
			<wcf:param name="storeEntity" value="${storeEntity[0]}" />
			<wcf:param name="orderId" value="${documentNumber[0] }" />
			<wcf:param name="cdbn" value="" />
		</wcf:url>

		<wcf:url var="LogonFormURL" value="LogonForm">
			<wcf:param name="storeId" value="${storeId}" />
			<wcf:param name="langId" value="${langId}" />
			<wcf:param name="catalogId" value="${catalogId}" />
			<wcf:param name="myAcctMain" value="1" />
			<wcf:param name="URL" value="${LapeyreProURL}" />
		</wcf:url>
		<div id="notGrantedMessageErrorContainer">
			<label><fmt:message bundle="${storeText}" key="orderTrackingSearchNotAllowed" /></label>
			<div class="ctaContainer">
				<%--ECOCEA: on redirige vers la page de resultat apres login --%>
				<a href="#" onClick="javascript:redirectToSignOn('${OrderTrackingDetailsURL}'); return false;" class="button greenSmall" id="WC_GenericError_Link_1">
					<fmt:message bundle="${storeText}" key="Logon_Title" />
				</a>
			</div>
		</div>
	</c:when>
	<c:when test="${TimeoutError}">
		<div id="WStimeoutErrorContainer">
			<fmt:message bundle="${storeText}" key="technicalErrorMessage" />
		</div>
	</c:when>
	<c:when test="${empty keumand || keumand.statutEntity.code eq '6' || keumand.statutEntity.code eq '5' || keumand.statutEntity.code eq '1' || keumand.statutEntity.code eq '2' || keumand.statutEntity.code eq '3' || keumand.statutEntity.code eq '4' || keumand.statutEntity.code eq '8'}">
		<div class="errorOrderNotFoundContainer clearAll">
			<fmt:message bundle="${storeText}" key="orderNotFoundErrorMessage">	</fmt:message>
		</div>
	</c:when>
	<c:otherwise>
		<fmt:message var="dateLabel" bundle="${storeText}" key="DateColumnlabel" />
		<fmt:message var="storeCommandeLabel" bundle="${storeText}" key="storeOrderNumberColumnLabel" />
		<fmt:message var="webCommandeLabel" bundle="${storeText}" key="webOrderNumberColumnLabel" />
		<fmt:message var="storeLabel" bundle="${storeText}" key="storeColumnLabel" />
		<fmt:message var="statutLabel" bundle="${storeText}" key="statusColumnLabel" />
		<c:choose>
			<c:when test="${extendedUserContext.isPro}">
				<c:if test="${keumand.type eq 'WEB'}">
					<fmt:message var="totalLabel" bundle="${storeText}" key="totalHtAmountColumnLabel" />
					<c:set var="realPrice" value="${keumand.priceHt}" />
				</c:if>
			</c:when>
			<c:otherwise>
				<c:if test="${keumand.type eq 'WEB'}">
					<fmt:message var="totalLabel" bundle="${storeText}" key="totalTtcAmountColumnLabel" />
					<c:set var="realPrice" value="${keumand.priceTtc}" />
				</c:if>
			</c:otherwise>
		</c:choose>
		<wcf:useBean var="datas" classname="java.util.ArrayList" />
		<fmt:formatDate var="dateFormatted" value="${keumand.dateCreation}" type="date" pattern="EEEE dd MMMM yyyy" />
		<c:if test="${!empty keumand.statutEntity.labelDate}"><c:set var="libelle" value=" ${keumand.statutEntity.labelDate}"/></c:if>
		<c:choose>
			<c:when test="${keumand.type eq 'WEB'}">
				<wcf:useBean var="datasInnerList" classname="java.util.ArrayList" />
				<wcf:url var="OrderTrackingDetailsURL" value="OrderTrackingDetailsView">
					<wcf:param name="storeId" value="${storeId}" />
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="catalogId" value="${catalogId}" />
					<wcf:param name="orderId" value="${keumand.webCommandNumber}" />
					<wcf:param name="cdnb" value="${keumand.commandNumber}" />
					<wcf:param name="storeEntity" value="${keumand.shopEntity.identifier}" />
				</wcf:url> 
				<wcf:set target="${datasInnerList}" value="<a href='${OrderTrackingDetailsURL}'>${dateFormatted}</a>" />
				<wcf:set target="${datasInnerList}" value="${keumand.commandNumber}" /> 
				<wcf:set target="${datasInnerList}" value="<a href='${OrderTrackingDetailsURL}'>${keumand.webCommandNumber}</a>" /> 
				<wcf:set target="${datasInnerList}" value="<span class='shopceil'><a class='hover_underline' href='${keumand.shopEntity.seoUrl}'>${keumand.shopEntity.name}</a><br /><c:out value='${ecocea:fmtPhone(keumand.shopEntity.phone)}'/></span>" /> 
				<wcf:set target="${datasInnerList}" value="<span class='row' title='${keumand.statutEntity.description}'><span class='dispo orderStatus${keumand.statutEntity.color}'>${keumand.statutEntity.label}${libelle}</span></span>" />
				<wcf:set target="${datasInnerList}" value="<span class='price'>${realPrice}<sup>${env_CurrencySymbolToFormat}</sup></span>" />
				<wcf:set target="${datas}" value="${datasInnerList}" />
				<c:remove var="datasInnerList" />
				<c:set var="tableHeader" value="${dateLabel},${storeCommandeLabel},${webCommandeLabel},${storeLabel},${statutLabel},${totalLabel}" />
				<c:set var="mobileBody" value="<div class='orderBlock'><span class='header'><p class='date'>%0</p><p class='status'>%4</p></span><div class='clearFloat'></div><p class='numbers'>${storeCommandeLabel} : %1<br />${webCommandeLabel} : %2</p><p class='shop'>%3</p>%5</div>" />
			</c:when>
			<c:otherwise>
				<wcf:useBean var="datasInnerList" classname="java.util.ArrayList" />
				<wcf:set target="${datasInnerList}" value="${dateFormatted}"/>
				<wcf:set target="${datasInnerList}" value="${keumand.commandNumber}" /> 
				<wcf:set target="${datasInnerList}" value="<span class='shopceil'><a class='hover_underline' href='${keumand.shopEntity.seoUrl}'>${keumand.shopEntity.name}</a><br />${ecocea:fmtPhone(keumand.shopEntity.phone)}</span>" /> 
				<wcf:set target="${datasInnerList}" value="<span class='row' title='${keumand.statutEntity.description}'><span class='dispo orderStatus${keumand.statutEntity.color}'>${keumand.statutEntity.label}${libelle}</span></span>" />
				<wcf:set target="${datas}" value="${datasInnerList}" />
				<c:remove var="datasInnerList" />
				<c:set var="tableHeader" value="${dateLabel},${storeCommandeLabel},${storeLabel},${statutLabel}" />
	           	<c:set var="mobileBody" value="<div class='orderBlock'><span class='header'><p class='date'>%0</p><p class='status'>%3</p></span><div class='clearFloat'></div><p class='numbers'>${storeCommandeLabel} : %1<br /></p><p class='shop'>%2</p></div>"/>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${isOnMobileDevice}">
				<div class="listesAchat">
					<ecocea:dataGrid 
						data="${datas}">
							${mobileBody}
					</ecocea:dataGrid>
				</div>
				<div class="clearAll"></div>
			</c:when>
			<c:otherwise>
				<ecocea:dataGrid 
					data="${datas}"
					header="${tableHeader}"
					tableClass="ordersDatagrid">
				</ecocea:dataGrid>
				<div class="clearAll"></div>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>