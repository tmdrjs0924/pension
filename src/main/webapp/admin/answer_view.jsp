<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="pension.dao.AdminDao" %>
<%
     AdminDao adao=new AdminDao();
     adao.answer_view(request,out);
%>     