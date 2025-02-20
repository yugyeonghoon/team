<%@page import="board.CalendarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	CalendarDAO dao = new CalendarDAO();
	dao.delete(no);
	out.print("success");
%>