<%@ page import="com.familyutil.*,
                 java.util.ArrayList" %>

<%

if (request.getParameter("login") != null) {
	DAO dao = new DAO();
	if (dao.checkUser(request.getParameter("username"),request.getParameter("password"))) {
		User user = dao.getUser(request.getParameter("username").trim());
		SessionState.setUserID(request,user.getUserID());
		if (user.getUserTypeID() ==  0) {
			pageContext.forward("photoadmin.jsp");
			return;
		} else {
			if (user.getNotify() && (user.getEmail() == null || user.getEmail().trim().equalsIgnoreCase("")))
                pageContext.forward("getuseremail.jsp");
            else
                pageContext.forward("photothumbs.jsp");

			return;
		}
	}
}

//Menu Config
ArrayList menuList = new ArrayList();
ArrayList linkList = new ArrayList();
menuList.add("New Site");
linkList.add("newsite.jsp");
menuList.add("New User");
linkList.add("newpass.jsp");
String pageTitle = "Photo Site";
String userName = "";
String helpText = "Type your user name and password to enter the site.";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.username.focus();
}
</SCRIPT>

<%@ include file="menu.jsp" %>

<form name="myForm" method="POST" action="login.jsp">
<table border="0" width="700" cellspacing="0" cellpadding="0">
  <tr>
    <td width="219" align="right"><font face="Arial" size="2">User Name:</font></td>
    <td width="252"><input type="text" name="username" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="219" align="right"><font face="Arial" size="2">Password:</font></td>
    <td width="252"><input type="password" name="password" size="20"></td>
    <td width="207">&nbsp;</td>
  </tr>
  <tr>
    <td width="219" align="right">&nbsp;</td>
    <td width="252"><input type="submit" value="Login" name="login"></td>
    <td width="207">&nbsp;</td>
  </tr>
</table>
</form>

<%@ include file="footer.jsp" %>


