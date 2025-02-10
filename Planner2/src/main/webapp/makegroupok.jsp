<%@page import="group.groupVO"%>
<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String gnum = request.getParameter("gnum");
	
	groupDAO dao = new groupDAO();
	groupVO vo = new groupVO();
	
	int gnum2 = Integer.parseInt(gnum);
	
	vo.setGroupNum(gnum2);
	
	dao.insertGroup(vo);
	
	response.sendRedirect("group.jsp");
	
%>