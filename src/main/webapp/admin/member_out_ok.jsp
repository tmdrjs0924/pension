<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%
     AdminDao adao=new AdminDao();
     adao.member_out_ok(request,session,response);
%> 