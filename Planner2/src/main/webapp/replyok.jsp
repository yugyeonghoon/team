<%@page import="reply.ReplyVO"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String text = request.getParameter("reply");
	String no = request.getParameter("no");
	String author = "hong";
	
	if(text == null || no == null || author == null){
		return;
	}
	
	ReplyDAO dao = new ReplyDAO();
	ReplyVO vo = new ReplyVO();
	vo.setRcontent(text);
	vo.setNo(no);
	vo.setRauthor(author);
	
	dao.write(vo);
%>