<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<!-- list.jsp -->
<%@page import="pension.dao.TourDao" %>
<%@page import="java.util.ArrayList" %>
<%@page import="pension.dto.TourDto" %>
<%
    TourDao tdao=new TourDao();
    tdao.list(request);
    
    ArrayList<TourDto> tlist=(ArrayList<TourDto>)request.getAttribute("tlist");
%>
 <style>
   #section {
      width:1000px;
      height:500px;
      margin:auto;
      color:black;
   }
      #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#eeeeee;
   }
   #section table tr:first-child:hover {
      background:white;
   }
 
   #section table td {
     height:30px;
     font-size:13px;
   }
   #section table td {
     border-bottom:1px solid black;
   }
   #section table tr:first-child td {
     border-top:2px solid black;
     font-weight:900;
   }
   #section table tr:last-child td {
     border-bottom:2px solid black;
   }
   #section a {
     color:black;
   }
   #section #write:hover {
     background:white;
   }
 </style>
 
  <div id="section">
    <table width="700" align="center">
      <caption> <h3> 여 행 후 기 </h3></caption>
      <tr align="center">
        <td> 제 목 </td>
        <td> 작성자 </td>
        <td> 조회수 </td>
        <td> 작성일 </td>
      </tr>
    <%
     for(int i=0;i<tlist.size();i++)
     {
    %> 
      <tr>
        <td> <a href="readnum.jsp?id=<%=tlist.get(i).getId()%>"> <%=tlist.get(i).getTitle()%> </a> </td>
        <td align="center"> <%=tlist.get(i).getName()%> </td>
        <td align="center"> <%=tlist.get(i).getReadnum()%> </td>
        <td align="center"> <%=tlist.get(i).getWriteday()%> </td>
      </tr>
    <%
     }
    %>  
    
    <%
    if(session.getAttribute("userid") != null)
    {
    %>
      <tr align="center" id="write">
        <td colspan="4"> <a href="write.jsp"> 글쓰기 </a> </td>
      </tr>
    <%
    }
    %>
    </table>
  </div>
  
 <%@ include file="../bottom.jsp"%>