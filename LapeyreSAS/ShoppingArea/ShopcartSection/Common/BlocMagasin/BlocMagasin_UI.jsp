<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2013 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN BlocMagasin_UI.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="shopBlock ${(!empty selected && selected eq true)?'selected':''} ${(!empty selectable && selectable eq true)?'selectable':''}" >
	<div class="left ${(!empty selectable && selectable eq true)?'selectable':''}" id="${prefix}_magasin_${shop.strLocId}" data-shop-id="${shop.strLocId}" data-shop-name="${shop.name}">
		<h3><a class="hover_underline" href="${shop.seoUrl}"><ecocea:crop value="${shop.name}" length="35" /></a></h3>
		<p>${shop.type} <%-- <c:if test="${shop.retraitDrive eq 'true'}"><img src="${jspStoreImgDir}/images/logoDrive.png"></c:if> --%></p>
		<span class="shopBlocSeparator"></span>
		<p>${shop.address1}</p>
		<c:if test="${!empty shop.address2}">
			<p>${shop.address2}</p>
		</c:if>
		<c:if test="${!empty shop.address3 || !empty shop.address4}">
			<p>${!empty shop.address3?shop.address3:''}${!empty shop.address4?shop.address4:''}</p>
		</c:if>
		<p>${shop.cp} ${shop.city}</p>
		<p>${ecocea:fmtPhone(shop.mainPhone)}</p>
		<div class="transports">
			<c:choose>
				<c:when test="${!empty shop.access}">
					<p>${shop.access}</p>
				</c:when>
				<c:otherwise>
					<c:if test="${!empty shop.secondaryPhone}">
						<c:forEach items="${shop.secondaryPhone}" var="secPhoneKey">
								<p>${secPhoneKey.key} : ${ecocea:fmtPhone(secPhoneKey.value)}</p>
						</c:forEach>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<c:if test="${empty hideStoreHoursInfo || hideStoreHoursInfo eq false}">
		<a class="bottom" href="javascript:void(0);" onclick="javascript:openStoreHours('${shop.seoUrl}&view=AjaxStoreInfoView&errorViewName=AjaxStoreInfoView');return false;"></a>
	</c:if>
</div>
<!-- END BlocMagasin_UI.jsp -->
