<%@page import="user.UserVO"%>
<%@page import="reply.ReplyVO"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String text = request.getParameter("reply");
	String no = request.getParameter("no");
	UserVO user = (UserVO)session.getAttribute("user");
	
	String author = null;
	if(user == null) {
		author = null;
	}else {
		author = user.getId();
	}
	
	
	if(text == null || no == null || user == null){
		response.sendRedirect("page.jsp");
		return;
	}
	
	ReplyDAO dao = new ReplyDAO();
	ReplyVO vo = new ReplyVO();
	vo.setRcontent(text);
	vo.setNo(no);
	vo.setRauthor(author);
	
	dao.write(vo);
%>