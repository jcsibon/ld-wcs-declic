<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/Widgets/Common/EnvironmentSetup.jspf" %>

<c:if test="${empty categoryIds}">
	<c:set var="categoryIds" value="{top_category: '', parent_category_rn: '', categoryId: ''}" scope="request"/>
</c:if>

<c:choose>
	<c:when test="${param.fromHeader == 'false'}">
		<a role="button" class="button" name="comparatorButton" href="javascript:shoppingActionsJS.compareProducts(${categoryIds});" aria-label="${param.comparatorLabel}">${param.comparatorLabel}<label></label></a>
	</c:when>
	<c:when test="${param.asCheckbox == 'true'}">
		<a title ="Voir le comparateur" class="" href="javascript:shoppingActionsJS.compareProducts(${categoryIds});" aria-label="${param.param.comparatorLabel}">${param.comparatorLabelWithLink}</a>
	</c:when>
	<c:otherwise>
		<c:if test="${!isOnMobileDevice}">
			<a class="hover_underline" name="comparatorLinkHeader" href="javascript:shoppingActionsJS.compareProducts(${categoryIds});" onclick="return false" aria-label="${param.comparatorLabel}">${param.comparatorLabel}<label></label></a>
		</c:if>
	</c:otherwise>
</c:choose>
