<%@ page import="com.familyutil.Family" %>
<%@ page import="com.familyutil.DAO" %>
<%@ page import="java.util.*" %>

<%

DAO dao = new DAO();
ArrayList famlist = dao.getFamilyList();

if (request.getParameter("submit") != null) {
		pageContext.forward("famquestion.jsp");
		return;
}
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    String pageTitle = "Site Select";
    String userName = "";
    String helpText = "Select a site to view";
// end Menu Config
%>

<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<form method="POST" action="newpass.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
  <tr>
    <td width="230" align="right">Site to View:</td>
    <td width="252"><select size="1" name="family">
        <%
		for (int i=0;i < famlist.size(); i++) {
			int familyID = ((Family)famlist.get(i)).getFamilyID();
			String familyName = ((Family)famlist.get(i)).getDescription();
			%>
			<option value=<%=familyID%>><%=familyName%></option>
		<%}%>
      </select></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="219" align="right"></td>
    <td width="252"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="219" align="right">&nbsp;</td>
    <td width="252"><input type="submit" value="Next" name="submit"></td>
    <td width="207">&nbsp;</td>
  </tr>
</table>
</form>

<%@ include file="footer.jsp"%>