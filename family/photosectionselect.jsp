<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
    DAO dao = new DAO();
//System.out.println("USER:"+SessionState.getUserID(request));
    Family family = (Family)((dao.getFamilyListForUser(SessionState.getUserID(request))).get(0));
    ArrayList sectionList = dao.getSectionsForFamily(family.getFamilyID());
    Photo photo = dao.getPhoto(Integer.parseInt(request.getParameter("photoid")));
    Section section = dao.getSection(photo.getSectionID());

//Menu Config
        ArrayList menuList = new ArrayList();
        ArrayList linkList = new ArrayList();
        menuList.add("Logout");
        linkList.add("login.jsp");
        menuList.add("Upload Photos");
        linkList.add("sectionmodify.jsp?sectionid="+section.getSectionID());
        String pageTitle = "Swap photo Section - ";
        String userName = family.getDescription();
        String helpText = "Pick the new section for the photo";
// end Menu Config
%>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<table border="0" width="700" cellspacing="0" cellpadding="0">
        <td width="230" align="right">
            <img border="0" src="./photo/<%=family.getFamilyID()%>/<%=photo.getThumbName()%>">
  		</td>
		<td width="252">&nbsp;<td>
		<td width="207">&nbsp;<td>

	  <%for(int i=0;i<sectionList.size();i++) {%>
	  <%if (i==0) {%>
		  <tr>
			<td width="230" align="right"><font face="Arial" size="2">Available Sections:</font></td>
	  <%} else {%>
		  <tr>
			<td width="230" align="right"></td>
	  <%}%>
			<td width="252"><a href="swapphotosection.jsp?sectionid=<%=((Section)sectionList.get(i)).getSectionID()%>&photoid=<%=request.getParameter("photoid")%>"><font face="Arial" size="2"><%=((Section)sectionList.get(i)).getShortDescription()%></font></a></td>
			<td width="207">
			</td>
		  </tr>
	<%}%>


</table>
<%@ include file="footer.jsp" %>
