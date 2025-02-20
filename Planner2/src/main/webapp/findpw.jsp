<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>
		<script src="./jquery-3.7.1.js"></script>
			<style>
				body{
					font-family: 'Source Sans Pro', sans-serif;
					background-color: #1d243d;
					padding: 0;
					margin: 0;
				}
				.findpw{
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
					width: 800px;
					height: 350px;
					box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53);
				}
				.pwform{
			        font-size: 1rem;
			        width: 50%;
			        display: inline-block;
				}
				h1{
					text-align: center;
					margin-bottom: 20px;
					color: #5c7fda;
					font-family: 'Seoul 1980', sans-serif;
				}
				.btn{
					font-size: 1rem;
					cursor: pointer;
					margin-top: 75px;
					border: 0;
					background: #7f5feb;
					color: #dfdeee;
					border-radius: 100px;
					width: 80px;
					height: 30px;
				}
				.check{
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
				.btn1{
					font-size: 1rem;
					cursor: pointer;
					margin-top: 10px;
					border: 0;
					background: #7f5feb;
					color: #dfdeee;
					border-radius: 100px;
					width: 130px;
					height: 35px;
				}
				input{
					margin: 10px auto;
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
				.fi1{
					color: #5c7fda;
				}
				::-webkit-input-placeholder {
				  	color: #565f79;
				}	
				.emailCheck{
					background: #7f5feb;
					width: 70px;
					height: 35px;
					position: absolute;
					top: 41%;
					left: 71%;
					font-size: 1rem;
					cursor: pointer;
					margin-top: 10px;
					border: 0;					
					color: #dfdeee;
					border-radius: 100px;					
				}
				.pwcheck{
					width: 180px;
					height: 35px;
					text-align: center;
				}
				.fi2{
					position: absolute;
					top: 55%;
					left: 39%;
				}
				.feedback{
					font-size: 1rem;
					color: red;
					margin-bottom: 10px;
					position: absolute;
					top: 87%;
					left: 3%;
					display : none;
				}
				.feedback.success{
					color: green;
				}	
			</style>
	</head>
	<body style="padding:30px;" >
		<div class="findpw">
		<h1>비밀번호 찾기</h1>
			<form class="pwform" method="post" action="findpwok.jsp" onsubmit="return formCheck()">
				<div class="fi1">아이디 :
					<input type="text" name="id" id="id" placeholder="ID을 입력하세요" autocomplete="off">
				</div>
				<div class="fi1">이메일 :
					<input type="text" name="email" id="email" placeholder="email을 입력하세요" autocomplete="off">
					<input type="button" class="emailCheck" id="checkBtn" value="전송">		
				</div>
				<div class="fi2"> 
					<input type="text" class="pwcheck" id="mailCheck" placeholder="인증번호">
					<input type="submit" id="mailCheckBtn" value="확인" class="check">
					<div id="mailCheck-feedback" class="feedback">인증번호가 일치하지 않습니다.</div>
				</div>
			</form>
				<div>			
					<button onclick="location.href='login.jsp'" class="btn">취소</button>
				</div>
		</div>
	</body>
	<script>
		let emailCheckFlag = false;
		
		let id = $("#id")
		let mail = $("#email")
		let emc = $("#mailCheck");
		let emcFeedback = $("#mailCheck-feedback");
		
		function formCheck(){
			if(emailCheckFlag == false){
				alert("이메일 인증을 해주세요");
				return false;
			}
			
			return true;
		}
	
		let mailCode = "";
		$("#checkBtn").click(function(){
			
			
			if(mail.val().trim() == ""){
				alert("이메일을 입력해주세요");
				return;
			}
			
			$("#checkBtn").attr("disabled", true);
			
			//입력한 아이디와 이메일이 일치하는 회원정보가 있는지 확인
			$.ajax({
				url : "mailCheck.jsp",
				//select count(*) from user where id = ? and mail = ?
				type : "post",
				async : false,
				//비동기를 강제로 동기화
				data : {
					id : id.val(),
					mail : mail.val()
				},
				success : function(result){
					mailCode = result.trim();
					//여기 return은 success를 종료
				},
				error : function(){
					console.log("에러 발생");
					$("#checkBtn").attr("disabled", false);
				}
			});
			
			if(mailCode == 0){
				$("#checkBtn").attr("disabled", false);
				alert("아이디와 이메일이 동일하지 않습니다.");
				return;
			}
			
			$.ajax({
				url : "sendMail.jsp",
				type : "post",
				data : {
					mail : mail.val()
				},
				success : function(result){
					mailCode = result.trim();
					if(mailCode == "fail"){
						$("#checkBtn").attr("disabled", false);
						alert("이메일이 올바르지 않습니다.");
					}else{
						alert("이메일 전송 완료");
					}
				},
				error : function(){
					console.log("에러 발생");
					$("#checkBtn").attr("disabled", false);
				}
			});
			
		});
		
		$("#mailCheckBtn").click(function(){
			
			if(id.val().trim() == ""){
				id.focus();
				id.val("");
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			if(mail.val().trim() ==""){
				mail.focus();
				mail.val();
				alert("이메일을 입력해주세요.");
				return false;
			}
			
			let mailCheck = $("#mailCheck");
			if(mailCheck.val().trim() == ""){
				
				return false;
			}
			
			if(mailCode == mailCheck.val().trim()){
				emailCheckFlag = true;
				alert("코드가 일치합니다!")
			}else{
				emailCheckFlag = false;
				alert("코드가 일치하지 않습니다.");
				return false;
			}
				
		});
	</script>
</html>