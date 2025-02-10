<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	if(user == null || user.getUserType() != 0){
		response.sendRedirect("board.jsp");
		return;
	}

	String userId = request.getParameter("userId");
	if(userId == null){
		response.sendRedirect("board.jsp");
		return;
	}
	
	if(userId.isEmpty()){
		response.sendRedirect("board.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	dao.delete(userId);
	
	response.sendRedirect("user_management.jsp");
	
%>