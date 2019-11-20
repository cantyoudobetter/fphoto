<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
dao.swapPhotoSection(Integer.parseInt(request.getParameter("photoid")),Integer.parseInt(request.getParameter("sectionid")));
pageContext.forward("sectionmodify.jsp");

%>