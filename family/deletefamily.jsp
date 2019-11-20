<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
dao.deleteUserFamilyXref(SessionState.getUserID(request),Integer.parseInt(request.getParameter("familyid")));
pageContext.forward("newuserfam.jsp");

%>