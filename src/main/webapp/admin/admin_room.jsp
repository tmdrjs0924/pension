<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="top.jsp" %> 
<%@ page import="pension.dao.AdminDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pension.dto.RoomDto" %>
<%
		AdminDao adao=new AdminDao();
		adao.getRoom(request);
		
		ArrayList<RoomDto> rlist=(ArrayList<RoomDto>)request.getAttribute("rlist");
%>
<style>
  #section {
   width:780px;
   height:500px;
   margin:auto;
  }
  .layer{
  	display:none;
  	height:100px;
  	width:700px;
  }
  #view{
  	cursor:pointer;
  }
</style>
<script>
  function view(n){
	  if(document.getElementsByClassName("layer")[n].style.display=="none")
		  document.getElementsByClassName("layer")[n].style.display="table-row";
	  else
		  document.getElementsByClassName("layer")[n].style.display="none";
  }
</script>
 <div id="section">
 
   <table width="780" align="center">
     <caption><h3> 객실현황 </h3></caption>
       <tr align="center">
         <td> 객실명 </td>
         <td> 숙박료(1박) </td>
         <td> 최소인원 </td>
         <td> 최대인원 </td>
         <td> 등록일 </td>
         <td> 수정 </td>
         <td> 삭제 </td>
       </tr>
<%
	for(int i=0;i<rlist.size();i++){
%>
       <tr align="center" onclick="view(<%=i%>)" id="view">
         <td> <%=rlist.get(i).getName()%> </td>
         <td> <%=String.format("%,d", rlist.get(i).getPrice())%> </td>
         <td> <%=rlist.get(i).getMin()%> </td>
         <td> <%=rlist.get(i).getMax()%> </td>
         <td> <%=rlist.get(i).getWriteday()%> </td>
         <td> <a href="room_update.jsp?id=<%=rlist.get(i).getId()%>"> click </a> </td>
         <td> <a href="room_delete.jsp?id=<%=rlist.get(i).getId()%>"> click </a> </td>
       </tr>
	   <tr class="layer">
	     <td colspan="3" width="385">
<%
	if(rlist.get(i).getImg()!=null && !rlist.get(i).getImg().trim().equals("")){
		String[] img=rlist.get(i).getImg().split(",");
		for(int j=0;j<img.length;j++){
			
%>
		   <img src="../room/img/<%=img[j]%>" width="70" height="50">
<%
		}
	}
%>
		 </td>
	     <td colspan="4" valign="top" width="395">
	       객실시설 <br> <%=rlist.get(i).getContent() %>
	     </td>
	   </tr>
<%
	}
%>
   </table>
   <p align="center"> <input type="button" onclick="location='room_add.jsp'" value="객실추가"> </p>
 </div>
</body>
</html>