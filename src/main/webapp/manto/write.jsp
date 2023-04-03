<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ include file="../top.jsp"%>
 <style>
  #section {
      width:1000px;
      height:500px;
      margin:auto;
      font-size:13px;
   }
  #section table {
     margin-top:30px;
     border-spacing:15px;
   }
  #section #submit {
      width:200px;
      height:32px;
      border:1px solid black;
      background:white;
      color:black;
      font-size:15px;
      font-weight:900;
   }
   #section #content {
      width:500px;
      height:120px;
      border:1px solid black;
      outline:none;
      resize:none;
   }
   #section #email {
      width:500px;   
      height:28px;
      border:1px solid black;
      outline:none;
   }
   #section #que {
      border:1px solid black;
      width:100px;
      height:30px;
      font-size:12px;
   }
 </style>
 <script>
   function len_check(my)
   {
	   document.getElementById("len").innerText=my.length; // 길이
   }
 </script>
  <div id="section">
    <form method="post" action="write_ok.jsp">
      <table width="650" align="center">
        <caption> <h3> 1:1 질문하기</h3></caption>
       <%
       if(session.getAttribute("userid")==null)
       {
       %>
        <tr> 
          <td> 이메일 </td>
          <td> <input type="text" name="email" id="email">
        </tr>
       <%
       }
       %>
        <tr>
          <td> 질문유형 </td>
          <td>
            <select name="que" id="que">
              <option value="0"> 회원관련 </option>
              <option value="1"> 예약관련 </option>
              <option value="2"> 객실관련 </option>
              <option value="3"> 결제관련 </option>
            </select>
          </td>
        </tr>
        <tr>
          <td> 질문내용<br> (<span id="len" style="color:red;"></span>자) </td>
          <td> <textarea name="content" id="content" maxlength="99" onkeyup="len_check(this.value)"></textarea> </td>
        </tr>
        <tr>
          <td colspan="2" align="center">
            <input type="submit" value="질문저장" id="submit">
          </td>
        </tr>
      </table>
    </form>
  
  </div>
  
 <%@ include file="../bottom.jsp"%>