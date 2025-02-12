<%@page import="group.memberVO"%>
<%@page import="user.UserVO"%>
<%@page import="group.memberDAO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String gnum = request.getParameter("gnum");
	
	if(id == null || gnum == null){
		out.print("fail");
		return;
	}
		
	int groupnum = Integer.parseInt(gnum);
	
	memberDAO dao = new memberDAO();
	memberVO vo = new memberVO();
	vo.setId(id);
	vo.setGrouptype(2);
	vo.setGroupnum(groupnum);
	dao.insertMember(vo);

%>