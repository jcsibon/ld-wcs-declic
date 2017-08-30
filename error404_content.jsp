<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2006, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="/LapeyreSAS/storetext_v2" var="storeText" scope="request"/>

	<div class="notfoundErrorBlock">
		<span><fmt:message key="pageIntrouvableCode" bundle="${storeText}" /></span>
		<span><fmt:message key="pageIntrouvableLabel" bundle="${storeText}" /></span>
		<p><fmt:message key="pageIntrouvableDesc" bundle="${storeText}" /></p>
		<p><fmt:message key="pageIntrouvableTryLater" bundle="${storeText}" /></p>
		<a href="/" class="button"><fmt:message key="pageIntrouvableReturnToHome" bundle="${storeText}" /></a>
	</div>
	<div class="row">
		<div class="content">
			<%out.flush();%>
			<c:catch var="exc">
				<ecocea:widgetPath var="emspotpath" identifier="EMarketingSpot" />
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="404MarketingSpot_bestSeller" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="404MarketingSpot_bestSeller"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="404MarketingSpot_RecoProduits" />
					<c:param name="pageSize" value="3"/>
					<%-- Target2Sell BEGIN --%>
					<c:param name="t2sWidgetSuffix" value="404MarketingSpot_RecoProduits"/>
					<c:param name="displayPreference" value="1"/>
					<%-- Target2Sell END --%>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="404MarketingSpot_SelectionDuMois" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="404MarketingSpot_SelectionDuMois"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="404MarketingSpot_ProduitsEtContenus" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="404MarketingSpot_ProduitsEtContenus"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
			</c:catch>
			<%out.flush();%>
		
		</div>
	</div>

