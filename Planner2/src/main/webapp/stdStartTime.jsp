<%@page import="user.UserVO"%>
<%@page import="studytime.studytimeVO"%>
<%@page import="studytime.studytimeDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	String no = request.getParameter("no");
	String startTime = request.getParameter("startTime");
	
	String id = null;
	if(user == null) {
		id = null;
	}else {
		id = user.getId();
	}
	
	if(user == null || no == null || startTime == null) {
		out.print("fail");
		return;
	}
	
	studytimeDAO dao = new studytimeDAO();
	studytimeVO vo = new studytimeVO();
	vo.setNo(no);
	vo.setId(id);
	vo.setStartTime(startTime);
	
	int stdno = dao.start(vo);
	out.print(stdno);
%>