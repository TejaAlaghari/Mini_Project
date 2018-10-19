<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>

<html>

<head>

	<title> Commit Confirmation </title>

	<script type= "text/javascript">
		
		function create_element(ele_name, id_ind)
		{
			var ele = document.createElement("INPUT");
			ele.type = "text";
			ele.name = "Uname" + id_ind;
			ele.value = ele_name;
			ele.readOnly = true;

			document.getElementById("td" + id_ind).appendChild(ele);
		}

	</script>

</head>

<body>

	<center>

	<form action= "payments.jsp" method= "post">

	<table cellpadding= "8" cellspacing= "5" align= "center" style= "border-collapse: collapse;">

	<% 
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		String ele, gname, uname, status;
		int cnt = 0;

		Enumeration parameterList = request.getParameterNames();
		while(parameterList.hasMoreElements())
		{
			ele = (String)parameterList.nextElement();
			cnt++;
		}

		gname = request.getParameter("game");
		out.println("<tr> <th colspan= '3'> Game: " + gname);
		out.println("<tr> <th> UserName <th> Player <th> E-Mail ");

		int i = 1;
		for(int iter = 1, ind = 1; iter < cnt; iter += 2, ind++)
		{
			uname = request.getParameter("Uname" + ind);
			status = request.getParameter("status" + ind);
			if(status.equals("select"))
				status = "1";
			else
				status = "0";

			if(status.equals("1"))
			{
				stmt = con.createStatement();
				rs = stmt.executeQuery("SELECT first_name, last_name, e_mail FROM members WHERE user_name = '" + uname + "'");

				if(rs.next())
					out.println("<tr> <td id= 'td" + i + "'> <script type= 'text/javascript'> create_element('" + uname + "', " + i++ + "); </script> <td> " + rs.getString(1) + " " + rs.getString(2) + " <td> " + rs.getString(3));
			}

			stmt = con.createStatement();
			stmt.executeUpdate("UPDATE " + gname + " SET selected = " + status + " WHERE user_name = '" + uname + "'");
		}

		out.println("<tr> <td align= 'center' colspan= '3'> <br> <input type= 'submit' name= 'submit' value= 'Proceed To Payment Gateway'>");
	%>

	</table>

	</form>
	<br> <br> <a href= 'clg_head.jsp'> Back To Home </a>
	
	</center>

</body>

</html>