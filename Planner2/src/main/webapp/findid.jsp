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
			background-color: #1d243d;
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
			background-color: rgb( 33, 41, 66 );
			border-radius: 9px;
			border-top: 10px solid #79a6fe;
			border-bottom: 10px solid #8BD17C;
			width: 800px;
			height: 300px;
			box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53);
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
			color: #5c7fda;
			font-family: 'Seoul 1980', sans-serif;
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
			font-size: 0.9rem;
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
					<button type="submit" class="btn">찾기</button>	
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
		function formCheck(){
			let name = $("#name")
			let email = $("#email")
			
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
	</script>
</html>