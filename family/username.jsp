<%@ page import="com.familyutil.Family" %>
<%@ page import="com.familyutil.DAO" %>
<%@ page import="java.util.*" %>

<%

DAO dao = new DAO();
boolean error = false;
String errorText = null;
if (request.getParameter("submituser") != null) {
		
		if (!dao.checkUser(request.getParameter("username").trim())) {

			dao.createUser(request.getParameter("username").trim(),request.getParameter("password").trim(),1,request.getParameter("realname").trim(),Integer.parseInt(request.getParameter("family")),request.getParameter("email").trim(),false);
			pageContext.forward("login.jsp");
			return;
		
		} else {
			error = true;
			errorText = "This user name is already in use.  Please Try Again.";
		
		}
}
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    String pageTitle = "User Information";
    String userName = "";
    String helpText = "Enter your user information";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.realname.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<form method="POST" action="username.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
<%if (!error) {%>
  
  <tr>
    <td width="230" align="right">What is your real name:</td>
    <td width="252"><input type="text" name="realname" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>

  <tr>
    <td width="230" align="right">Select a username:</td>
    <td width="252"><input type="text" name="username" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">Select a password:</td>
    <td width="252"><input type="text" name="password" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">email:</td>
    <td width="252"><input type="text" name="email" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="219" align="right">&nbsp;</td>
    <td width="252"><input type="submit" value="Finish" name="submituser"></td>
    <td width="207">&nbsp;</td>
  </tr>
<%} else {%>
  <tr>
    <td width="230" align="right">What is your real name:</td>
    <td width="252"><input type="text" name="realname" value="<%=request.getParameter("realname")%>" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right" ><font color=red><%=errorText%></font></td>
    <td width="252">&nbsp;</td>
    <td width="207">&nbsp;</td>
  </tr>  

  <tr>
    <td width="230" align="right">Select a username:</td>
    <td width="252"><input type="text" name="username" value="<%=request.getParameter("username")%>" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">Select a password:</td>
    <td width="252"><input type="text" name="password" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">email:</td>
    <td width="252"><input type="text" name="email" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="219" align="right">&nbsp;</td>
    <td width="252"><input type="submit" value="Finish" name="submituser"></td>
    <td width="207">&nbsp;</td>
  </tr>

  
<%}%>  
</table>
<input type="hidden" name="family" value=<%=request.getParameter("family")%>>
</form>
<%@ include file="footer.jsp"%>
