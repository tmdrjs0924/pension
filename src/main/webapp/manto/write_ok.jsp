<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MantoDao" %>    
<%
    MantoDao mdao=new MantoDao();
    mdao.write_ok(request, session, response);
%>