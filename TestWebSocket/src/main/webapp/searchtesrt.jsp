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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
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


	<div>
<canvas id="chart2"></canvas>

		<canvas id="chart"></canvas>

		
	</div>
	<script>

  $(function() {//=window.onload=function(){}
    new Chart($("#chart"), {
      type: 'line',//line 折線圖
      data: {
     	  labels: [ ${yearSix[5]}+"/"+${monSix[5]}, ${yearSix[4]}+"/"+${monSix[4]}, ${yearSix[3]}+"/"+${monSix[3]}, ${yearSix[2]}+"/"+${monSix[2]}, ${yearSix[1]}+"/"+${monSix[1]}, ${yearSix[0]}+"/"+${monSix[0]}],//橫坐標
    	  datasets: [
    		{
	      	data: [1000,1000,1000,2000,2000,3000]//直條圖data
	    	}
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
          text: '每月淨利'
        }
      }
    });//end of new Chart
  });
  
  
  $(function() {//=window.onload=function(){}
	    new Chart($("#chart2"), {
	      type: 'line',//line 折線圖
	      data: {
	    	  labels: [ ${yearSix[5]}+"/"+${monSix[5]}, ${yearSix[4]}+"/"+${monSix[4]}, ${yearSix[3]}+"/"+${monSix[3]}, ${yearSix[2]}+"/"+${monSix[2]}, ${yearSix[1]}+"/"+${monSix[1]}, ${yearSix[0]}+"/"+${monSix[0]}],
	    	  datasets: [//直條圖設定及data
	    		{
	    		label:"每月淨利",
		      	backgroundColor: "rgb(238,197,145)",
	      	borderColor:"rgb(238,197,145)",//線條顏色
	      	
 	      	pointRadius:5,//點半徑
	      	
 	      	pointHoverRadius:7,
 	      	pointWidth:5,
 	      	pointBackgroundColor:"rgb(238,197,145)",
	      	fill:false,//線條夏布要填滿
data: [${netAl[5]},${netAl[4]},${netAl[3]},${netAl[2]},${netAl[1]},${netAl[0]}]
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