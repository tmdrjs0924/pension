<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="top.jsp" %> 
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
   margin-top:50px;
  }
</style>
 <div id="section">
 
   <form method="post" action="admin_event_add_ok.jsp" enctype="multipart/form-data">
     <table width="400" align="center">
       <tr>
         <td> 이벤트 개요 </td>
         <td> <input type="text" name="title"> </td>
       </tr>
       <tr>
         <td> 이벤트 그림</td>
         <td> <input type="file" name="img"> </td>
       </tr>
       <tr>
         <td colspan="2" align="center"> <input type="submit" value="이벤트등록"> </td>
       </tr>
     </table>
   </form>
 
 </div>
</body>
</html>