<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	UserVO user = (UserVO)session.getAttribute("user");	
	
	String pw = request.getParameter("password");
	
	if(pw == null){
		response.sendRedirect("findpwok.jsp");
		return;
	}
	
	if(pw.isEmpty()){
		response.sendRedirect("findpwok.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	
	vo.setPw(pw);
	
	dao.changepw(vo);
	
	session.setAttribute("user", user);
	
	response.sendRedirect("login.jsp");
%>