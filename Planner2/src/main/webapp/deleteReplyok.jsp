<%@ page import="reply.ReplyDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String rno = request.getParameter("rno");
	if(rno == null) {
		out.print("fail");
		return;
	}
	
	if(rno.isEmpty()) {
		out.print("fail");
		return;
	}
	
	ReplyDAO dao = new ReplyDAO();
	dao.delete(rno);
	out.print("success");
%>