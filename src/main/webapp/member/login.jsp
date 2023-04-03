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
		}
		#section input[type=password] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
		}
		#section input[type=submit] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
			color:black;
			background:white;
			font-weight:900;
		}
		#section input[type=button] {
			width:300px;
			height:33px;
			border:1px solid black;
			outline:none;
			color:black;
			background:white;
			font-weight:900;
		}
		#uform ,#pform {
			display:none;
		}
	</style>
	<script>
		function view_uform() {
			document.getElementById("uform").style.display="block";
			document.getElementById("pform").style.display="none";
		}
		function view_pform() {
			document.getElementById("pform").style.display="block";
			document.getElementById("uform").style.display="none";
		}
		function userid_search() {
			var chk=new XMLHttpRequest();
			var name=document.uform.name.value;
			var email=document.uform.email.value;
			chk.onload=function() {
				var userid=chk.responseText.trim();
				if(userid=="1")
					document.getElementById("msg").innerText="이름 혹은 이메일이 잘못되었습니다";
				else {		   
					document.getElementById("msg").innerText="아이디: "+userid;
					document.getElementById("uform").style.display="none"; 
				}
			}
			chk.open("get","userid_search.jsp?name="+name+"&email="+email);
			chk.send();
		}
		function pwd_search() {
			var chk=new XMLHttpRequest();
			var userid=document.pform.userid.value;
			var name=document.pform.name.value;
			var email=document.pform.email.value;
			chk.onload=function() {
				var pwd=chk.responseText.trim();
				if(pwd=="1")
					document.getElementById("msg").innerText="일치하는 정보가 없습니다";
				else {
					document.getElementById("msg").innerText="당신의 비밀번호 : "+pwd;
					document.getElementById("pform").style.display="none";
				}	   
			}
			chk.open("get","pwd_search.jsp?userid="+userid+"&name="+name+"&email="+email);
			chk.send();
		}
	</script>
	
	<div id="section">

		<form method="post" action="login_ok.jsp">
			<input type="hidden" name="y" value="<%=request.getParameter("y")%>">
			<input type="hidden" name="m" value="<%=request.getParameter("m")%>">
			<input type="hidden" name="d" value="<%=request.getParameter("d")%>">
			<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
			<input type="text" name="userid" placeholder="아이디" value="ksg"> <p>
			<input type="password" name="pwd" placeholder="비밀번호" value="123"> <p>
			<input type="submit" value="로그인">
		</form>
    
		<div align="center">
			<a href="javascript:view_uform()"> 아이디 찾기 </a>
			&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="javascript:view_pform()"> 비밀번호 찾기 </a>
		</div> 
		<p>
		<div id="msg" align="center"></div>
		
		<form name="uform" id="uform">
			<input type="text" name="name" placeholder="이름"> <p>
			<input type="text" name="email" placeholder="이메일"> <p>
			<input type="button" onclick="userid_search()" value="아이디찾기">
		</form>

		<form name="pform" id="pform">
			<input type="text" name="userid" placeholder="아이디"> <p>
			<input type="text" name="name" placeholder="이름"> <p>
			<input type="text" name="email" placeholder="이메일"> <p>
			<input type="button" onclick="pwd_search()" value="비밀번호찾기">
		</form>
	</div>

<%@ include file="../bottom.jsp"%>