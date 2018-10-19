<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> 
	<% 
		String gname = request.getParameter("gname");
		String cname = request.getParameter("cname");

		out.println(gname + ": " + cname); 
	%> 
	</title>
	<%
		String uname = session.getAttribute("userName").toString();

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null, rs2 = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");
	%>
</head>

<body>
	<h1> Info </h1>
	<center>
		<hr>
		<br> <br> <br>
		<p> Info about sport/event </p>
		<br> <br> <br>
		<hr>

		<%
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT team, payment FROM player WHERE user_name = '" + uname + "' AND game = '" + gname + "' AND category = '" + cname + "'");
			if(rs.next() && rs.getInt("payment") == 1)
			{
				out.println("<br> <p> Your team is successfully registered </p> <br> ");

				out.println("<form action= 'team.jsp' method= 'post'>");
				out.println("<input type= 'hidden' name= 'tname' value= '" + rs.getString("team") + "'>");
				out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
				out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

				out.println("<input type= 'submit' name= 'submit' value= 'Visit Team'>");
				out.println("</form>");	

				out.println("<br>");
			}
			else
			{
				stmt = con.createStatement();
				rs2 = stmt.executeQuery("SELECT players, price FROM categories WHERE sport = '" + gname + "' AND category = '" + cname + "'");
				if(rs2.next())
				{
					if(rs2.getInt("players") == 1)
					{
						out.println("<form action= 'payments.jsp' method= 'post'>");
						
						out.println("<input type= 'hidden' name= 'price' value= '" + rs2.getInt("price") + "'>");
						out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
						out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

						// out.println("<input type= 'hidden' name= 'tname' value= 'none'>");
						session.setAttribute("paying_team", "none");
						
						out.println("<input type= 'submit' name= 'submit' value= 'Pay'>");
						out.println("</form>");

						out.println("<br>");
					}
					else
					{
						if(rs.getString("team").equals("none"))
						{
							out.println("<form action= 'team.jsp' method= 'post'>");
							out.println("<input type= 'radio' name= 'configure' value= 'create'> Create </input> &nbsp; &nbsp;");
							out.println("<input type= 'radio' name= 'configure' value= 'join'> Join </input> <br>");

							out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
							out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

							out.println("<input type= 'text' name= 'tname'> <br> <br>");

							out.println("<input type= 'submit' name= 'submit' value= 'Submit Request'>");
						}
						else
						{
							out.println("<form action= 'team.jsp' method= 'post'>");
							out.println("<input type= 'hidden' name= 'tname' value= '" + rs.getString("team") + "'>");
							out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
							out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

							out.println("<input type= 'submit' name= 'submit' value= 'Visit Team'>");
							out.println("</form>");

							out.println("<br>");	
						}
					}
				}
			}
		%>
	</center>
</body>

</html>