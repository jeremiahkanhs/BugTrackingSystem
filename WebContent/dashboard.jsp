<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.PreparedStatement, java.sql.Connection, java.sql.ResultSet, DAO.UserDAO, Model.Role, Model.User, Service.UserDAOImpl, Utilities.MyConnectionProvider" %>

<%
	int sessionVal = 0;
	UserDAO ud = new UserDAOImpl();
	if (session.getAttribute("roleId") != null)
		sessionVal = (Integer) session.getAttribute("roleId");
	else {
		request.setAttribute("errorMessage", "You do not have access");
		request.getRequestDispatcher("login.jsp").forward(request, response);
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(document).ready( function () {
	    $('#user_table').DataTable();
	    $('#assignee_table').DataTable();
	    $('#triager_table').DataTable();
	    $( "#tabs" ).tabs();
	} );
</script>

</head>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.js"></script>
<body>
	<div id="tabs">
		<ul>
			<%if((Integer) session.getAttribute("roleId") == 193){ %>
		   	<li><a href="#tabs-1">Triager - Unassigned</a></li>
		   	<%} %>
		   <li><a href="#tabs-2">Assigned to Me</a></li>
		   <li><a href="#tabs-3">All Bugs</a></li>
		</ul>
		<%if((Integer) session.getAttribute("roleId") == 193){ %>
		<div id = "tabs-1">
		<table id = "triager_table">
			<h3 style="text-align:center">Triager - Unassigned</h3>
			<thead>
				<tr>
					<th>Bug ID </th>
					<th>Bug Title </th>
					<th>Assigner </th>
					<th>Assignee </th>
					<th>Bug Severity </th>
					<th>Bug Status </th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					int bugId;
					try {
						Connection con = MyConnectionProvider.getCon();
						PreparedStatement ps = con.prepareStatement("select * from bugs where user_assignee_id = 9999");
						ResultSet rs = ps.executeQuery();
						while (rs.next()) {
							bugId = rs.getInt(1);
				%>
				
				<tr>
					<td id="bugID<%=bugId%>"><%=rs.getInt(1)%></td>
					<td id="bugTitle<%=bugId%>"><%=rs.getString(4)%></td>
					<td id="bugAssigner<%=bugId%>"><%=ud.getUser(rs.getInt(2)).getFirstName()%> <%=ud.getUser(rs.getInt(2)).getLastName()%></td>
					<td id="bugAssignee<%=bugId%>">Unassigned</td>
					<td id="bugSeverity<%=bugId%>"><%=rs.getInt(6)%></td>
					<td id="bugStatus<%=bugId%>"><%=rs.getString(7)%></td>
					<td>
						<a href="<%=request.getContextPath()%>/BugManagement?roleId=<%=session.getAttribute("roleId")%>&bugId=<%=bugId%>">
							<button type="button" class="editUser" id="button<%=bugId%>">View</button>
						</a>
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
		</div>
		<%
		} 
		%>
		
		<div id="tabs-2">
		<table id = "assignee_table">
		<h3 style="text-align:center">Assigned to me</h3>
		<thead>
			<tr>
				<th>Bug ID </th>
				<th>Bug Title </th>
				<th>Assigner </th>
				<th>Assignee </th>
				<th>Bug Severity </th>
				<th>Bug Status </th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<%
				int bugId1;
				try {
					Connection con = MyConnectionProvider.getCon();
					PreparedStatement ps = con.prepareStatement("select * from bugs where user_assignee_id = ?");
					ps.setInt(1, (Integer) session.getAttribute("userId"));
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						bugId1 = rs.getInt(1);
			%>
			
			<tr>
				<td id="bugID<%=bugId1%>"><%=rs.getInt(1)%></td>
				<td id="bugTitle<%=bugId1%>"><%=rs.getString(4)%></td>
				<td id="bugAssigner<%=bugId1%>"><%=ud.getUser(rs.getInt(2)).getFirstName()%> <%=ud.getUser(rs.getInt(2)).getLastName()%></td>
				<td id="bugAssignee<%=bugId1%>"><%=ud.getUser(rs.getInt(3)).getFirstName()%> <%=ud.getUser(rs.getInt(3)).getLastName()%></td>
				<td id="bugSeverity<%=bugId1%>"><%=rs.getInt(6)%></td>
				<td id="bugStatus<%=bugId1%>"><%=rs.getString(7)%></td>
				<td>
					<a href="<%=request.getContextPath()%>/BugManagement?roleId=<%=session.getAttribute("roleId")%>&bugId=<%=bugId1%>">
						<button type="button" class="editUser" id="button<%=bugId1%>">View</button>
					</a>
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
		</div>
		
		
		<div id="tabs-3">
		<table id = "user_table">
		<h3 style="text-align:center">All Incidents</h3>
		<thead>
			<tr>
				<th>Bug ID </th>
				<th>Bug Title </th>
				<th>Assigner </th>
				<th>Assignee </th>
				<th>Bug Severity </th>
				<th>Bug Status </th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<%
				int bugId2;
				try {
					Connection con = MyConnectionProvider.getCon();
					PreparedStatement ps = con.prepareStatement("select * from bugs");
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						bugId2 = rs.getInt(1);
			%>
			
			<tr>
				<td id="bugID<%=bugId2%>"><%=rs.getInt(1)%></td>
				<td id="bugTitle<%=bugId2%>"><%=rs.getString(4)%></td>
				<td id="bugAssigner<%=bugId2%>"><%=ud.getUser(rs.getInt(2)).getFirstName()%> <%=ud.getUser(rs.getInt(2)).getLastName()%></td>
				<% if (rs.getInt(3) != 9999){%>
				<td id="bugAssignee<%=bugId2%>"><%=ud.getUser(rs.getInt(3)).getFirstName()%> <%=ud.getUser(rs.getInt(3)).getLastName()%></td>
				<%}else { %>
				<td id="bugAssignee<%=bugId2%>">Unassigned</td>
				<%} %>
				<td id="bugSeverity<%=bugId2%>"><%=rs.getInt(6)%></td>
				<td id="bugStatus<%=bugId2%>"><%=rs.getString(7)%></td>
				<td>
					<a href="<%=request.getContextPath()%>/BugManagement?roleId=<%=session.getAttribute("roleId")%>&bugId=<%=bugId2%>">
						<button type="button" class="editUser" id="button<%=bugId2%>">View</button>
					</a>
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
		</div>
	</div>
		
	
</body>
</html>