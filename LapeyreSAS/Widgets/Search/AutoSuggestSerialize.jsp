<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- BEGIN AutoSuggestSerialize.jsp -->

<%@include file="../../Common/JSTLEnvironmentSetup.jspf" %>
<%@include file="../../Common/EnvironmentSetup.jspf" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="org.apache.solr.client.solrj.SolrServer"%>
<%@page import="org.apache.solr.client.solrj.request.QueryRequest"%>
<%@page import="org.apache.solr.client.solrj.response.TermsResponse.Term"%>
<%@page import="org.apache.solr.common.params.TermsParams"%>
<%@page import="org.apache.solr.client.solrj.SolrRequest"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.search.config.solr.SolrSearchConfigurationRegistry"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.search.metadata.solr.SolrSearchServiceConstants"%>


<fmt:message bundle="${storeText}" var="suggestedKeyWords" key="SUGGESTED_KEYWORDS" />

<%
		String PARAM_TERM = "term";
		String PARAM_SHOWHEADER = "showHeader";
		String term = request.getParameter(PARAM_TERM).trim();
		//pageContext.setAttribute("showHeader", request.getParameter(PARAM_SHOWHEADER));
		pageContext.setAttribute("showHeader", false);
		pageContext.setAttribute("term", term);
		String lowerCaseTerm = term.toLowerCase();
		pageContext.setAttribute("lowerCaseSearchTerm", lowerCaseTerm);

%>
<c:if test="${fn:length(term) > 1}">
	<c:set var="myKeywords" value="${ecocea:findKeyWordSuggestion(term,WCParam.catalogId,WCParam.langId,WCParam.storeId)}" />
</c:if>
<c:if test="${fn:length(myKeywords.suggestionView) > 0}">
<%-- Start showing the results --%>
<div id='suggestedKeywordResults'>

	<c:if test="${showHeader}">
		<div id='suggestedKeywordsHeader'>
			<ul class="autoSuggestDivNestedList">
				<li class="heading">
					<span id="suggest_keywords_ACCE_Label"><c:out value="${suggestedKeyWords} (${fn:length(myKeywords.suggestionView[0].entry) })"/></span>
				</li>
			</ul>
		</div>
	</c:if>
	<div class='list_section'>
		<div title="${suggestedKeyWords}" role='list' aria-labelledby="suggest_keywords_ACCE_Label"></div>
		<c:if test="${empty myKeywords.suggestionView[0].entry }">
			<div class="empty-result">
				<fmt:message bundle="${storeText}" key="SEARCH_NO_RESULT" />
			</div>
		</c:if>
		<c:forEach items="${myKeywords.suggestionView[0].entry}" var="resultTerm" varStatus="status">
			<c:set var="result" value="${resultTerm.term}"/>
			<c:set var="resultInLowerCase" value="${fn:toLowerCase(result)}"/>
			<ul class="autoSuggestDivNestedList">
				<li id='suggestionItem_${status.index}' role='listitem' tabindex='-1'>
					<a role='listitem' href='#' onmouseout="this.className=''"
					onmouseover='SearchJS.enableAutoSelect("${status.index}");' onmousedown="SearchJS.cancelEvent(event);" onmouseup='SearchJS.selectAutoSuggest(this.title); return false;' title='<c:out value="${result}"/>'
					id='autoSelectOption_${status.index}'>
						<%-- Highlight the search term in the result --%>
						<span class='highlight'><c:out value="${fn:substring(result,0,(fn:length(term)))}"/></span><c:out value="${fn:substring(result,(fn:length(term)),(fn:length(result)))}"/>
					</a>
				</li>
			</ul>
		</c:forEach>
	</div>
	<input type='hidden' id='autoSuggestOriginalTerm' value='${term}'/>
	<input type='hidden' id='dynamicAutoSuggestTotalResults' value="${fn:length(myKeywords.suggestionView[0].entry)}"/>
</div>
</c:if>
<!-- END AutoSuggestSerialize.jsp -->
