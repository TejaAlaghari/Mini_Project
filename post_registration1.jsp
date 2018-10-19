<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html>

<head>
	<title> Registration </title>

	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		$(document).ready(function(){

	         $(".mySelect").on("focus click",function () {
	             
	            $(this).data("prev", this.value);

	        });

		});
	</script>

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

		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT COUNT(*) FROM sports where subs = 0");

		if(rs.next())
			count += Integer.parseInt(rs.getString(1));
	%>

	<script type = "text/javascript">

		var games = new Array();

		for(var ind = 0; ind <= Number("<%= count %>") + 1; ind++)
			games[ind] = new Array();

	</script>

	<%
		//String[][] s_games = new String[count + 1][3];

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

		stmt = con.createStatement();
		rs = stmt.executeQuery("SELECT name FROM sports where subs = 0 ORDER BY name");

		while(rs.next())
		{
			out.println("games[" + i + "][0] = '" + rs.getString(1) + "'");
			out.println("games[" + i + "][1] = 'None'");
			out.println("games[" + i + "][2] = '1'");

			i++;
		}

		out.println("</script>");

	%>

</head>

<body>

	<script type = "text/javascript">

		var count = Number("<%= count %>");

		var here = document.getElementById("here");

		function create_select(game, ind)
		{
			var select = document.createElement("SELECT");
			var option;
			var dummy;

		    select.setAttribute("id", game);
		    if(ind == 0)
		    	select.setAttribute("onchange", "change_gam(this)");
		    else
		    	select.setAttribute("onchange", "change_cat(this)");

		    select.setAttribute("class", "mySelect");

		    document.getElementById("here").appendChild(select);


		    for(var i = 0; i <= count; i++) 
		    {
		    	if(games[i][2] === "1")
				{
				    option = document.createElement("option");
					    
				    option.setAttribute("value", games[i][ind]);
				    var name = document.createTextNode(games[i][ind]);
					    
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

		    for (var i=0;i<tmpAry.length;i++) 
		    {
		        var op = new Option(tmpAry[i][0], tmpAry[i][1]);
		        selElem.options[i] = op;
		    }

		    selElem.value = selected;
		    
		    return;
		}

		function sortFunction(a, b) 
		{

		    if (a[0] === b[0]) 
		    {
		    	if (a[1] === b[1]) 
		    	{
		    		return 0;
		    	}

		    	return (a[1] < b[1]) ? -1 : 1;
		    }
		    else 
		    {
		        return (a[0] < b[0]) ? -1 : 1;
		    }
		}

		function show_unique(ele)
		{
			var Target=document.forms[0][ele];
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

		function change_gam(ele) 
		{
			var Target = document.getElementById("cat" + ele.id.substring(3));

			var index = 1;
			var last_changed = -1;

			var value = "";

			var pre_gam = $(ele).data("prev");

			alert("Pre_gam: " + pre_gam);

			for(var i = 0; i <= count; i++) 
		    {
		    	if(games[i][2] === "1")
				{
				    option = document.createElement("option");
					    
				    option.setAttribute("value", games[i][1]);
				    var name = document.createTextNode(games[i][1]);
					    
				    option.appendChild(name);

				    Target.appendChild(option);
				}
			}

			show_unique("cat" + ele.id.substring(3));

			sortSelect(Target);

			while(index <= count)
			{
				if(games[index][0] === ele.value && games[index][2] === "1")
				{

					//alert("Searching for: " + games[index][1]);

					for(var i = last_changed + 1; i < Target.options.length; i++)
					{
						//alert(i + " came in");

						value = Target.options[i].value;

						//alert(value + " is in focus");

						last_changed = i;

						if(value == null || value === games[index][1])
							break;

						//Target.options[i].value = null;
						Target.remove(i--);

						alert(value + " is removed");
					}

				}

				index++;
			}

			last_changed++;

			//alert("Clean Out: " + Target.options.length + " Last Changed: " + last_changed);

			while(last_changed < Target.options.length)
			{

				//alert("Remaining: " + last_changed + " Value: " + Target.options[last_changed].value);

				Target.remove(last_changed);

				last_changed++;
			}

			searchEles = document.getElementById("here").children;

			for(var i = 0; i < searchEles.length; i++) 
			{
			    if(searchEles[i].tagName == "SELECT")
			    {
			        if(searchEles[i].id.indexOf("gam") == 0 && searchEles[i].id !== ele.id) 
			        {
			            option = document.createElement("option");
				    
					    option.setAttribute("value", pre_gam);
					    var name = document.createTextNode(pre_gam);
						    
					    option.appendChild(name);

					    searchEles[i].appendChild(option);

					    sortSelect(searchEles[i]);
			        }
			    }
			}

		}

		function change_cat(ele)
		{
			var searchEles = document.getElementById("here").children;
			var Target = document.getElementById("gam" + ele.id.substring(3));
			
			var option;

			var index = 1;

			var pre_gam = $(Target).data("prev");
			var pre_cat = $(ele).data("prev");

			while(index <= count)
			{
				if(games[index][0] === Target.value && games[index][1] === ele.value)
				{
					alert("Blocked: " + games[index][0] + ", " + games[index][1]);
					games[index][2] = "0";
				}

				if(games[index][0] === pre_gam && games[index][1] === pre_cat)
					games[index][2] = "1";

				index++;
			}

			for(var i = 0; i < searchEles.length; i++) 
			{
			    if(searchEles[i].tagName == "SELECT")
			    {
			        if(searchEles[i].id.indexOf("cat") == 0  && searchEles[i].id.indexOf("cat") !== ele.id  && document.getElementById("gam" + searchEles[i].id.substring(3)).value === Target.value) 
			        {
			            option = document.createElement("option");
				    
					    option.setAttribute("value", pre_cat);
					    var name = document.createTextNode(pre_cat);
						    
					    option.appendChild(name);

					    document.getElementById(searchEles[i]).appendChild(option);

					    sortSelect(searchEles[i]);
			        }
			    }
			}

		}

		function create_button(name, no)
		{
			var button;
			var txtNode;

			var fnctn = "_game(this)";
			var id;

			if(name === "X")
				id = "purge";
			else
				id = "add";

			fnctn = id + fnctn;

			button = document.createElement("BUTTON");
				
			txtNode = document.createTextNode(name);
			button.appendChild(txtNode);
				
			button.setAttribute("type", "button");

			button.setAttribute("id", id + no);

			button.setAttribute("onclick", fnctn);

			return(button);
		}

		function add_game(add)
		{
			var here = document.getElementById("here");
			var searchEles = here.children;

			var button;

			add.parentNode.removeChild(add);

			if(searchEles.length == 4)
			{
				button = create_button("X");
				here.appendChild(button);
			}

			var no = (searchEles.length / 4) + 1;

			var br = document.createElement("BR");
			br.setAttribute("id", "br" + no);
			here.appendChild(br);

			create_select("gam" + no, 0);
			create_select("cat" + no, 1);

			show_unique("gam" + no);
			show_unique("cat" + no);

			button = create_button("X", no);
			here.appendChild(button);

			button = create_button("+", no);
			here.appendChild(button);

		}

		function purge_game(purge)
		{
			var searchEles = document.getElementById("here").children;;

			var id = purge.id.substring(5);
			var ele, i;

			for(i = 0; i < searchEles.length; i++) 
			{
			    if(searchEles[i].tagName == "SELECT")
			        if(searchEles[i].id === "br" + id) 
			        	break;
			}

			ele = document.getElementById("br" + id);
			ele.parentNode.removeChild(ele);

			ele = document.getElementById("gam" + id);
			ele.parentNode.removeChild(ele);

			ele = document.getElementById("cat" + id);
			ele.parentNode.removeChild(ele);

			ele = document.getElementById("purge" + id);
			ele.parentNode.removeChild(ele);

			ele = document.getElementById("add" + id);
			if(ele != null)
			{
				ele.parentNode.removeChild(ele);

				var targetId = searchEles[i - 1].id.substring(5);

				create_button("+",  targetId);
			}

			searchEles = document.getElementById("here").children;

			if(searchEles.length == 5)
			{
				ele = document.getElementById(searchEles[i - 2].id);
				ele.parentNode.removeChild(ele);
			}

		}

	</script>
	
	<center>

		<p id= "insert"> </p>

		<form action= "#" method= "post">
		
		<div id= "here">

			<br id= "br1">

			<script type="text/javascript">

				create_select("gam1", 0);
				create_select("cat1", 1);

				show_unique("gam1"); 
				show_unique("cat1");

			</script>

			<button type= "button" id= "add1" onclick= "add_game(this)"> + </button>

		</div>
	
		</form>
	</center>

</body>

</html>