<%@page import="invate.inviteVO"%>
<%@page import="invate.inviteDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	int inviteno = Integer.parseInt(no);
	
	inviteDAO dao = new inviteDAO();
	inviteVO vo = new inviteVO();
	
	dao.refuse(inviteno);
	out.print("success");
	
%>