<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="com.ibm.commerce.member.facade.client.MemberFacadeClient" %>
<%@ page import="com.ibm.commerce.member.facade.datatypes.PersonType" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="flow.tld" prefix="flow"%>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm"%>
<%@ include file="../../../Common/EnvironmentSetup.jspf"%>
<%@ include file="../../../Common/nocache.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>



<%@ include file="../../../include/ErrorMessageSetupBrazilExt.jspf"%>


<wcf:getData var="person" type="com.ibm.commerce.member.facade.datatypes.PersonType" expressionBuilder="findCurrentPerson">
	<wcf:param name="accessProfile" value="IBM_All" />
</wcf:getData>

<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message bundle="${storeText}" key="pageTitleOrder" /></title>
<META NAME="robots" CONTENT="noindex,nofollow" />
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}?${versionNumber}"/>" type="text/css" />
<link rel="stylesheet" href="${jsAssetsDir}css/base.css?${versionNumber}" type="text/css" />
<%-- <link rel="stylesheet" href="${jspStoreImgDir}UserAreaDeclic/css/style.css" type="text/css" /> --%>


<%@ include file="../../../Common/CommonJSToInclude.jspf"%>

<%-- CommonContexts must come before CommonControllers --%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AddressHelper.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/MyAccountDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/AccountWishListDisplay.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/UserArea/QuickCheckoutProfile.js?${versionNumber}"/>"></script>
	
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonContextsDeclarations.js?${versionNumber}"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CommonControllersDeclaration.js?${versionNumber}"/>"></script>
<script type="text/javascript"	src="${jspStoreImgDir}UserAreaDeclic/javascript/userJS.js?${versionNumber}"></script>


<wcf:url var="ToggleNewsletterForm" value="NewsletterToggleCmd">
	<wcf:param name="langId" value="${WCParam.langId}" />
	<wcf:param name="storeId" value="${WCParam.storeId}" />
	<wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>


</head>
<body>
<c:set var="orderId" value="${WCParam.orderId}"/>
<c:set var="suiviCom" value="${true}"/>

<%@ include file="OrderDetails_data.jspf"%>
<!-- Page Start -->
<div id="page">
	<%out.flush();%>
	<c:import url="${env_jspStoreDir}/Widgets/Header/Header.jsp" />
	<%out.flush();%>

		<div id="contentWrapper">
			<div id="content" role="main">
				<div class="rowContainer">
					<div class="row">
						<div data-slot-id="1" class="col12 slot1 mobile-hidden">
							<%out.flush();%>
							<fmt:message var="lastBreadCrumbItem"
								key="myNewslettersBreadcrumbLabel" bundle="${widgetText}" />
							<c:import
								url="/Widgets-lapeyre/com.lapeyre.declic.commerce.store.widgets.BreadcrumbTrail/BreadcrumbTrail.jsp">
								<c:param name="pageName" value="CompteClient" />
								<c:param name="breadCrumbMonCompte" value="true" />
								<c:param name="lastBreadCrumbItemCompteClient" value="${lastBreadCrumbItem}" />
							</c:import>
							<%out.flush();%>
						</div>
					</div>
					<c:set var="navMonCompteCurrentPage" value="myOrders"/>
					<%--@ include file="../../AccountSection/headerClient.jspf"--%>
					
					<div class="headerContent">
						<div class="backOrderList">
							<%-- TODO link --%>
							<a href="javascript:history.back()" class="button back"><fmt:message bundle="${storeText}" key="orderdetailReturnButtonLabel"/></a>
						</div>
						<div class="ContentTitle center">
							<h2 class="titleBlock">
								<fmt:message bundle="${storeText }" key="orderPageTitle"/>
								<span><c:out value="123456789"/></span>
							</h2>
							<br>
							<fmt:parseDate value="07/02/2015" pattern="dd/MM/yyyy" var="dateDispo"/>
							<div class="statusCommande">Disponible le <fmt:formatDate value="${dateDispo}" pattern="d MMM yyyy"/> </div>
						</div>
						<div class="nextPrevOrder">
							<%-- TODO links --%>
							<a class="prev"><img src="${jspStoreImgDir}images/responsive/mobileSearchArrowActive.png"/></a>
							<p class="button"><fmt:message bundle="${storeText}" key="orderdetailReturnButtonLabel"/></p>
							<a class="next"><img src="${jspStoreImgDir}images/responsive/mobileSearchArrowActive.png"/></a>
						</div>
					</div>
					
					<!--  Indicateur de status -->
					<div class="row">
						<div class="col12 slot1" id="orderHeader" data-slot-id="1">
							<ul class="etapes">
								<%-- TODO Status --%>
								<c:set var="statusCode" value="2"/>
								<li>
									<div class="<c:if test='${statusCode==2 or statusCode==20 }'>current</c:if>">
										<span>1</span>
										<fmt:message bundle="${storeText}" key="validatingBreadcrumbLabel"/>
									</div>
								</li>
								<li>
									<div class="<c:if test='${statusCode==30 or statusCode==31 }'>current</c:if>">
										<span>2</span>
										<fmt:message bundle="${storeText}" key="preparationBreadcrumbLabel"/>
									</div>
								</li>
								<li>
									<div class="<c:if test='${statusCode==40}'>current</c:if>">
										<span>3</span>
										<fmt:message bundle="${storeText}" key="availableBreadcrumbLabel"/>
									</div>
								</li>
								<li>
									<div class="<c:if test='${statusCode==52 or statusCode==51 }'>current</c:if>">
										<span>4</span>
										<fmt:message bundle="${storeText}" key="endedBreadcrumbLabel"/>
									</div>
								</li>
								<li>
									<div class="<c:if test='${statusCode==80 or statusCode==90 }'>current</c:if>">
										<span>5</span>
										<c:choose>
											<c:when test="${statusCode==90}">
												<fmt:message bundle="${storeText}" key="shippedBreadcrumbLabel"/>
											</c:when>
											<c:otherwise>
												<fmt:message bundle="${storeText}" key="cancellationBreadcrumbLabel"/>
											</c:otherwise>
										</c:choose>
									</div>
								</li>
								</ul>
							</div>
						</div>
					<!--  Indicateur de status FIN -->
					
					<div class="lineInfo">
						<div id="numOrderWeb" class="left">
							<fmt:message bundle="${storeText}" key="webOrderNumberLabel"/>
							<br>
							<span><c:out value="${orderId}"/></span>
						</div>
						<div id="dispoMag" class="right">
							<fmt:message bundle="${storeText}" key="ShippingModeLabel"/>
							<br>
							<span>
								<c:choose>
									<c:when test="">
										<fmt:message bundle="${storeText}" key="ShippingAtStoreLabel"/>
									</c:when>
									<c:otherwise>
										<fmt:message bundle="${storeText}" key="ShippingAtHomeLabel"/>
									</c:otherwise>
								</c:choose>
							</span>	
						</div>
					</div>
					<div class="row tunnel suiviCom">
						<div class="listeProduitsHeader">
							<div> <b> <c:choose>
										<c:when test="${orderQuantity <= 1}">
											<p> ${orderQuantity} <fmt:message bundle="${storeText}" key="productLabel" /> </p>
										</c:when>
										<c:otherwise>
											<p> ${orderQuantity} <fmt:message bundle="${storeText}" key="productsLabel" /> </p>
										</c:otherwise>
									</c:choose> </b> </div>
							<div></div>
							<div>
								<c:choose>
									<c:when test="${extendedUserContext.isPro}">
										 <fmt:message bundle="${storeText}" key="htPriceColumnLabel" />
									</c:when>
									<c:otherwise>
										 <fmt:message bundle="${storeText}" key="ttcPriceColumnLabel" />
									</c:otherwise>
								</c:choose>
							</div>
							<div><fmt:message bundle="${storeText}" key="QuantityColumnLabel" /></div>
							<div>${tvaRateColumnLabel} <fmt:message bundle="${storeText}" key="vatColumnLabel" /></div>
							<div>&nbsp;</div>
							<div>
								<c:choose>
									<c:when test="${extendedUserContext.isPro}">
										 <fmt:message bundle="${storeText}" key="htTotalPriceColumnLabel" />
									</c:when>
									<c:otherwise>
										 <fmt:message bundle="${storeText}" key="ttcTotalPriceColumnLabel" />
									</c:otherwise>
								</c:choose>
							</div>
							<div>&nbsp;</div>
						</div>
						<div class="listeProduits">
						<%@ include file="../../../ShoppingArea/ShopcartSection/OrderItemDetail.jspf"%>
						<%-- TODO  get méthode de paiement --%>
						</div>
						<!--  Sous-total -->
						<div class="ecoPart">
							<div id="modePaiement">
								<h2 class="titleBlock">
									<fmt:message bundle="${storeText}" key="PAYMENT_METHOD"/>
									<br>
									<img src="${jspStoreImgDir}images/picto/card_paypal.png">
								</h2>
							</div>
							<div id="sousTotalLabel">
								<p><fmt:message bundle="${storeText}" key="htTotalAmountLabel"/></p>
								<br>
								<p ><fmt:message bundle="${storeText}" key="tvaTotalAmountLabel"/></p>
								<br>
								<c:if test="${!extendedUserContext.isPro}">
									<p><fmt:message bundle="${storeText}" key="ttcTotalAmountLabel"/></p>
									<br>
								</c:if>
								<p ><fmt:message bundle="${storeText}" key="alreadyPaidTotalAmountLabel"/></p>
								<br>
								<p ><fmt:message bundle="${storeText}" key="restantDuLabel"/></p>
								<br>
							</div>
							<div id="sousTotalValue">
								<p>todo recup HT</p>
								<br>
								<p>todo recup TVA</p>
								<br>
								<c:if test="${!extendedUserContext.isPro}">
									<p>todo recup TTC</p>
									<br>
								</c:if>
								<p>todo recup Deja payé</p>
								<br>
								<p>todo recup restant</p>
								<br>
							</div>
						</div>
						<!--  fin sous-total -->
						<div class="montantTotal">
							<div style="height: auto;">
								<p><fmt:message bundle="${storeText}" key="totalAmountLabel"/></p>
							</div>
							<div style="height: auto;">
								<p >${orderSubTotal}<sup>${env_CurrencySymbolToFormat}</sup></p>
							</div>
						</div>
					</div>
					<br clear="all">
					<div class="row">
						<div class="shopContainer center" id="DocDetail">
							<c:choose>
								<c:when test="${empty ErrorShop}">
									<h2 class="titleBlock">
										<fmt:message bundle="${storeText}" key="orderStoreSectionTitle"/>
									</h2>
									<%@ include file="ShopDisplayLinked.jspf"%>
								</c:when>
								<c:otherwise>
									<span class="titleBlock error">
										<fmt:message bundle="${storeText}" key="errorShopOrder"/>
									</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="row center" id="linkCancel">
						<a>
							<span class="error ">
								<fmt:message bundle="${storeText}" key="cancelOrderLinkLabel"/>
							</span>
						</a>
					</div>
				</div>
			</div>
		</div>

		<% out.flush(); %>
			<c:import url="${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<% out.flush(); %>
</div>
</body>
</html>