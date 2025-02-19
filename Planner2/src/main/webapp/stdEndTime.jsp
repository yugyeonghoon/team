<%@page import="studytime.studytimeDAO" %>
<%@page import="studytime.studytimeVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//a.jax로 update end_time = now(), total_time ROUND(TIMESTAMPDIFF(SECOND, start_time, now()) / 60)
	int stdno = Integer.parseInt(request.getParameter("stnNo"));
	
	studytimeDAO dao = new studytimeDAO();
	dao.update(stdno);
	out.print("success");
	
%>