<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%
    GongjiDao gdao=new GongjiDao();
    gdao.content(request);
    GongjiDto gdto=(GongjiDto)request.getAttribute("gdto");
%>    
 <%@ include file="../top.jsp"%>
 
 <style>
   #section {
      width:1000px;
      height:500px;
      margin:auto;
   }
   #section a {
     color:black;
     font-weight:900;
     border:1px solid black;
     width:100px;
     height:25px;
     padding-top:3px;
     display:inline-block;
     font-size:15px;
   }
   #section a:hover {
     color:white;
     border:1px solid black;
     background:black;
    }
   #section table {
      border-spacing:0px;
    }
   #section table td {
     border-bottom:1px solid black;
     height:30px;
     font-size:13px;
   }
   #section table #menu td {
     border-bottom:none;
     height:50px;
   }
   #section table tr:last-child td {
     border-bottom:none;
     height:60px;
   }
   #section #content {
     width:100%;
     height:100%;
     overflow:auto;
     word-break:break-all;
   }
 </style>
 
  <div id="section">
  <table width="600" align="center">
    <caption> <h3> 공지사항 내용 </h3></caption>
    <tr>
      <td width="120"> 제 목 </td>
      <td> <%=gdto.getTitle()%> </td>
    </tr>
    <tr>
      <td> 조회수 </td>
      <td> <%=gdto.getReadnum()%> </td>
    </tr>
    <tr>
      <td> 작성일 </td>
      <td> <%=gdto.getWriteday()%> </td>
    </tr>
    <tr height="220">
      <td> 내 용 </td>
      <td> <div id="content">  <%=gdto.getContent().replace("\r\n","<br>")%> </div></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <a href="list.jsp"> 목록 </a>
      <%
       // 관리자만 볼수 있게
    if(session.getAttribute("userid")!=null)
    {
       if(session.getAttribute("userid").equals("admin"))
       {
     %>    
        <a href="update.jsp?id=<%=gdto.getId()%>"> 수정 </a>
        <a href="delete.jsp?id=<%=gdto.getId()%>"> 삭제 </a>
       <%
       }
    }
     %>    
      </td>
    </tr>
   
  </table>
</div>
  
 <%@ include file="../bottom.jsp"%>