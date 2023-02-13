<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="top.jsp" %> 
<style>
  #section {
   width:780px;
   height:500px;
   margin:auto;
  }
</style>
 <div id="section">

 <form method="post" action="room_add_ok.jsp" enctype="multipart/form-data">
   <table width="780">
     <caption><h3> 객실추가 </h3></caption>
     <tr>
       <td> 객실명 </td>
       <td> <input type="text" name="name"> </td>
     </tr>
     <tr>
       <td> 객실사진 </td>
       <td>
         <input type="file" name="img1"><br>
         <input type="file" name="img2"><br>
         <input type="file" name="img3"><br>
         <input type="file" name="img4"><br>
         <input type="file" name="img5"><br>
         <input type="file" name="img6">
       </td>
     </tr>
     <tr>
       <td> 숙박료(1박) </td>
       <td> <input type="text" name="price"> </td>
     </tr>
     <tr>
       <td> 최소인원 </td>
       <td>
         <select name="min">
<%
		for(int i=1;i<=20;i++){
%>
           <option value="<%=i%>"> <%=i%>명 </option>
<%
		}
%>
         </select>
       </td>
     </tr>
     <tr>
       <td> 최대인원 </td>
       <td>
         <select name="max">
<%
		for(int i=1;i<=20;i++){
%>
           <option value="<%=i%>"> <%=i%>명 </option>
<%
		}
%>
         </select>
       </td>
     </tr>
     <tr>
       <td> 객실내용 </td>
       <td> <textarea rows="7" cols="70" name="content"></textarea> </td>
     </tr>
     <tr>
       <td colspan="2" align="center">
         <input type="submit" value="추가">
         <input type="button" value="취소" onclick="location='admin_room.jsp'">
       </td>
     </tr>
   </table>
 </form>
 
 </div>
</body>
</html>