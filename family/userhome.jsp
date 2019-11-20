<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
    DAO dao = new DAO();
    User userMain = dao.getUser(SessionState.getUserID(request));
    boolean error = false;
    boolean success = false;
    String errorText = "";
    String checked = "";
    if (userMain.getNotify()) checked = "checked";
    if (request.getParameter("submituser") != null) {
        if (request.getParameter("password").trim().equalsIgnoreCase("")) {
            error = true;
            errorText = "Password cannot be blank";
        } else if (request.getParameter("name").trim().equalsIgnoreCase("")) {
            error = true;
            errorText = "Real Name cannot be blank";
        } else {
            boolean notify = false;
            if (request.getParameter("notify") != null && request.getParameter("notify").equalsIgnoreCase("on")) notify = true;
            dao.updateUser(userMain.getUserID(),
                    request.getParameter("password").trim(),
                    request.getParameter("name").trim(),
                    request.getParameter("email").trim(),
                    notify
                    );
            success = true;
            userMain = dao.getUser(userMain.getUserID());
            checked = "";
            if (userMain.getNotify()) checked = "checked";
        }
    }

//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    menuList.add("Back");
    linkList.add(request.getParameter("RP").trim());
    String pageTitle = "My Info - ";
    String userName = userMain.getName();
    String helpText = "Update your your user information as needed.";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.name.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
&nbsp;
<form method="POST" action="userhome.jsp?RP=<%=request.getParameter("RP").trim()%>" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
<%if (error) {%>
  <tr>
    <td width="230" align="right"><font color=red>Error Found: </font></td>
    <td width="470"><font color=red><%=errorText%></font></td>
  </tr>
<%} %>
<%if (success) {%>
  <tr>
    <td width="230" align="right"><font color=green>User Info Updated</font></td>
    <td width="470"></td>
  </tr>
<%} %>
  <tr>
    <td width="230" align="right">User Name:</td>
    <td width="470" align="left"><%=userMain.getUserName()%></td>
  </tr>
  <tr>
    <td width="230" align="right"><b>Real Name:</b></td>
    <td width="470"><input type="text" value="<%=userMain.getName()%>" name="name" size="20"></td>
  </tr>
  <tr>
    <td width="230" align="right"><b>Password:</b></td>
    <td width="470"><input type="text" value="<%=userMain.getPassword()%>" name="password" size="20"></td>
  </tr>
  <tr>
    <td width="230" align="right">Email Address:</td>
    <td width="470"><input type="text" value="<%=userMain.getEmail()%>" name="email" size="60"></td>
  </tr>
  <tr>
    <td width="230" align="right"><input type="checkbox" name="notify" <%=checked%>></td>
    <td width="470">Get Update Notifications?</td>
  </tr>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470"><input type="submit" value="Update" name="submituser"></td>
  </tr>
</table>
</form>
<%@ include file="footer.jsp"%>