<%@page import="invate.inviteDAO"%>
<%@page import="group.memberVO"%>
<%@page import="group.memberDAO"%>
<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	String id = request.getParameter("id");
	String gnum = request.getParameter("gnum");
	int gnum2 = Integer.parseInt(gnum);
	String no = request.getParameter("no");
	int noNum = Integer.parseInt(no);
	
	memberDAO dao = new memberDAO();
	memberVO vo = new memberVO();
	vo.setId(id);
	vo.setGroupnum(gnum2);
	vo.setGrouptype(2);
	
	dao.insertMember(vo);
	
	inviteDAO iDao = new inviteDAO();
	iDao.refuse(noNum);
	
	out.print("success");
	
%>