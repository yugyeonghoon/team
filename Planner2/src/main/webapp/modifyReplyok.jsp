<%@ page import="reply.ReplyDAO"%>
<%@ page import="reply.ReplyVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.getParameter("utf-8");

	String rno = request.getParameter("rno");
	String rcontent = request.getParameter("rcontent");
	System.out.println(rno);
	System.out.println(rcontent);
	if(rno == null || rcontent == null) {
		out.print("fail");
		return;
	}
	
	if(rno.isEmpty() || rcontent.isEmpty()) {
		out.print("fail");
		return;
	}
	
	ReplyDAO dao = new ReplyDAO();
	ReplyVO vo = new ReplyVO();
	vo.setRno(rno);
	vo.setRcontent(rcontent);
	dao.modify(vo);
	out.print("success");
%>