<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> Payment Confirmation </title>

	<%
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		String prd_name = request.getParameter("gname") + " " + request.getParameter("cname");
		int price = Integer.parseInt(request.getParameter("price"));
		double fee = 3 + (price * .02);
		double tax = fee * .15;
		double prd_price = fee + tax + price;
	%>
</head>

<body>
	<center>
		<h3> Your Payment Details </h3>

		<p> <b> Sport name : </b> <%= prd_name %> </p>
		<p> <b> Price : </b> <%= price %> </p>
		<p> <b> Bank Fee : </b> <%= tax + fee %> <small> (Rs:3 + 2% of fee + 15% Service Tax) </small> </p>

		<p> <b> Total : </b> <%= prd_price %> </p>

		<form action= "payment_gateway-master/pay.php" method= "post" accept-charset= "utf-8">
			<input type= "hidden" name= "product_name" value= "<%= prd_name %>"> 
			<input type= "hidden" name= "product_price" value= "<%= prd_price %>"> 

			<%
				stmt = con.createStatement();
				rs = stmt.executeQuery("SELECT first_name, last_name, phone_num, e_mail FROM members WHERE user_name = '" + session.getAttribute("userName") + "'");
				
				rs.next();

				String name = rs.getString("first_name").toString() + " " + rs.getString("last_name").toString();
				String phone = rs.getString("phone_num");
				String email = rs.getString("e_mail");
			%>

			<input type= "hidden" name= "name" value= "<%= name %>"> 
			<input type= "hidden" name= "phone" value= "<%= phone %>"> 
			<input type= "hidden" name= "email" value= "<%= email %>"> 

			<input type= "submit" name= "submit" value= "Click here to Pay Rs: <%= prd_price %> ">
		</form>
	</center>
</body>

</html>