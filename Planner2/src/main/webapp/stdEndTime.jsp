<%@page import="studytime.studytimeDAO" %>
<%@page import="studytime.studytimeVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//a.jax로 update end_time = now(), total_time ROUND(TIMESTAMPDIFF(SECOND, start_time, now()) / 60)
	int stdno = Integer.parseInt(request.getParameter("stdno"));
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	
	int stime = Integer.parseInt(startTime);
	int etime = Integer.parseInt(endTime);
	int totalTime = stime - etime;
	
	
	studytimeDAO dao = new studytimeDAO();
	studytimeVO vo = new studytimeVO();
	vo.setStdno(stdno);
	vo.setEndTime(endTime);
	vo.setTotalTime(totalTime);
	
	dao.update(vo);
	out.print("success");
	
%>