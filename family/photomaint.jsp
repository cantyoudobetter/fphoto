<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
DAO dao = new DAO();
//System.out.println("USER:"+SessionState.getUserID(request));
Family family = (Family)((dao.getFamilyListForUser(SessionState.getUserID(request))).get(0));

if (request.getParameter("addsection") != null) {
	dao.createSection(family.getFamilyID(),request.getParameter("newsection"),"");
}

ArrayList sectionList = dao.getSectionsForFamily(family.getFamilyID());
    User userMain = dao.getUser(SessionState.getUserID(request));
//Menu Config
        ArrayList menuList = new ArrayList();
        ArrayList linkList = new ArrayList();
        menuList.add("Logout");
        linkList.add("login.jsp");
        menuList.add("Site Info");
        linkList.add("photoadmin.jsp");
        String pageTitle = "Manage Photo Site Sections - ";
        String userName = family.getDescription();
        String helpText = "Add and Remove Sections From Your Site";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.addsection.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<form method="POST" action="photomaint.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
  <%if (sectionList.size() == 0) {%>
	  <tr>
		<td width="230" align="right">Current Sections:</td>
		<td width="252">None</td>
		<td width="207"></td>
	  </tr>
  <%} else {%>
  
	  <%for(int i=0;i<sectionList.size();i++) {%>
	  <%if (i==0) {%>
		  <tr>
			<td width="230" align="right">Current Sections:</td>
	  <%} else {%>
		  <tr>
			<td width="230" align="right"></td>
	  <%}%>	
			<td width="252"><a href="sectionmodify.jsp?sectionid=<%=((Section)sectionList.get(i)).getSectionID()%>"><%=((Section)sectionList.get(i)).getShortDescription()%></a></td>
			<td width="207">
			<font size="1">
				<a href="deletesection.jsp?sectionid=<%=((Section)sectionList.get(i)).getSectionID()%>">
					(delete)
				</a>
				<%if (i>0) {%>
			    &nbsp;&nbsp;&nbsp;
                <a href="movesection.jsp?sectionid=<%=((Section)sectionList.get(i)).getSectionID()%>&
										sectionso=<%=((Section)sectionList.get(i)).getSortOrder()%>&
										nextsectionid=<%=((Section)sectionList.get(i-1)).getSectionID()%>&
										nextsectionso=<%=((Section)sectionList.get(i-1)).getSortOrder()%>">
				(Up)</a>&nbsp;
				<%} else {%>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%>
				<%if (i<(sectionList.size()-1)) {%>
				&nbsp;&nbsp;&nbsp;
                <a href="movesection.jsp?sectionid=<%=((Section)sectionList.get(i)).getSectionID()%>&
										sectionso=<%=((Section)sectionList.get(i)).getSortOrder()%>&
										nextsectionid=<%=((Section)sectionList.get(i+1)).getSectionID()%>&
										nextsectionso=<%=((Section)sectionList.get(i+1)).getSortOrder()%>">
				(Down)</a>&nbsp;
				<%}%>

			</font>
			</td>
		  </tr>
	<%}}%>
	  <tr>
		<td width="230" align="right"></td>
		<td width="252"><font size=1 color=green>Warning:  If you delete a section with photos, those photos will no longer be available.</font></td>
		<td width="207"></td>
	  </tr>
	  <tr>
		<td width="230" align="right"></td>
		<td width="252"></td>
		<td width="207">&nbsp;</td>
	  </tr>
	
	  <tr>
		<td width="230" align="right">New Section:</td>
		<td width="252"><input type="text" name="newsection" size="35"></td>
		<td width="207">&nbsp;</td>
	  </tr>
	  <tr>
		<td width="230" align="right">&nbsp;</td>
		<td width="252"><input type="submit" value="Add" name="addsection"></td>
		<td width="207">&nbsp;</td>
	  </tr>
</table>
</form>
<%@ include file="footer.jsp"%>