<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../../../../Common/EnvironmentSetup.jspf" %>
<%@include file="../../../../Common/nocache.jspf" %>

<wcf:useBean var="webOrders" classname="java.util.ArrayList" />
<wcf:useBean var="storeOrders" classname="java.util.ArrayList" />

<c:forEach var="fullCmd" items="${fullCommands}">
	<c:choose>
		<c:when test="${fullCmd.type eq 'WEB'}">
			<wcf:set target="${webOrders}" value="${fullCmd}" />
		</c:when>
		<c:otherwise>
			<wcf:set target="${storeOrders}" value="${fullCmd}" />
		</c:otherwise>
	</c:choose>
</c:forEach>
<c:set var="webOrders" value="${ecocea:sortCommandsByDate(webOrders)}" />
<c:set var="storeOrders" value="${ecocea:sortCommandsByDate(storeOrders)}" />
	<h2 class="titleBlock"><fmt:message bundle="${storeText}" key="webOrderSectionTitle" /></h2>
<wcf:url var="OrderTrackingSearchURL" patternName="SearchOrderPageURL" value="OrderTrackingSearchView" type="Ajax">
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<script>
	var onFormSubmitHandler = function() {
		require(['dojo/dom-form'], function(domForm){
			$('input[id="submit"]').attr('disabled', 'disabled');
			$.post('${OrderTrackingSearchURL}', domForm.toObject('searchOrderForm'), function(data) {
				$('#resultContainer').empty();
				$('#resultContainer').append(data);
				$('input[id="submit"]').removeAttr('disabled');
			}); 
		});
	}
</script>



<wcf:useBean var="datas" classname="java.util.ArrayList" />

<fmt:message var="dateLabel" bundle="${storeText}" key="DateColumnlabel" />
<fmt:message var="storeCommandeLabel" bundle="${storeText}" key="storeOrderNumberColumnLabel" />
<fmt:message var="webCommandeLabel" bundle="${storeText}" key="webOrderNumberColumnLabel" />
<fmt:message var="storeLabel" bundle="${storeText}" key="storeColumnLabel" />
<fmt:message var="statutLabel" bundle="${storeText}" key="statusColumnLabel" />
<c:choose>
    <c:when test="${extendedUserContext.isPro}">
        <fmt:message var="totalLabel" bundle="${storeText}" key="totalHtAmountColumnLabel" />
    </c:when>
    <c:otherwise>
        <fmt:message var="totalLabel" bundle="${storeText}" key="totalTtcAmountColumnLabel" />
    </c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${!empty webOrders}">
		<c:forEach var="webOrder" items="${webOrders}">
		    <wcf:useBean var="datasInnerList" classname="java.util.ArrayList" />
		    <fmt:formatDate var="dateFormatted" value="${webOrder.dateCreation}" type="date" pattern="EEEE dd MMMM yyyy" />
		    <wcf:url var="OrderTrackingDetailsURL" value="OrderTrackingDetailsView">
		        <wcf:param name="storeId" value="${storeId}" />
		        <wcf:param name="langId" value="${langId}" />
		        <wcf:param name="catalogId" value="${catalogId}" />
		        <wcf:param name="orderId" value="${webOrder.webCommandNumber}" />
		        <wcf:param name="cdnb" value="${webOrder.commandNumber}" />
		        <wcf:param name="storeEntity" value="${webOrder.shopEntity.identifier}" />
		    </wcf:url> 
		    <wcf:set target="${datasInnerList}" value="<a class='hover_underline' href='${OrderTrackingDetailsURL}'>${dateFormatted}</a>" />
		    <wcf:set target="${datasInnerList}" value="${webOrder.commandNumber}" /> 
		    <wcf:set target="${datasInnerList}" value="<a class='hover_underline' href='${OrderTrackingDetailsURL}'>${webOrder.webCommandNumber}</a>" />
		    <c:choose>
		    	<c:when test="${webOrder.shopEntity.name eq 'UNKNOWN_SHOP'}">
			    	<fmt:message var="unkwnowShopMessage" key="unkwnowShopMessage" bundle="${storeText}">
			    		<fmt:param value="${webOrder.shopEntity.identifier}" />
			    	</fmt:message>
			   		 <wcf:set target="${datasInnerList}" value="${unkwnowShopMessage}" /> 
		    	</c:when>
		    	<c:otherwise>
		    		<wcf:set target="${datasInnerList}" value="<a class='hover_underline' href='${webOrder.shopEntity.seoUrl}'>${webOrder.shopEntity.name}</a><br /><b>${ecocea:fmtPhone(webOrder.shopEntity.phone)}</b>" /> 
		    	</c:otherwise>
		    </c:choose>
		    <wcf:set target="${datasInnerList}" value="<a class='hover_underline' href='${OrderTrackingDetailsURL}'><span class='row' title='${webOrder.statutEntity.description}'><span class='dispo orderStatus${webOrder.statutEntity.color}'>${webOrder.statutEntity.label}</span></span></a>" />
			
		    <c:choose>
			    <c:when test="${extendedUserContext.isPro}">
			    	<fmt:parseNumber var="priceFormatted" value="${webOrder.priceHt}" parseLocale="en_US"/>
					<fmt:formatNumber var="price" value="${priceFormatted}" type="currency" currencySymbol="${env_CurrencySymbolToFormat}<sup class='supHTPriceCategoryPage'>HT</sup>" maxFractionDigits="${env_currencyDecimal}"/>
			        <wcf:set target="${datasInnerList}" value="<a class='hover_underline' href='${OrderTrackingDetailsURL}'><span class='price'>${price}</span></a>" />
			    </c:when>
			    <c:otherwise>
			    	<fmt:parseNumber var="priceFormatted" value="${webOrder.priceTtc}" parseLocale="en_US"/>
					<fmt:formatNumber var="price" value="${priceFormatted}" type="currency" currencySymbol="<sup>${env_CurrencySymbolToFormat}</sup>" maxFractionDigits="${env_currencyDecimal}"/>
			        <wcf:set target="${datasInnerList}" value="<a class='hover_underline' href='${OrderTrackingDetailsURL}'><span class='price'>${price}</span></a>" />
			    </c:otherwise>
			</c:choose>
		    
		    <wcf:set target="${datas}" value="${datasInnerList}" />
		    <c:remove var="datasInnerList" />
		</c:forEach>
	
	
		<c:choose>
		    <c:when test="${isOnMobileDevice}">
		    <div class="listesAchat">
		        <ecocea:dataGrid 
		            data="${datas}">
		            <div class="orderBlock">
		                <span class="header">
		                	<p class="date">%0</p>
		                	<p class="status">%4</p>
		                </span>
		                <div class="clearFloat"></div>
		                <p class="numbers">
		                	${storeCommandeLabel} : %1<br />
		                	${webCommandeLabel} : %2
		                </p>
		                <p class="shop">
		                	%3
		                </p>
		                %5
		            </div>
		        </ecocea:dataGrid>
		    </div>
		    <div class="clearAll"></div>
		    </c:when>
		    <c:otherwise>
		        <ecocea:dataGrid 
		            header="${dateLabel},${storeCommandeLabel},${webCommandeLabel},${storeLabel},${statutLabel},${totalLabel}"
		            data="${datas}"
		            tableClass="ordersDatagrid">
		        </ecocea:dataGrid>
		        <div class="clearAll"></div>
		    </c:otherwise>
		</c:choose>
	
	</c:when>
	<c:otherwise>
		<div class="errorOrderNotFoundContainer">
			<fmt:message bundle="${storeText}" key="noWebOrdersFoundErrorMessage" />
		</div>
		<div class="clearAll"></div>
	</c:otherwise>
</c:choose>


	<h2 class="titleBlock marginTop20"><fmt:message bundle="${storeText}" key="storeOrderSectionTitle" /></h2>
	
	<div id="inlineSearchOrderFormcontainer">
		<a class="button" onclick="javascript:$('#searchOrderForm').slideToggle('slow', function() {});"><fmt:message bundle="${storeText}" key="searchOrderButtonLabel" /></a>
	</div>
	<c:import url="Common/CommonTracking_SearchForm.jsp">
		<c:param name="trackingType" value="Order" />
		<c:param name="inlineClass" value=" searchTrackingInlineForm" />
		<c:param name="actionUrl" value="${OrderTrackingSearchURL}" />
	</c:import>
	
	<div id="resultContainer">
	</div>
	
<c:if test="${!empty storeOrders}">	
	<p id="storeOrderMessage" class="description">
		<%-- <fmt:message bundle="${storeText}" key="storeOrderSectionMessage" /> --%>
	</p>


	<c:remove var="datas" />
	<wcf:useBean var="datas" classname="java.util.ArrayList" />

	<c:forEach var="storeOrder" items="${storeOrders}">
	    <wcf:useBean var="datasInnerList" classname="java.util.ArrayList" />
	    <fmt:formatDate var="dateFormatted" value="${storeOrder.dateCreation}" type="date" pattern="EEEE dd MMMM yyyy" />
	    <wcf:set target="${datasInnerList}" value="${dateFormatted}" />
	    <wcf:set target="${datasInnerList}" value="${storeOrder.commandNumber}" />
	    <c:choose>
	    	<c:when test="${storeOrder.shopEntity.name eq 'UNKNOWN_SHOP'}">
	    	<fmt:message var="unkwnowShopMessage" key="unkwnowShopMessage" bundle="${storeText}">
	    		<fmt:param value="${storeOrder.shopEntity.identifier}" />
	    	</fmt:message>
	    <wcf:set target="${datasInnerList}" value="${unkwnowShopMessage}" /> 
	    	</c:when>
	    	<c:otherwise>
	    <wcf:set target="${datasInnerList}" value="<a href='${storeOrder.shopEntity.seoUrl}'>${storeOrder.shopEntity.name}</a><br />${ecocea:fmtPhone(storeOrder.shopEntity.phone)}" /> 
	    	</c:otherwise>
	    </c:choose>
	    <wcf:set target="${datasInnerList}" value="<span class='row' title='${storeOrder.statutEntity.description}'><span class='dispo orderStatus${storeOrder.statutEntity.color}'>${storeOrder.statutEntity.label}</span></span>" />
	    <%--  ${storeOrder.statutEntity.labelDate} --%>
	    <wcf:set target="${datas}" value="${datasInnerList}" />
	    <c:remove var="datasInnerList" />
	</c:forEach>

	<c:choose>
	    <c:when test="${isOnMobileDevice}">
	    <ecocea:dataGrid 
	        data="${datas}">
	           <div class="orderBlock">
	               <span class="header">
	               	<p class="date">%0</p>
	               	<p class="status">%3</p>
	               </span>
	               <div class="clearFloat"></div>
	               <p class="numbers">
	               	${storeCommandeLabel} : %1<br />
	               </p>
	               <p class="shop">
	               	%2
	               </p>
	           </div>
	           <div class="clearAll"></div>
	    </ecocea:dataGrid>
	    </c:when>
	    <c:otherwise>
	        <ecocea:dataGrid
	            header="${dateLabel},${storeCommandeLabel},${storeLabel},${statutLabel}"
	            data="${datas}"
	            tableClass="ordersDatagrid" />
	            <div class="clearAll"></div> 
	    </c:otherwise>
	</c:choose>
</c:if>
