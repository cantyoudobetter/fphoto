<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
    DAO dao = new DAO();
//System.out.println("USER:"+SessionState.getUserID(request));
    Section section = (Section)(dao.getSection(Integer.parseInt(request.getParameter("sectionid"))));
    Family family = (Family)(dao.getFamily(section.getFamilyID()));
    if (request.getParameter("renamesection") != null) {
        //System.out.println("SECTIONID:"+section.getSectionID()+":SECTIONNEWNAME:"+request.getParameter("sectionname"));
        dao.updateSection(section.getSectionID(),request.getParameter("sectionname"),"");
        response.sendRedirect("sectionmodify.jsp?sectionid="+request.getParameter("sectionid"));
    }
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    menuList.add("Upload Photos");
    linkList.add("sectionmodify.jsp?sectionid="+section.getSectionID());
    String pageTitle = "Rename Section - ";
    String userName = family.getDescription();
    String helpText = "Type over old section name and click Rename";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.sectionname.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">

&nbsp;
<form method="POST" action="sectionrename.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">

	  <tr>
		<td width="230" align="right">Section Name:</td>
		<td width="252">
            <input type="text" name="sectionname" value="<%=section.getShortDescription()%>" size="35">
            <input type="hidden" name="sectionid" value="<%=section.getSectionID()%>">

        </td>
		<td width="207">&nbsp;</td>
	  </tr>
	  <tr>
		<td width="230" align="right">&nbsp;</td>
		<td width="252"><input type="submit" value="Rename" name="renamesection"></td>
		<td width="207">&nbsp;</td>
	  </tr>
</table>
</form>
<%@ include file="footer.jsp" %>