<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
ArrayList familyList = dao.getFamilyListForUser(SessionState.getUserID(request));
Family familyMain = (Family)familyList.get(0);
User userMain = dao.getUser(SessionState.getUserID(request));
Photo photo = dao.getPhoto(Integer.parseInt(request.getParameter("photoid")));
if (request.getParameter("commentbutton") != null) {
	dao.createPhotoNote(photo.getPhotoID(),userMain.getUserID(),request.getParameter("comment"));
}
ArrayList noteList = dao.getNotesForPhoto(photo.getPhotoID());
Section section = dao.getSection(photo.getSectionID());
//Menu Config
ArrayList menuList = new ArrayList();
ArrayList linkList = new ArrayList();
menuList.add("Thumbnails");
linkList.add("photothumbs.jsp");
String pageTitle = "Photo Site - ";
String userName = userMain.getName();
String helpText = "Type in text and click Add Comment button to create comments";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.comment.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0>
  <tr>
    <td width="700" colspan="2" height="1">
        <ul>
		  <%for (int i=0;i < noteList.size();i++) {%>
          <li>
            <p align="center"><%=((PhotoNote)noteList.get(i)).getNote()%></li>
          <%}%>
        </ul>
        <form name="myForm" method="POST" action="photodetail.jsp">
          <input type="hidden" name="photoid" value="<%=photo.getPhotoID()%>">
		  <p align="center"><input type="text" name="comment" size="30"><br>
          <input type="submit" value="Add Comment" name="commentbutton"></p>
        </form>
        <img border="0" width="640" src="./photo/<%=section.getFamilyID()%>/<%=photo.getPhotoName()%>">
   	</td>
  </tr>
</table>
<%@ include file="footer.jsp" %>

