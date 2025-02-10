<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<%
	request.setCharacterEncoding("utf-8");	

	String id = request.getParameter("id");
	
	if(id == null){
		response.sendRedirect("user_management.jsp");
		return;
	}
	
	if(id.isEmpty()){
		response.sendRedirect("user_management.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	
	vo.setId(id);
	
	dao.getOneUser(id);

%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 정보 수정(관리자 전용)</title>
	</head>
	<body>
		<h2>회원 관리</h2>
			<form>
				<div>
					<label for="username">아이디</label>
					<input type="text" id="id" name="id" value="<%= id %>" readonly>
				</div>
				<div class="profile-field">
					<label for="name">이름</label>
					<input type="text" id="name" name="name" value="<%= vo.getName() %>" readonly>
				</div>
			</form>
	</body>
</html>