<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>

<fmt:setBundle basename="/com/lapeyre/declic/listValue" var="storeListe" scope="request"/>
<fmt:setBundle basename="/${sdb.jspStoreDir}/storelist" var="storeListe" scope="request"/>



<%out.flush();%>
<c:import url="${env_jspStoreDir}/UserAreaDeclic/AccountSection/SynchronisationSubsection/UserSynchronisationAddForm.jsp"/>
<%out.flush();%>