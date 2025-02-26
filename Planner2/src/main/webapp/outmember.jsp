<%@page import="group.memberDAO"%>
<%@page import="group.memberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mid = request.getParameter("mid");
	String gnum = request.getParameter("gnum");
	memberDAO dao = new memberDAO();
	memberVO vo = new memberVO();
	
	dao.outmember(mid, gnum);
	out.print("success");
%>