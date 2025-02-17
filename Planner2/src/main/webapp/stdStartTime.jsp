<%@page import="user.UserVO"%>
<%@page import="board.BoardVO"%>
<%@page import="studytime.studytimeVO"%>
<%@page import="studytime.studytimeDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	Integer noObject = (Integer)request.getAttribute("no");
	int no = (noObject != null) ? noObject.intValue() : 0;
	
	String stdTime = request.getParameter("startTime");
	String id = request.getParameter("id");
	
	if(user == null) {
		out.print("fail");
		return;
	}
	
	studytimeDAO dao = new studytimeDAO();
	studytimeVO vo = new studytimeVO();
	vo.setId(id);
	vo.setStartTime(stdTime);
	
	
%>