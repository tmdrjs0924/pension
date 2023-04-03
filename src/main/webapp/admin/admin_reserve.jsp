<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %> 
<%@ page import="pension.dao.AdminDao" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="pension.dto.ReserveDto" %>
<%
		AdminDao adao=new AdminDao();
		adao.admin_reserve(request);
		
		ArrayList<ReserveDto> rlist=(ArrayList<ReserveDto>)request.getAttribute("rlist");
%>
<style>
  #section {
   width:780px;
   height:500px;
   margin:auto;
   text-align:center;
  }
  #info {
  	position:absolute;
  	visibility:hidden;
  	background:white;
  	text-align:right;
  	border:1px solid black;
  	padding:5px;
  }
</style>
<script>
  function view_info(my){
	  var userid=my.innerText;
	  var chk=new XMLHttpRequest();
	  var x=event.clientX;
	  var y=event.clientY;
	  chk.onload=function(){
		  document.getElementById("info").style.left=x+"px";
		  document.getElementById("info").style.top=y+"px";
	  	  document.getElementById("info").style.visibility="visible";
		  document.getElementById("info").innerHTML=chk.responseText.trim();
	  }
	  chk.open("get", "getInfo.jsp?userid="+userid);
	  chk.send();
  }
  function hide_info(my){
	  document.getElementById("info").style.visibility="hidden";
  }
</script>
 <div id="section">
  <div id="info"></div>
  <table width="700" align="center">
    <tr>
      <td> 객실명 </td>
      <td> 예약자 </td>
      <td> 입실일 </td>
      <td> 퇴실일 </td>
      <td> 숙박일 </td>
      <td> 숯불패키지 </td>
      <td> 비비큐 </td>
      <td> 결제금액 </td>
    </tr>
<%
	for(int i=0;i<rlist.size();i++){
%>
    <tr>
      <td> <%=rlist.get(i).getName() %> </td>
      <td onmouseover="view_info(this)" onmouseout="hide_info(this)"><%=rlist.get(i).getUserid() %> </a> </td>
      <td> <%=rlist.get(i).getInday() %> </td>
      <td> <%=rlist.get(i).getOutday() %> </td>
      <td> <%=rlist.get(i).getSuk() %> </td>
      <td> <%=rlist.get(i).getChacol() %> </td>
      <td> <%=rlist.get(i).getBbq() %> </td>
      <td> <%=String.format("%,d", rlist.get(i).getTprice()) %> </td>
    </tr>
<%
	}
%>
  </table>
 
 </div>
</body>
</html>