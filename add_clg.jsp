<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>

	<title> Adding College </title>

	<script type= "text/javascript">
		
	<%
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		String uname = request.getParameter("uname");
		String clg = request.getParameter("clg");

		if(uname != null)
		{
			String query;
		
			query = "INSERT INTO logins VALUES ( "
				+ "'" + uname + "', "
				+ "'" + clg + "', " 
				+ "2"
				+ ")";

			stmt = con.createStatement();
			stmt.executeUpdate(query);

			query = "CREATE TABLE IF NOT EXISTS finalized( "
				+ "sport_key varchar(20) NOT NULL REFERENCES categories.sport_key)";

			stmt = con.createStatement();
			stmt.executeUpdate(query);

			query = "ALTER TABLE finalized ADD COLUMN "
				+ "`" + clg + "` "
				+ "int(2) NOT NULL DEFAULT 0";

			stmt = con.createStatement();
			stmt.executeUpdate(query);

			out.println("alert('College " + clg + " Added !!');");
		}
		
	%>

	</script>

</head>

<body>

	<center>

		<form action= "#" method= "post">
			
			User Name: &nbsp <input type= "text" name= "uname"> <br>
			College: &nbsp <input type= "text" name= "clg"> <br>

			<br>
			<input type= "submit" name= "submit" value= "Add">
		
		</form>

		<br> <br> <a href= "admin.jsp"> Back To Home </a>

	</center>
</body>

</html>