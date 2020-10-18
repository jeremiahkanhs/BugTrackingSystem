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

@import url(https://fonts.googleapis.com/css?family=Raleway:300,400,600);


body{
    margin: 0;
    padding-left: 100px;
    padding-right: 100px;
    font-size: 14px !important;'
    font-weight: 400;
    line-height: 1.6;
    color: #212529;
    text-align: left;
    background-color: #f5f8fa;
}

.navbar-laravel
{
    box-shadow: 0 2px 4px rgba(0,0,0,.04);
}

.navbar-brand , .nav-link, .my-form, .login-form
{
    font-family: Raleway, sans-serif;
}

.my-form
{
    padding-top: 1.5rem;
    padding-bottom: 1.5rem;
}

.my-form .row
{
    margin-left: 0;
    margin-right: 0;
}

.login-form
{
    padding-top: 1.5rem;
    padding-bottom: 1.5rem;
}

.login-form .row
{
    margin-left: 0;
    margin-right: 0;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<!-- Required meta tags -->
 <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

 <!-- Fonts -->
 <link rel="dns-prefetch" href="https://fonts.gstatic.com">
 <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,600" rel="stylesheet" type="text/css">

 <link rel="icon" href="Favicon.png">

 <!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">



<nav class="navbar navbar-expand-lg navbar-light navbar-laravel">
    <div class="container">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <%try{if(session.getAttribute("roleId").toString().equals("191")) {%><li class="nav-item"><a class="nav-link" href="adminpanel.jsp">Admin Panel</a></li><%}}catch (Exception e){} %>
                <%try{if(!session.getAttribute("roleId").toString().equals("191") && session.getAttribute("roleId") != null) {%><li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li><%}}catch (Exception e){} %>
                <%try{if(session.getAttribute("roleId").toString().equals("192")) {%><li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/BugManagement?roleId=<%=session.getAttribute("roleId")%>" id="bugManagement">Report Bug</a></li><%}}catch (Exception e){} %>
                <%try{if(session.getAttribute("roleId") != null) {%><li class="nav-item"><a class="nav-link" href="logout.jsp" id="logout">LogOut</a></li><%}}catch (Exception e){} %>

            </ul>

        </div>
    </div>
</nav>

</html>