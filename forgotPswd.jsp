<!DOCTYPE html>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.*" %>

<html>

<head>

	<title> Forgot Password </title>

	<%
		int sent = 0;
		sent = Integer.parseInt(request.getParameter("sent"));
	%>

</head>

<body>

<center>
	
	<%
		if(sent == 0)
			out.println("<form action= 'sendEmail.jsp' method= 'post'>"
			+ "<input type= 'email' name= 'email'>"
			+ "<br> <br> <input type= 'submit' value= 'Send Password'>"
			+ "</form>"
			+ ")"
			);
		else
			out.println("P");
	%>

</center>

</body>

</html>