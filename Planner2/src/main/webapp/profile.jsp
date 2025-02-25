<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String id = user.getId();
	if(user == null){
		response.sendRedirect("calendar.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>마이페이지</title>
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
					background: #ffffff;
					border-radius: 10px;
					box-shadow: 0 2px 10px rgb(30 88 139 / 20%);
					border: 2px solid #a9a9a9;
				}
				h2{
					color: #000000;
					text-align: center;
					margin-bottom: 20px;
					font-size: 27px;
				}
				.profile-field{
					margin-bottom:15px;
				}
				.profile-field label{
					font-weight: bold;
					margin-bottom: 5px;
					display: block;
					color: black;
					font-size: 17px;
				}
				.profile-field input{
					width: 95%;
					padding: 8px;
					border: 1px solid black;
				    height: 20px;
				    font-size: 15px;
				    padding-left: 10px;
				    box-shadow: 0 1px 10px rgb(30 88 139 / 20%);
					border-radius: 12px;
					border-style: hidden;
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
					background: #000000;
					color: #ffffff;
					border: none;
					padding: 10px 20px;
					border-radius: 5px;
					cursor: pointer;
					transition: background 0.3s ease;
					margin: 0 64px;
					font-size: 14px;
					font-weight: bold;
				}
				.profile-actions button:hover {
				        background: #1a5fc4;
				}
				.feedback{
					font-size: 1rem;
					color: red;
					margin-bottom: 10px;
					display : none;
				}
				.feedback.success{
					color: green;
				}
			</style>
	</head>
	<body>
		<div class="profile-container">
			<h2>마이페이지</h2>
			<form method="post" action="profileok.jsp" onsubmit="return formCheck()">
				<div class="profile-field">
					<label for="username">아이디</label>
					<input type="text" id="username" name="username" value="<%= user.getId() %>" readonly>
				</div>
				<div class="profile-field">
					<label for="name">이름</label>
					<input type="text" id="name" name="name" value="<%= user.getName() %>" readonly>
				</div>
				<div class="profile-field">
					<label for="nickname">닉네임</label>
					<input type="text" id="nickname" name="nickname" value="<%= user.getNick() %>">
					<!-- <div class="feedback">닉네임 중복확인을 해주세요. </div> -->
				</div>
				<div class="profile-field">
					<label for="email">이메일</label>
					<input type="text" id="email" name="email" value="<%=user.getEmail() %>" readonly>
				</div>
				<div class="profile-field">
					<label for="password">새 비밀번호</label>
					<input type="password" id="password" name="password" placeholder="비밀번호를 다시 입력하세요.">
				</div>
				<div class="profile-field">
					<label>새 비밀번호 확인</label>
					<input type="password" id="password-check" placeholder="새 비밀번호를 다시 입력하세요.">
					<div id="password-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
				</div>
				<div class="profile-actions">
					<button type="submit">저장</button>
					<button type="button" onclick="location.href='calendar.jsp'">취소</button>
					<button type="button" onclick="joinout('<%= id %>')">탈퇴</button>
				</div>
			</form>
		</div>
	</body>
	<script>
	function formCheck(){
		let pw = $("#password");
		let pwc = $("#password-check");
		let pwFeedback = $("#password-feedback");
		
		if(pw.val().trim() == ""){
			pw.focus();
			pw.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("변경할 비밀번호를 입력해주세요.");
			pwFeedback.removeClass("success");
			return false;
		}
		
		if(pwc.val().trim() == ""){
			pwc.focus();
			pwc.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("비밀번호 확인을 입력해주세요.");
			pwFeedback.removeClass("success");
			return false;
		}
		
		if(pw.val() != pwc.val()){
			pwc.focus();
			pwc.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("비밀번호가 일치하지 않습니다.");
			pwFeedback.removeClass("success");
			return false;
		}
		
		confirm("비밀번호가 변경되었습니다.");
	}
	function joinout(id){
		let result = confirm("회원탈퇴를 하시겠습니까 ?")
		if(result == true){
			$.ajax({
				url : "joinout.jsp",
				type : "post",
				data : {
					id : id
				},
				success : function(result){
					if(result.trim() == "success"){
						alert("회원탈퇴를 하셨습니다.");
						location.href = "login.jsp"
					}
				},
				error : function(){
					console.log("error")
				}
			});
		}
		
	}
	</script>
</html>