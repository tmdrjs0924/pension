<%@page import="pension.dto.RoomDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pension.dao.ReserveDao" %>
<%@ page import="util.MyJob" %>
<%
		ReserveDao rdao=new ReserveDao();
		rdao.getRoom(request);
		
		RoomDto rdto=(RoomDto)request.getAttribute("rdto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%@ include file="../top.jsp"%>
 
 <style>
   #section {
      width:1000px;
      height:700px;
      margin:auto;
   }
   #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#eeeeee;
   }
   #section table td {
     height:30px;
     font-size:13px;
   }
   #section table td {
     border-bottom:1px solid black;
   }
   #section table tr:first-child td {
     border-top:1px solid black;
   }
 </style>
 <script>
   function zoom_chg(my){
	   document.getElementById("zoom").src=my;
   }
 </script>
 
  <div id="section">
  
    <table width="700" align="center">
      <caption><h3> 객실보기 </h3></caption>
      <tr>
        <td colspan="4">
      <%
      	String imsi="";
      	if(rdto.getImg().equals(""))
      		imsi=",";
      	else
      		imsi=rdto.getImg();
      	
      	String[] img=imsi.split(",");
      	
      	if(img.length>0)
      	{
      %>
        <div> <img id="zoom" src="img/<%=img[0]%>" width="100%" height="350"> </div>
      <%
      	}
      	for(int i=0;i<img.length;i++)
      	{
      %>
        	<img src="img/<%=img[i]%>" width="50" height="40" onclick="zoom_chg(this.src)">
      <%
      	}
      %>
        </td>
      </tr>
      <tr>
        <td> 객실명 </td>
        <td> <%=rdto.getName()%> </td>
        <td> 숙박료(1박) </td>
        <td> <%=MyJob.comma(rdto.getPrice())%>원 </td>
      </tr>
      <tr>
        <td> 기준인원 </td>
        <td> <%=rdto.getMin()%>명 </td>
        <td> 최대인원 </td>
        <td> <%=rdto.getMax()%>명 </td>
      </tr>
      <tr>
        <td> 객실시설 </td>
        <td colspan="3"> <%=rdto.getContent()%> </td>
      </tr>
    </table>
  
  </div>
  
 <%@ include file="../bottom.jsp"%>
</body>
</html>