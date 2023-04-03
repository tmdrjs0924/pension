<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   #first {
     width:900px;
     margin:auto;
     height:50px;
   }
   #first > ul {
     width:900px;
     height:30px;
     padding-left:0px;
   }
   #first li {
     list-style-type:none;
     width:120px;
     height:26px;
     border:1px solid black;
     display:inline-block;
     text-align:center;
     padding-top:4px;
   }
   #first #main{
   	 position:relative;
   	 cursor:pointer;
   }
   #first #sub{
     position:absolute;
     padding-left:0px;
     list-style:none;
     left:-1px;
     top:30px;
     visibility:hidden;
     background:white;
   }
   a {
  	 color:black;
  	 text-decoration:none;
   }
 </style>
 <script>
   function view_menu(){
	   document.getElementById("sub").style.visibility="visible";
   }
   function hide_menu(){
	   document.getElementById("sub").style.visibility="hidden";
   }
 </script>
</head>
<body> <!-- main.jsp -->
  <div id="first">
    <ul>
      <li> <a href="../main/main.jsp"> 홈 </a> </li>
      <li> <a href="admin_member.jsp"> 회원관리 </a> </li>
      <li> <a href="admin_manto.jsp"> 1:1질문 </a> </li>
      <li id="main" onmouseover="view_menu()" onmouseout="hide_menu()"> 커뮤니티
        <ul id="sub">
          <li> <a href="glist.jsp"> 공지사항 </a> </li>
          <li> <a href="blist.jsp"> 게시판 </a> </li>
          <li> <a href="tlist.jsp"> 여행후기 </a> </li>
        </ul>
      </li>
      <li> <a href="admin_reserve.jsp"> 예약관리 </a> </li>
      <li> <a href="admin_room.jsp"> 객실관리 </a> </li>
      <li> <a href="admin_event_list.jsp"> 이벤트관리 </a> </li>
    </ul>
  </div>