<%@ page import="com.familyutil.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.SQLException" %>
<%

    boolean error = false;
    boolean success = false;
    String errorText = "";

    if (request.getParameter("submitdb") != null) {
		   SetupDB sdb = new SetupDB();
            try {
//                sdb.createDatabase(request.getParameter("host").trim(),
//                                  request.getParameter("dbname").trim(),
//                                  request.getParameter("username").trim(),
//                                  request.getParameter("password").trim(),
//                                  request.getParameter("port").trim()
//                                  );
               sdb.setupDatabaseFromSchema(request.getParameter("schemalocation").trim(),
                                           request.getParameter("host").trim(),
                                           request.getParameter("dbname").trim(),
                                           request.getParameter("username").trim(),
                                           request.getParameter("password").trim(),
                                           request.getParameter("port")
                                           );
                success=true;
            } catch (Exception e) {
                error = true;
                errorText = e.getMessage();
            }

    }
//Menu Config
        ArrayList menuList = new ArrayList();
        ArrayList linkList = new ArrayList();
        menuList.add("Login");
        linkList.add("login.jsp");
        String pageTitle = "DB Setup";
        String userName = "";
        String helpText = "Enter a new database name and this utility will create the DB and tables";
// end Menu Config
%>


<%@ include file="menu.jsp" %>
<table border="0" width="600" cellspacing=0 cellpadding=0 height="21">
<form method="POST" action="dbsetup.jsp" name="myForm">
<table border="0" width="700" cellspacing="0" cellpadding="0">
<%if (error) {%>
  <tr>
    <td width="230" align="right"><font color=red>Error Setting Up DB:</font></td>
    <td width="470"><%=errorText%></td>
  </tr>
<%} %>
<%if (success) {%>
  <tr>
    <td width="230" align="right"><font color=green>Database Creation Successful!</font></td>
    <td width="470"></td>
  </tr>
<%} %>
  <tr>
    <td width="230" align="right">Database Host:</td>
    <td width="470"><input type="text" value="" name="host" size="20">(not needed)</td>
  </tr>
  <tr>
    <td width="230" align="right">Database Name:</td>
    <td width="470"><input type="text" value="c:\photo" name="dbname" size="20"></td>
  </tr>
  <tr>
    <td width="230" align="right">DB Admin User Name:</td>
    <td width="470"><input type="text" value="sa" name="username" size="20"></td>
  </tr>
  <tr>
    <td width="230" align="right">Password:</td>
    <td width="470"><input type="text" value="" name="password" size="20">(not needed)</td>
  </tr>
  <tr>
    <td width="230" align="right">MySQL Port:</td>
    <td width="470"><input type="text" value="3306" name="port" size="20">(not needed)</td>
  </tr>
  <tr>
    <td width="230" align="right">Schema File Location:</td>
    <td width="470"><input type="text" value="c:\\tomcat\\webapps\\family\\hSQL-Schema+Control.sql" name="schemalocation" size="60"></td>
  </tr>
  <tr>
    <td width="230" align="right">&nbsp;</td>
    <td width="470"><input type="submit" value="Create" name="submitdb"></td>
  </tr>
</table>
</form>
<%@ include file="footer.jsp"%>



