<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html>

<head>
	<title> Registration </title>

	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<%
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData md = null;
		PreparedStatement prepStmt = null;
		int i = 0, count = 0;

		Class.forName("com.mysql.jdbc.Driver"); 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sports","testUser","testPswd");

		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT COUNT(*) FROM categories");

		if(rs.next())
			count = Integer.parseInt(rs.getString(1));
	%>

	<script type = "text/javascript">

		var count = Number("<%= count %>");
		var games = new Array();

		for(var ind = 0; ind <= count + 1; ind++)
			games[ind] = new Array();

	</script>

	<%
		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT sport, category FROM categories ORDER BY sport, category");

		out.println("<script type = 'text/javascript'>");

		out.println("games[" + i + "][0] = 'None'");
		out.println("games[" + i + "][1] = 'None'");
		out.println("games[" + i + "][2] = '1'");

		i++;

		while(rs.next())
		{
			out.println("games[" + i + "][0] = '" + rs.getString(1) + "'");
			out.println("games[" + i + "][1] = '" + rs.getString(2) + "'");
			out.println("games[" + i + "][2] = '1'");

			i++;
		}

		/*stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT name FROM sports where subs = 0 ORDER BY name");

		while(rs.next())
		{
			out.println("games[" + i + "][0] = '" + rs.getString(1) + "'");
			out.println("games[" + i + "][1] = 'None'");
			out.println("games[" + i + "][2] = '1'");

			i++;
		}*/

		out.println("</script>");

	%>

</head>

<body>

	<script type = "text/javascript">

		var no = 1;

		var here = document.getElementById("here");

		function create_select(game, ind)
		{
			var select;
			var option;
			var dummy;
			var element_tr, element_td;

			select = document.createElement("SELECT");
			element_td = document.createElement("TD");

		    select.setAttribute("id", game);
		    select.setAttribute("name", game);

		    if(ind == 0)
		    {
		    	select.setAttribute("onchange", "change_gam(this)");

		    	element_tr = document.createElement("TR");
		    	element_tr.setAttribute("id", "tr" + no);

		    	document.getElementById("here").appendChild(element_tr);

		    	element_td.setAttribute("id", "td" + no + "_" + 1);
		    }
		    else
		    {
		    	select.setAttribute("onchange", "change_cat(this)");

		    	element_td.setAttribute("id", "td" + no + "_" + 2);
		    }

		    element_td.setAttribute("align", "center");

		    select.setAttribute("onfocus", "$(this).data('prev', this.value);");

		    select.setAttribute("class", "mySelect");

		    document.getElementById("tr" + no).appendChild(element_td);

		    element_td.appendChild(select);


		    // Adding Default Option 
		    option = document.createElement("option");
					    
			option.setAttribute("value", "None");
			var name = document.createTextNode("None");
					    
			option.appendChild(name);

			document.getElementById(game).appendChild(option);

			game.selectedIndex = 0;

		    if(ind == 1)
		    	return;

		    for(var i = 1; i <= count; i++) 
		    {
		    	if(games[i][2] === "1")
				{
				    option = document.createElement("option");
					    
				    option.setAttribute("value", games[i][ind]);
				    name = document.createTextNode(games[i][ind]);
					    
				    option.appendChild(name);

				    document.getElementById(game).appendChild(option);
			    }
			}
		}

		function sortSelect(selElem) 
		{
		    var tmpAry = new Array();
		    var selected = selElem.value;
		    
		    for (var i = 0; i < selElem.options.length; i++) 
		    {
		        tmpAry[i] = new Array();
		        tmpAry[i][0] = selElem.options[i].text;
		        tmpAry[i][1] = selElem.options[i].value;
		    }
		    
		    tmpAry.sort();
		    
		    while (selElem.options.length > 0) {
		        selElem.options[0] = null;
		    }

		    for (var i = 0; i < tmpAry.length; i++) 
		    {
		        var op = new Option(tmpAry[i][0], tmpAry[i][1]);
		        selElem.options[i] = op;
		    }

		    selElem.value = selected;
		    
		    return;
		}

		function show_unique(ele)
		{
			var Target = document.forms[0][ele];
			var option = "";

			for(var i = 0; i < Target.options.length; i++)
			{
				option = Target.options[i].value;

				for(var j = i + 1; j < Target.options.length; j++)
				{
					if(Target.options[j].value === option)
						Target.remove(j--);
				}
			}
		}

		function update()
		{
			var searchPar = document.getElementById("here").children;
			var searchEles, ele;
			var gseleted = "";
			var cseleted = "";
			var option, name;

			var ind;

			for(var i = 0; i < searchPar.length; i++) 
			{

				ele = document.getElementById("gam" + searchPar[i].id.substring(2));

				if(ele != null)
				{
					ind = 0;
					gseleted = ele.value;

					var j = 0;
					while(++j < ele.options.length)
					{
						if(j == ele.selectedIndex)
							continue;

						ele.remove(j);
					}

					for(j = 1; j <= count; j++) 
		    		{
		    			if(games[j][2] === "1")
						{
						    option = document.createElement("option");
							    
						    option.setAttribute("value", games[j][ind]);
						    name = document.createTextNode(games[j][ind]);
							    
						    option.appendChild(name);

						    ele.appendChild(option);
			    		}
					}

					show_unique(ele.id);

					//searchEles[i].value = gseleted;
				}
				else
					continue;

				if(gseleted === "None")
					continue;

				ele = document.getElementById("cat" + searchPar[i].id.substring(2));

				//alert("i: " + i);

				if(ele != null)
				{
					ind = 1;
					cseleted = ele.value;

					var j = 0;
					while(++j < ele.options.length)
					{
						if(j == ele.selectedIndex)
							continue;

						ele.remove(j);
					}

					for(j = 1; j <= count; j++) 
		    		{
		    			if(games[j][0] === gseleted && games[j][2] === "1")
						{
						    option = document.createElement("option");
							    
						    option.setAttribute("value", games[j][ind]);
						    name = document.createTextNode(games[j][ind]);
							    
						    option.appendChild(name);

						    ele.appendChild(option);
			    		}
					}

					show_unique(ele.id);

					//searchEles[i].value = cseleted;
				}
			}
		}

		function change_gam(ele) 
		{
			var Target = document.getElementById("cat" + ele.id.substring(3));

			var index = 1;
			var last_changed = -1;

			var tvalue = Target.value;

			var pre_gam = $(ele).data("prev");

			// Adding New Options 
			while(Target.options.length != 1)
				Target.remove(index);

			for(var i = 1; i <= count; i++) 
		    {
		    	if(games[i][0] === ele.value && games[i][2] === "1")
				{
				    option = document.createElement("option");
					    
				    option.setAttribute("value", games[i][1]);
				    var name = document.createTextNode(games[i][1]);
					    
				    option.appendChild(name);

				    Target.appendChild(option);
				}
			}

			while(index <= count)
			{
				if(games[index][0] === pre_gam && games[index][1] === tvalue)
					games[index][2] = "1";

				if(games[index][0] === ele.value && games[index][1] === Target.value)
					games[index][2] = "0";

				index++;
			}

			update();

		}

		function change_cat(ele)
		{
			var Target = document.getElementById("gam" + ele.id.substring(3));
			
			var option;

			var index = 1;

			var pre_gam = $(Target).data("prev");
			var pre_cat = $(ele).data("prev");

			while(index <= count)
			{
				if(games[index][0] === Target.value && games[index][1] === ele.value)
				{
					//alert("Blocked: " + games[index][0] + ", " + games[index][1]);
					games[index][2] = "0";
				}

				if(games[index][0] === pre_gam && games[index][1] === pre_cat)
					games[index][2] = "1";

				index++;
			}

			update();

		}

		function create_button(name, no)
		{
			var button;
			var txtNode;
			var element_td;

			var fnctn = "_game(this)";
			var id;

			if(name === "x")
				id = "purge";
			else
				id = "add";

			fnctn = id + fnctn;

			button = document.createElement("BUTTON");
				
			txtNode = document.createTextNode(name);
			button.appendChild(txtNode);
				
			button.setAttribute("type", "button");

			button.setAttribute("id", id + no);

			button.setAttribute("name", id + no);

			button.setAttribute("onclick", fnctn);


			element_td = document.createElement("TD");
			if(name === "x")
				element_td.setAttribute("id", "td" + no + "_" + 3);
			else
				element_td.setAttribute("id", "td" + no + "_" + 4);

			element_td.setAttribute("align", "center");
			document.getElementById("tr" + no).appendChild(element_td);
			element_td.appendChild(button);

		}

		function add_game(add)
		{
			var here = document.getElementById("here");
			var searchEles = document.getElementById("here").children;

			var button;
			var i, id;

			for(i = 0; i < searchEles.length; i++)
			{
				id = searchEles[i].id.substring(2);

				if(id === add.id.substring(3))
					break;
			}

			searchEles[i].removeChild(document.getElementById("td" + id + "_" + 4));
			//add.parentNode.removeChild(add);


			if(searchEles[i].children.length == 2)
				create_button("x", parseInt(id));

			create_select("gam" + no, 0);
			create_select("cat" + no, 1);

			show_unique("gam" + no);
			show_unique("cat" + no);

			create_button("x", no);

			create_button("+", no);

			no++;

		}

		function purge_game(purge)
		{
			var here = document.getElementById("here");
			var searchEles = document.getElementById("here").children;

			var id = purge.id.substring(5);
			var ele_g, ele_c, i = 0;

			ele_g = document.getElementById("gam" + id);
			ele_c = document.getElementById("cat" + id);

			while(++i <= count)
				if(games[i][0] === ele_g.value && games[i][1] === ele_c.value)
					games[i][2] = "1";


			for(i = 0; i < searchEles.length; i++)
			{
				if(searchEles[i].id.substring(2) === id)
					break;
			}

			if(searchEles[i].children.length == 4)
				create_button("+", parseInt(searchEles[i - 1].id.substring(2)));

			here.removeChild(searchEles[i]);

			update();

			searchEles = document.getElementById("here").children;

			if(searchEles.length == 2) 
				searchEles[1].removeChild(document.getElementById("td" + searchEles[1].id.substring(2) + "_" + 3));



		}

		function fill_extra(selElem)
		{
			var ele;
			var extra = document.getElementById("extra");

			if(selElem.options[selElem.selectedIndex].value === "Other")
			{
				ele = document.createElement("LABEL");
				ele.innerHTML = "Required:*";
				extra.appendChild(ele);

				extra.innerHTML += "&nbsp;";

				ele = document.createElement("INPUT");
				ele.type = "text";
				ele.name = "clg_new";
				ele.value = "";
				ele.required = true;

				extra.appendChild(ele);
			}
			else 
				extra.innerHTML = "";
		}

	</script>
	
	<center>
		<p id= "insert"> </p>

		<form action= "add_members.jsp" method= "post">
		
		<table cellspacing= "5" cellpadding= "5" id= "here" align= "center">

		<tbody>
			<tr>
			<td> FirstName: <input type= "text" name= "fname"> &nbsp; &nbsp; 
			<td> LastName: <input type= "text" name= "lname"> 

			<tr>
			<td> E-Mail: <input type= "email" name= "email">

			<tr>
			<td> Mobile No: <input type= "number" name="phno">

			<tr>
			<td> D.O.B.: <input type= "date" name="bday" min="1996-01-01">

			<tr>
			<td> College: 
				<select name= "clg" onChange= "return fill_extra(this)">
				
				<%
					stmt = con.createStatement();
					rs = stmt.executeQuery("SELECT college FROM logins WHERE special = 2");

					while(rs.next()) 
						out.println("<option value= '" + rs.getString("college") + "'> " + rs.getString("college"));
					out.println("<option> Other </option>");
				%>
				
				</select>
				<div id= "extra"> </div>
			<tr>
			<td> Username: <input type= "text" name= "uname"> 

			<div >
			<tr>
			<td align= "center"> Game
			<td align= "center"> Category

			<script type="text/javascript">

				create_select("gam" + no, 0);
				create_select("cat" + no, 1);

				show_unique("gam1");
				show_unique("cat1");

				create_button("+", no);

				no++;

			</script>
			</td>

			<!-- <td id= "tr1_3"> <button type= "button" id= "add1" onclick= "add_game(this)"> + </button> -->

		</tbody>

		</table>
	
		<br> <br> 
		<input type= "submit" value= "submit">
		</form>
	</center>

</body>

</html>