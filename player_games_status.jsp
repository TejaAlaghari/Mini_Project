<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> Status </title>

	<%
		String uname = session.getAttribute("userName").toString();

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		String query = "";

		query += "SELECT p.game, p.category, p.team, c.players, p.payment FROM player p, categories c ";
		query += "WHERE p.user_name = '" + uname + "' ";
		query += "AND p.sport = c.sport ";
		query += "AND p.category = c.category ";

		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
	%>

</head>

<body>
	<table width= "50%" align= "center">
		<tr>
			<th> Game </th>
			<th> Category </th>

		</tr>
	</table>
</body>

</html>