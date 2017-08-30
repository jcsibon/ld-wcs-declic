<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="wishListPage" value="true"/>   
<c:set var="sharedWishList" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="false" scope="request"/>
<c:set var="useHomeRightSidebar" value="true" scope="request"/>
<% out.flush(); %>		
<c:set var="wishListEMail" value="false"/>
<c:if test="${WCParam.wishListEMail == 'true'}">
	<c:set var="wishListEMail" value="true"/>
</c:if>
<c:set var="sharedWishList" value="true" scope="request"/>
<c:import url="WishListResultDisplay.jsp">
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${catalogId}" />
	<c:param name="langId" value="${langId}" />
	<c:param name="externalId" value="${WCParam.externalId}" />
	<c:param name="wishListEMail" value="${wishListEMail}"/>
</c:import>		
<% out.flush(); %>


</div>
</div>