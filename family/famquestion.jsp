<%@ page import="com.familyutil.Family" %>
<%@ page import="com.familyutil.DAO" %>
<%@ page import="java.util.*" %>

<%

DAO dao = new DAO();
Family family  = dao.getFamily(Integer.parseInt(request.getParameter("family")));
boolean error = false;
String errorText = null;
if (request.getParameter("submitquestion") != null) {
		if (family.getSecret().trim().equalsIgnoreCase(request.getParameter("answer").trim())) {
				pageContext.forward("username.jsp");
				return;
		} else {
			error = true;
			errorText = "Wrong Answer.  Please Try Again.";
		
		}
}
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    String pageTitle = "Secret Question";
    String userName = "";
    String helpText = "Enter the Answer to the Site's Secret Question";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.answer.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<form method="POST" action="famquestion.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
  <%if (error) {%>
  <tr>
    <td width="400" align="right" ><font color=red><%=errorText%></font></td>
    <td width="300"></td>
  </tr>
  
  
  <%}%>
  <tr>
    <td width="400" align="right"><%=family.getSecretQuestion()%></td>
    <td width="300"><input type="text" name="answer" size="20"></td>
  </tr>
  <tr>
    <td width="400" align="right">&nbsp;</td>
    <td width="300"><input type="submit" value="Next" name="submitquestion"></td>
  </tr>
</table>
<input type="hidden" name="family" value=<%=family.getFamilyID()%>>
</form>
<%@ include file="footer.jsp" %>
