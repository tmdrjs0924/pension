<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="top.jsp" %> 
<%@ page import="pension.dao.AdminDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pension.dto.RoomDto" %>
<%
		AdminDao adao=new AdminDao();
		adao.room_update(request);
		
		RoomDto rdto=(RoomDto)request.getAttribute("rdto");
%>

<style>
  #section {
   width:780px;
   height:500px;
   margin:auto;
  }
  .fname{
  	display:none;
  }
</style>
<script>
  window.onload=function(){
	  document.rform.min.value=<%=rdto.getMin()%>
	  document.rform.max.value=<%=rdto.getMax()%>
	  
	  // 사진파일 갯수를 최대3개로 지정할 때..
	  var len=document.getElementsByClassName("chk").length;
	  //alert(len);
	  for(i=0;i<6-len;i++){  // 6-len => 보여질 input태그의 갯수
		  document.getElementsByClassName("fname")[i].style.display="inline";
	  }
  }
  function check(){
	  // 삭제할 그림파일은 delimg 변수, 남길 그림파일은 eximg 변수에 저장
	  var delimg="";
	  var eximg="";
	  var n=0;
	  var chk=document.getElementsByClassName("chk");
	  for(i=0;i<chk.length;i++) // 체크박스가 있는 만큼 동작
	  {
		  if(chk[i].checked)
		  {
			  delimg=delimg+chk[i].value+","; // 삭제할 그림  
		  }
		  else
		  {
			  eximg=eximg+chk[i].value+",";  // 남길 그림
			  n++;
		  }
	  }
	  document.rform.delimg.value=delimg;
	  document.rform.eximg.value=eximg;
	  
	  for(i=0;i<6;i++)
	  {
		  document.getElementsByClassName("fname")[i].style.display="none";
	  }
	   
	  // type="file"의 갯수를 변화 (삭제하고자 하는 그림이 발생하면)
	  // 3 - 체크안된 체크박스갯수만큼 type="file"을 추가 
	  for(i=0;i<6-n;i++)
	  {
		  document.getElementsByClassName("fname")[i].style.display="inline";
	  }
  }
</script>
 <div id="section">

 <form name="rform" method="post" action="room_update_ok.jsp" enctype="multipart/form-data" onsubmit="return check()">
   <input type="hidden" name="delimg">
   <input type="hidden" name="eximg">
   <input type="hidden" name="id" value="<%=rdto.getId()%>">
   <table width="780">
     <caption><h3> 객실추가 </h3></caption>
     <tr>
       <td> 객실명 </td>
       <td> <input type="text" name="name" value="<%=rdto.getName()%>"> </td>
     </tr>
     <tr>
       <td> 객실사진 </td>
       <td>
     <%
     	if(rdto.getImg()!=null && !rdto.getImg().trim().equals("")){
     		String[] img=rdto.getImg().split(",");
     		for(int i=0;i<img.length;i++){
     %>
     	<img src="../room/img/<%=img[i]%>" width="50" height="50" class="img">
     	<input type="checkbox" onclick="check()" value="<%=img[i]%>" class="chk">
     <%
     		}
     	}
     %>
     	<br> <span style="color:red;font-size:13px;"> 삭제할 그림은 체크하세요 </span> <br>
         <input type="file" name="img1" class="fname"><br>
         <input type="file" name="img2" class="fname"><br>
         <input type="file" name="img3" class="fname"><br>
         <input type="file" name="img4" class="fname"><br>
         <input type="file" name="img5" class="fname"><br>
         <input type="file" name="img6" class="fname"><br>
       </td>
     </tr>
     <tr>
       <td> 숙박료(1박) </td>
       <td> <input type="text" name="price" value="<%=rdto.getPrice()%>"> </td>
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
       <td> <textarea rows="7" cols="70" name="content"><%=rdto.getContent()%></textarea> </td>
     </tr>
     <tr>
       <td colspan="2" align="center">
         <input type="submit" value="수정" onclick="check()">
         <input type="button" value="취소" onclick="location='admin_room.jsp'">
       </td>
     </tr>
   </table>
 </form>
 
 </div>
</body>
</html>