<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao"%>
<%
    TourDao tdao=new TourDao();
    tdao.update_ok(request, response);
%>