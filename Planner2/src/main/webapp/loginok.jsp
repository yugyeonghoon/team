<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("username");
	String pw = request.getParameter("password");
	
	if(id == null || pw == null){
		response.sendRedirect("login.jsp");
		return;
	}
	
	if(id.isEmpty() || pw.isEmpty()){
		response.sendRedirect("login.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	vo.setId(id);
	vo.setPw(pw);
	
	UserVO user = dao.login(vo);
	if(user == null){
		response.sendRedirect("login.jsp");
		return;
	}
	
	session.setAttribute("user", user);
	
	response.sendRedirect("calendar.jsp");
%>