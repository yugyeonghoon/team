<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		.findid{
			margin: 0;
			top: 180px;
			left: 50%;
			position: absolute;
			text-align: center;
			transform: translateX(-50%);
			background-color: white;
			border-radius: 9px;
			border-top: 2px solid gray;
			border-bottom: 2px solid gray;
			border-right: 2px solid gray;
			border-left:2px solid gray;
			width: 800px;
			height: 300px;
			/* box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53); */
		}
		.idform{
	        font-size: 1rem;
	        width: 50%;
	        display: inline-block;
	        color: #dfdeee;
       	}
		h1{
			text-align: center;
			margin-bottom: 20px;
			color: black;
			font-family: 'Seoul 1980', sans-serif;
		}
		.btn{
			font-size: 1rem;
			cursor: pointer;
			margin-top: 10px;
			border: 0;
			background: black;
			color: #dfdeee;
			border-radius: 100px;
			width: 80px;
		}	
		.btn1{
			font-size: 1rem;
			cursor: pointer;
			margin-top: 10px;
			border: 0;
			background: black;
			color: #dfdeee;
			border-radius: 100px;
			width: 130px;
			height: 35px;
		}
		input{
			margin: 10px auto;
			background: black;
			border: 0;
			border-radius: 5px;
			outline: none;
			width: 250px;
			height: 35px;
			font-size: 0.9rem;
			color: white;
			      -webkit-transition: all .2s ease-out;
			    -moz-transition: all .2s ease-out;
			    -ms-transition: all .2s ease-out;
			    -o-transition: all .2s ease-out;
			    transition: all .2s ease-out;
		}
		input:focus{
			border: 1px solid #79A6FE;
			color: white;
		}
		.fi1{
			color: black;
		}
		::-webkit-input-placeholder {
		  color: white;
		}
	</style>
	</head>
	<body style="padding:30px;" >
		<div class="findid">
		<h1>아이디 찾기</h1>
			<form class="idform" method="post" action="findidok.jsp" onsubmit="return formCheck()">
				<div class="fi1"> &nbsp 이름 :
					<input type="text" name="name" id="name" placeholder="이름을 입력하세요" autocomplete="off">
				</div>
				<div class="fi1">이메일 :
					<input type="text" name="email" id="email" placeholder="email을 입력하세요" autocomplete="off">
				</div>
				<div>
					<button type="submit" class="btn" id="btn">찾기</button>	
					<button onclick="location.href='login.jsp'" class="btn"> 취소</button>
				</div>
			</form>
				<div>
					<button onclick="location.href='login.jsp'" class="btn1">login</button>
					<button onclick="location.href='findpw.jsp'" class="btn1">비밀번호 찾기</button>
				</div>
			</div>
	</body>
	<script>
		let email = $("#email");
		let name = $("#name");
	
		function formCheck(){
			
			if(name.val().trim() == ""){
				name.focus();
				name.val("");
				confirm("이름을 입력해주세요.");
				return false;
			}
			
			if(email.val().trim() == ""){
				email.focus();
				email.val("");
				confirm("이메일을 입력해주세요.");
				return false;
			}
		}
		
		let check = "";
		$("#btn").click(function(){
			
			if(name.val().trim() == ""){
				name.focus();
				name.val("");
				confirm("이름을 입력해주세요.");
				return false;
			}
			
			if(email.val().trim() == ""){
				email.focus();
				email.val("");
				confirm("이메일을 입력해주세요.");
				return false;
			}
		
		$.ajax({
			url : "idMailCheck.jsp",
			//select count(*) from user where id = ? and mail = ?
			type : "post",
			async : false,
			//비동기를 강제로 동기화
			data : {
				email : email.val(),
				name : name.val()
			},
			success : function(result){
				check = result.trim();
				//여기 return은 success를 종료
			},
			error : function(){
				console.log("에러 발생");
				$("#btn").attr("disabled", false);
			}
		});
		
		if(check == 0){
			$("#btn").attr("disabled", false);
			alert("일치하는 이름과 이메일이 없습니다.");
			return false;
		}else{
			alert("완료");
		}
		});
	</script>
</html>