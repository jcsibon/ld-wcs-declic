<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

 (C) Copyright IBM Corp. 2011, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>


<%-- 
  *****
  * SEOSitemap.jsp generates all the SEO URLs for static pages that a store admin want to be indexed by Google search engine.
  * This JSP is invoked by the SiteMapGenerateCmd, when 'SEO' feature is enabled for the particular store.
  * This file does not generate the catalog related SEO URLs.
  * parameters:
  * storeId: the storeId of the store to which the sitemap file is generated.
  *	catalogIds: list of catalog Ids that belong to this store.
  *****
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/xml" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="Common/EnvironmentSetup.jspf" %>

<%--
***
* Retrieve parameters for deciding how many URLs to create and the beginning index for the current iteration.
***
--%>
<c:set var="hostName" value="${param.hostName}" />

<c:set var="numberUrlsToGenerate" value="${param.numberUrlsToGenerate}" />
<c:if test="${empty numberUrlsToGenerate}">
	<c:set var="numberUrlsToGenerate" value="50000"/>
</c:if>

<c:set var="beginIndex" value="${param.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0"/>
</c:if>

<c:set var="maxUrlsToGenerate" value="${beginIndex+numberUrlsToGenerate}" />
<c:set var="urlCounter" value="0" />
<c:set var="constructedUrlCounter" value="0" />

<%--
***
* If the sitemapGenerate command is executed on a staging server, then the command need pass hostName to the jsp, where
* hostName is the serverName which will be hosting the sitemap xml file to be generated.
***
--%>

<c:set var="replaceHost" value="false"/>
<c:set var="contextHostName" value="${pageContext.request.serverName}"/>

<c:if test="${!empty param.hostName || !empty param.HostName}">
	<c:choose>
		<c:when test="${!empty param.hostName}">
			<c:set var="hostName" value="${param.hostName}"/>
		</c:when>
		<c:otherwise>
			<c:set var="hostName" value="${param.HostName}"/>
		</c:otherwise>
	</c:choose>
	<c:set var="replaceHost" value="true"/>
</c:if>

<%--
***
* Get storeId and create storeDB
***
--%>
<c:set var="storeId" value="${param.storeId}" /> 
<wcbase:useBean	id="storeDB" classname="com.ibm.commerce.common.beans.StoreDataBean">
	<c:set value="${storeId}" target="${storeDB}" property="storeId" />
</wcbase:useBean>

<%--
***
* The master catalog will be used if no catalogId is provided in the request
***
--%>
<c:choose>
	<c:when test="${empty param.catalogIds}">
	    	<c:set var="catalogIdsStr" value="${storeDB.masterCatalogDataBean.catalogId}" />
   	</c:when>
   	<c:otherwise>
		<c:set var="catalogIdsStr" value="${param.catalogIds}" />
    </c:otherwise>
</c:choose>

<%--
***
* Begin  generate URLs for views TopCategoriesDisplay for each catalogId.
***
--%>
<c:set var="delim" value="," />
<c:set var="catalogIdsArray" value="${fn:split(catalogIdsStr, delim)}" />

<c:forEach var="token" items="${catalogIdsArray}" varStatus="count">
	<c:set var="catalogId" value="${token}" />

	<%--
	***
	* For Each language supported by the store, generate URLs for view:
	* TopCategoriesDisplay
	***
	--%>
	<c:forEach var="dbLanguage" items="${storeDB.languageDataBeans}">
		<c:set var="langId" value="${dbLanguage.languageId}" />
		<c:set var="urlLangId" value="${langId}" />
	<c:if test="${urlCounter >= beginIndex && urlCounter < maxUrlsToGenerate}">

		<c:set var="HomePageURL" value="${contextHostName}" />
		
		<c:if test="${replaceHost eq 'true'}">
			<c:set var="HomePageURL" value="${fn:replace(TopCategoriesDisplayURL,contextHostName,hostName)}"/>
		</c:if>
	<url>
		<loc>http://${hostName}</loc>
		<priority>1.0</priority>
	</url>
		 <c:set var="constructedUrlCounter" value="${constructedUrlCounter + 1}" />
	</c:if>
<c:set var="urlCounter" value="${urlCounter + 1}" />
	<url>
		<loc>http://${hostName}/faq</loc>
		<priority>0.5</priority>
	</url>
<c:set var="urlCounter" value="${urlCounter + 1}" />
	 	<c:set var="constructedUrlCounter" value="${constructedUrlCounter + 1}" />
<c:set var="urlCounter" value="${urlCounter + 1}" />
	<url>
		<loc>http://${hostName}/contact</loc>
		<priority>0.5</priority>
	</url>
<c:set var="urlCounter" value="${urlCounter + 1}" />
	 	<c:set var="constructedUrlCounter" value="${constructedUrlCounter + 1}" />
 	</c:forEach>
 	<%--
  	***
 	* End of topCategoriesDisplay
  	***
 	--%>	
<%--
Deprecated
***
* For Each language supported by the store, generate URLs for views:
* HelpContactUsView, PrivacyView. 
* Only need generate URLs with one catalogId.
***
--%>
<%--
***
* End of for Each language supported by the store, generate URLs for views:
* HelpContactUsView, PrivacyView. 
***
--%>
<flow:ifEnabled feature="SearchBasedNavigation">
<c:forEach var="dbLanguage" items="${storeDB.languageDataBeans}">
    <c:set var="langId" value="${dbLanguage.languageId}" />
    <c:set var="urlLangId" value="${langId}" />

    <wcf:getData type="com.ibm.commerce.search.facade.datatypes.SearchTermAssociationType[]"
        var="landingPages"    
        varShowVerb="showVerb"
        expressionBuilder="findLandingPagesByLanguageAndStorePath"
        recordSetStartNumber="0"
        recordSetReferenceId="1"
        maxItems="100">
            <wcf:contextData name="storeId" data="${storeId}" />
            <wcf:param name="dataLanguageIds" value="${langId}"/>
    </wcf:getData>
    
    <c:if test="${landingPages != null || landingPages != 'null'}">
        <c:forEach items="${landingPages}" var="curLandingPage">
			<c:set var="searchTerms" value="${curLandingPage.searchTerms}"/>
			<c:set var="searchTermArray" value="${fn:split(searchTerms, delim)}" />
			
			<c:forEach var="searchTerm" items="${searchTermArray}" varStatus="count">
				<%-- convert search term to encoded --%>
				<c:set var="searchTerm" value="${fn:trim(searchTerm)}" scope="request"/>
				
				<%
				 	String searchTerm = String.valueOf(request.getAttribute("searchTerm"));
					if (searchTerm != null) {
						request.setAttribute("searchTerm", URLEncoder.encode(searchTerm,"UTF-8"));
					}
				%>
				<c:set var="searchTerm" value="${requestScope.searchTerm}"/>

            <c:if test="${urlCounter >= beginIndex && urlCounter < maxUrlsToGenerate}">
                <wcf:url var="landingPageURL" patternName="SearchURL" value="SearchDisplay">
                  <wcf:param name="langId" value="${langId}" />                                          
                  <wcf:param name="storeId" value="${WCParam.storeId}" />
                  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
                  <wcf:param name="searchTerm" value="${searchTerm}" />
                  <wcf:param name="urlLangId" value="${urlLangId}" />
                </wcf:url>
                
                <c:if test="${replaceHost eq 'true'}">
                    <c:set var="landingPageURL" value="${fn:replace(landingPageURL,contextHostName,hostName)}"/>
                </c:if>
				<url> 
				    <loc><c:out value="${landingPageURL}" /></loc>
				    <priority>1.0</priority> 
				</url>
				<c:set var="constructedUrlCounter" value="${constructedUrlCounter + 1}" />
           	</c:if>
			</c:forEach>
			<c:set var="urlCounter" value="${urlCounter + 1}" />
        </c:forEach>
    </c:if>
</c:forEach>

</flow:ifEnabled>


<%-- search landing pages --%>
</c:forEach>
<%	
	TypedProperty prop = (TypedProperty)request.getAttribute("RequestProperties");
	int constructedUrlCount = Integer.valueOf(String.valueOf(pageContext.getAttribute("constructedUrlCounter")));
	
	Integer[] obj = (Integer[])prop.get("totalUrlCount");
    obj[0] = constructedUrlCount;

%>
<%-- End - JSP File Name:  SEOSitemap.jsp --%>
