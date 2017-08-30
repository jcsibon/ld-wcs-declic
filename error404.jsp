<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2006, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<fmt:setBundle basename="/LapeyreSAS/storetext_v2" var="storeText" scope="request"/>

<!DOCTYPE HTML>
<html lang="fr">
<head>
<link href='//fonts.googleapis.com/css?family=Roboto:300,400,700,400italic' rel='stylesheet' type='text/css'> 
<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:300,300italic,400,400italic,700,700italic' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="/wcsstore/LapeyreSAS/css/common1_1.css" type="text/css" media="screen"/>
<link rel="stylesheet" href="/wcsstore/LapeyreSAS/css/styles.css" type="text/css" />
<title><fmt:message key="pageIntrouvableLabel" bundle="${storeText}" /></title>
</head>
<body>
<div id="page">
	<%@ include file="error404_content.jsp" %>
	
</div>

</body>
</html>
