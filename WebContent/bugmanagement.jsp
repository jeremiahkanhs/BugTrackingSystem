<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
ul.timeline {
    list-style-type: none;
    position: relative;
}
ul.timeline:before {
    content: ' ';
    background: #d4d9df;
    display: inline-block;
    position: absolute;
    left: 29px;
    width: 2px;
    height: 100%;
    z-index: 400;
}
ul.timeline > li {
    margin: 20px 0;
    padding-left: 20px;
}
ul.timeline > li:before {
    content: ' ';
    background: white;
    display: inline-block;
    position: absolute;
    border-radius: 50%;
    border: 3px solid #22c0e8;
    left: 20px;
    width: 20px;
    height: 20px;
    z-index: 400;
}
</style>
<%
	int sessionVal = 0;
	if (session.getAttribute("roleId") == null)
	{
		request.setAttribute("errorMessage", "You do not have access");
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
%>
<meta charset="ISO-8859-1">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
<!------ Include the above in your HEAD tag ---------->



<%@ page import="java.sql.PreparedStatement, java.sql.Connection, java.sql.ResultSet, DAO.UserDAO, DAO.BugDAO, Service.BugDAOImpl, Model.Role, Model.User, Service.UserDAOImpl, Utilities.MyConnectionProvider" %>
<%@ include file="header.jsp" %>
</head>

<body>

<%
	BugDAO bd = new BugDAOImpl();
	UserDAO ud = new UserDAOImpl();
%>
<div class="container">
<div id="accordion">
    <div class="row">
        <div class="col-lg-12">
            <div class="text-center">
                <h3>Bug Management</h3>
            </div>
        </div>
    </div>

    <div class="card card-default">
        <div class="card-header">
            <h4 class="card-title">
                    <b>Bug Details</b>
            </h4>
        </div>
        <div id="collapse1" class="collapse show">
            <div class="card-body">
             	<form action='reportbug' method="post">
	                <div class="row">
	                    <div class="col-md-4 col-lg-4">
	                        <div class="form-group">
	                            <label class="control-label">Severity</label>
	                            <select id="bugseverity" name="bugseverity" class="form-control" required>
								  <option value="1">1</option>
								  <option value="2">2</option>
								  <option value="3">3</option>
								</select>
	                        </div>
	                    </div>
	                    <div class="col-md-4 col-lg-4">
	                        <div class="form-group">
	                            <label class="control-label">Title</label>
	                            <input id="bugtitle" name="bugtitle" type="text" class="form-control" / required>
	                        </div>
	                    </div>
	                    <div class="col-md-4 col-lg-4">
	                        <div class="form-group">
	                            <label class="control-label">Assigner</label>
	                            <select id="bugassigner" name="bugassigner" class="form-control" required>
	                            <option value="" selected disabled hidden>Select Assigner</option>
	                            <%
	                            	try {
										Connection con = MyConnectionProvider.getCon();
										PreparedStatement ps = con.prepareStatement("select u.user_id, u.first_name, u.last_name, r.role_desc from users u inner join roles r on u.role_id = r.role_id where r.role_id <> 191");
										ResultSet rs = ps.executeQuery();
										while (rs.next()) {
								%>
	                            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%> <%=rs.getString(3)%> | <%=rs.getString(4)%></option>
	                            <%
									}
										con.close();
									} catch (Exception e) {
										System.out.println(e);
									}
								%>
								</select>
	                        </div>
	                    </div>
	                </div>
	
	                <div class="row">
	                    <div class="col-md-8 col-lg-8">
	                        <div class="form-group">
	                            <label class="control-label">Description</label>
	                            <textarea id="bugdescription" name="bugdescription" class="form-control" rows="5" required></textarea>
	                        </div>
	                    </div>
	                    <div class="col-md-4 col-lg-4">
		                    <div class="row">
			                    <div class="col-md-12 col-lg-12">
			                        <div class="form-group">
			                            <label class="control-label">Assignee</label>
			                            <select id="bugassignee" name="bugassignee" class="form-control" required>
			                            	<option value="" selected disabled hidden>Select Assignee</option>
			                            <%
			                            	try {
												Connection con = MyConnectionProvider.getCon();
												PreparedStatement ps = con.prepareStatement("select u.user_id, u.first_name, u.last_name, r.role_desc from users u inner join roles r on u.role_id = r.role_id where r.role_id <> 191");
												ResultSet rs = ps.executeQuery();
												while (rs.next()) {
										%>
			                            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%> <%=rs.getString(3)%> | <%=rs.getString(4)%></option>
			                            <%
											}
												con.close();
											} catch (Exception e) {
												System.out.println(e);
											}
										%>
										</select>
		                       		 </div>
			                    </div>
		                    </div>
		                    <div class="row">
			                    <div class="col-md-12 col-lg-12">
			                        <div class="form-group">
			                            <label class="control-label">Current Status</label>
			                            <select id="bugstatus" name="bugstatus" class="form-control" required>
										  <option value="open">Open</option>
										  <option value="closed">Closed</option>
										</select>
			                        </div>
			                    </div>
		                	</div>
	                	</div>
	                </div>
	                
	                
					<div class="row">
						<div class="col-md-12 col-lg-12">
							<h4>Comments</h4>
							<ul class="timeline">
								<%
									int comment_id = 0;
				                       	try {
				                       		
											Connection con = MyConnectionProvider.getCon();
											PreparedStatement ps = con.prepareStatement("select * from comments where bug_id = ?");
											ps.setInt(1, Integer.parseInt(request.getParameter("bugId")));
											ResultSet rs = ps.executeQuery();
											while (rs.next()) {
								%>
				                <li>
									<label><%=ud.getUser(Integer.parseInt(rs.getString(5))).getFirstName()%> <%=ud.getUser(Integer.parseInt(rs.getString(5))).getLastName()%></label>
									<label><%=rs.getString(4)%></label>
									<p><%=rs.getString(3)%></p>
								</li>
				                <%
											}
											con.close();
										} catch (Exception e) {
											System.out.println(e);
										}
								%>
								
							</ul>
							<textarea id="commentdescription" name="commentdescription" class="form-control" rows="5" required></textarea>
						</div>
					</div>
					<%
						System.out.println(session.getAttribute("userId"));
					%>
					<input type="hidden" id="commentuserid" name="commentuserid" value="<%=(Integer)session.getAttribute("userId")%>">
					
					<div class="row">
					    <div class="col-lg-12">
					        <div class="pull-right">
					        <%if(request.getParameter("bugId")==null){ %>
					            <input style="margin-top:5px"class="btn btn-success btn-lg" type="submit" id="btnSubmit" value="Report Bug"/>
					        <%} else { %>
					        	<input id="bugid" name="bugid" type="hidden" value="<%=request.getParameter("bugId")%>"/>
					        	<input style="margin-top:5px"class="btn btn-success btn-lg" type="submit" id="btnSubmit" value="Save"/>
					        <%} %>
					        </div>
					    </div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</div>

<%
String bugtitle, bugstatus, bugdescription;
int bugseverity, bugassigner, bugassignee;
if(request.getParameter("bugId")!=null){
	bugseverity = bd.getBug(Integer.parseInt(request.getParameter("bugId"))).getBugSeverity();
	bugtitle = bd.getBug(Integer.parseInt(request.getParameter("bugId"))).getBugTitle();
	bugassigner = bd.getBug(Integer.parseInt(request.getParameter("bugId"))).getBugAssigner();
	bugassignee = bd.getBug(Integer.parseInt(request.getParameter("bugId"))).getBugAssignee();
	bugstatus = bd.getBug(Integer.parseInt(request.getParameter("bugId"))).getBugStatus();
	bugdescription = bd.getBug(Integer.parseInt(request.getParameter("bugId"))).getBugDesc();
%>
<script>
	$(document).ready(function(){
		$("#bugseverity").val('<%=bugseverity%>');
		$("#bugtitle").val('<%=bugtitle%>');
		$("#bugassigner").val('<%=bugassigner%>');
		<% if (bugassignee != 9999){%>
		$("#bugassignee").val('<%=bugassignee%>');
		<%}%>
		$("#bugstatus").val('<%=bugstatus%>');
		$("#bugdescription").val('<%=bugdescription%>');
	});
</script>
<%
} else {
%>
<script>
	$(document).ready(function(){
		$("#bugassignee").attr('disabled','disabled');
	});
</script>
<%
}
%>




   <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
</body>
</html>