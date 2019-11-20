<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
ArrayList noteList;
DAO dao = new DAO();
Family family = (Family)((dao.getFamilyListForUser(SessionState.getUserID(request))).get(0));
Section section = dao.getSection(Integer.parseInt(request.getParameter("sectionid")));
ArrayList photoList = dao.getPhotosForSection(section.getSectionID());
User userMain = dao.getUser(SessionState.getUserID(request));
//Menu Config
        ArrayList menuList = new ArrayList();
        ArrayList linkList = new ArrayList();
        menuList.add("Logout");
        linkList.add("login.jsp");
        menuList.add("Photo Sections");
        linkList.add("photomaint.jsp");
        String pageTitle = "Upload & Change Photos - ";
        String userName = family.getDescription();
        String helpText = "Browse, Upload, Rotate, and Delete Photos";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.fileSelection.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
<form ENCTYPE='multipart/form-data' ACTION='photoupload.jsp?sectionid=<%=section.getSectionID()%>' method="post" name="myForm">
<input type=hidden name="sectionid" value=<%=section.getSectionID()%>>

<table width="700" cellspacing="0" cellpadding="0">
	  <tr>
		<td width="230" align="right"><font face="Arial" size="2">Section:</font></td>
		<td width="252"><b><font face="Arial" size="3"><%=section.getShortDescription()%></font></b>
                <a href="sectionrename.jsp?sectionid=<%=section.getSectionID()%>">
					<font face="Arial" size=1>(Rename Section)</font>
				</a>
        </td>
		<td width="207">
                &nbsp;
        </td>
	  </tr>
	  <tr>
		<td width="230">&nbsp;</td>
		<td width="252">&nbsp;</td>
		<td width="207">&nbsp;</td>
	  </tr>
	  <tr>
		<td width="230" align="right"><font face="Arial" size="2">New Photo:</font></td>
		<td width="252"><input id=fileSelection type="File" name="fileSelection" size="38" ACCEPT="*.jpg"></td>
		<td width="207">&nbsp;</td>
	  </tr>
	  <tr>
		<td width="230" align="right">&nbsp;</td>
		<td width="252"><input type="submit" value="Add" name="addsection"></td>
		<td width="207">&nbsp;</td>
	  </tr>
	  <tr>
		<td width="230" align="right"></td>
		<td width="252"></td>
		<td width="207">&nbsp;</td>
	  </tr>

</table>


<table width="650" cellspacing="0" cellpadding="5" border="1">
<tr>
   <td width="150" align="middle" bgcolor="#C0C0C0"><font face="Arial" size=2 ><b>Photo Tools</b></font></td>
   <td width="100" align="middle" bgcolor="#C0C0C0"><font face="Arial" size=2><b>Photo</b><br></font><font face="Arial" size=1>(Click to Comment)</font></td>
   <td width="100" align="middle" bgcolor="#C0C0C0"><font face="Arial" size=2><b>Sequence</b></td>
   <td width="300" align="middle" bgcolor="#C0C0C0"><font face="Arial" size=2><b>Comments</b></td>

</tr>
</table>
<%for (int i=0;i < photoList.size();i++) {%>

	<table width="650" cellspacing="0" cellpadding="5" border="1">

	<tr>
            <td width="150" align="right" valign=middle>

                <a href="deletephoto.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>&sectionid=<%=section.getSectionID()%>">
					<font face="Arial" size=1>(delete Photo)</font>
				</a>
				<br>
				<font face="Arial" size=1>rotate: </font>
                <a href="rotatephoto.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>&sectionid=<%=section.getSectionID()%>">
					<font face="Arial" size=1>(90)</font>
                </a>
                &nbsp;&nbsp;
				<a href="rotatephoto180.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>&sectionid=<%=section.getSectionID()%>">
					<font face="Arial" size=1>(180)</font>
				</a>

                <br>
				<a href="photosectionselect.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>&sectionid=<%=section.getSectionID()%>">
					<font face="Arial" size=1>(Swap Section)</font>
				</a>





			</td>
			<td width="100" valign="middle" >
				<a href="photodetailadmin.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>">
					<img border="0" src="./photo/<%=family.getFamilyID()%>/<%=((Photo)photoList.get(i)).getThumbName()%>">
				</a>


  			</td>
			<td width="100">
                <font face="Arial" size="1" >
                    <%if (i>0) {%>

                    <a href="movephoto.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>&photoso=<%=((Photo)photoList.get(i)).getSortOrder()%>&nextphotoid=<%=((Photo)photoList.get(i-1)).getPhotoID()%>&nextphotoso=<%=((Photo)photoList.get(i-1)).getSortOrder()%>&sectionid=<%=section.getSectionID()%>">(Up)</a>
                    &nbsp;
                    <%}%>
                    <%if (i<(photoList.size()-1)) {%>
                    &nbsp;&nbsp;&nbsp;
                    <a href="movephoto.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>&photoso=<%=((Photo)photoList.get(i)).getSortOrder()%>&nextphotoid=<%=((Photo)photoList.get(i+1)).getPhotoID()%>&nextphotoso=<%=((Photo)photoList.get(i+1)).getSortOrder()%>&sectionid=<%=section.getSectionID()%>">(Down)</a>

                    <%}%>

                </font>
            </td>
			<td width="300" align="left">
                <%noteList = dao.getNotesForPhoto(((Photo)photoList.get(i)).getPhotoID());%>
                <%if (noteList.size() > 0) {%>
                        <%for (int j=0;j < noteList.size();j++) {%>
                            <font face="Arial" size="1" >-<%=((PhotoNote)noteList.get(j)).getNote()%>
                            <a href="deletephotonote.jsp?photonoteid=<%=((PhotoNote)noteList.get(j)).getNoteID()%>&sectionid=<%=section.getSectionID()%>">(Delete)</a>
                            </font>
                            <br>
                        <%}%>
                <%} %>
                <a href="photodetailadmin.jsp?photoid=<%=((Photo)photoList.get(i)).getPhotoID()%>">
                    <font face="Arial" size="1" >(Add Comments)</font>
                </a>
  			</td>
	 	</tr>
	</table>
    <%}%>

</form>
<%@ include file="footer.jsp" %>