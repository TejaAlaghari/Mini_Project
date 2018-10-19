<!DOCTYPE html>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.io.*" %> 

<html>

<head>
	<title> User Login </title>
</head>

<body>
	<center>
	
	<form action= "validate.jsp" method= "post">
		
		User Name: <input type= "text" name= "uname">
		<br>
		Password: <input type= "password" name= "pswd">
		<br>

		<input type= "submit" value= "submit">
		<br>

	</form>
	
	<br> <a href= "index.html"> Home </a>

	</center>
</body>

</html>