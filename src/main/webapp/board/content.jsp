<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
<%@page import="pension.dao.BoardDao" %>
<%@page import="pension.dto.BoardDto" %>
<%
    BoardDao bdao=new BoardDao();
    bdao.content(request);
    
    BoardDto bdto=(BoardDto)request.getAttribute("bdto");
%>
 <style>
   #section {
     width:1000px;
     height:500px;
     margin:auto;
     color:black;
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
   }

 #section input[type=submit] {
      width:100px;
      height:32px;
      border:1px solid black;
      outline:none;
      background:white;
      color:black;
      font-weight:900;
   }
   #section input[type=password] {
      width:60px;
      height:28px;
      border:1px solid black;
      outline:none;
 
   }
 #section #content {
     width:100%;
     height:100%;
     overflow:auto;
     word-break:break-all;
   }
    </style>
 <script>
 
 function viewdel()
 {
 	document.getElementById("delform").style.display="table-row";
 }
</script>
 </script>
 <div id="section">
   <table width="700" align="center">
    <caption> <h3> 게시판 내용 </h3></caption>
    <tr>
      <td width="120"> 제 목 </td>
      <td> <%=bdto.getTitle()%> </td>
    </tr>
    <tr>
      <td> 이 름 </td>
      <td> <%=bdto.getName()%> </td>
    </tr>
    <tr>
      <td> 조회수 </td>
      <td> <%=bdto.getReadnum()%> </td>
    </tr>
    <tr>
      <td> 작성일 </td>
      <td> <%=bdto.getWriteday()%> </td>
    </tr>
    <tr height="150">
      <td> 내 용 </td>
      <td> <div id="content"> <%=bdto.getContent().replace("\r\n","<br>")%> </div></td>
    </tr>
    <tr>
      <td> 좋아하는여행지 </td>
      <td> <%=bdto.getDest()%> </td>
    </tr>
    <tr align="center" id="menu">
      <td colspan="2">
       <a href="list.jsp?"> 목록 </a> 
       <a href="update.jsp?id=<%=bdto.getId()%>"> 수정 </a>
      <%
      if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals(bdto.getUserid())) )
      {
      %>
       <a href="javascript:viewdel()"> 삭제 </a>
      <%
      }
      else
      {
      %> 
       <a href="delete.jsp?id=<%=bdto.getId()%>"> 삭제 </a>
      <%
      }
      %> 
      </td>
    </tr>
    <tr id="delform" align="center" style="display:none;">
      <td colspan="2">
        <form method="post" action="delete.jsp">
          <input type="hidden" name="id" value="<%=bdto.getId()%>">
          <input type="password" name="pwd" placeholder="비밀번호" size="5">
          <input type="submit" value="삭제">
        </form>
      </td>
    </tr>
  </table>
 
 </div>


<%@ include file="../bottom.jsp"%>