<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	
	<%
		String uname = session.getAttribute("userName").toString();
		
		String gname = request.getParameter("gname");
		String cname = request.getParameter("cname");
		String tname = request.getParameter("tname");

		out.println("<title> " + tname + " </title>");

		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		String query;
		int mem_cnt = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		String configure = request.getParameter("configure");
		if(configure != null)
		{
			query = "";
			
			query += "UPDATE player SET team = '" + tname + "' ";
			
			if(configure.equals("create"))
				query += ", admin = 1 ";
			
			query += "WHERE user_name = '" + uname + "' ";
			query += "AND game = '" + gname + "' ";
			query += "AND category = '" + cname + "'";
			
			stmt = con.createStatement();
			stmt.execute(query);
		}
	%>
</head>

<body>
	<center>
		<table align= "center" border id= "members" width= "50%">
			<tr> 
				<th> First Name </th> 
				<th> Last Name </th> 
				<th> Payment </th>
			</tr>

			<%
				query = "";

				query += "SELECT m.first_name, m.last_name, p.admin, p.payment FROM members m, player p ";
				query += "WHERE p.team = '" + tname + "' ";
				query += "AND game = '" + gname + "' ";
				query += "AND category = '" + cname + "' ";
				query += "AND p.user_name = m.user_name ";
				query += "ORDER BY p.admin DESC";

				stmt = con.createStatement();
				rs = stmt.executeQuery(query);
				
				String row;
				while(rs.next())
				{
					row = "";

					row += "<tr>";
					row += "<td align= 'center'> " + rs.getString("first_name") + "</td>";
					row += "<td align= 'center'> " + rs.getString("last_name") + "</td>";
					if(rs.getInt("payment") == 1)
						row += "<td align= 'center'> Done </td>";
					else
					{
						mem_cnt++;
						row += "<td align= 'center'> Pending </td>";
					}
					row += "</tr>";

					out.println(row);
				}
			%>
		</table>

		<%			
			query = "";
			query += "SELECT players, price FROM categories ";
			query += "WHERE sport = '" + gname + "' ";
			query += "AND category = '" + cname + "'";

			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				if(rs.getInt("players") == mem_cnt)
				{
					out.println("<form action= 'payments.jsp' method= 'post'>");
					
					out.println("<input type= 'hidden' name= 'price' value= '" + rs.getInt("price") + "'>");
					out.println("<input type= 'hidden' name= 'gname' value= '" + gname + "'>");
					out.println("<input type= 'hidden' name= 'cname' value= '" + cname + "'>");

					// out.println("<input type= 'hidden' name= 'tname' value= '" + tname + "'>");
					session.setAttribute("paying_team", tname);
					
					out.println("<br> <input type= 'submit' name= 'submit' value= 'Pay'>");
					out.println("</form>");

					out.println("<br>");
				}
				else if(mem_cnt == 0)
					out.println("<br> <br> <p> *Team registration is complete </p>");
				else
					out.println("<br> <br> <p> *Pay option is available after all members are registerd ! </p>");
			}
		%>

		<br> <br> <a href= 'player.jsp'> Dashboard </a> 
	</center>
</body>

</html>