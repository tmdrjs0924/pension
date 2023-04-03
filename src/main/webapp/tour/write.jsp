<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ include file="../top.jsp"%>
 <!-- write.jsp -->
 <style>
   #section {
      width:1000px;
      height:500px;
      margin:auto;
   }
    #section #title {
      width:440px;
      height:28px;
      border:1px solid black;
      outline:none;
   }
    #section #content {
      width:440px;
      height:120px;
      border:1px solid black;
      outline:none;
   }
   #section #submit {
      width:200px;
      height:32px;
      border:1px solid black;
      outline:none;
      background:white;
      color:black;
      font-size:15px;
      font-weight:900;
   }
 </style>
 <script>
  function add_form()
  {
	  var size=document.getElementsByClassName("up").length;
	  if(size<10)
	  {
	     var outer=document.getElementById("outer2");
	     outer.innerHTML=outer.innerHTML+"<p class='up'> <input type='file' name='fname"+(size+1)+"'> </p> ";
         
	     document.getElementById("section").style.height=500+(size*30)+"px";
	  }
  }
  function del_form()
  {
	  // class='up'의 크기를 알수 있다
	  //alert(document.getElementsByClassName("up").length);
	  var size=document.getElementsByClassName("up").length;
	  if(size!=1) // 하나만 남았을경우 삭제 중지
	    document.getElementsByClassName("up")[size-1].remove();
  }
 </script>
  <div id="section">
    <form method="post" action="write_ok.jsp" enctype="multipart/form-data">
      <table width="600" align="center">
        <caption> <h3> 여행후기 작성 </h3></caption>
        <tr>
          <td> 제 목 </td>
          <td> <input type="text" name="title" id="title"> </td>        
        </tr>
        <tr>
          <td> 내 용 </td>
          <td> <textarea name="content" id="content"></textarea> </td>
        </tr>
        <tr>
          <td> 사 진 </td>
          <td id="outer2">
           <input type="button" value="추가" onclick="add_form()"> <input type="button" value="삭제" onclick="del_form()">
           <p class="up"> <input type="file" name="fname1"> </p> 
           
          </td>
        </tr>
        <tr>
          <td colspan="2" align="center"> <input type="submit" value="후기 작성" id="submit"> </td>
        </tr>
      </table>
    </form>
    
  
  </div>
  
 <%@ include file="../bottom.jsp"%>