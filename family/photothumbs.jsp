<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
ArrayList familyList = dao.getFamilyListForUser(SessionState.getUserID(request));
ArrayList sectionList = null;

ArrayList photoList = null;
Section sectionMain = null;
Family familyMain = null;
if (request.getParameter("familyid") != null) {
	familyMain = dao.getFamily(Integer.parseInt(request.getParameter("familyid")));
	sectionList = dao.getSectionsForFamily(familyMain.getFamilyID());
	sectionMain = (Section)sectionList.get(0);
}
if (request.getParameter("sectionid") != null) {
	sectionMain = dao.getSection(Integer.parseInt(request.getParameter("sectionid")));
	familyMain = dao.getFamily(sectionMain.getFamilyID());
	sectionList = dao.getSectionsForFamily(familyMain.getFamilyID());

}
if (request.getParameter("sectionid") == null && request.getParameter("familyid") == null) {
	familyMain = (Family)familyList.get(0);
	sectionList = dao.getSectionsForFamily(((Family)familyList.get(0)).getFamilyID());
	sectionMain = dao.getSection(((Section)sectionList.get(0)).getSectionID());
}
int counter = 4;
User userMain = dao.getUser(SessionState.getUserID(request));
ArrayList noteList = null;
//Menu Config
ArrayList menuList = new ArrayList();
ArrayList linkList = new ArrayList();
menuList.add("Logout");
linkList.add("login.jsp");
menuList.add("Add/Remove Site");
linkList.add("newuserfam.jsp");
menuList.add("My Info");
linkList.add("userhome.jsp?RP=photothumbs.jsp");
String pageTitle = "Photo Site - ";
String userName = userMain.getName();
String helpText = "Click on thumbnails to enlarge and add comments.";

// end Menu Config
%>

<%@ include file="menu.jsp" %>
<table border="0" width="700" cellspacing=0 cellpadding=0 height="21">
  <tr>
    <td width="700" colspan="2" height="1">
        <table border="0" width="100%" cellspacing="0" cellpadding="0" valign=top>
          <tr>
            <td width="25%" valign="top">
                  <%for (int i=0;i < familyList.size();i++) {%>
                      <font size="2"><a href="photothumbs.jsp?familyid=<%=((Family)familyList.get(i)).getFamilyID()%>"><%=((Family)familyList.get(i)).getDescription()%></a></font><br>
                      <%
					  if (((Family)familyList.get(i)).getFamilyID() == familyMain.getFamilyID()) {
					  for (int j=0;j < sectionList.size();j++) {%>
		                   <font size="1">&nbsp;&nbsp;&nbsp;<a href="photothumbs.jsp?sectionid=<%=((Section)sectionList.get(j)).getSectionID()%>"><%=((Section)sectionList.get(j)).getShortDescription()%></a></font><br>
					  <%}}%>
                  <%
                  }%>
            </td>
            <td width="78%" valign="top">
              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="100%" colspan="4" valign="top" bgcolor="#C0C0C0">
                    <p align="center"><b><%=familyMain.getDescription()%> - <%=sectionMain.getShortDescription()%></b></td>
                </tr>
                <tr>
                  <td width="100%" colspan="4" valign="top">
                        <i><p align="center"><%=familyMain.getMessageOfTheDay()%></i></td>
                  </tr>


                  <%
				  photoList = dao.getPhotosForSection(sectionMain.getSectionID());	
				  for (int k=0;k < photoList.size();k++) {	
				  if (counter%4 == 0) {

				  %><tr> <%}%>
				  <td width="25%"> 
                    <p align="center">
					<a href="photodetail.jsp?photoid=<%=((Photo)photoList.get(k)).getPhotoID()%>">
					<img border="0" src="./photo/<%=sectionMain.getFamilyID()%>/<%=((Photo)photoList.get(k)).getThumbName()%>">
					</a>
					<br>
                    <font size="1"> 
					<%noteList =  dao.getNotesForPhoto(((Photo)photoList.get(k)).getPhotoID());
					for (int p=0;p < noteList.size();p++){
					%>
						- <%=((PhotoNote)noteList.get(p)).getNote()%>
						<br>
					<%}%>
					</font>
				  </td>
				  <%
  				  counter++;
				  if (counter%4 == 0 && counter > 4) {
				  %>
				  </tr>
                  <%
				  }
				  }%>	
			
              </table>
            </td>
          </tr>
        </table>
   	</td>
  </tr>

</table>
<%@ include file="footer.jsp" %>
