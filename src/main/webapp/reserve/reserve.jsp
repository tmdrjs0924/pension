<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@page import="java.time.LocalDate"%>
<%@page import="pension.dao.ReserveDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pension.dto.RoomDto"%>
<%
	ReserveDao rdao=new ReserveDao(); 
	
	int year,month;
	if(request.getParameter("year")==null) {	  
		LocalDate today=LocalDate.now();
		year=today.getYear();
		month=today.getMonthValue();
	}
	else {
		year=Integer.parseInt(request.getParameter("year"));
		month=Integer.parseInt(request.getParameter("month"));
	}
	if(month==0) {
		year--;
		month=12;
	}
	if(month==13) {
		year++;
		month=1;
	}
	
	LocalDate xday=LocalDate.of(year,month,1);
	int chong=xday.lengthOfMonth();
	int yoil=xday.getDayOfWeek().getValue();
	if(yoil==7)
		yoil=0;
	int ju=(int)Math.ceil( (yoil+chong)/7.0 ) ;    		
%>
	<style>
		#section {
			width:1000px;
			min-height:820px;
			margin:auto;
		}
	</style>

	<div id="section">

	<table width="900" align="center" border="1">
		<caption style="padding-bottom:8px;">
			<h3>실시간 예약</h3>
			<a href="reserve.jsp?year=<%=year%>&month=<%=month-1%>"> ◀ </a>
			<span style="font-size:17px;"> <%=year%>년 <%=month%>월 </span>
			<a href="reserve.jsp?year=<%=year%>&month=<%=month+1%>"> ▶ </a>
		</caption>
		<tr align="center" height="25">
			<td width="130">일</td>
			<td width="130">월</td>
			<td width="130">화</td>
			<td width="130">수</td>
			<td width="130">목</td>
			<td width="130">금</td>
			<td width="130">토</td>
		</tr>
<%
	int day=1;     
	for(int i=1;i<=ju;i++) {
%>
		<tr height="130">
<%
		for(int j=0;j<7;j++) {

			if((j<yoil && i==1) || day>chong) {
%>
			<td></td>
<%
			}
			else {
				rdao.getRoomName(request);
				ArrayList<RoomDto> rlist=(ArrayList<RoomDto>)request.getAttribute("rlist");
			
				String ss="";
				if(j==0)
					ss="color:red;";
				else if(j==6)
					ss="color:blue";
				else 
					ss="color:black;"; 
%>
			<td height="90" style="font-size:13px;" align="right" valign="top">
				<span style="font-size:15px;font-weight:900;<%=ss%>"> <%=day%> </span>
				<p>
<%
				LocalDate today=LocalDate.now();
				LocalDate prevday=LocalDate.of(year,month,day);
	      
				if(!prevday.isBefore(today)) {
					for(int k=0;k<rlist.size();k++) {
						int id=rlist.get(k).getId();
						boolean ck=rdao.isEmpty(year,month,day,id);
						if(ck) {
%>
					<a href="reserve_next.jsp?y=<%=year%>&m=<%=month%>&d=<%=day%>&id=<%=id%>"> <%=rlist.get(k).getName()%> </a> <br>
<%
						}
						else {
%>
					<span style="color: red"> <%=rlist.get(k).getName()%>	</span> <br>
<%
						}
					}
				}
%>
				</td>
<%
					day++;
			}
		}
%>
		</tr>
<%
	}
%>
	</table>
	
	</div>

<%@ include file="../bottom.jsp"%>