<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> My Games </title>

	<%
		String uname = session.getAttribute("userName").toString();

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");
	%>
</head>

<body>
	<center>
		<%
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT game, category FROM player where user_name = '" + uname + "'");
			while(rs.next())
			{
				out.println("<form action= 'process.jsp' method= 'post'>");
				out.println("<input type= 'hidden' name= 'gname' value= '" + rs.getString("game") + "'>");
				out.println("<input type= 'hidden' name= 'cname' value= '" + rs.getString("category") + "'>");

				out.println("<input type= 'submit' name= 'submit' value= '" + rs.getString("game") + " - " + rs.getString("category") + "'>");
				out.println("</form>");

				out.println("<br>");
			}
		%>

		<br> <a href= "player.jsp"> Dashboard </a>
	</center>
</body>

</html>