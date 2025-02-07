<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	UserDAO dao = new UserDAO();
	dao.delete(user.getId());
	
	session.invalidate();
	response.sendRedirect("login.jsp");
%>