<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>

<%
boolean error = false;
boolean success = false;
String errorText = "";
String email = "";
DAO dao = new DAO();
Family family = (Family)((dao.getFamilyListForUser(SessionState.getUserID(request))).get(0));
User userMain = dao.getUser(SessionState.getUserID(request));

if (request.getParameter("dropuser") != null) {
	dao.deleteUserFamilyXref(Integer.parseInt(request.getParameter("userid")),family.getFamilyID());

}
ArrayList UserList = dao.getUserListForFamily(family.getFamilyID());

if (request.getParameter("updatefamily") != null) {
    if (request.getParameter("password").trim().equalsIgnoreCase("")) {
        error = true;
        errorText = "Password cannot be blank";
    } else if (request.getParameter("name").trim().equalsIgnoreCase("")) {
        error = true;
        errorText = "Real Name cannot be blank";
    } else if (request.getParameter("description").trim().equalsIgnoreCase("")) {
        error = true;
        errorText = "Site Name cannot be blank";
    } else if (request.getParameter("question").trim().equalsIgnoreCase("")) {
        error = true;
        errorText = "Secret Question cannot be blank";
    } else if (request.getParameter("secret").trim().equalsIgnoreCase("")) {
        error = true;
        errorText = "Secret Answer cannot be blank";
    } else {
        dao.updateFamily(family.getFamilyID(),request.getParameter("description"),true,request.getParameter("secret"),request.getParameter("question"),"",request.getParameter("mod"),"","","");
        dao.updateUser(userMain.getUserID(),
                request.getParameter("password").trim(),
                request.getParameter("name").trim(),
                "",
                false
                );
        success = true;
        userMain = dao.getUser(userMain.getUserID());
        family = (Family)((dao.getFamilyListForUser(SessionState.getUserID(request))).get(0));
    }
}
//Menu Config
    ArrayList menuList = new ArrayList();
    ArrayList linkList = new ArrayList();
    menuList.add("Logout");
    linkList.add("login.jsp");
    menuList.add("Photo Sections");
    linkList.add("photomaint.jsp");
    String pageTitle = "Manage Photo Site - ";
    String userName = family.getDescription();
    String helpText = "General Site Information";
// end Menu Config
%>
<SCRIPT LANGUAGE="JavaScript">
function processPageLoad() {
    document.myForm.description.focus();
}
</SCRIPT>
<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
<form method="POST" action="photoadmin.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
<%if (error) {%>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right"><font color=red>Error Found: </font></td>
    <td width="470"><font color=red><%=errorText%></font></td>
  </tr>
<%} %>
<%if (success) {%>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right"><font color=green>Site Info Updated</font></td>
    <td width="470"></td>
  </tr>
<%} %>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right"><b>Site Name:</b></td>
    <td width="470"><input type="text" name="description" value="<%=family.getDescription()%>" size="20"></td>
  </tr>
  <tr>
    <td width="230" align="right"><b>Secret Question:</b></td>
    <td width="470"><textarea rows="4" name="question" cols="30"><%=family.getSecretQuestion()%></textarea></td>
  </tr>
  <tr>
    <td width="230" align="right"><b>Secret Answer:</b></td>
    <td width="470"><input type="text" name="secret"  value="<%=family.getSecret()%>" size="20"></td>
  </tr>
  <tr>
    <td width="230" align="right">Message Of The Day:</td>
    <td width="470"><textarea rows="4" name="mod" cols="30"><%=family.getMessageOfTheDay()%></textarea></td>
  </tr>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="230" align="right">Admin User Name:</td>
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
    <td width="230" align="right">&nbsp;</td>
    <td width="407"><input type="submit" value="Update Site Data" name="updatefamily"></td>
  </tr>
</table>
</form>
<table border="0" width="700" cellspacing="0" cellpadding="0">
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="252" colspan=2 align="right">&nbsp;</td>
    <td width="207">&nbsp;</td>
  </tr>
  
  <tr color=grey>
    <td width="230" align="left"><b>Current Site Viewers</b></td>
    <td width="252" colspan=2 align="left"><b>Email Address</b></td>
    <td width="207">&nbsp;</td>
  </tr>

  <% for (int i = 0; i < UserList.size() ; i++) {%>
  <tr>
    <td width="230" align="left"><%=((User)UserList.get(i)).getName()%></td>
    <% if (((User)UserList.get(i)).getUserTypeID() > 0) {%>
        <%email = ((User)UserList.get(i)).getEmail();%>
        <%if (email == null || email.trim().equalsIgnoreCase("") || email.equalsIgnoreCase("null")) {
            email = "Not Available";
        } else {
            email = "<input type='checkbox' name='emails' value=" + ((User)UserList.get(i)).getUserID() + ">" + email;
        }%>
        <td width="252" colspan=2 align="left"><%=email%></td>
        <td width="207"><a href="photoadmin.jsp?dropuser='yes'&userid=<%=((User)UserList.get(i)).getUserID()%>">(remove access)</a></td>
    <%} else {%>
        <td width="252" colspan=2 align="left">N/A</td>
        <td width="207"><i>Cannot Remove</i></td>
	<%}%>
  </tr>
  <%}%>

</table>

<%@ include file="footer.jsp" %>
