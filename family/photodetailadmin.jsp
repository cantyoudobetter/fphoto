<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
    DAO dao = new DAO();
    User userMain = dao.getUser(SessionState.getUserID(request));
    Photo photo = dao.getPhoto(Integer.parseInt(request.getParameter("photoid")));
    if (request.getParameter("commentbutton") != null) {
        dao.createPhotoNote(photo.getPhotoID(),userMain.getUserID(),request.getParameter("comment"));
    }
    ArrayList noteList = dao.getNotesForPhoto(photo.getPhotoID());
    Section section = dao.getSection(photo.getSectionID());
    Family family = (Family)((dao.getFamilyListForUser(SessionState.getUserID(request))).get(0));
//Menu Config
        ArrayList menuList = new ArrayList();
        ArrayList linkList = new ArrayList();
        menuList.add("Logout");
        linkList.add("login.jsp");
        menuList.add("Upload Photos");
        linkList.add("sectionmodify.jsp?sectionid="+section.getSectionID());
        String pageTitle = "Photo Detail & Comments - ";
        String userName = family.getDescription();
        String helpText = "Add comments by typing them in and clicking Add Comment";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.photoid.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
  <tr>
    <td width="700" colspan="2" height="1">
        <ul>
		  <%for (int i=0;i < noteList.size();i++) {%>
          <li>
            <p align="center"><%=((PhotoNote)noteList.get(i)).getNote()%></li>
          <%}%>
        </ul>
        <form method="POST" action="photodetailadmin.jsp" name="myForm">
          <input type="hidden" name="photoid" value="<%=photo.getPhotoID()%>">
		  <p align="center"><input type="text" name="comment" size="30"><br>
          <input type="submit" value="Add Comment" name="commentbutton"></p>
        </form>
        <p align="center"><img border="0" src="./photo/<%=section.getFamilyID()%>/<%=photo.getPhotoName()%>"></p>
        <p align="center">&nbsp;
   	</td>
  </tr>

</table>
<%@ include file="footer.jsp" %>