<?xml version="1.0" encoding="UTF-8"?>
<%@ page import="javax.servlet.*" %><%@ page import="com.ibm.commerce.server.*" %><%@ page import="com.ibm.commerce.beans.*" %><%@ page import="com.ibm.commerce.datatype.*" %><%@ page import="java.util.*" %><%@page import="com.ibm.commerce.server.JSPHelper" %><%@ page import="com.ibm.commerce.ras.ECTrace"%><%@ page import="com.ibm.commerce.ras.ECTraceIdentifiers"%><success>
<% 
response.setContentType("text/xml;charset=UTF-8");
try { 
	JSPHelper jsphelper = new JSPHelper(request);
	Enumeration e1 = request.getParameterNames();
	while(e1.hasMoreElements() ) {
	    String param_name = (String)e1.nextElement();
	    String param_value = jsphelper.getParameter(param_name);
	    //ECOCEA si la valeur du message est trop longue on la tronque, sinon le message JMS depasse la taille maximale autorisée et ne peut être envoyée
	    if(param_name != null && param_name.equalsIgnoreCase("message") && param_value != null ){
	    	if(param_value.length() > 2000000){
	    		    	param_value = param_value.substring(0,1999999) + " .... ";
	    	}%>  <initialMessage><%=param_value%></initialMessage>  <%}}} catch (Exception e) {}%>
</success>