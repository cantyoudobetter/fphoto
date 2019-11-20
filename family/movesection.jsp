<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
dao.updateSectionSortOrder(Integer.parseInt(request.getParameter("sectionid")),Integer.parseInt(request.getParameter("nextsectionso")));
dao.updateSectionSortOrder(Integer.parseInt(request.getParameter("nextsectionid")),Integer.parseInt(request.getParameter("sectionso")));
pageContext.forward("photomaint.jsp");

%>