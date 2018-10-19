<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>

	<title> Remove College </title>

	<%
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		String[] selectedClgs = request.getParameterValues("clgs");
		String query;
	%>

	<script type= "text/javascript">
		
		var clg = new Array();

	<%
		if(selectedClgs != null)
		{
			for(int i = 0; i < selectedClgs.length; i++)
			{
				query = "DELETE FROM logins WHERE college = '" + selectedClgs[i] + "'";

				stmt = con.createStatement();
				stmt.executeUpdate(query);

				query = "ALTER TABLE finalized DROP COLUMN " + selectedClgs[i];

				stmt = con.createStatement();
				stmt.executeUpdate(query);

				out.println("alert('College " + selectedClgs[i] + " Deleted !!');");
			}
		}

		query = "SELECT DISTINCT college FROM logins WHERE college <> 'null'";
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);

		int i = 0;
		while(rs.next())
			out.println("clg[" + i++ + "] = '" + rs.getString(1) + "'");
	%>

	function add_chkbxs()
	{
		var chkbx, label;

		for(var i = 0; i < Number(<%= i %>); i++)
		{
			label = document.createElement("LABEL");

			chkbx = document.createElement("INPUT");
			chkbx.type = "checkbox";
			chkbx.name = "clgs";
			chkbx.value = clg[i];

			label.appendChild(chkbx);
			label.appendChild(document.createTextNode(clg[i]));


			document.forms[0].appendChild(document.createElement("BR"));
			document.forms[0].appendChild(label);
		}
	}
	
	</script>

</head>

<body>
	
	<center>

		<p> Select Colleges To Remove </p>
		
		<form action= "#" method = "post">

			<script type= "text/javascript">
				add_chkbxs();
			</script>

		<br> <br> <input type= "submit" name= "submit" value= "submit">
		</form>
	
		<br> <br> <a href= "admin.jsp"> Back To Home </a>

	</center>

</body>

</html>