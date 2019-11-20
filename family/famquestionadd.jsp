<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%

DAO dao = new DAO();
Family family  = dao.getFamily(Integer.parseInt(request.getParameter("family")));
int userID = SessionState.getUserID(request);
boolean error = false;
String errorText = null;
if (request.getParameter("submitquestion") != null) {
		if (family.getSecret().trim().equalsIgnoreCase(request.getParameter("answer").trim())) {
				dao.createUserFamilyXref(userID,family.getFamilyID());
				pageContext.forward("photothumbs.jsp");
				return;
		} else {
			error = true;
			errorText = "Wrong Answer.  Please Try Again.";
		
		}
}
User userMain = dao.getUser(SessionState.getUserID(request));
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Thumbnails");
    linkList.add("photothumbs.jsp");
    String pageTitle = "Photo Site - ";
    String userName = userMain.getName();
    String helpText = "Answer the secret question to access the site.";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.answer.focus();
}
</SCRIPT>

<%@ include file="menu.jsp" %>

<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
<br>
<form name="myForm" method="POST" action="famquestionadd.jsp">
<table border="0" width="700" cellspacing="0" cellpadding="0">
  <%if (error) {%>
  <tr>
    <td width="400" align="right" ><font face="Arial" color=red><%=errorText%></font></td>
    <td width="300"></td>
  </tr>
  
  
  <%}%>
  <tr>
    <td width="400" align="right"><font face="Arial"><%=family.getSecretQuestion()%></font>></td>
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
