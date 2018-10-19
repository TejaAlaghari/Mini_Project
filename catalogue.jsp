<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>

<html>

<head>
	<title> Games Catalogue </title>

	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>

	<%
		Connection con = null;  
		Statement stmt = null;
		PreparedStatement prepStmt = null;
		ResultSet rs = null, rs2 = null;
		int res = 0;

		String query;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");
	%>

	<script type= "text/javascript">

		$(document).ready(function() {
		    $.fn.get_catq = function(game_btn) { 

		        var div = document.getElementById("cat_div");
				var table = document.getElementById("cat_table");
				var ele;
				var iter = 1;
				var output = "";

				if(table == null) {
					table = document.createElement("TABLE");
					table.id = "cat_table";
					table.border = true;

					ele = document.createElement("TR");
					ele.innerHTML += "\
						<th> Category </th> \
						<th> Players </th> \
						<th> Rounds </th> \
						<th> Days </th> \
						<th> Price </th> \
						<th> Location </th> \
					";

					table.appendChild(ele);

					ele = document.createElement("TBODY");
					ele.id = "cat_tbody";
					table.appendChild(ele);

					div.appendChild(table);
				}
				else 
					document.getElementById("cat_tbody").innerHTML = "";


				/*
				$.ajax({
					type:    "POST",
					url:     "get_categories.jsp",
					cache: false, 
					async: false, 
					data:    "game=" + game_btn.value,
					success: function(data){
						alert(data);
					}
				}); 
				*/

				$.post('get_categories.jsp', {  cache: false, aync: false, game:  game_btn.value}, function(data){
			    	if(data) {
			        	document.getElementById("cat_tbody").innerHTML = data // response from your server
			    	}
				});
			}

		    $(".call-btn").click(function(){
		        $.fn.get_catq(this);
		    });

		});

	</script>

</head>

<body>
	<center>
		<%
			query = "SELECT DISTINCT theme FROM sports";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				out.println("<h3> " + rs.getString("theme") + " </h3>");

				query = "SELECT name FROM sports WHERE theme = '" + rs.getString("theme") + "'";
				stmt = con.createStatement();
				rs2 = stmt.executeQuery(query);
				
				while(rs2.next()) {
					out.println("<ul>");
					out.println("<li> <button type= 'button' class= 'call-btn' value= '" + rs2.getString("name") + "'> " + rs2.getString("name") + " </button>  </li>");
					out.println("</ul>");
				}

				out.println("<br />");
			}
		%>

		<div id= "cat_div"> </div>
		<div id= "response"> </div>

	</center>
</body>

</html>