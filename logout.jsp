<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> Logout </title>

	<%
		session.removeAttribute("userName");
	%>
	<script type="text/javascript">
		window.location.href = "index.html";
	</script>
</head>

<body>

</body>

</html>