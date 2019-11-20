<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%		DAO dao = new DAO();
		Section section = dao.getSection(Integer.parseInt(request.getParameter("sectionid")));
		try {
            FamilyProperties zionProperties = FamilyProperties.getInstance();
            String destinationDir = zionProperties.PHOTODIR.trim();
			
            destinationDir = destinationDir+section.getFamilyID();
			//System.out.println("OUTDIR:"+destinationDir);
			File dir = new File(destinationDir);
			if (!dir.isDirectory())
				dir.mkdir();

			MultipartRequest multi = new MultipartRequest(request, destinationDir, 5 * 1024 * 1024);

            String fileName = multi.getFilesystemName("fileSelection");
            File f = multi.getFile("fileSelection");
			//File newFile = new File(destinationDir+File.separator+FamUtil.getUniqueFileName(destinationDir));
			//f.renameTo(newFile);
            String photoName = FamUtil.getUniqueFileName(destinationDir);
			String thumbName = photoName.substring(0,photoName.indexOf(".")) + "thumb" + ".JPEG";
            FamUtil.resizeMainPhoto(destinationDir+File.separator+f.getName(),destinationDir+File.separator+photoName,640);
            FamUtil.createThumb(destinationDir+File.separator+photoName,destinationDir+File.separator+thumbName,100);
			dao.createPhoto(section.getSectionID(),photoName,thumbName);
            f.delete();
		}	catch (Exception e) {
		    e.printStackTrace();
	    } // end try/catch
	    response.sendRedirect("sectionmodify.jsp?sectionid="+request.getParameter("sectionid"));
			
%>