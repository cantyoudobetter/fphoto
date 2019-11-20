<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
dao.deleteSection(Integer.parseInt(request.getParameter("sectionid")));
pageContext.forward("photomaint.jsp");

%>