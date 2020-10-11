<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.PreparedStatement, java.sql.Connection, java.sql.ResultSet, DAO.UserDAO, Model.Role, Model.User, Service.UserDAOImpl, Utilities.MyConnectionProvider" %>

<%
	int sessionVal = 0;
	if (session.getAttribute("roleId") != null)
		sessionVal = (Integer) session.getAttribute("roleId");

	if (sessionVal != 191) {
		request.setAttribute("errorMessage", "You do not have admin access");
		request.getRequestDispatcher("home.jsp").forward(request, response);
	}
%>

<style>
td {
	max-width: 300px;
}

.hiddenContainer {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 800px; /* adjust as per your needs */
	height: 500px; /* adjust as per your needs */
	margin-left: -400px; /* negative half of width above */
	margin-top: -250px; /* negative half of height above */
	outline-style: solid;
	z-index: 9;
	background-color: white;
}

/* Add styles to the form container */
.hiddenForm {
	padding: 10px;
	margin: auto;
}

.hiddenForm td {
	padding-right: 10px;
	width: auto;
}
</style>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.js"></script>
<script>
	$(document).ready( function () {
	    $('#user_table').DataTable();
	} );
	
	function editUser(x) {
		document.getElementById("formID").style.display = "block";
		document.getElementById("input0").value = document.getElementById("userID"+x).innerHTML;
		document.getElementById("input1").value = document.getElementById("userName"+x).innerHTML;
		document.getElementById("input2").value = document.getElementById("firstName"+x).innerHTML;
		document.getElementById("input3").value = document.getElementById("lastName"+x).innerHTML;
		document.getElementById("input4").value = document.getElementById("emailAddress"+x).innerHTML;
		document.getElementById("input5").value = document.getElementById("roleDescription"+x).innerHTML;
	}
	
	function closeForm(){
		document.getElementById("formID").style.display = "none";
	}
</script>

</head>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.js"></script>
<body>

	<div id="formID" class="hiddenContainer" style="display: none">
		<form action='userAccount' method="post" class="hiddenForm">
			<h1 style="text-align: center;">Edit Event</h1>
			<table style="margin-left: auto; margin-right: auto;">
				<tr>
					<td>User ID :</td>
					<td><input id="input0" type="text" name="userID" readonly></td>
				</tr>
				
				<tr>
					<td>Username :</td>
					<td><input id="input1" type="text" name="userName" readonly></td>
				</tr>
				
				<tr>
					<td>First Name :</td>
					<td><input id="input2" type="text" name="firstName" ></td>
				</tr>
				
				<tr>
					<td>Last Name :</td>
					<td><input id="input3" type="text" name="lastName" ></td>
				</tr>
				
				<tr>
					<td>Email :</td>
					<td><input id="input4" type="text" name="emailAddress" ></td>
				</tr>
				
				<tr>
					<td>Role :</td>
					<td><select id="input5" name="userRole">
							<option value="System Administrator">System Administrator</option>
							<option value="Bug Reporter">Bug Reporter</option>
							<option value="Triager">Triager</option>
							<option value="Developer">Developer</option>
							<option value="Reviewer">Reviewer</option>
					</select></td>
				</tr>
				<tr>
					<td style="text-align: center;" colspan="3">
						<input  type="submit" name="submit" value="Edit">
						<input type="submit" name="submit" value="Delete">
						<button type="button" onClick="closeForm()">Close</button></td>
				</tr>
			</table>
		</form>
	</div>


	<table id = "user_table">
	<thead>
		<tr>
			<th>User ID </th>
			<th>Username </th>
			<th>First Name </th>
			<th>Last Name </th>
			<th>Email Address </th>
			<th>Role ID </th>
			<th>Role Name </th>
			<th>Role Description </th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<%
			int userNum;
			try {
				Connection con = MyConnectionProvider.getCon();
				PreparedStatement ps = con.prepareStatement("select * from users u inner join roles r on u.role_id = r.role_id");
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					userNum = rs.getInt(1);
		%>
		
		<tr>
			<td id="userID<%=userNum%>"><%=rs.getInt(1)%></td>
			<td id="userName<%=userNum%>"><%=rs.getString(2)%></td>
			<td id="firstName<%=userNum%>"><%=rs.getString(5)%></td>
			<td id="lastName<%=userNum%>"><%=rs.getString(6)%></td>
			<td id="emailAddress<%=userNum%>"><%=rs.getString(7)%></td>
			<td id="roleID<%=userNum%>"><%=rs.getString(4)%></td>
			<td id="roleName<%=userNum%>"><%=rs.getString(9)%></td>
			<td id="roleDescription<%=userNum%>"><%=rs.getString(10)%></td>
			<td><button type="button" class="editUser"
					id="button<%=userNum%>" onClick="editUser(<%=userNum%>)">Edit</button>
			</td>
		</tr>
		<%
			}
				con.close();
			} catch (Exception e) {
				System.out.println(e);
			}
		%>
		</tbody>
	</table>
	
	<input type="button" value="Registration" class="btn btn-info btn-block" onclick="location.href='register.jsp';">
		
	
</body>
</html>