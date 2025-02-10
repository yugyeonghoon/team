<%@page import="user.UserVO"%>
<%@page import="board.CalendarDAO"%>
<%@page import="board.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String boardType = request.getParameter("boardType");
	
	CalendarDAO dao = new CalendarDAO();
	BoardVO vo = new BoardVO();
	int boardTypeNum = Integer.parseInt(boardType);
	
	vo.setAuthor(user.getId());
	vo.setTitle(title);
	vo.setContent(content);
	vo.setStartTime(start);
	vo.setEndTime(end);
	vo.setBoardType(boardTypeNum);
	
	dao.writeMemo(vo);
	
	out.print("ok");
%>