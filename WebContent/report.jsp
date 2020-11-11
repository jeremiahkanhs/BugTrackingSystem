<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%
int sessionVal = 0;
if (session.getAttribute("roleId") == null)
{
	request.setAttribute("errorMessage", "You do not have access");
	request.getRequestDispatcher("login.jsp").forward(request, response);
}	
%>
<meta charset="ISO-8859-1">
<title>Report</title>
<%@ include file="header.jsp" %>
</head>

<!--  Bar chart for bugs reported in last 6 months -->
<script>
var d = new Date();
console.log(d.getFullYear());
var xaxis = [];
xaxis[0] = d.getMonth()+1 + "/" + d.getFullYear();
xaxis[1] = d.getMonth() + "/" + d.getFullYear();
xaxis[2] = d.getMonth()-1 + "/" + d.getFullYear();
xaxis[3] = d.getMonth()-2 + "/" + d.getFullYear();
xaxis[4] = d.getMonth()-3 + "/" + d.getFullYear();
xaxis[5] = d.getMonth()-4 + "/" + d.getFullYear();

$(document).ready(function() {
	$.ajax({
		url : 'reports',
		data : {
			reportType : 'bugreportedsixmonths'
		},
		success : function(responseData) {
			var returnedData = JSON.parse(responseData);
			var chart = new CanvasJS.Chart("chartContainer",
				    {
				      title:{
				        text: "Bugs Reported in Last 6 Months"
				    },
				    data: [
				    {        
				        type: "column",
				        dataPoints: [//array
					        { y: parseInt(returnedData[5], 10), label: xaxis[5]},
					        { y: parseInt(returnedData[4], 10), label: xaxis[4]},
					        { y: parseInt(returnedData[3], 10), label: xaxis[3]},
					        { y: parseInt(returnedData[2], 10), label: xaxis[2]},
					        { y: parseInt(returnedData[1], 10), label: xaxis[1]},
					        { y: parseInt(returnedData[0], 10), label: xaxis[0]}
				        ]
				    }
				    ]
				});

				    chart.render();
		}
	});
	$.ajax({
		url : 'reports',
		data : {
			reportType : 'bugclosedsixmonths'
		},
		success : function(responseData2) {
			var returnedData2 = JSON.parse(responseData2);
			var chart2 = new CanvasJS.Chart("chartContainer2",
				    {
				      title:{
				        text: "Bugs Closed in Last 6 Months"
				    },
				    legend: {
						maxWidth: 350,
						itemWidth: 120
					},
				    data: [
				    {        
				    	type: "pie",
						showInLegend: true,
						legendText: "{indexLabel}",
				        dataPoints: [//array
					        { y: parseInt(returnedData2[5], 10), indexLabel: String(xaxis[5])},
					        { y: parseInt(returnedData2[4], 10), indexLabel: String(xaxis[4])},
					        { y: parseInt(returnedData2[3], 10), indexLabel: String(xaxis[3])},
					        { y: parseInt(returnedData2[2], 10), indexLabel: String(xaxis[2])},
					        { y: parseInt(returnedData2[1], 10), indexLabel: String(xaxis[1])},
					        { y: parseInt(returnedData2[0], 10), indexLabel: String(xaxis[0])}
				        ]
				    }
				    ]
				});
	
				    chart2.render();
		}
	});
	$.ajax({
		url : 'reports',
		data : {
			reportType : 'toptendevelopers'
		},
		success : function(responseData3) {
			var returnedData3 = JSON.parse(responseData3);
			var chart3 = new CanvasJS.Chart("chartContainer3",
				    {
				      title:{
				        text: "Top 10 Developers All Time"
				    },
				    data: [
				    {        
				        dataPoints: [//array
					        { x: 1, y: parseInt(returnedData3[1], 10), label: String(returnedData3[0])},
					        { x: 2, y: parseInt(returnedData3[3], 10), label: String(returnedData3[2])},
					        { x: 3, y: parseInt(returnedData3[5], 10), label: String(returnedData3[4])},
					        { x: 4, y: parseInt(returnedData3[7], 10), label: String(returnedData3[6])},
					        { x: 5, y: parseInt(returnedData3[9], 10), label: String(returnedData3[8])},
					        { x: 6, y: parseInt(returnedData3[11], 10), label: String(returnedData3[10])},
					        { x: 7, y: parseInt(returnedData3[13], 10), label: String(returnedData3[12])},
					        { x: 8, y: parseInt(returnedData3[15], 10), label: String(returnedData3[14])},
					        { x: 9, y: parseInt(returnedData3[17], 10), label: String(returnedData3[16])},
					        { x: 10, y: parseInt(returnedData3[19], 10), label: String(returnedData3[18])}
				        ]
				    }
				    ]
				});
	
				    chart3.render();
		}
	});
});
	
</script>


<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<body>
	<div id="chartContainer" style="height: 300px; width: 100%; margin-bottom: 75px;"></div>
	<div id="chartContainer2" style="height: 300px; width: 100%; margin-bottom: 75px;"></div>
	<div id="chartContainer3" style="height: 300px; width: 100%; margin-bottom: 75px;"></div>

</body>
</html>