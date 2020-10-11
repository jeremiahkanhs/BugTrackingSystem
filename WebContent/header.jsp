<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<style>
#tableDes table {
    font-size:16px;
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    border-spacing: 0;
    width: 100%;
}

#tableDes td,  th {
    border: 1px solid #ddd;
    text-align: left;
    padding: 8px;
}

#tableDes tr:nth-child(even){background-color: #f2f2f2}

#tableDes th {
    padding-top: 11px;
    padding-bottom: 11px;
    background-color: #1a284d;
    color: white;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


<script>

/* $("#logout").click(function logout(e) {
	e.preventDefault();
	$.ajax({
		   type:'POST',
		   url :"logout",
		   success: function() {
			   window.location.href("login.jsp");
		   },
		   error:function(exception){alert('Exeption:'+exception);}
		});
	return false;
} */
</script>
<style>
	.navDiv{text-align:right}
	.navUL {list-style-type:none; margin:0; padding:0;}
	li {display:inline-block; padding: 20px;}
</style>

<div class="navDiv">
	<ul class="navUL">
		<%try{if(session.getAttribute("roleId").toString().equals("191")) {%><li><a href="adminpanel.jsp">Admin Panel</a></li><%}}catch (Exception e){} %>
		<%try{if(session.getAttribute("roleId") != null) {%><li><a href="logout.jsp" id="logout">LogOut</a></li><%}}catch (Exception e){} %>
		
	</ul>
</div>
<div style="margin: auto; text-align: center;">
		<img src="uowlogo.png" />
	</div>

</html>