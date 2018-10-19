<!DOCTYPE html>

<html>

<head>
	<title> College Admin Dashboard </title>

</head>

<body>
	<center>

		<a href= "confirm_frame.jsp" >  </a>
		<br>

		<%
			out.println("<a href= 'confirm_stu_target.jsp?view=1&clg=" + request.getParameter("clg") + "'> View Players </a> <br>");
			out.println("<a href= 'confirm_stu_target.jsp?view=0&clg=" + request.getParameter("clg") + "'> Confirm Students </a> <br>"); 
		%>
		<br>

	</center>
</body>

</html>
