<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		body {
			margin:0px; padding:0px;
		}
		a	{
			text-decoration:none;
			color:black;
		}
		* {
			box-sizing:border-box;
		}
		input::placeholder {
			text-indent:5px;
		}
		input {
			text-indent:5px;
		}
		#first {
			margin:auto;
			width:1200px;
			height:35px;
			background:lightcyan;
			color:cornflowerblue;
			display:flex;
		}
		#first #left {
			margin:auto;
		}
		#first #right {
			float:right;
			padding-top:5px;
		}
		#second {
			width:1200px;
			height:30px;
			background:white;
			margin:auto;
			text-align:right;
			font-size:13px;
		}
		#second #mmain {
			position:relative;
			display:inline-block;
		}
		#second #msub {
			position:absolute;
			left:-10px;
			top:5px;
			border:1px solid black;
			padding:5px;
			background:white;
			z-index:1;
			visibility:hidden;
		}
		#second #msub li {
			list-style-type:none;
			padding-bottom:5px;
			width:58px;
		}
		#third {
			width:1200px;
			height:30px;
			margin:auto;
		}
		#third > ul {
			text-align:center;
			padding-left:0px;
		}
		#third .main {
			display:inline-block;
			list-style-type:none;
			width:150px;
			position:relative;
			cursor:pointer;
		}
		#third .main .sub {
			position:absolute;
			padding-left:0px;
			z-index:1;
			visibility:hidden;
		}
		#third .main .sub li {
			list-style-type:none;
			width:150px;
			height:30px;
			background:white;
			padding:7px;
		}
		#seventh {
			font-size:13px;
			width:1200px;
			margin:auto;
			text-align:center;
		}
	</style>
	<script>
		function first_hide() {
			document.getElementById("outer").style.display="none";
		}
		function view_menu(n) {
			document.getElementsByClassName("sub")[n].style.visibility="visible";
		}
		function hide_menu(n) {
			document.getElementsByClassName("sub")[n].style.visibility="hidden";
		}
		function my_view() {
			document.getElementById("msub").style.visibility="visible";
		}
		function my_hide() {
			document.getElementById("msub").style.visibility="hidden";
		}
		function move_left() {
			
		}
		function move_right() {
			
		}
	</script>
</head>
<body>

	<div id="outer">
		<div id="first">
			<div id="left"> ~2/9 VIP?????? ???????????? ?????????!! </div>
			<div id="right" onclick="first_hide()"> x </div>
		</div>
	</div>

	<div id="second">
<%
	if(session.getAttribute("userid")==null) {
%>
		<a href="../member/login.jsp"> ????????? </a> &nbsp;|&nbsp;
		<a href="../member/member_input.jsp"> ???????????? </a> &nbsp;|&nbsp;
		<a href=""> 1:1?????? </a>
<%
	}
	else {
%>
		<%=session.getAttribute("name")%>??? &nbsp;|&nbsp;
		<a href="../member/logout.jsp"> ???????????? </a> &nbsp;|&nbsp;
		<span id="mmain" onmouseover="my_view()" onmouseout="my_hide()"> Mypage &nbsp;|&nbsp;
			<ul id="msub">
				<li> <a href="../member/member_view.jsp"> ?????? ?????? </a> </li>
				<li> <a href="../reserve/reserve_all.jsp"> ?????? ?????? </a> </li>
				<li> <a href=""> ?????? ?????? </a> </li>
			</ul>
		</span>
		<a href=""> 1:1?????? </a>
<%
	}
%>
	</div>
	
	<div id="third">
		<ul>
			<li class="main"> <a href="../main/main.jsp"> Logo </a> </li>
			<li class="main" onmouseover="view_menu(0)" onmouseout="hide_menu(0)"> ?????? 
				<ul class="sub">
					<li> ????????? </li>
					<li> ????????? ??? </li>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(1)" onmouseout="hide_menu(1)"> ???????????? 
				<ul class="sub">
					<li> A??? </li>
					<li> B??? </li>
					<li> C??? </li>
					<li> D??? </li>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(2)" onmouseout="hide_menu(2)"> ??????????????? 
				<ul class="sub">
					<li> ?????????????????? </li>
					<li> ???????????? </li>
					<li> ????????? </li>
					<li> ?????????????????? </li>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(3)" onmouseout="hide_menu(3)"> ???????????? 
				<ul class="sub">
					<li> ?????? ?????? </li>
					<li> <a href="../reserve/reserve.jsp"> ??????????????? </a>	</li>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(4)" onmouseout="hide_menu(4)"> ???????????? 
				<ul class="sub">
					<li> <a href=""> ???????????? </a> </li>
					<li> <a href=""> ??????????????? </a> </li>
					<li> <a href=""> ???????????? </a> </li>
				</ul>
			</li>
		</ul>
	</div>