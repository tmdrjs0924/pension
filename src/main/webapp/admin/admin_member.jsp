<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.MemberDto" %>
<%@page import="java.util.ArrayList" %>
<%
if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals("admin")) )
{
	response.sendRedirect("../main/main.jsp");
}
else
{
   AdminDao adao=new AdminDao();
   adao.admin_member(request, session, response);
   ArrayList<MemberDto> mlist=(ArrayList<MemberDto>)request.getAttribute("mlist");
%>    
<%@ include file="top.jsp" %> 
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
   text-align:center;
  }
</style>
 <div id="section">
   <table width="700" align="center">
     <caption> <h3> 회원 목록 </h3></caption>
     <tr>
       <td> 사용자 아이디 </td>
       <td> 이 름 </td>
       <td> 전화번호 </td>
       <td> 가입일 </td>
       <td> 회원상태 </td>
       <td> 탈퇴승인 </td>
     </tr>
    <%
    for(int i=0;i<mlist.size();i++)
    {
    	String state;
    	switch(mlist.get(i).getState())
    	{
    	   case 0: state="정상회원"; break;
    	   case 1: state="탈퇴신청중"; break;
    	   case 2: state="탈퇴회원"; break;
    	   default: state="오류";
    	}
    %> 
     <tr>
       <td> <%=mlist.get(i).getUserid()%> </td>
       <td> <%=mlist.get(i).getName()%> </td>
       <td> <%=mlist.get(i).getPhone()%> </td>
       <td> <%=mlist.get(i).getWriteday()%> </td>
       <td> <%=state%></td>
       <td>
        <%
        if(mlist.get(i).getState()==1) // 탈퇴신청을 한 회원만 : state필드의 값이 1인 경우
        {
        %> 
          <a href="member_out_ok.jsp?id=<%=mlist.get(i).getId()%>"> 탈퇴</a>
          <!-- 클릭하면 member테이블의 state필드를 2로 변경 -->
        <%
        }
        %> 
       </td>
       
     </tr>
    <%
    }
    %>
     
   </table>
 
 </div>
</body>
</html>
<%
}
%>