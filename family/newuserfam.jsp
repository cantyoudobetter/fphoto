<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%

DAO dao = new DAO();
ArrayList famlist = dao.getFamilyList();

if (request.getParameter("submit") != null) {
		pageContext.forward("famquestionadd.jsp");
		return;
}

User userMain = dao.getUser(SessionState.getUserID(request));
ArrayList userFamilyList = dao.getFamilyListForUser(SessionState.getUserID(request));
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Tumbnails");
    linkList.add("photothumbs.jsp");
    String pageTitle = "Photo Site - ";
    String userName = userMain.getName();
    String helpText = "Select a site to add and click the Next Button";
// end Menu Config
%>

<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
<form method="POST" action="newuserfam.jsp">
<table border="0" width="700" cellspacing="0" cellpadding="0">
  <br>
  <tr>
    <td width="230" align="right">Site:</td>
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
    <td width="219" align="right">&nbsp;</td>
    <td width="252"><input type="submit" value="Next" name="submit"></td>
    <td width="207">&nbsp;</td>
  </tr>
</table>
</form>

<table border="0" width="700" cellspacing="0" cellpadding="0">
  <tr>
    <td width="219" align="right"></td>
    <td width="252"><b>Current Sites</b></td>
    <td width="207">&nbsp;</td>
  </tr>
<%
for (int i=0;i < userFamilyList.size(); i++) {
%>
	  <tr>
    	<td width="230" align="right"></td>
    	<td width="252">
			<font face="Arial" size=2><%=((Family)userFamilyList.get(i)).getDescription()%></font>
      	</td>
		<% if (userFamilyList.size() > 1) {%>
		    <td width="207"><font face="Arial" size=2><a href="deletefamily.jsp?familyid=<%=((Family)userFamilyList.get(i)).getFamilyID()%>">(remove)</a></font></td>
		<%} else {%>  	
		    <td width="207"></td>
		<%}%>  	
	  </tr>
<%}%>
  <tr>
    <td width="219" align="right"></td>
    <td width="252"></td>
    <td width="207">&nbsp;</td>
  </tr>
</table>

<%@ include file="footer.jsp" %>
