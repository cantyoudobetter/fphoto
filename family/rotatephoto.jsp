<%@ page import="com.familyutil.*" %>
<%@ page import="java.io.*" %>

<%		
		DAO dao = new DAO();
		Photo photo = dao.getPhoto(Integer.parseInt(request.getParameter("photoid")));
		Section section = dao.getSection(Integer.parseInt(request.getParameter("sectionid")));
        FamilyProperties zionProperties = FamilyProperties.getInstance();
        String destinationDir = zionProperties.PHOTODIR.trim();
        destinationDir = destinationDir+section.getFamilyID();
		FamUtil.rotateImage(destinationDir+File.separator+photo.getPhotoName(),90);
		FamUtil.rotateImage(destinationDir+File.separator+photo.getThumbName(),90);

		response.sendRedirect("sectionmodify.jsp?sectionid="+section.getSectionID());
%>			
