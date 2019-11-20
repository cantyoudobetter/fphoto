<%@ page import="com.familyutil.Family,
                 com.familyutil.User,
                 com.familyutil.SessionState" %>
<%@ page import="com.familyutil.DAO" %>
<%@ page import="java.util.*" %>

<%

DAO dao = new DAO();
boolean error = false;
String errorText = null;
//System.out.println("here1");
if (request.getParameter("submitfamily") != null) {
		if (request.getParameter("description") != null) {
			int familyid = dao.createFamily(request.getParameter("description").trim(),true,request.getParameter("secret").trim(),request.getParameter("question").trim(),"","","","","");
			pageContext.forward("usernameadmin.jsp?family="+familyid);
			return;
		
		} else {
			error = true;
			errorText = "Fields cannot be left blank.  Please Try Again.";
		
		}
}
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    String pageTitle = "Create New Photo Site";
    String userName = "";
    String helpText = "Step 1 of 3: Type in site info and click next.";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.description.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<form name="myForm" method="POST" action="newsite.jsp">
<table border="0" width="700" cellspacing="0" cellpadding="0">
<%if (!error) {%>
  
  <tr>
    <td width="230" align="right">Site Name:</td>
    <td width="252"><input type="text" name="description" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">Secret Question:</td>
    <td width="252"><textarea rows="4" name="question" cols="30"></textarea></td>
    <td width="207">&nbsp;</td>
  </tr>

  <tr>
    <td width="230" align="right">Secret Answer:</td>
    <td width="252"><input type="text" name="secret" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="252"><input type="submit" value="Next" name="submitfamily"></td>
    <td width="207">&nbsp;</td>
  </tr>
<%} else {%>
  <tr>
    <td width="230" align="right" ><font color=red><%=errorText%></font></td>
    <td width="252">&nbsp;</td>
    <td width="207">&nbsp;</td>
  </tr>  
  
  <tr>
    <td width="230" align="right">Site Name:</td>
    <td width="252"><input type="text" name="description" value="<%=request.getParameter("description")%>" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">Secret Question:</td>
    <td width="252"><textarea rows="4" name="question" value="<%=request.getParameter("question")%>" cols="30"></textarea></td>
    <td width="207">&nbsp;</td>
  </tr>

  <tr>
    <td width="230" align="right">Secret Answer:</td>
    <td width="252"><input type="text" name="secret" value="<%=request.getParameter("secret")%>" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="252"><input type="submit" value="Next" name="submitfamily"></td>
    <td width="207">&nbsp;</td>
  </tr>
  
<%}%>  
</table>
<input type="hidden" name="family" value=<%=request.getParameter("family")%>>
</form>

<%@ include file="footer.jsp" %>
