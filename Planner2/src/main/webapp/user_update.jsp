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
	
	UserVO uvo = dao.getOneUser(id);

%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 정보 수정(관리자 전용)</title>
		<style>
			body {
				font-family : 'Source Sans Pro', sans-serif; 
				background: white;
				margin: 0;
				padding: 0;
				color: #333;
			}
			.profile-container{
				padding: 20px;
				max-width: 600px;
				margin: 40px auto;
				background: white;
				border-radius: 10px;
				box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
				border-top: 10px solid #79a6fe;
				border-bottom: 10px solid #8BD17C;
			}
			h2{
				color: #0073e6;
				text-align: center;
				margin-bottom: 20px;
			}
			.profile-field{
				margin-bottom:15px;
			}
			.profile-field label{
				font-weight: bold;
				margin-bottom: 5px;
				display: block;
				color: black;
			}
			.profile-field input{
				width: 100%;
				padding: 8px;
				border: 1px solid black;
				border-radius: 10px;
				box-sizing: border-box;
			}
			.feedback{
				font-size: 0.9rem;
				color: red;
				margin-bottom: 10px;
			}
			.feedback.success{
				color: green;
			}
			.profile-actions button{
				background: #7f5feb;
				color: #dfdeee;
				border: none;
				padding: 10px 20px;
				border-radius: 5px;
				cursor: pointer;
				transition: background 0.3s ease;
				margin: 0 64px;
			}
			.profile-actions button:hover {
			        background: #1a5fc4;
			    }
		</style>
	</head>
	<body>
		<div class="profile-container">
			<h2>회원 관리</h2>
				<form>
					<div class="profile-field">
						<label for="username">아이디</label>
						<input type="text" id="id" name="id" value="<%= id %>" readonly>
					</div>
					<div class="profile-field">
						<label for="name">이름</label>
						<input type="text" id="name" name="name" value="<%= uvo.getName() %>" readonly>
					</div>
					<div class="profile-field">
						<label for="nick">닉네임</label>
						<input type="text" id="nick" name="nick" value="<%= uvo.getNick() %>" readonly>
					</div>
					<div class="profile-field">
						<label for="email">이메일</label>
						<input type="text" id="email" name="email" value="<%= uvo.getEmail() %>" readonly>
					</div>
					<div class="profile-field">
						<label for="user_type">타입</label>
						<input type="text" id="type" name="type" value="<%= uvo.getUserType() %>" readonly>
					</div>				
				</form>
		</div>
	</body>
</html>