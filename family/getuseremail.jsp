<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
    DAO dao = new DAO();
    User userMain = dao.getUser(SessionState.getUserID(request));
    boolean error = false;
    boolean success = false;
    String errorText = "";
    if (request.getParameter("submitemail") != null) {
        if (request.getParameter("email").trim().equalsIgnoreCase("")) {
            error = true;
            errorText = "You need to enter something to use this feature";
        } else {
            dao.updateUser(userMain.getUserID(),
                    userMain.getPassword(),
                    userMain.getName(),
                    request.getParameter("email").trim(),
                    true
                    );
        }
        pageContext.forward("photothumbs.jsp");
    }
    if (request.getParameter("skip") != null) {
        pageContext.forward("photothumbs.jsp");
    }
    if (request.getParameter("never") != null) {
        dao.updateUser(userMain.getUserID(),
                userMain.getPassword(),
                userMain.getName(),
                userMain.getEmail(),
                false
                );
        pageContext.forward("photothumbs.jsp");
    }

//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    String pageTitle = "Email address - ";
    String userName = userMain.getName();
    String helpText = "Update your email address.";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.email.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<form method="POST" action="getuseremail.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
<%if (error) {%>
  <tr>
    <td width="230" align="right"><font color=red>Error Found: </font></td>
    <td width="470"><font color=red><%=errorText%></font></td>
  </tr>
<%} %>
  <tr>
    <td width="700" colspan=2 align="left">Your email address is not on file.  If you enter it, you can recieve notifications that new picture have been added via email.  If you want to do this later, click the Remind Me Later button.  If you do not want to use this feature, click the Never button.</td>
  </tr>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">Email Address:</td>
    <td width="470"><input type="text" value="<%=userMain.getEmail()%>" name="email" size="60"></td>
  </tr>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470">
    <input type="submit" value="Save Email" name="submitemail">
    <input type="submit" value="Remind Me Later" name="skip">
    <input type="submit" value="Never!" name="never">
    </td>
  </tr>
</table>
</form>
<%@ include file="footer.jsp"%>