<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("username");
	String pw = request.getParameter("password");
	String email = request.getParameter("email");
	String nick = request.getParameter("nickname");
	String birth = request.getParameter("birth");
	
	if(id == null || pw == null || email == null || nick == null || birth == null){
		response.sendRedirect("signup.jsp");
		return;
	}
	
	if(id.isEmpty() || pw.isEmpty() || email.isEmpty() || nick.isEmpty() || birth.isEmpty()){
		response.sendRedirect("signup.jsp");
		return;
	}

	UserDAO dao = new UserDAO();
	
	UserVO vo = new UserVO();
	vo.setId(id);
	vo.setPw(pw);
	vo.setEmail(email);
	vo.setNick(nick);
	vo.setBirth(birth);
	
	dao.join(vo);
	
	response.sendRedirect("login.jsp");
%>

	
