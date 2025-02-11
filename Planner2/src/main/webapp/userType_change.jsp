<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<%
	String id = request.getParameter("id");
	String userType = request.getParameter("changeType");
	
	if(id == null || userType == null){
		response.sendRedirect("user_update");
		return;
	}
	
	if(id.isEmpty() || userType.isEmpty()){
		response.sendRedirect("user_update");
		return;
	}
	
	int userTypeNum = Integer.parseInt(userType);

	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	
	vo.setId(id);
	vo.setUserType(userTypeNum);
	
	dao.changeType(vo);
	
	response.sendRedirect("user_update.jsp");
%>