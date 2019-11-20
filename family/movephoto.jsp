<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
dao.updatePhotoSortOrder(Integer.parseInt(request.getParameter("photoid")),Integer.parseInt(request.getParameter("nextphotoso")));
dao.updatePhotoSortOrder(Integer.parseInt(request.getParameter("nextphotoid")),Integer.parseInt(request.getParameter("photoso")));
pageContext.forward("sectionmodify.jsp");

%>