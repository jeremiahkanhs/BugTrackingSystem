<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<%@ include file="header.jsp" %>
</head>
<body>
	<form action='login' method="post">
		<table style="margin:auto">
			<tr>
				<td><h3>${message}</h3> <h3>${successmessage}</h3></td>
			</tr>
			<tr>
				<td>Username :</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>Password :</td>
				<td><input type="password" name="userpassword"></td>
			</tr>
			<tr>
				<td><input type="submit" name="submit" value="login"></td>
			</tr>
		</table>
	</form>
</body>
</html>