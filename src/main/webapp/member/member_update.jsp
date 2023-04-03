<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@ page import="pension.dao.MemberDao" %>
<%@ page import="pension.dto.MemberDto" %>
<%
	MemberDao mdao=new MemberDao();
	mdao.member_view(session, request);
	
	MemberDto mdto=(MemberDto)request.getAttribute("mdto");
%>
	<style>
		#section {
			width:1000px;
			height:820px;
			margin:auto;
			text-align:center;
			margin-top:100px;
		}
		#section input[type=text] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
		}
		#section input[type=submit] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
			color:black;
			background:white;
			font-weight:900;
		}
	</style>
 
	<div id="section">
	
		<div align="center"><h3> 회원 정보 수정 </h3></div> <p>
		<form method="post" action="member_update_ok.jsp">
			<input type="text" name="phone" value="<%=mdto.getPhone()%>"> <p>
			<input type="text" name="email" value="<%=mdto.getEmail()%>"> <p>
			<input type="submit" value="정보수정">
		</form>
	</div>
  
 <%@ include file="../bottom.jsp"%>