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
			margin-top:100px;
		}
		#tleft {
			width:130px;
			height:35px;
			text-align:right;
		}
		#tright {
			width:200px;
			text-indent:50px;
		}
		input[type=button] {
			width:100px;
			height:25px;
			border:1px solid black;
			outline:none;
			color:black;
			background:white;
			font-weight:900;
		}
	</style>
	
	<div id="section">
	
		<table align="center">
			<caption><h3> 회원정보 </h3></caption>
			<tr>
				<td id="tleft"> 아이디 </td>
				<td id="tright"> <%=mdto.getUserid()%></td>
			</tr>
			<tr>
				<td id="tleft"> 이름 </td>
				<td id="tright"> <%=mdto.getName()%> </td>
			</tr>
			<tr>
				<td id="tleft"> 전화번호 </td>
				<td id="tright"> <%=mdto.getPhone()%> </td>
			</tr>
			<tr>
				<td id="tleft"> 이메일 </td>
				<td id="tright"> <%=mdto.getEmail()%> </td>
			</tr>
			<tr>
				<td id="tleft"> 가입일 </td>
				<td id="tright"> <%=mdto.getWriteday()%> </td>
			</tr>
			<tr>
				<td colspan="2" align="center" height="50">
					<input type="button" onclick="location='member_update.jsp'" value="정보수정">
					<input type="button" onclick="location='member_out.jsp'" value="탈퇴신청">
				</td>
			</tr>
		</table>
		
	</div>
	
<%@ include file="../bottom.jsp"%>