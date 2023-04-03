<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao" %> 
<%@page import="pension.dto.TourDto" %>   
<%
    TourDao tdao=new TourDao();
    tdao.content(request);
    TourDto tdto=(TourDto)request.getAttribute("tdto");
    
    String[] fname=(String[])request.getAttribute("fname");
    String userid=request.getAttribute("userid").toString();
%>    
<%@ include file="../top.jsp"%>
 
 <style>
   #section {
      width:1000px;
      height:600px;
      margin:auto;
      position:relative;
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
   }
   #section #img_layer {
     position:absolute;
     left:200px;
     width:600px;
     height:400px;
     visibility:hidden;
     border:1px solid black;
     background:white;
   }
    #section #content {
     width:100%;
     height:100%;
     overflow:auto;
     word-break:break-all; /* 스페이스 없을경우 한줄로 나오는것을 줄을바꾸게 하기*/
   }
   /*
     word-break:normal; 생략과 동일 => 영역내에서 over되는 한글은 줄이바뀜, 영어는 안바뀜
     word-break:break-all; => 전부 줄이 바뀜
     word-break:keep-all;  => 전부 줄이 안바뀜
   */
 </style>
 <script>
   function view(my)
   {
	   document.getElementById("img_layer").style.visibility="visible";
	   document.getElementById("img").src=my;
   }
   function hide()
   {
	   document.getElementById("img_layer").style.visibility="hidden";
   }
   
 </script>
  <div id="section">
  
   <!-- 큰 그림을 보여줄 레이어 -->
   <div id="img_layer"><img src="" width="100%" height="100%" id="img" onclick="hide()"></div>
  
   <table width="600" align="center">
     <caption> <h3> 여행후기 내용 </h3></caption>
     <tr>
       <td width="120"> 제 목 </td>
       <td> <%=tdto.getTitle()%> </td>
     </tr>
     <tr>
       <td> 작성자 </td>
       <td> <%=tdto.getUserid()%> </td>
     </tr>
     <tr>
       <td> 조회수 </td>
       <td> <%=tdto.getReadnum()%> </td>
     </tr>
     <tr>
       <td> 작성일 </td>
       <td> <%=tdto.getWriteday()%> </td>
     </tr>
     <tr height="220">
       <td> 내 용 </td>
       <td width="480"> <div id="content"> <%=tdto.getContent().replace("\r\n","<br>")%> </div></td>
     </tr>
     <tr height="110">
       <td> 사 진 </td>
       <td>
        <%
         for(int i=0;i<fname.length;i++)
         {
        %>
         <img src="img/<%=fname[i]%>" width="100" height="100" onclick="view(this.src)">
        <%
         }
        %>
       </td>
     </tr>
     <tr>
       <td colspan="2" align="center">
         <a href="list.jsp"> 목록 </a>
       <%
        // 수정 삭제 링크는 본인의 글일 경우 나타나기                        객체명.equals(객체명)
        if(session.getAttribute("userid")!=null && session.getAttribute("userid").equals(userid))
        {
       %>        
         <a href="update.jsp?id=<%=tdto.getId()%>"> 수정 </a>
         <a href="delete.jsp?id=<%=tdto.getId()%>"> 삭제 </a>
       <%
        }
       %>  
       </td>
     </tr>
   </table>
  
  </div>
  
 <%@ include file="../bottom.jsp"%>
 
 
 
 
 
 