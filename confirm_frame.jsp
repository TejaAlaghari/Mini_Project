<!DOCTYPE html>

<html>

<head>

	<title> Student Confirmation </title>

</head>

	<frameset rows="10%,*">
	  <% 

	  	String clg = request.getParameter("clg");
	  	String view = request.getParameter("view");

	  	out.println("<frame name= 'src'  src= 'confirm_students.jsp?view=" + view + "&clg="   + clg + "'>");
	  	
	  	// out.println("<frame name= 'trgt' src= 'view_players.jsp?clg=" + request.getParameter("clg") + "'>");

	  	out.println("<frame name= 'trgt' src= 'confirm_stu_target.jsp?clg=" + request.getParameter("clg") + "'>");

	  %>
	</frameset>

</html>