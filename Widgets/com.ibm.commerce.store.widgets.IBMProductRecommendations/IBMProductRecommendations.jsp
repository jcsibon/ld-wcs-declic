<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2012, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN IBMProductRecommendations.jsp -->

<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<script type="text/javascript" src="<c:out value="${staticAssetContextRoot}/Widgets/com.ibm.commerce.store.widgets.IBMProductRecommendations/javascript/IBMProductRecommendations.js?${versionNumber}"/>"></script>

<%@include file="IBMProductRecommendations_Data.jspf"%>

<c:if test="${numIntelligentOffer == 0}">
	<%out.flush();%>
		<c:import url="/Widgets/com.ibm.commerce.store.widgets.IBMProductRecommendations/IBMProductRecommendations_Result_UI.jsp">
			<c:param name="langId" value="${WCParam.langId}" /> 
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${WCParam.catalogId}" />
			<c:param name="emsName" value="${emsName}" />							
			<c:param name="maxProductsToDisplay" value="${param.maxProductsToDisplay}"/>
			<c:param name="pagination" value="${param.pagination}"/>
			<c:param name="pageView" value="${param.pageView}"/>
			<c:param name="currentPage" value="${param.currentPage}"/>							           								
			<c:param name="showBorder" value="${showBorder}"/>
			<c:param name="showHeader" value="${showHeader}"/>
			<c:param name="showCompareBox" value="${showCompareBox}"/>
			<c:param name="mainProductId" value="${param.mainProductId}" />
			<c:param name="partNumber" value=""/>
			<c:param name="widgetSuffix" value="${widgetSuffix}" />
			<c:param name="pageSize" value="${pageSize}" />
			<c:param name="showFeed" value="${param.showFeed }" />
			<c:param name="feedURL" value="${eMarketingFeedURL}" />
			<c:param name="widgetOrientation" value="${param.widgetOrientation}"/>
			<c:param name="displayPreference" value="${param.displayPreference}" />
			<c:param name="columnCountByWidth" value="${columnCountByWidth}"/>
		</c:import>
	<%out.flush();%>
</c:if>

<c:if test="${numIntelligentOffer != 0}">
	<script type="text/javascript">
		dojo.addOnLoad(function() { 	
			//console.warn('before cmDisplayRecs');
		  cmDisplayRecs();
	  });		  
	</script>
</c:if>

<!-- END IBMProductRecommendations.jsp -->