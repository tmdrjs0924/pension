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
			<div id="left"> ~2/9 VIP회원 프로모션 진행중!! </div>
			<div id="right" onclick="first_hide()"> x </div>
		</div>
	</div>

	<div id="second">
<%
	if(session.getAttribute("userid")==null) {
%>
		<a href="../member/login.jsp"> 로그인 </a> &nbsp;|&nbsp;
		<a href="../member/member_input.jsp"> 회원가입 </a> &nbsp;|&nbsp;
		<a href="../manto/write.jsp"> 1:1질문 </a>
<%
   	}
   	else if(session.getAttribute("userid").equals("admin")) // admin인 경우
   	{
%>
      <%=session.getAttribute("name")%>님 | <a href="../member/logout.jsp"> 로그아웃 </a> 
      | <a href="../admin/main.jsp"> 관리페이지 </a>
<%
	}
	else {
%>
		<%=session.getAttribute("name")%>님 &nbsp;|&nbsp;
		<a href="../member/logout.jsp"> 로그아웃 </a> &nbsp;|&nbsp;
		<span id="mmain" onmouseover="my_view()" onmouseout="my_hide()"> Mypage &nbsp;|&nbsp;
			<ul id="msub">
				<li> <a href="../member/member_view.jsp"> 회원 정보 </a> </li>
				<li> <a href="../reserve/reserve_all.jsp"> 예약 현황 </a> </li>
				<li> <a href="../manto/list.jsp"> 나의 질문 </a> </li>
			</ul>
		</span>
		<a href="../manto/write.jsp"> 1:1질문 </a>
<%
	}
%>
	</div>
	
	<div id="third">
		<ul>
			<li class="main"> <a href="../main/main.jsp"> Logo </a> </li>
			<li class="main" onmouseover="view_menu(0)" onmouseout="hide_menu(0)"> 소개 
				<ul class="sub">
					<li> 인사글 </li>
					<li> 오시는 길 </li>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(1)" onmouseout="hide_menu(1)"> 객실현황 
				<ul class="sub">
				<%@page import="pension.dao.ReserveDao" %>
				<%@page import="java.util.ArrayList" %>
				<%@page import="pension.dto.RoomDto" %>
				<%
				// room테이블에서 객실명을 가져와서 li태그에 이름을 출력
				ReserveDao rdao2=new ReserveDao();
				rdao2.getRoomName(request);
				ArrayList<RoomDto> rlist2=(ArrayList<RoomDto>)request.getAttribute("rlist");
				 
				for(int i=0;i<rlist2.size();i++)
				{
				%>
					<li> <a href="../room/room_view.jsp?id=<%=rlist2.get(i).getId()%>"> <%=rlist2.get(i).getName()%> </a> </li>
				<%
				}
				%>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(2)" onmouseout="hide_menu(2)"> 주변관광지 
				<ul class="sub">
					<li> 하늘바람공원 </li>
					<li> 하늘축제 </li>
					<li> 야시장 </li>
					<li> 액티비티센터 </li>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(3)" onmouseout="hide_menu(3)"> 예약하기 
				<ul class="sub">
					<li> 예약 안내 </li>
					<li> <a href="../reserve/reserve.jsp"> 실시간예약 </a>	</li>
				</ul>
			</li>
			<li class="main" onmouseover="view_menu(4)" onmouseout="hide_menu(4)"> 커뮤니티 
				<ul class="sub">
					<li> <a href="../gongji/list.jsp"> 공지사항 </a> </li>
					<li> <a href="../board/list.jsp"> 자유게시판 </a> </li>
					<li> <a href="../tour/list.jsp"> 여행후기 </a> </li>
				</ul>
			</li>
		</ul>
	</div>