<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="../Common/JSTLEnvironmentSetup.jspf" %>

<%-- call CMS and make response available --%>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>

<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.context.content.ContentContext" %>
<%@ page import="com.ibm.commerce.context.preview.PreviewContext" %>
<%@ page import="com.ibm.commerce.tools.segmentation.SegmentDataBean" %>

<%
//cf. EnvironmentSetup.jspf: détermination de la date de preview
 String pmstart = "";
CommandContext pmt_commandContext = (CommandContext) request.getAttribute("CommandContext");
PreviewContext pmt_previewContext = (PreviewContext) pmt_commandContext.getContext(PreviewContext.CONTEXT_NAME);
if(pmt_previewContext!=null){
	Pattern pmt_p = Pattern.compile(".*\\[preview time = (.*) \\| isStatic = (.*) \\| other data = (.*) \\| dirty = (.*)\\]");
	Matcher pmt_m = pmt_p.matcher(pmt_previewContext.toString());
	if (pmt_m.matches()) {
		pmstart = pmt_m.group(1);
		if(pmstart!=null && !pmstart.equals("null") && !pmstart.isEmpty()){
			SimpleDateFormat pmt_sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			SimpleDateFormat target_sdf = new SimpleDateFormat("yyyyMMddHHmm"); //format du CMS
			pmstart= target_sdf.format(pmt_sdf.parse(pmstart));
		}else{
			pmstart="";
		}
	}
}
request.setAttribute("pmstart",pmstart);
%>
<c:set var="isMobile" scope="request" value="${EC_deviceAdapter.deviceFormatId == -21}" />

<jsp:useBean id="contentHelper" class="com.lapeyre.declic.cms.ContentHelper" scope="request">
	<%-- page --%>
	<jsp:setProperty name="contentHelper" property="typePage" value="/${param.typePage}" />
	<jsp:setProperty name="contentHelper" property="id" value="${param.id}" />
	<jsp:setProperty name="contentHelper" property="complement" value="${param.complement}" /><%-- sert pour les tags et autres complements --%>

	<%-- contexte --%>
	<jsp:setProperty name="contentHelper" property="isPreview" value="${env_inPreview?1:0}"/>
	<jsp:setProperty name="contentHelper" property="date" value="${pmstart}"/>	
	<jsp:setProperty name="contentHelper" property="device" value="${isMobile?'M':'D'}"/>
	<jsp:setProperty name="contentHelper" property="target" value="${(userType eq 'G') ? 'ano' : extendedUserContext.isPro?'pro':'part'}"/>
	
</jsp:useBean>

<% ((com.lapeyre.declic.cms.ContentHelper) request.getAttribute("contentHelper")).setContent();  //c'est cette ligne qui declenche l'appel du ws %>
<c:set var="carouselIdx" value="1" scope="request" />

<c:set var="imageUrl" scope="request" value="${contentHelper.imageUrl}" />
<% request.removeAttribute("pmstart"); %>
<%-- TODO exclure meaWidget.jsp du dynacache ! --%>
