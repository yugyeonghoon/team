<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>    
<%
	request.setCharacterEncoding("utf-8");	
	
	String nick = request.getParameter("nickname");
	String pw = request.getParameter("password");
	
	if(nick == null || pw == null){
		response.sendRedirect("profile.jsp");
		return;
	}
	
	if(nick.isEmpty() || pw.isEmpty()){
		response.sendRedirect("profile.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	vo.setNick(nick);
	vo.setPw(pw);
	vo.setId(user.getId());
	
	dao.update(vo);
	
	user.setNick(nick);
	session.setAttribute("user", user);
	
	response.sendRedirect("profile.jsp");
%>