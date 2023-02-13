<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // mycookie.jsp
    Cookie cookie=new Cookie("chk","11");
    cookie.setMaxAge(600);
    response.addCookie(cookie);
%>