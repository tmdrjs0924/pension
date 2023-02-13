<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 쿠키를 읽어오기
	Cookie[] cookie=request.getCookies();

	for(int i=0;i<cookie.length;i++)
	{
		if(cookie[i].getName().equals("chk"))
			out.print(cookie[i].getValue()+"<br>");
	}
%>
</body>
</html>