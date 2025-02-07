<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="./jquery-3.7.1.js"></script>
		<style>
			body{
					font-family: 'Source Sans Pro', sans-serif;
					background-color: #1d243d;
					padding: 0;
					margin: 0;
				}
			.findpw-container {
					margin: 0;
					top: 180px;
					left: 50%;
					position: absolute;
					text-align: center;
					transform: translateX(-50%);
					background-color: rgb( 33, 41, 66 );
					border-radius: 9px;
					border-top: 10px solid #79a6fe;
					border-bottom: 10px solid #8BD17C;
					width: 550px;
					height: 300px;
					box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53);
				}
				h2{
					text-align: center;
					margin-bottom: 20px;
					color: #dfdeee;
					font-family: 'Seoul 1980', sans-serif;
				}
				label{
					display: block;
		            margin-bottom: 5px;
		            font-weight: bold;
		            color: #5c7fda;
				}
				input{
					margin: 5px auto;
					background: #262e49;
					border: 0;
					border-radius: 5px;
					outline: none;
					width: 250px;
					height: 35px;
					font-size: 0.8rem;
					color: #d6d6d6;
					      -webkit-transition: all .2s ease-out;
					    -moz-transition: all .2s ease-out;
					    -ms-transition: all .2s ease-out;
					    -o-transition: all .2s ease-out;
					    transition: all .2s ease-out;
				}
				input:focus{
					border: 1px solid #79A6FE;
					color: #d6d6d6;
				}
				.btn{
					font-size: 1rem;
					cursor: pointer;
					margin-top: 10px;
					border: 0;
					background: #7f5feb;
					color: #dfdeee;
					border-radius: 100px;
					width: 80px;
					height: 30px;
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
		<div class="findpw-container">
			<h2>비밀번호 변경</h2>
				<form method="post" action="changepw.jsp" onsubmit="return formCheck()">
					<div class="profile-field">
						<label for="password">새 비밀번호</label>
						<input type="password" id="password" name="password" placeholder="비밀번호를 다시 입력하세요.">
					</div>
					<div class="profile-field">
						<label>새 비밀번호 확인</label>
						<input type="password" id="password-check" name="password-check" placeholder="새 비밀번호를 다시 입력하세요.">
						<div id="password-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
					</div>
					<div>
						<button type="submit" class="btn">확인</button>
					</div>
				</form>
		</div>
	</body>
	<script>
		let pw = $("#password");
		let pwc = $("#password-check");
		let pwFeedback = $("#password-feedback");
		
		function formCheck(){
			if(pw.val().trim() == ""){
				pw.focus();
				pw.val("");
				pwFeedback.css("display", "block");
				pwFeedback.text("비밀번호를 입력해주세요.");
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
			
			return true;
		}
	</script>
</html>