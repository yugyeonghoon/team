<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String gnum = request.getParameter("gnum");
	int gnum2 = Integer.parseInt(gnum);
	groupDAO dao = new groupDAO();
	dao.delete(gnum2);
	out.print("success");
%>