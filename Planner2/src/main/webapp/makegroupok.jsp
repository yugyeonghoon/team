<%@page import="group.memberVO"%>
<%@page import="group.memberDAO"%>
<%@page import="user.UserVO"%>
<%@page import="group.groupVO"%>
<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	//makegroup.jsp에서 넘겨준 그룹이름, 세션에 들어있는 아이디 꺼내오기
	//꺼내온 그룹 이름으로 groupdao의 insertGroup 메서드 실행
	//insertGroup메서드는 방금 insert된 그룹의 groupnum을 반환
	
	//memberdao의 그룹원 추가 메서드 실행
	//유저, 그룹 번호, 그룹타입 1로 
	
	UserVO user1 = (UserVO)session.getAttribute("user");
	String gname = request.getParameter("gname");
	
	groupDAO dao = new groupDAO();
	groupVO vo =new groupVO();
	
	memberDAO dao2 = new memberDAO();
	memberVO vo2 = new memberVO();
	
	vo.getGroupName();
	int groupnum = dao.insertGroup(gname);
	
	vo2.setGroupnum(groupnum);
	vo2.setGrouptype(1);
	vo2.setId(user1.getId());
	dao2.insertMember(vo2);
	
	response.sendRedirect("group.jsp");
	
%>