<%@page import="invate.inviteDAO"%>
<%@page import="invate.inviteVO"%>
<%@page import="javax.websocket.SendResult"%>
<%@page import="group.memberVO"%>
<%@page import="user.UserVO"%>
<%@page import="group.memberDAO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	String id = request.getParameter("id");
	String gnum = request.getParameter("gnum");
	if(id == null || gnum == null){
		out.print("fail");
		return;
	}
	
	int groupnum = Integer.parseInt(gnum);

	UserDAO userdao = new UserDAO();
	memberDAO dao = new memberDAO();
	memberVO vo = new memberVO();
	vo.setId(id);
	vo.setGroupnum(groupnum);
	
	//유저가 있는지 검사
	int result = userdao.idCheck(id);
	
	if(result == 0){
		out.print("nouser");
		return;
	};
	
	//같은 그룹이 아닌 사람만 초대
	int inUser = dao.groupCheck(vo);
	if(inUser == 1){
		out.print("inUser");
		return;
	}
	
	//멤버초대
	/* vo.setId(id);
	vo.setGrouptype(2);
	vo.setGroupnum(groupnum);
	dao.insertMember(vo); */
	
	//멤버를 초대 테이블에 저장
	inviteVO iVo = new inviteVO();
	inviteDAO iDao = new inviteDAO();
	
	int inviteCheck =  iDao.inviteCheck(groupnum);
	
	if(inviteCheck == 1){
		out.print("inviteUser");
		return;
	}
	
	iVo.setReceiver(id);
	iVo.setGroupnum(groupnum);
	iVo.setSender(user.getId());
	iDao.insert(iVo);
	
	out.print("success");
%>