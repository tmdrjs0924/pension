<%@page import="pension.dto.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp" %>
	<style>
		#fourth
		{
			width:100%;
			height:500px;
			margin:auto;
			text-align:center;
		}
		#fourth img
		{
			width:1200px;
			height:500px;
		}
		#fifth
		{
			width:1200px;
			height:100px;
			margin:auto;
		}
		#fifth table
		{
			border-spacing:0px;
		}
		#fifth td:first-child
		{
			border-left:1px solid black;
		}
		#fifth td:nth-child(2)
		{
			border-left:1px solid black;
			border-right:1px solid black;
		}
		#fifth td:nth-child(3)
		{
			border-right:1px solid black;
		}
		#sixth
		{
			width:1300px;
			height:250px;
			margin:auto;
		}
	</style> 
	<script>
		window.onload=function()
		{
			var mm=0;
			var fmain=["1.jpg","3.jpg","2.jpg"];
			setInterval(function()
			{
				mm++;
				if(mm==fmain.length)
					mm=0;
				document.getElementById("mimg").src=fmain[mm];
			}, 3000);
		}
	</script>
	
	<div id="fourth">
		<img src="1.jpg" id="mimg">
	</div>
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%@page import="pension.dao.BoardDao" %>
<%@page import="pension.dto.BoardDto" %>
<%@page import="pension.dao.TourDao" %>
<%@page import="pension.dto.TourDto" %>
<%@page import="java.util.ArrayList" %>
<%
		GongjiDao gdao=new GongjiDao();
		gdao.getFour(request);
		ArrayList<GongjiDto> glist=(ArrayList<GongjiDto>)request.getAttribute("glist");
		
		BoardDao bdao=new BoardDao();
		bdao.getFour(request);
		ArrayList<BoardDto> blist=(ArrayList<BoardDto>)request.getAttribute("blist");
		
		TourDao tdao=new TourDao();
		tdao.getFour(request);
		ArrayList<TourDto> tlist=(ArrayList<TourDto>)request.getAttribute("tlist");
 %>
	<style>
		#tt
		{
			vertical-align:top;
		}
		#tt td
		{
			font-size:13px;
			width:400px;
			text-align:center;
		}
		#tt span
		{
			display:inline-block;
		}
		#tt #title
		{
			width:227px;
			text-align:left;
			padding-left:3px;
		}
		#tt #writeday
		{
			width:90px;
			text-align:right;
		}
		ion-icon
		{
			cursor:pointer;
		}
	</style>
	<p>
	<div id="fifth">
		<table width="1200" height="100" align="center">
			<tr id="tt">
				<td> <b> 공지사항 </b> </td>
				<td> <b> 자유게시판 </b> </td>
				<td> <b> 여행후기 </b> </td>
			</tr>
			<tr id="tt">
				<td>
<%
		for(int i=0;i<glist.size();i++)
		{
%>
					<a href="../gongji/content.jsp?id=<%=glist.get(i).getId()%>">
						<span id="title"> <%=glist.get(i).getTitle()%> </span> 
						<span id="writeday"> <%=glist.get(i).getWriteday()%> </span>
					</a> <br>
<%
		}
%>
				</td>
				<td>
<%
		for(int i=0;i<blist.size();i++)
		{
%>
					<a href="../board/content.jsp?id=<%=blist.get(i).getId()%>">
						<span id="title"> <%=blist.get(i).getTitle()%> </span> 
						<span id="writeday"> <%=blist.get(i).getWriteday()%> </span>
					</a> <br>
<%
		}
%>
				</td>
				<td>
<%
		for(int i=0;i<tlist.size();i++)
		{
%>
					<a href="../tour/content.jsp?id=<%=tlist.get(i).getId()%>">
						<span id="title"> <%=tlist.get(i).getTitle()%> </span> 
						<span id="writeday"> <%=tlist.get(i).getWriteday()%> </span>
					</a> <br>
<%
		}
%>
				</td>
			</tr>
		</table>
	</div>
	<p>
<%@ page import="pension.dao.AdminDao"%>
<%
		AdminDao adao=new AdminDao();
		adao.main_list(request);
		
		ArrayList<EventDto> elist=(ArrayList<EventDto>)request.getAttribute("elist");
%>
	<script>
<%
		String str="";
		for(int i=0;i<elist.size();i++)
		{
			str=str+"'"+elist.get(i).getImg()+"'";
			if(i!=elist.size()-1)
				str=str+",";
		}
%>
		var simg=[<%=str%>];
		var v=0;
		function left_move()
		{
			v--;
			if(v==-1)
			{
				v=simg.length-1;
			}
			var chk=v;
			for(i=0;i<4;i++){
				if(chk==simg.length){
					chk=0;
				}
				document.getElementsByClassName("img")[i].src="../event/img/"+simg[chk];
				chk++;
			}
		}
		function right_move()
		{
			v++;
			if(v==simg.length){
				v=0;
			}
			var chk=v;
			for(i=0;i<4;i++)
			{
				if(chk==simg.length)
				{
					chk=0;
				}
				document.getElementsByClassName("img")[i].src="../event/img/"+simg[chk];
				chk++;
			}
		}
	</script>
	<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
	
	<div id="sixth">
		<table width="1200" height="200" align="center">
			<tr align="center">
				<td width="50" onclick="left_move()"> <ion-icon name="chevron-back-outline"></ion-icon> </td>
<%
		for(int i=0;i<4;i++)
		{
%>
				<td width="300"> <img class="img" src="../event/img/<%=elist.get(i).getImg()%>" width="300" height="250"> </td>
<%
		}
%>
				<td width="50" onclick="right_move()"> <ion-icon name="chevron-forward-outline"></ion-icon> </td>
			</tr>
		</table>
	</div>
  
<%@ include file="../bottom.jsp" %>