<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	
	if(id == null){
		response.sendRedirect("findpwok.jsp");
		return;
	}
	
	if(id.isEmpty()){
		response.sendRedirect("findpwok.jsp");
		return;
	}
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
					background-color: white;
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
					background-color: #b1dbe900;
					border-radius: 9px;
					border-top: 2px solid gray;
					border-bottom: 2px solid gray;
					border-right: 2px solid gray;
					border-left:2px solid gray;
					width: 550px;
					height: 300px;
					/* box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53); */
				}
				h2{
					text-align: center;
					margin-bottom: 20px;
					color: black;
					font-family: 'Seoul 1980', sans-serif;
				}
				label{
					display: block;
		            margin-bottom: 5px;
		            font-weight: bold;
		            color: black;
				}
				input{
					margin: 5px auto;
					background: #C2E9F3;
					border: 0;
					border-radius: 5px;
					outline: none;
					width: 250px;
					height: 35px;
					font-size: 0.8rem;
					color: #000000;
					      -webkit-transition: all .2s ease-out;
					    -moz-transition: all .2s ease-out;
					    -ms-transition: all .2s ease-out;
					    -o-transition: all .2s ease-out;
					    transition: all .2s ease-out;
				}
				input:focus{
					border: 1px solid #79A6FE;
					color: #000000;
				}
				::-webkit-input-placeholder {
				  	color: #000000;
				}
				.btn{
					font-size: 1rem;
					cursor: pointer;
					margin-top: 10px;
					border: 0;
					background: #C2E9F3;
					color: #000000;
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
				.bounceInDown{
					width: 100%;
					height: 100%;
				}
				
				.bounceInDown::before{
					content: "";
					background: url(./sky1.jpg) no-repeat;
				    background-size: 100% 100%;
				    opacity: 0.5;
				    position: absolute;
				    top: 0px;
				    left: 0px;
				    right: 0px;
				    bottom: 0px;
				}
		</style>
	</head>
	<body>
		<div class="bounceInDown">
			<div class="findpw-container">
				<h2>비밀번호 변경</h2>
					<form method="post" action="changepw.jsp" onsubmit="return formCheck()">
						<div class="profile-field">
							<label for="password">새 비밀번호</label>
							<input type="hidden" value="<%= id %>" name="id">
							<input type="password" id="password" name="password" placeholder="비밀번호를 다시 입력하세요.">
						</div>
						<div class="profile-field">
							<label>새 비밀번호 확인</label>
							<input type="password" id="password-check" name="password-check" placeholder="새 비밀번호를 다시 입력하세요.">
							<div id="password-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
						</div>
						<div>
							<button type="submit" class="btn" id="btnClick">확인</button>
						</div>
					</form>
			</div>
		</div>	
	</body>
	<script>
		let pw = $("#password");
		let pwc = $("#password-check");
		let pwFeedback = $("#password-feedback");
		
		$("#btnClick").click(function(){
			
		});
		
		function formCheck(){
			if(pw.val().trim() == ""){
				pw.focus();
				pw.val("");
				confirm("비밀번호를 입력해주세요.")
				return false;
			}
			
			
			if(pwc.val().trim() == ""){
				pwc.focus();
				pwc.val("");
				confirm("비밀번호 확인을 입력해주세요.")
				return false;
			}
			
			if(pw.val() != pwc.val()){
				pwc.focus();
				pwc.val("");
				pwFeedback.css("display", "block");
				pwFeedback.text("비밀번호가 일치하지 않습니다.");
				pwFeedback.removeClass("success");
				return false;
			}else{
				pwFeedback.css("display", "block");
				pwFeedback.addClass("success");
				pwFeedback.text("비밀번호가 일치합니다.");
				confirm("비밀번호 변경이 완료되었습니다.");
			}
			
			return true;
		}
	</script>
</html>