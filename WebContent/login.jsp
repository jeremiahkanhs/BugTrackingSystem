<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%
	int sessionVal = 0;
	if (session.getAttribute("roleId") != null){
		if (session.getAttribute("roleId").equals("191"))
			request.getRequestDispatcher("adminpanel.jsp").forward(request, response);
		else
			request.getRequestDispatcher("dashboard.jsp").forward(request, response);
	}
%>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<%@ include file="header.jsp" %>
</head>
<body>
	<main class="login-form">
    <div class="cotainer">
        <div class="row justify-content-center">
        	<div class="class="col-md-12">
       			<h3>${errorMessage}</h3>
       		</div>
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Login</div>
                    <div class="card-body">
                        <form action='login' method="post">
                            <div class="form-group row">
                                <label for="username" class="col-md-4 col-form-label text-md-right">Username</label>
                                <div class="col-md-6">
                                    <input type="text" id="username" class="form-control" name="username" required autofocus>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="password" class="col-md-4 col-form-label text-md-right">Password</label>
                                <div class="col-md-6">
                                    <input type="password" id="password" class="form-control" name="userpassword" required>
                                </div>
                            </div>

                            <div class="col-md-6 offset-md-4">
                                <button type="submit" class="btn btn-primary" name="submit">
                                    Login
                                </button>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </div>
</main>
	
</body>
</html>