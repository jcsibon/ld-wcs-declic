<%@page import="com.bazaarvoice.seo.sdk.model.ContentType"%>
<%@page import="com.bazaarvoice.seo.sdk.model.SubjectType"%>
<%@page import="com.bazaarvoice.seo.sdk.model.BVParameters"%>
<%@page import="com.bazaarvoice.seo.sdk.BVManagedUIContent"%>
<%@page import="com.bazaarvoice.seo.sdk.BVUIContent"%>
<%@page import="com.bazaarvoice.seo.sdk.config.BVClientConfig"%>
<%@page import="com.bazaarvoice.seo.sdk.config.BVSdkConfiguration"%>
<%@page import="com.bazaarvoice.seo.sdk.config.BVConfiguration"%>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>

<!-- BEGIN ItemPageContainer.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="../Common/EnvironmentSetup.jspf" %>

<%
String itemId = request.getParameter("productId");
request.setAttribute("itemId", itemId);
%>
<%-- A REST call is needed here to retrieve the partnumber --%>
<wcf:rest var="catalogNavigationView" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/productview/byId/${itemId}" >	
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="currency" value="${env_currencyCode}"/>
	<wcf:param name="responseFormat" value="json"/>		
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="searchProfile" value="ECO_findProductByIds_Light"/>
</wcf:rest>
<c:set var="catentry" value="${catalogNavigationView.catalogEntryView[0]}" />
<c:set var="partNumber" value="${catentry.partNumber}" scope="request" />
<c:set var="productType" value="${catentry.type}" scope="request" />

<%-- This is the canonical URL --%>
<wcf:url var="ProductDisplayURL" patternName="ProductURL" value="Product1" scope="request">
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="storeId" value="${storeId}" />
	<wcf:param name="catalogId" value="${catalogId}" />
	<wcf:param name="productId" value="${itemId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>
<%
	//BVConfiguration used to configure SEO SDK
	BVConfiguration _bvConfig = new BVSdkConfiguration();
	_bvConfig.addProperty(BVClientConfig.SEO_SDK_ENABLED, "true");

	Properties connectionProperties = ConfigTool.getConnectionPropertiesResource();
	String param = connectionProperties.getProperty("bv.timeout","1500");	
	_bvConfig.addProperty(BVClientConfig.EXECUTION_TIMEOUT, param);
	param = connectionProperties.getProperty("bv.timeout.bot","2000");
	_bvConfig.addProperty(BVClientConfig.EXECUTION_TIMEOUT_BOT, param);
		
	//the following 3 lines must be updated to use actual values
	//CLOUD_KEY & BV_ROOT_FOLDER is customer centric and should be obtained from Bazaarvoice
	param = connectionProperties.getProperty("bv.cloud_key");
	_bvConfig.addProperty(BVClientConfig.CLOUD_KEY, param);
	param = connectionProperties.getProperty("bv.staging","true");
	_bvConfig.addProperty(BVClientConfig.STAGING, param);
	param = connectionProperties.getProperty("bv.rootFolder");
	_bvConfig.addProperty(BVClientConfig.BV_ROOT_FOLDER, param);

	// proxy configuration to access bazaarvoice api
	String proxyHost = connectionProperties.getProperty("proxy.host");
	if (org.apache.commons.lang3.StringUtils.isNotBlank(proxyHost)) {
		_bvConfig.addProperty(BVClientConfig.PROXY_HOST, proxyHost);
	}
	String proxyPort = connectionProperties.getProperty("proxy.port");
	if (org.apache.commons.lang3.StringUtils.isNotBlank(proxyPort)) {
		_bvConfig.addProperty(BVClientConfig.PROXY_PORT, proxyPort);
	}
		
	//Create BVParameters for each injection.  If the page contains multiple injections, for example, 
	//reviews and questions, set unique parameters for each injection. 
	BVParameters _bvParam = new BVParameters();
	_bvParam.setUserAgent(request.getHeader( "User-Agent" ));
	 //This should be URI/URL of the current page with all URL parameters.
	_bvParam.setPageURI(request.getRequestURI() + "?" + request.getQueryString());
	_bvParam.setContentType(ContentType.REVIEWS);
	_bvParam.setSubjectType(SubjectType.PRODUCT);

	//the following 2 lines must be configured for each page.
	//Insert the URI/URL of the page. This is typically the canonical URL.  
	//The SDK will append pagination parameters to this URI/URL to create search-friendly pagination links.
	_bvParam.setBaseURI((String)request.getAttribute("ProductDisplayURL"));
	//Since our subject is Product, set the productId below.	
	_bvParam.setSubjectId((String)request.getAttribute("partNumber"));

	//Below two lines instantiates the BVUIContent and makes a call to the contents
	BVUIContent _bvOutput = new BVManagedUIContent(_bvConfig);
	String reviewContent = _bvOutput.getContent(_bvParam);
	String sBvOutputSummary = _bvOutput.getAggregateRating(_bvParam);  //getAggregateRating delivers the AggregateRating section only
	String sBvOutputReviews = _bvOutput.getReviews(_bvParam);  //getReviews delivers the review content with pagination only
	
	request.setAttribute("reviewContent", reviewContent);
	request.setAttribute("sBvOutputSummary", sBvOutputSummary);
	request.setAttribute("sBvOutputReviews", sBvOutputReviews);
%>

<%@taglib uri="http://commerce.ibm.com/pagelayout" prefix="wcpgl"%>

<div id="container_${pageDesign.layoutID}" class="item-page-container">
	<!-- If we are in a product collection page, the breadcrumb has a different color and takes 100% width -->
	<!-- Moreover, in a product page, the container need to be inside the breadcrumb widget in order to control the width -->
	<c:if test="${not empty productType and productType eq 'COLLECTION'}">
		<div class="full-background"> 
	</c:if> 
		<div class="container">
			<div data-slot-id="1"><wcpgl:widgetImport slotId="1"/></div>
		</div>
	<c:if test="${not empty productType and productType eq 'COLLECTION'}">
		</div>
	</c:if>
	<!-- FIX MAntis-0000181: Hot Fix style for CATALOGUE_PAPIER pages Need rework after refonte all pages-->
	<c:if test="${not empty productType and productType eq 'CATALOGUE_PAPIER'}">
		<div class="container">
	</c:if>
		<div id="ficheProduitHead" data-slot-id="2" itemscope itemtype="${MICRO_DATA_PRODUCT}" class="col s12 l10 push-l1"><wcpgl:widgetImport slotId="2"/></div>
		<div id="ficheProduitBody" data-slot-id="3"><wcpgl:widgetImport slotId="3" /></div>
	<c:if test="${not empty productType and productType eq 'CATALOGUE_PAPIER'}">
		</div>
	</c:if>
	<div class="container">	
		<div class="col s12" data-slot-id="4"><wcpgl:widgetImport slotId="4" /></div>
	</div>
</div>


<!-- END ItemPageContainer.jsp -->