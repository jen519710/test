<%-- <%@include file="/Components/topLeft2.jsp"%> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SEARCH</title>

<!-- jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<!--圓餅圖與長條圖 Chart.js-->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>


<style>

</style>
</head>

<body>
	
		

		<canvas id="chart"></canvas>


	<script>

  $(function() {//=window.onload=function(){}
    new Chart($("#chart"), {
      type: 'bar',//line 折線圖
      data: {
    	  labels: [ "June", "July","August","September","October","November"],//橫坐標
    	  datasets: [//直條圖設定及data
    		//{}每組數據組的設定值  
    		{
    		label:"總銷售額",//直條圖代表
	      	backgroundColor: "rgb(238,197,145)",//直條圖顏色
	      	data: [${sumAl[0]},${sumAl[1]},${sumAl[2]},${sumAl[3]},${sumAl[4]},${sumAl[5]}]//直條圖data
	    	}//,{},{}加入不同數據組
    	 ]	
	},
      options: {
          scales: {//恆縱軸的值和設定
        	  yAxes: [
        		  {
        			  ticks: {min:0}//ticks x y軸座標值設定(數值或位置)
        		  }//,{},{}可設定多個y軸
        	]
          },
        title: {//表格title
          display: true,
          text: '每月銷售金額'
        }
      }
    });//end of new Chart

  });
  </script>

</body>

</html>