<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html>

<head>
	<title> Adding Sport </title>
</head>

<body>

	<center>

	<%

		if(session.getAttribute("userName") == null)
			out.println("<script type= 'text/javascript'> window.location.href = 'index.html'; </script>");

		String sport = request.getParameter("sport");
		int sub_cats = Integer.parseInt(request.getParameter("subs"));
		String info = request.getParameter("info");

		String theme = request.getParameter("theme_new");
		if(theme == null)
			theme = request.getParameter("theme");

		sport = sport.charAt(0).toUpperCase() + sport.slice(1);
		theme = theme.charAt(0).toUpperCase() + theme.slice(1);

		Connection con = null;  
		Statement stmt = null;
		PreparedStatement prepStmt = null;
		int res = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		stmt = con.createStatement();
		stmt.execute("STRAT TRANSACTION");
		
		boolean failure = false;

		stmt = con.createStatement();
		stmt.executeUpdate("CREATE TABLE IF NOT EXISTS sports " + 
			"(" + 
			"name varchar(15) NOT NULL PRIMARY KEY, " + 
			"subs int(2) NOT NULL DEFAULT 0, " + 
			"info varchar(160)" + 
			"theme varchar(25) DEFAULT 'Open'" + 
			")");

		try
		{
			res = stmt.executeUpdate("INSERT INTO sports VALUES " + 
			"(" + 
			"'" + sport + "', " + 
			sub_cats + ", " + 
			"'" + info + "', " + 
			"'" + theme + "' " + 
			")");

			out.println("<br> " + sport + " is created !");

			res = 0;

			stmt = con.createStatement();
				stmt.executeUpdate("CREATE TABLE IF NOT EXISTS categories " + 
				"(" + 
				"sport varchar(15) NOT NULL, " +
				"category varchar(15) NOT NULL, " + 
				"players int(2) NOT NULL, " + 
				"rounds int(2) NOT NULL, " + 
				"days int(2) NOT NULL, " + 
				"sport_key varchar(10) NOT NULL, " + 
				"price int(6) NOT NULL, " + 
				"location int(1), " + 
				"PRIMARY KEY (sport, category)" + 
				")");

			String category, players, price, key;
			String rounds, days, location;
	
			for(int i = 1; i <= sub_cats; i++)
			{
				category = request.getParameter("Category " + i); 
				players = request.getParameter("Players_in_cat "+ i); 
				price = request.getParameter("Price "+ i); 
				rounds = request.getParameter("Rounds "+ i);
				days = request.getParameter("Days "+ i);
				location = request.getParameter("Location "+ i);
				key = sport.substring(0, 3) + "_" + category.substring(0, 4); 

				try
				{
					res = stmt.executeUpdate("INSERT INTO categories VALUES " + 
					"(" + 
					"'" + sport + "', " + 
					"'" + category + "', " + 
					players + ", " +  
					rounds + ", " +  
					days + ", " +  
					"'" + key + "', " + 
					price + ", " + 
					location + 
					")");

					out.println("<br> Sub category " + category + " is created !");
				}
				catch(Exception e)
				{
					out.println("<br> Error: Insertion of " + category + " of " + sport + " !");
					failure = true;
				}
			}

			if(sub_cats == 0)
			{
				price = request.getParameter("price");
				players = request.getParameter("players");
				rounds = request.getParameter("rounds");
				days = request.getParameter("days");
				location = request.getParameter("location");

				try
				{
					res = stmt.executeUpdate("INSERT INTO categories VALUES " + 
					"(" + 
					"'" + sport + "', " + 
					"'None', " + 
					players + ", " + 
					rounds + ", " +  
					days + ", " +
					"'" + sport.substring(0, 3) + "_None', " + 
					price + ", " + 
					location + 
					")");

					out.println("<br> With no sub category !");
				}
				catch(Exception e)
				{
					out.println("<br> Error: Insertion of " + sport + " into categories !");
					failure = true;
				}	
			}
		}
		catch(Exception e)
		{
			out.println("<br> Error: Insertion of " + sport + " ! <br> ");
			failure = true;
		}
		
		stmt = con.createStatement();
		if(failure)
			stmt.execute("ROLLBACK");
		else
			stmt.execute("COMMIT");
	%>
	
	<br> <br> 
	<br> <a href= "add_sport.jsp"> Add Other Game </a>
	<br> <a href= "index.html"> Home </a>
	</center>
</body>

</html>