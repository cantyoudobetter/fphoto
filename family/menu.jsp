<style type="text/css">
.menutitle{
cursor:pointer;
margin-bottom: 0px;
margin-top: 0px;
padding:0px;
text-align:left;
font-weight:normal;
font-size:2;
}
</style>

<html><head><title>Photo Center</title>
<link rel="stylesheet" type="text/css" href="family.css" title="Horizontal Menu"/>
</head><body bgcolor=#ffffff text=#000000 link=#000000 vlink=#000000 alink=#000000 >
<font face="Arial" size=2>
<table border="0" width="700" cellspacing=0 cellpadding=0 height="21">
  <tr>
    <td width="700" height="21">
        <table border="0" width="700" cellspacing="0" cellpadding="0" height="10">
            <tr>
                <td width="700" height="4"><b><font face="Arial" size="5"><%=pageTitle%></font><font face="Arial"><%=userName%></font></b></td>

            </tr>

        </table>
        <div id="nav"><ul>
        	<%for (int i=0; i<menuList.size(); i++) {%>
        		<li><a href="<%=linkList.get(i).toString()%>"><%=menuList.get(i).toString()%></a></li>	
        	<%}%>
        </ul></div>
        <table border="0" width="700" cellspacing="0" cellpadding="0" height="10">
            <tr>
                <td width="700" colspan="2" height="1" bgcolor="#3366CC">
                    &nbsp;<font color="#FFFFFF" face="Arial" size="2"><%=helpText%></font>
                </td>
            </tr>
        </table>
    </td>
  </tr>
</table>