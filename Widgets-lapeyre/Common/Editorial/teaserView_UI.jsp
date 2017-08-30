<!-- Begin teaserView_UI.jsp -->
<%@ page trimDirectiveWhitespaces="true" %>
<%@include file="/Widgets/Common/EnvironmentSetup.jspf" %>
<c:set var="typ" value="${editoElement.template == 0?'article':editoElement.template == 2?'dossier':editoElement.template == 3?'mag':'free'}"/>

<c:import url="/Widgets-lapeyre/Common/Editorial/${typ}_teaserView_${param.format}_UI.jsp" />
<!-- End teaserView_UI.jsp -->
