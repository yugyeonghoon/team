<%@page import="group.groupVO"%>
<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String gname = request.getParameter("gname");
	String gnum = request.getParameter("gnum");
	int gnum2 = Integer.parseInt(gnum);

	
	if(gname == null || gname.isEmpty()){
		return;
	}
	
	groupDAO dao = new groupDAO();
	groupVO vo = new groupVO();
	

	vo.setGroupName(gname);
	vo.setGroupNum(gnum2);
	
	dao.updateGname(vo);
	
	out.print("success");
	
	

%>