<%@ page import="com.familyutil.*" %>

<%		DAO dao = new DAO();
		dao.deletePhoto(Integer.parseInt(request.getParameter("photoid")));
	    response.sendRedirect("sectionmodify.jsp?sectionid="+request.getParameter("sectionid"));
	    
%>			
