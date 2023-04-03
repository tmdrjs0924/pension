<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="top.jsp" %> 
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
   text-align:center;
  }
</style>
 <div id="section">
 
<%@ page import="pension.dao.AdminDao"%>
<%@ page import="pension.dto.EventDto" %>
<%@ page import="java.util.ArrayList" %>
<%
   		AdminDao adao=new AdminDao();
   		adao.main_list(request);
   		
   		ArrayList<EventDto> elist=(ArrayList<EventDto>)request.getAttribute("elist");
%>
	<table width="400" align="center">
	  <caption><h3> 이벤트 현황 </h3></caption>
	  <tr>
	    <td> 이벤트 제목 </td>
	    <td> 등록일 </td>
	    <td> 삭제 </td>
	  </tr>
<%  		
   		for(int i=0;i<elist.size();i++){
%>
      <tr>
        <td> <%=elist.get(i).getTitle()%> </td>
        <td> <%=elist.get(i).getWriteday()%> </td>
        <td><a href="admin_event_delete.jsp?id=<%=elist.get(i).getId()%>"> click </a></td>
      </tr>
<%
   		}
%>
  	  <tr>
  	    <td colspan="2" align="center"> <input type="button" value="이벤트추가" onclick="location='admin_event_add.jsp'"> </td>
  	  </tr>
	</table>
 
 </div>
</body>
</html>
</body>
</html>