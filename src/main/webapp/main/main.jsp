<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>

	<style>
		#fourth {
			width:1200px;
			height:500px;
			margin:auto;
			text-align:center;
		}
		#fourth img {
			width:1200px;
			height:500px;
		}
		#fifth {
			width:1200px;
			height:100px;
			margin:auto;
		}
		#fifth table {
			border-spacing:0px;
			width:1200px;
			height:100px;
		}
		#fifth table td {
			width:400px;
		}
		#fifth td:first-child {
			border-left:1px solid black;
		}
		#fifth td:nth-child(2) {
			border-left:1px solid black;
			border-right:1px solid black;
		}
		#fifth td:nth-child(3) {
			border-right:1px solid black;
		}
		#fifth #tt {
			vertical-align:top;
			text-align:center;
			height:22px;
			border:1px solid black;
		}
		#sixth {
			width:1300px;
			height:250px;
			margin:auto;
			display:flex;
			justify-content:space-evenly;
			align-items:center;
		}
		#sixth div a {
			margin:0 20px;
		}
		#sixth #icon{
			width:35px;
			height:35px;
		}
	</style> 
	
	<script>
		window.onload=function() {
			var mm=0;
			var fmain=["1.jpg","3.jpg","2.jpg"];
			setInterval(function(){
				mm++;
				if(mm==fmain.length)
					mm=0;
				document.getElementById("mimg").src="img/"+fmain[mm];
			}, 3000);
		}
	</script>
	<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

	<div id="fourth">
		<img src="img/1.jpg" id="mimg">
	</div>
	<p>
	
	<div id="fifth">
		<table>
			<tr id="tt">
				<td> <b> 공지사항 </b> </td>
				<td> <b> 자유게시판 </b> </td>
				<td> <b> 여행후기 </b> </td>
			</tr>
			
			<tr>
				<td>  </td>
				<td>  </td>
				<td>  </td>
			</tr>

		</table>
	</div>
	<p>
	
	<div id="sixth">
		<div> <ion-icon name="chevron-back-outline" id="icon" onclick="move_left()"></ion-icon> </div>
		<div>
			<a href="#"> <img src="../event/img/e1.png"> </a>
			<a href="#"> <img src="../event/img/e2.png"> </a>
			<a href="#"> <img src="../event/img/e3.png"> </a>
			<a href="#"> <img src="../event/img/e4.png"> </a>
		</div>
		<div> <ion-icon name="chevron-forward-outline" id="icon" onclick="move_right()"></ion-icon> </div>
	</div>

<%@ include file="../bottom.jsp"%>