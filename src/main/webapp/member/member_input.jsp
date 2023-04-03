<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../top.jsp"%>
	<style>
		#section {
			width:1000px;
			height:820px;
			margin:auto;
			text-align:center;
			margin-top:100px;
		}
		#section input[type=text] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
			border-radius:3px;
		}
		#section input[type=password] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
			border-radius:3px;
		}
		#section input[type=submit] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
			color:black;
			background:white;
			font-weight:600;
			border-radius:3px;
		}
	</style>
	<script>
		function userid_check(userid) {
			if(userid.trim().length==0) {
				alert("아이디를 입력해 주세요");
			}
			else {
				var chk=new XMLHttpRequest();
				chk.onload=function() {
					if(chk.responseText.trim()=="0") {
						document.getElementById("umsg").innerText="사용 불가능한 아이디";
						document.getElementById("umsg").style.color="red";
					}	
					else {
						document.getElementById("umsg").innerText="사용 가능한 아이디";
						document.getElementById("umsg").style.color="blue";
					}
	      }
	      chk.open("get","userid_check.jsp?userid="+userid);
	      chk.send();
			}
		}
		function pwd_check() {
			if(document.pkc.pwd.value.trim()!="" && document.pkc.pwd2.value.trim()!="") {
				if(document.pkc.pwd.value == document.pkc.pwd2.value) {
					document.getElementById("pmsg").innerText="비밀번호가 일치합니다";
					document.getElementById("pmsg").style.color="blue";
				}	
				else {
					document.getElementById("pmsg").innerText="비밀번호가 불일치합니다";
					document.getElementById("pmsg").style.color="red";
				}
			}
		}
	</script>
  
  <div id="section">
    <div align="center"><h3> 회원가입 </h3></div>
    <form name="pkc" method="post" action="member_input_ok.jsp">
       <input type="text" name="userid" placeholder="아이디" onkeyup="userid_check(this.value)">
       <br> <span id="umsg" style="font-size:12px;"></span> 
       <p> 
       <input type="text" name="name" placeholder="이름"> <P>
       <input type="password" name="pwd" placeholder="비밀번호" onblur="pwd_check()"> <p>
       <input type="password" name="pwd2" placeholder="비밀번호 확인" onkeyup="pwd_check()"> 
       <br> <span id="pmsg" style="font-size:12px;"></span>
       <p>
       <input type="text" name="phone" placeholder="전화번호"> <p>
       <input type="text" name="email" placeholder="이메일"> <p>
       <input type="submit" value="가입하기">
    </form>
  </div>
  
 <%@ include file="../bottom.jsp"%>