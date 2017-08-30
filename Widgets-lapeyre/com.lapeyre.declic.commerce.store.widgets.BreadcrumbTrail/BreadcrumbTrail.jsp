<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page pageEncoding="UTF-8"%>

<!-- BEGIN BreadcrumbTrail.jsp -->

<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<c:if test="${!empty param.parent_category_rn}">
	<c:set var="parent_category_rn" value="${param.parent_category_rn}"/>
</c:if>
<c:if test="${!empty WCParam.parent_category_rn}">
	<c:set var="parent_category_rn" value="${WCParam.parent_category_rn}"/>
</c:if>	
<c:if test="${!empty param.productId}">
	<c:set var="productId" value="${param.productId}"/>
</c:if>
<c:if test="${!empty WCParam.productId}">
	<c:set var="productId" value="${WCParam.productId}"/>
</c:if>
<c:if test="${!empty param.categoryId}">
	<c:set var="categoryId" value="${param.categoryId}"/>
</c:if>
<c:if test="${!empty WCParam.categoryId}">
	<c:set var="categoryId" value="${WCParam.categoryId}"/>
</c:if>
<c:if test="${!empty param.pageName}">
	<c:set var="pageName" value="${param.pageName}"/>
</c:if>
<c:if test="${!empty WCParam.pageName}">
	<c:set var="pageName" value="${WCParam.pageName}"/>
</c:if>
<c:set var="widgetSuffix" value="" />
<c:if test="${(!empty param.pgl_widgetSlotId) && (!empty param.pgl_widgetDefId) && (!empty param.pgl_widgetId)}">
		<c:set var="widgetSuffix" value="_${param.pgl_widgetSlotId}_${param.pgl_widgetDefId}_${param.pgl_widgetId}"  scope="request"/>
</c:if>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_Start.jspf" %>
<c:choose>
	<c:when test="${pageName eq 'AdvancedSearchPage' || pageName eq 'StaticSearchPage'}">
		<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrailGeneric.jsp" />
		<%out.flush();%>
	</c:when>
	<c:when test="${pageName eq 'HelpPage'}">
		<fmt:message key='FAQ_BREADCRUMB_LABEL' var="HelpPage" bundle='${widgetText}'/>
		<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrailHierarchyWithBackButton.jsp" >
				<c:param name="target" value="${HelpPage}"/>
			</c:import>
		<%out.flush();%>
	</c:when>
	<c:when test="${pageName eq 'ContactPage'}">
		<fmt:message key='CONTACT_BREADCRUMB_LABEL' var="ContactPage" bundle='${widgetText}'/>
		<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrailHierarchyWithBackButton.jsp" >
				<c:param name="target" value="${ContactPage}"/>
				<c:param name="formName" value="${param.formName}" />
			</c:import>
		<%out.flush();%>
	</c:when>
	<c:when test="${pageName eq 'CompteClient'}">
		<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrailHierarchyWithBackButton.jsp" >
				<c:param name="pageName" value="${pageName}" />
				<c:param name="breadCrumbIdentification" value="${param.breadCrumbIdentification}" />
				<c:param name="breadCrumbSynchro" value="${param.breadCrumbSynchro}" />
				<c:param name="breadCrumbMesAdresses" value="${param.breadCrumbMesAdresses}" />
				<c:param name="breadCrumbMonCompte" value="${param.breadCrumbMonCompte}" />
				<c:param name="breadCrumbInscription" value="${param.breadCrumbInscription}" />
				<c:param name="breadCrumbWishList" value="${param.breadCrumbWishList}" />
				<c:param name="lastBreadCrumbItemCompteClient" value="${param.lastBreadCrumbItemCompteClient}" />
			</c:import>
		<%out.flush();%>
		
	</c:when>
	<c:when test="${pageName eq 'suiviCom'}">
		<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrailHierarchyWithBackButton.jsp" >
				<c:param name="pageName" value="${pageName}" />
				<c:param name="breadCrumbMonCompte" value="${param.breadCrumbMonCompte}" />
				<c:param name="breadCrumbMiddleUrls" value="${param.breadCrumbMiddleUrls}" />
				<c:param name="breadCrumbMiddleLabels" value="${param.breadCrumbMiddleLabels}" />
				<c:param name="lastBreadCrumbItemCompteClient" value="${param.lastBreadCrumbItemCompteClient}" />
			</c:import>
		<%out.flush();%>	
	</c:when>
	<c:when test="${pageName eq 'ProductComparePage'}">
		<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrailHierarchyWithBackButton.jsp" />
		<%out.flush();%>
	</c:when>
	<c:otherwise>
		<%out.flush();%>
			<c:import url = "/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrailHierarchy.jsp" />
		<%out.flush();%>
	</c:otherwise>
</c:choose>

<%@ include file="/Widgets/Common/StorePreviewShowInfo_End.jspf" %>

<jsp:useBean id="BreadCrumb_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END BreadcrumbTrail.jsp -->

