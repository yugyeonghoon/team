<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<%
	if(user == null || user.getUserType() != 0){
		response.sendRedirect("board.jsp");
		return;
	}
	
	String no = request.getParameter("no");
	
	int bno = Integer.parseInt(no); 
	
	groupDAO dao = new groupDAO();
	dao.delete(bno);
	
	response.sendRedirect("group_management.jsp");
%>