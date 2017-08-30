<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  *	This JSP page shows the footer of the e-mail send to the customer with the store home page link.
  *
  * This file is the WCS 7 version and it is currently used.
  *****
--%>
<!-- BEGIN Footer.jsp -->
<wcf:url var="PrivacyViewURL" patternName="PrivacyURL" value="PrivacyPolicy">
	<wcf:param name="urlLangId" value="${urlLangId}" />
	<wcf:param name="storeId"   value="${storeId}"  />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>
<wcf:url var="emailStoreURL" patternName="HomePageURLWithLang" value="TopCategories">
    <wcf:param name="langId" value="${langId}" />
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="urlLangId" value="${langId}" />
</wcf:url>

<span style="font-family: Arial, Helvetica, sans-serif;font-size: 10px;color: #808080;">
	<%out.flush();%>
	<c:import url="/Widgets/com.ibm.commerce.store.widgets.ContentRecommendation/ContentRecommendation.jsp">
		<c:param name="emsName" value="EmailFooter_Content" /> 
		<c:param name="numberContentPerRow" value="2" />
		<c:param name="catalogId" value="${catalogId}" />
		<c:param name="marketingSpotBehavior" value="0" /> 
		<c:param name="isEmail" value="true" />
		<c:param name="substitutionName1" value="[STORE_NAME]" />
		<c:param name="substitutionValue1" value="${storeName}" />
		<c:param name="substitutionName2" value="[LINK1]" />
		<c:param name="substitutionValue2" value="${ecocea:replaceHost(PrivacyViewURL,host_Path)}" />
		<c:param name="substitutionName3" value="[LINK2]" />
		<c:param name="substitutionValue3" value="${ecocea:replaceHost(emailStoreURL,host_Path)}" />
	</c:import> 
	<%out.flush();%>
</span>

<!-- END Footer.jsp -->