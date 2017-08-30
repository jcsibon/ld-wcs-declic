<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<wcf:rest var="nodeCategory" url="${searchHostNamePath}${searchContextPath}/store/${WCParam.storeId}/categoryview/byId/${nodeCategoryID}" >	
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="currency" value="${env_currencyCode}"/>
	<wcf:param name="responseFormat" value="json"/>		
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
</wcf:rest>

<c:forEach var="nodeCat" items="${nodeCategory.catalogGroupView}">
 	<c:choose>
		<c:when test="${nodeCat.parentCatalogGroupID != '-1'}">
			<c:set var="catlevel" value="${catlevel+1}" scope="request"/>
			<c:set var="nodeCategoryID" value="${nodeCat.parentCatalogGroupID}" scope="request"/>
			<jsp:include page="FamilyCategoryNavigationNode.jsp" />
		</c:when>
		<c:otherwise>
			<c:set var="universeCategoryID" value="${nodeCat.uniqueID}" scope="request"/>
			<c:set var="universeCategoryName" value="${nodeCat.name}" scope="request" />
		</c:otherwise>
	</c:choose>
</c:forEach>