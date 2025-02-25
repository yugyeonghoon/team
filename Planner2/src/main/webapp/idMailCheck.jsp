<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	UserDAO dao = new UserDAO();
	int result = dao.nameemail(name, email);
	out.println(result);
%>