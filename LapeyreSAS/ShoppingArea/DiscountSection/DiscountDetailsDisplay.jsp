	
<%--
  *****
  * DiscountDetailsDisplay.jsp displays the details of a discount code
  * - for item level discounts, display short and long description of the discount and the associated items and a clickable short
  *   description that links to the Item Display page
  * - for product level discounts, display short and long description of the discount and the associated products and a clickable
  *   name that links to the Product Display page
  * - for category level discounts, display the short and long description of the discount
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../Common/nocache.jspf"%>

<wcbase:useBean id="calculationCodeListDB" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean">
	<c:set property="calculationUsageId" value="-1" target="${calculationCodeListDB}"/>
	<c:set property="code" value="${WCParam.code}" target="${calculationCodeListDB}"/>
	<c:set property="excludePromotionCode" value="false" target="${calculationCodeListDB}"/>
	<c:set property="storeId" value="${WCParam.pStoreId}" target="${calculationCodeListDB}"/>
</wcbase:useBean>


<%-- CalculationCodeListDataBean is used to show the discount information of the product --%>
<c:set var="calculationCodeDBs" value="${calculationCodeListDB.calculationCodeDataBeans}" scope="request"/>


<%-- Target2Sell BEGIN --%>
	<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_CONTENT %>" scope="request" />
<%-- Target2Sell END --%>

	<%--
	***
	* Start check for valid discount.
	* - if true, then display the discount description and long description and the products associated with the discount.
	* - if false, then display error message stating that there is no valid discount.
	***
--%>

<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2014 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN DiscountDetailsDisplay.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>
		<fmt:message bundle="${storeText}" key="DISCOUNT_DETAILS_TITLE">
			<fmt:param value="${storeName}"/>
		</fmt:message>
	</title>
	<META NAME="robots" CONTENT="noindex,nofollow" />
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css"/>
	<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
		<link rel="stylesheet" href="${jsAssetsDir}css/styles.css?${versionNumber}" type="text/css" />
	<%@ include file="../../Common/CommonJSToInclude.jspf"%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
	<%@ include file="../../Common/CommonJSPFToInclude.jspf"%>
</head>

<body>

<!-- Page Start -->
<div id="page">

	<!-- Import Header Widget -->
	
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>
	
	<!-- Header Nav End -->

	<!-- Main Content Start -->
	<div id="contentWrapper">
		<div id="content" role="main">
			<div class="rowContainer">			
                  <div class="row">
                  	<div class="col13">
							<a href="#" class="button back" id="discountDetailsPageBack" tabindex="0" onclick="javascript:history.back(1);return false;"><fmt:message bundle="${storeText}" key="BACK" /></a>
						</div>
						<h1 class="titleBlock col9 bcol12 left mobile-small"><fmt:message bundle="${storeText}" key="DISCOUNT_DETAILS_TITLE"/><c:if test="${!empty calculationCodeDBs}"><br /><span>${calculationCodeDBs[0].descriptionString}</span></c:if></h1>
                  	</div>

                  <div class="row padding-bottom">
                  	<c:choose>
							<c:when test="${ !empty calculationCodeDBs }"  >
								<div id="WC_DiscountDetailsDisplay_div_2" class="col12 info_section">
									<%-- Show the long description of the discount - freeHTML --%>
										${calculationCodeDBs[0].longDescriptionString}
								</div>
							</c:when>
							<c:otherwise>
								<div class="error">
									<fmt:message bundle="${storeText}" key="DISCOUNTDETAILS_ERROR"/>
								</div>
							</c:otherwise>
					</c:choose>
                  </div>

                  <div class="row">
                  	<div class="col12">
                  		<%out.flush();%>
								<c:catch var="exc">
									<ecocea:widgetPath var="emspotpath" identifier="EMarketingSpot" />
									<c:import url="${emspotpath}">
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
										<c:param name="emsName" value="DiscountDisplayPage_bestSeller" />
										<c:param name="pageSize" value="4"/>
										<c:param name="t2sWidgetSuffix" value="DiscountDisplayPage_bestSeller"/>
										<c:param name="displayPreference" value="1"/>
									</c:import>
									<c:import url="${emspotpath}">
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
										<c:param name="emsName" value="DiscountDisplayPage_RecoProduits" />
										<c:param name="pageSize" value="4"/>
										<%-- Target2Sell BEGIN --%>
										<c:param name="t2sWidgetSuffix" value="DiscountDisplayPage_RecoProduits"/>
										<c:param name="displayPreference" value="1"/>
										<%-- Target2Sell END --%>
									</c:import>
									<c:import url="${emspotpath}">
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
										<c:param name="emsName" value="DiscountDisplayPage_SelectionDuMois" />
										<c:param name="pageSize" value="4"/>
										<c:param name="t2sWidgetSuffix" value="DiscountDisplayPage_SelectionDuMois"/>
										<c:param name="displayPreference" value="1"/>
									</c:import>
									<c:import url="${emspotpath}">
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
										<c:param name="emsName" value="DiscountDisplayPage_ProduitsEtContenus" />
										<c:param name="pageSize" value="4"/>
										<c:param name="t2sWidgetSuffix" value="DiscountDisplayPage_ProduitsEtContenus"/>
										<c:param name="displayPreference" value="1"/>
									</c:import>
								</c:catch>
							<%out.flush();%>
						</div>	
                  </div>
				<div class="row">
                  	<div class="col12 discount ml">																
						<p><fmt:message bundle="${storeText}" key="DETAILED_DISCOUNT_DISCLAIMER"/></p>
                  	</div>
                </div>
			</div>
		</div>
	</div>		

	
	<!-- Footer Start -->
	<div class="footer_wrapper_position">
		<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div>
	<!-- Footer End --> 
	
</div>	
<!-- Page End -->

<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
<%@ include file="../../Common/JSPFExtToInclude.jspf"%> </body>
</html>
<!-- END DiscountDetailsDisplay.jsp -->
