<%@page import="user.UserVO"%>
<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	UserVO user = (UserVO)session.getAttribute("user");
	if(user == null || user.getUserType() != 0){
		out.print("fail");
		return;
	}
	
	String no = request.getParameter("no");
	
	int bno = Integer.parseInt(no); 
	
	groupDAO dao = new groupDAO();
	dao.delete(bno);
	out.print("success");
	System.out.println("?");
%>