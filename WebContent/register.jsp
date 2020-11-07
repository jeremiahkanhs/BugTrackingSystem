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
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
%>
</head>
<body>
	<div class="container">
		
        <div class="row centered-form">
        <div class="col-xs-12 col-sm-8 col-md-4 col-sm-offset-2 col-md-offset-4">
        	<div class="panel panel-default">
        		<div class="panel-heading">
			    		<h3 class="panel-title">Create a new employee account</h3>
			 			</div>
			 			<div class="panel-body">
			    		<form action='userAccount' method="post">
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			                <input type="text" name="firstName" id="first_name" class="form-control input-sm" placeholder="First Name" required>
			    					</div>
			    				</div>
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="text" name="lastName" id="last_name" class="form-control input-sm" placeholder="Last Name" required>
			    					</div>
			    				</div>
			    			</div>

			    			<div class="form-group">
			    				<input type="email" name="emailAddress" id="email" class="form-control input-sm" placeholder="Email Address" required>
			    			</div>
			    			<div class="row">
				    			<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="text" name="username" id="username" class="form-control input-sm" placeholder="Username" required>
			    					</div>
		    					</div>
		    					<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="password" name="password" id="password" class="form-control input-sm" placeholder="Password" required>
			    					</div>
		    					</div>
	    					</div>
	    					<div class="form-group">
	    						<select name="userRole" id="userRole" class="form-control input-sm" required>
	    							<option value="" disabled selected>Select User Role</option>
									<option value="System Administrator">System Administrator</option>
									<option value="Bug Reporter">Bug Reporter</option>
									<option value="Triager">Triager</option>
									<option value="Developer">Developer</option>
									<option value="Reviewer">Reviewer</option>
	    						</select>
	    					</div>
			    			
			    			<input type="submit" name="submit" value="Create" class="btn btn-info btn-block">
			    		
			    		</form>
			    	</div>
	    		</div>
    		</div>
    	</div>
    </div>

</body>
</html>