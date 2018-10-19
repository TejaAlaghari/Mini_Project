<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html>

<head>
	<title> Add New Sport </title>

	<%
		if(session.getAttribute("userName") == null) {
	%>
			<script type= "text/javascript"> window.location.href = 'index.html'; </script>
	<%
		}
	%>

	<%
		Connection con = null;  
		Statement stmt = null;
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		int res = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");
	%>

	<script type="text/javascript">
		var pr_row_cnt = 0;

		function addSubs()
		{
	    	var number = document.getElementById("subs").value;

	    	if(number == 0 || number == pr_row_cnt)
	    		return;

		    var categories;

		    if(pr_row_cnt == 0)
	    	{
	    		var cat = document.getElementById("cat");

	    		categories = document.createElement("th");
	    		categories.innerHTML = "Category";

	    		cat.appendChild(categories);

	    		var ele = document.getElementById("tr0");
	    		ele.parentNode.removeChild(ele);
	    		
	    	}

		    var here = document.getElementById("here");

		    var str = "";
		    while(pr_row_cnt < number)
		    {
		    	categories = document.createElement("tr");
		    	categories.id = "tr" + ++pr_row_cnt;

		    	str += '<td> <input type= "text" name= "Players_in_cat ' + pr_row_cnt + '" value= "1"> </td>';
		    	str += '<td> <input type= "text" name= "Rounds ' + pr_row_cnt + '" value= "1"> </td>';
		    	str += '<td> <input type= "text" name= "Days ' + pr_row_cnt + '" value= "1"> </td>';
		    	str += '<td> <input type= "text" name= "Price ' + pr_row_cnt + '" value= "0"> </td>';

				str += '<td> <input type= "radio" name= "Location ' + pr_row_cnt + '" value= "1"> In City </input> \
						<br /> \
  						<input type= "radio" name= "Location ' + pr_row_cnt + '" value= "0"> Out Of City </input>';
				
				str += '<td> <input type= "text" name= "Category ' + pr_row_cnt + '"> </td>';
		    	
		    	categories.innerHTML = str;
		    	here.appendChild(categories);
		    }

		    while(pr_row_cnt > number)
		    {
		    	ele = document.getElementById("tr" + pr_row_cnt);
		    	ele.parentNode.removeChild(ele);

		    	pr_row_cnt--;
		    }
		}

		function fill_extra(select_ele)
		{
			var ele;
			var extra = document.getElementById("extra");

			if(select_ele.options[select_ele.selectedIndex].value === "Other")
			{
				ele = document.createElement("LABEL");
				ele.innerHTML = "Required:*";
				extra.appendChild(ele);

				extra.innerHTML += "&nbsp;";
				
				ele = document.createElement("INPUT");
				ele.type = "text";
				ele.name = "theme_new";
				ele.value = "";
				ele.required = true;

				extra.appendChild(ele);
			}
			else 
				extra.innerHTML = "";
		}
	</script>

</head>

<body>
	<form action= "add_sport_trgt.jsp" method= "post">
	<center>
		<label> Theme: </label>
		<select name= "theme" onChange= "return fill_extra(this)">
			<%
				stmt = con.createStatement();
				rs = stmt.executeQuery("SELECT DISTINCT theme FROM sports");

				out.println("<option value= 'Open'> Open </option>");
				while(rs.next()) {
					if(!rs.getString("theme").equals("Open"))
						out.println("<option value= '" + rs.getString("theme") + "'> " + rs.getString("theme") + " </option>");
				}
				out.println("<option value= 'Other'> Other </option>");
			%>
		</select>
		
		<div id= "extra"> </div>

		<label> Sport: </label>
		<input type= "text" name= "sport">

		<br>
		<label> Sub Categories: </label>
		<input type= "text" id= "subs" name= "subs" value= "0"> &nbsp; &nbsp; 
		
		<button type= "button" onclick= "addSubs()"> + </button> 

		<br />
		<br />
		<table border="1" cellpadding= "5" width= "100%">
			<tbody id= "here">
			<tr id= "cat">
				<th> Players </th>
				<th> Rounds </th>
				<th> Days </th>
				<th> Price </th>
				<th> Location </th>
			</tr>
			<tr id= "tr0">
				<td> <input type= "text" name= "players" value= "1"> </td>

				<td> <input type= "text" name= "rounds" value= "1"> </td>
					
				<td> <input type= "text" name= "days" value= "1"> </td>

				<td> <input type= "text" name= "price" value= "0"> </td>

				<td>
					<input type= "radio" name= "location" value= "1"> In City 
					<br />
  					<input type= "radio" name= "location" value= "0"> Out Of City 
  					<br />
  				</td>
			</tr>
			</tbody>
		</table>

		<br>
		<label> Info(any): </label>
		<textarea rows= "5" cols= "32">  </textarea>

		<br>
		<input type= "submit" name= "submit" value= "Proceed">
	</center>
	</form>
</body>

</html>