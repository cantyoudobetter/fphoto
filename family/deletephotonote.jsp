<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%

DAO dao = new DAO();
dao.deletePhotoNote(Integer.parseInt(request.getParameter("photonoteid")));
pageContext.forward("sectionmodify.jsp?sectionid="+Integer.parseInt(request.getParameter("sectionid")));

%>