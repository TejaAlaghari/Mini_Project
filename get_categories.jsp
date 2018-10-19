<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>

<%	
	Connection con = null;  
	Statement stmt = null;
	PreparedStatement prepStmt = null;
	ResultSet rs = null;
	int res = 0;

	Class.forName("com.mysql.jdbc.Driver"); 
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

	String game = request.getParameter("game");

	stmt = con.createStatement();
	rs = stmt.executeQuery("SELECT category, players, rounds, days, price, location FROM categories WHERE sport = '" + game + "'");
	
	while(rs.next()) {
		out.println("<tr>");

		for(int iter = 1; iter <= 5; iter++)
			out.println("<td> " + rs.getString(iter) + " </td>");
		if(rs.getInt(6) == 1)
			out.println("<td> Local </td>");
		else
			out.println("<td> Non-Local </td>");

		out.println("</tr>");
	}
	
%>