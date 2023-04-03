<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>

 <style>
   #section {
     width:1000px;
     height:400px;
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
     font-weight:900;
   }
   #section a {
     color:black;
   }
 </style>
 <div id="section">
   
 <%@page import="pension.dao.BoardDao" %>
<%@page import="pension.dto.BoardDto" %>
<%@page import="java.util.ArrayList" %>
<%
    BoardDao bdao=new BoardDao();
    bdao.list(request);
    
    ArrayList<BoardDto> list=(ArrayList<BoardDto>)request.getAttribute("list");
 %> 
 
 <table width="600" align="center">
  <caption> <h3> 자유 게시판 </h3></caption>
  <tr align="center">
    <td> 제 목 </td>
    <td> 이 름 </td>
    <td> 조회수 </td>
    <td> 작성일 </td>
  </tr>
  <%
      // list는 ArrayList
    for(int i=0;i<list.size();i++)
    {
       BoardDto bdto=list.get(i);
  %>
  <tr align="center">
    <td align="left"> <a href="readnum.jsp?id=<%=bdto.getId()%>"> <%=bdto.getTitle()%> </a> </td>
    <td> <%=bdto.getName()%> </td>
    <td> <%=bdto.getReadnum()%> </td>
    <td> <%=bdto.getWriteday()%> </td>
  </tr>
  <%
    }
  %>
  
  <tr>
    <td colspan="4" align="center"> <a href="write.jsp"> 글쓰기 </a> </td>
  </tr>
 </table>
  
 </div>


<%@ include file="../bottom.jsp"%>