<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<wcf:url var="itemUrl" patternName="ProductURL" value="Product1">
    <wcf:param name="langId" value="${WCParam.langId}" />
    <wcf:param name="storeId" value="${WCParam.storeId}"/>
    <wcf:param name="catalogId" value="${WCParam.catalogId}"/>
    <wcf:param name="productId" value="${id}"/>
    <wcf:param name="urlLangId" value="${WCParam.langId}" />
</wcf:url>
{"url":"${itemUrl}"}