<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("mail");
	UserDAO dao = new UserDAO();
	int result = dao.idemail(id, email);
	out.println(result);
%>