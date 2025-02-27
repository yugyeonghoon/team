<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 가입</title>
		<script src="./jquery-3.7.1.js"></script>
		<style>
			body{
				font-family: 'Source Sans Pro', sans-serif;
				background-color: #ffffff;
				padding: 0;
				margin: 0;
			}
			.signup-container {
				margin: 0;
				top: 100px;
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
				width: 500px;
				height: 770px;
				/* box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53); */
			}
			h1{
				text-align: center;
				margin-bottom: 20px;
				color: #000000;
				font-family: 'Seoul 1980', sans-serif;
			}
			form{
				
			}
			label{
				display: block;
	            margin-bottom: 10px;
	            margin-top: 7px;
	            font-size: 1rem;
	            font-weight: bold;
	            color: #000000;
			}
			input{
				margin: 2px auto;
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
			button{
				width: 100%;
				height: 40px;
				font-size: 1rem;
				cursor: pointer;
				border-radius: 5px;
				margin-top: 10px;
				color: black;
				background: gray;
			}
			select.box{
				width: 110px;
				height: 40px;
				box-sizing: border-box;
				margin-left: 5px;
				padding: 5px 0 5px 10px;
				border-radius: 4px;
				border: 1px solid #d9d6d6;
				color: #383838;
				background-color: #ffffff;
				font-family: 'Montserrat', 'Pretendard', sans-serif;
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
			.btn1 {
			  border:0;
			  background: #C2E9F3;
			  color: #000000;
			  border-radius: 100px;
			  width: 340px;
			  height: 49px;
			  font-size: 16px;
			  position: absolute;
			  top: 90%;
			  left: 16%;
			  transition: 0.3s;
			  cursor: pointer;
			}
			.btn{
				border: 0;
				background: #C2E9F3;
				color: #000000;
				border-radius: 100px;
				width: 120px;
				position: absolute;
				left: 370px;		
			}
			.email{
				width: 220px;
				height: 35px;
				border-top: none;
				border-left: none;
				border-right: none;
				/* border-bottom: 3px solid black; */
				font-size: 1rem;
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
			<div class="signup-container">
				<h1>회원 가입</h1>
					<form method="post" action="signupok.jsp" onsubmit="return formCheck()">
						<label for="username">아이디</label>
						<input type="text" id="username" name="username">
						<div id="username-feedback" class="feedback">아이디 중복확인을 해주세요</div>
						
						<label>이름</label>
						<input type="text" id="name" name="name">
						<div id="name-feedback" class="feedback">이름을 입력해주세요.</div>
						
						<label>비밀번호</label>
						<input type="password" id="password" name="password">
						
						<label>비밀번호 확인</label>
						<input type="password" id="password-check" name="password-check">
						<div id="password-feedback" class="feedback">비밀번호가 일치하지 않습니다.</div>
						
						<label>닉네임</label>
						<input type="text" id="nickname" name="nickname">
						<div id="nickname-feedback" class="feedback">닉네임 중복확인을 해주세요.</div>
						
						<label>이메일</label>
						<input type="text" id="mail" class="email" name="email">
						<input type="button" id="mailBtn" class="btn" value="이메일 인증">
						<div id="mail-feedback" class="feedback">인증번호가 일치하지 않습니다.</div>
						
						<label>인증번호</label>
						<input type="text" id="mailCheck" class="email">
						<input type="button" id="mailCheckBtn" class="btn" value="인증번호 확인">
						<div id="mailCheck-feedback" class="feedback">인증번호가 일치하지 않습니다.</div>
						
						<input type="submit" value="회원가입" class="btn1" >
					</form>
			</div>
		</div>	
	</body>
	<script>
	let idRegex = /^[a-zA-Z0-9]{6,12}$/;
	let idCheckFlag = false;
	
	let nick = $("#nickname");
	let nickFeedback = $("#nickname-feedback");
	let nickCheckFlag = false;
	let nickRegex = /^[a-zA-z0-9가-핳]{2,10}$/;
	
	let emailCheckFlag = false;
	let mailCode = "";
	
	let pw = $("#password");
	let pwc = $("#password-check");
	let pwFeedback = $("#password-feedback");
	
	let email = $("#mail");
	let emailFeedback = $("#mail-feedback");
	let emc = $("#mailCheck");
	let emcFeedback = $("#mailCheck-feedback");
	let emailRegex = /^[a-zA-Z0-9]+@[0-9a-zA-Z]+\\.[a-z]$/;
	
	let name = $("#name");
	let nameFeedback = $("#name-feedback");
	let nameRegex = /^[가-힣]{2,5}$/;
	
	$("#mailBtn").click(function(){
		if(email.val().trim() == ""){
			alert("이메일을 입력해주세요");
			return;
		}
		
		if(!emailRegex.test(email.val())){
			email.focus();
			email.val("");
			alert("올바른 이메일 형식이 아닙니다.");
			return;
		}
		
		$("#mailBtn").attr("disabled", true);
		
		$.ajax({
			url : "sendMail.jsp",
			type : "post",
			data : {
				mail : email.val()
			},
			success : function(result){
				mailCode = result.trim();
				if(mailCode == "fail"){
					$("#mailBtn").attr("disabled", false);
					emailFeedback.css("display", "block");
					emailFeedback.removeClass("success");
					emailFeedback.text("이메일이 올바르지 않습니다.");
					alert("이메일 전송에 실패하였습니다.");
				}else{
					alert("이메일 전송이 완료되었습니다. 인증코드를 확인해주세요");
					emailFeedback.css("display", "block");
					emailFeedback.addClass("success");
					emailFeedback.text("이메일 전송 완료");
					nickFeedback.css("display", "none");
				}
			},
			error : function(){
				console.log("에러 발생");
				$("#mailBtn").attr("disabled", false);
			}
		});		
	});
	
	$("#mailCheckBtn").click(function(){
		let mailCheck = $("#mailCheck");
		if(mailCheck.val().trim() == ""){
			alert("이메일 인증코드를 입력해주세요");
			
			return;
		}
		
		if(mailCode == mailCheck.val().trim()){
			emailCheckFlag = true;
			alert("코드가 일치합니다!")
			emailFeedback.css("display", "none");
			emcFeedback.css("display", "none");
			emcFeedback.addClass("success");
			emcFeedback.text("인증완료 되었습니다.");
		}else{
			emailCheckFlag = false;
			alert("코드가 일치하지 않습니다.");
		}
			
	});
	
	$("#username").keyup(function(e){
		let id = e.target.value;
		
		let idFeedback = $("#username-feedback");
		idFeedback.css("display", "block");
		idFeedback.removeClass("success");
		idFeedback.text("아이디는 영어 대소문자와 숫자 6 ~ 12자리만 사용 가능합니다.")
		idCheckFlag = false;
		
		if(!idRegex.test(id)){
			return;
		}
		
		$.ajax({
			url : "idCheck.jsp",
			type : "post",
			data : {
				id : id
			},
			success : function(result){
				if(result.trim() == "0"){
					idCheckFlag = true;
					idFeedback.css("display", "block");
					idFeedback.addClass("success");
					idFeedback.text("사용 가능한 아이디입니다.");
				}else{
					idCheckFlag = false;
					idFeedback.css("display", "block");
					idFeedback.removeClass("success");
					idFeedback.text("사용 불가능한 아이디입니다.");
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	});
		
	$("#nickname").keyup(function(e){
		let nick = e.target.value;
		
		let nickFeedback = $("#nickname-feedback");
		nickFeedback.css("display", "block");
		nickFeedback.removeClass("success");
		nickFeedback.text("닉네임은 2 ~ 10자리만 사용가능합니다.");
		nickCheckFlag = false;
		
		if(!nickRegex.test(nick)){
			return;
		}
		
		$.ajax({
			url : "nickCheck.jsp",
			type : "post",
			data : {
				nick : nick
			},
			success : function(result){
				if(result.trim() == "0"){
					nickCheckFlag = true;
					nickFeedback.css("display", "block");
					nickFeedback.addClass("success");
					nickFeedback.text("사용 가능한 닉네임입니다.");
				}else{
					nickCheckFlag = false;
					nickFeedback.css("display", "block");
					nickFeedback.removeClass("success");
					nickFeedback.text("닉네임이 중복됩니다.")
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	});
	
	function formCheck(){
		let id = $("#username");
		let idFeedback = $("#username-feedback");
		
		if(id.val().trim() == ""){
			id.focus();
			id.val("");
			idFeedback.css("display", "block");
			idFeedback.text("아이디를 입력해주세요.");
			idFeedback.removeClass("success");
			return false;
		}
		
		if(!idRegex.test(id.val())){
			id.focus();
			id.val("");
			idFeedback.css("display", "block");
			idFeedback.text("영어 대소문자 숫자 포함 6 ~ 12자");
			idFeedback.removeClass("success");
			return false;
		}
		if(idCheckFlag == false){
			id.focus();
			id.val("");
			idFeedback.css("display", "block");
			idFeedback.text("아이디가 중복되었습니다.");
			idFeedback.removeClass("success");
			return false;
		}
		
		idFeedback.css("display", "block");
		idFeedback.addClass("success");
		idFeedback.text("아이디 확인이 완료되었습니다.");
		
		if(name.val().trim() == ""){
			name.focus();
			name.val("");
			nameFeedback.css("display", "block");
			nameFeedback.text("이름을 입력해주세요.");
			nameFeedback.removeClass("success");
			return false;
		}
		
		
		if(!nameRegex.test(name.val())){
			name.focus();
			name.val("");
			nameFeedback.css("display", "block");
			nameFeedback.text("정확한 이름을 작성해주세요.");
			nameFeedback.removeClass("success");
			return false;
		}
		
		nameFeedback.css("display", "block");
		nameFeedback.addClass("success");
		nameFeedback.text("확인되었습니다.");
		
		idFeedback.css("display", "none");
		
		if(pw.val().trim() == ""){
			pw.focus();
			pw.val("");
			pwFeedback.css("display", "block");
			pwFeedback.text("비밀번호를 입력해주세요.");
			pwFeedback.removeClass("success");
			return false;
		}
		
		nameFeedback.css("display", "none");
		
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
		
		pwFeedback.css("display", "block");
		pwFeedback.addClass("success");
		pwFeedback.text("비밀번호가 일치합니다.");
		
		if(nick.val().trim() == ""){
			nick.focus();
			nick.val("");
			nickFeedback.css("display", "block");
			nickFeedback.text("닉네임을 입력해주세요.");
			nickFeedback.removeClass("success");
			return false;
		}
		
		if(!nickRegex.test(nick.val())){
			nick.focus();
			nick.val("");
			nickFeedback.css("display", "block");
			nickFeedback.text("닉네임은 2 ~ 10자리만 사용 가능합니다.");
			nickFeedback.removeClass("success");
			return false;
		}
		
		pwFeedback.css("display", "none");
		
		if(nickCheckFlag == false){
			nick.focus();
			nick.val("");
			nickFeedback.css("display", "block");
			nickFeedback.text("닉네임 중복확인이 필요합니다.");
			nickFeedback.removeClass("success");
			return false;
		}
		
		nickFeedback.css("display", "block");
		nickFeedback.addClass("success");
		nickFeedback.text("닉네임 확인이 완료되었습니다.");
		nickFeedback.css("display", "none");
		
		if(email.val().trim() == ""){
			email.focus();
			email.val("");
			emailFeedback.css("display", "block");
			emailFeedback.text("이메일을 입력해주세요")
			emailFeedback.removeClass("success");			
			return false;
		}
			
		if(emc.val().trim() == ""){
			emc.focus();
			emc.val("");
			emcFeedback.css("display", "block");
			emcFeedback.text("인증번호를 입력해주세요");
			emcFeedback.removeClass("success");
			emailFeedback.css("display", "none");
			return false;
		}
		
		if(emailCheckFlag == false){
			emc.focus();
			emc.val("");
			emcFeedback.css("display", "block");
			emcFeedback.text("인증되지 않았습니다.");
			emcFeedback.removeClass("success");
			return false;
		}
	
		return true;
	}
</script>
</html>