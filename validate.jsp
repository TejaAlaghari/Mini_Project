8<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> User Validation </title>

	<script type= "text/javascript">
		
		function form_submission(redirectURL, clg)
		{
			var form = document.getElementById("login");
			form.action = redirectURL;

			var inpfld = document.createElement("INPUT");
			inpfld.type = "hidden";
			inpfld.name = "clg";
			inpfld.value = clg;
			form.appendChild(inpfld);

			form.submit();
		}
	
	</script>
</head>

<body>

	<center>

		<form id= 'login' action= '' method= 'post'>
		</form>
	
	<%
		String uname = request.getParameter("uname");
		String pswd  = request.getParameter("pswd");

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		int loggedin = 0;
		String redirectURL = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT * FROM logins WHERE user_name = '" + uname + "'");
		while(rs.next())
		{	
			loggedin = Integer.parseInt(rs.getString("special"));
				
			switch(loggedin)
			{
				case 1: redirectURL = "player.jsp"; break;
				case 2: redirectURL = "clg_head.jsp"; break;
				case 3: redirectURL = "admin.jsp"; break;
			}
			
			break;
		}

		if(loggedin > 0)
		{
			session.setAttribute("userName", uname);

			out.println("<script type= 'text/javascript'> "
				+ "form_submission('" + redirectURL + "', '" + rs.getString("college") + "');"
				+ " </script>");
			
			// response.sendRedirect(redirectURL + "?clg=" + rs.getString("college").toString());
		}

	%>

		Login Failed !!
		<br>

		<br> <a href= "login.jsp"> Retry </a>
		<br> <a href= "index.html"> Home </a>

	</center>

</body>

</html>