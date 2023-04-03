<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%@page import="java.util.ArrayList" %>
<%
    GongjiDao gdao=new GongjiDao();
    gdao.list(request);
    
    ArrayList<GongjiDto> glist=(ArrayList<GongjiDto>)request.getAttribute("glist");
%>    
 <%@ include file="../top.jsp"%>
 <!-- list.jsp -->
 <style>
   #section {
      width:1000px;
      height:500px;
      margin:auto;
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
 </style>
 
  <div id="section">
    <table width="700" align="center">
      <caption> <h3> 공지사항 </h3></caption>
      <tr align="center">
        <td> 제목 </td>
        <td> 작성자 </td>
        <td> 조회수 </td>
        <td> 작성일 </td>
      </tr>
     <%
     for(int i=0;i<glist.size();i++)
     {
    	 String tt="";
    	 if(glist.get(i).getChk()==1)
    		 tt="<b style='color:red;'>[공지]</b>";
     %> 
      <tr>
        <td> <a href="readnum.jsp?id=<%=glist.get(i).getId()%>"> <%=tt%>  <%=glist.get(i).getTitle() %> </a> </td>
        <td align="center"> 관리자 </td>
        <td align="center"> <%=glist.get(i).getReadnum() %> </td>
        <td align="center"> <%=glist.get(i).getWriteday() %> </td>
      </tr>
     <% 
     }
     %> 
     
     <%
       // 관리자만 볼수 있게
    if(session.getAttribute("userid")!=null)
    {
       if(session.getAttribute("userid").equals("admin"))
       {
     %>
      <tr>
        <td colspan="4" align="center">
          <a href="write.jsp">공지사항 글쓰기</a>
        </td>
      </tr>
     <%
       }
    }
     %> 
    </table>
  
  </div>
  
 <%@ include file="../bottom.jsp"%>




