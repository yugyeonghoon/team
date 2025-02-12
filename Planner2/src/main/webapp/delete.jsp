<%@page import="group.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	if(id == null){
		out.print("fail");
		return;
	}
	memberDAO dao = new memberDAO();
	dao.deleteMember(id);
	out.print("success");
%>