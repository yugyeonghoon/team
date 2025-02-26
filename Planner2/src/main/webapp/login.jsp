<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		String cookie = "";

		Cookie[] cookies = request.getCookies(); //쿠키꺼내기
		//[JSESSIONID=5EBD963FD482064DE12CD024E12075EA;, id=asdasd] 
		//
		
		if(cookies != null && cookies.length > 0){
			for (int i = 0; i < cookies.length; i++){
				if (cookies[i].getName().equals("id")) { // 내가 원하는 쿠키명 찾아서 값 저장
					cookie = cookies[i].getValue();
				}
			}
		}	

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Study Calendar</title>
		<script src="./jquery-3.7.1.js"></script>
		<style>
		@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400');
		
		body, html {
		  font-family: 'Source Sans Pro', sans-serif;
		  background-color: #ffffff;
		  padding: 0;
		  margin: 0;
		  /* width:200px;
		  height:200px;
		  background:radial-gradient(circle,white,gray); */
		  /* background: url(./studycafe4.jpg) no-repeat;
		  background-size: 100% 100%; */
		}
		
		#particles-js {
		  position: absolute;
		  width: 100%;
		  height: 100%;
		}
		
		.container{
		  margin: 0;
		  top: 250px;
		  left: 50%;
		  position: absolute;
		  text-align: center;
		  transform: translateX(-50%);
		  background-color: #b1dbe900; 
		  opacity : 0.8;
		  border-radius: 9px;
		  border-top: 2px solid gray;
		  border-bottom: 2px solid gray;
		  border-right: 2px solid gray;
		  border-left:2px solid gray;
		  width: 400px;
		  height: 500px;
		  /* background: url(./sky1.jpg) no-repeat; */
		  opacity : 0.8;
		 /*  box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53); */
		}
		
		.box h4 {
		  font-family: 'Source Sans Pro', sans-serif;
		  color: #000000;
		  font-size: 18px;
		  margin-top:94px;;
		}
		
		.box h4 span {
		  color: #dfdeee;
		  font-weight: lighter;
		}
		
		.box h5 {
		  font-family: 'Source Sans Pro', sans-serif;
		  font-size: 13px;
		  color: #a1a4ad;
		  letter-spacing: 1.5px;
		  margin-top: -15px;
		  margin-bottom: 70px;
		}
		
		.box input[type = "text"],.box input[type = "password"] {
		  display: block;
		  margin: 20px auto;
		  background: #C2E9F3;
		  border: 0;
		  border-radius: 5px;
		  padding: 14px 10px;
		  width: 320px;
		  outline: none;
		  color: #000000;
		      -webkit-transition: all .2s ease-out;
		    -moz-transition: all .2s ease-out;
		    -ms-transition: all .2s ease-out;
		    -o-transition: all .2s ease-out;
		    transition: all .2s ease-out;
		  
		}
		::-webkit-input-placeholder {
		  color: #000000;
		}
		
		.box input[type = "text"]:focus,.box input[type = "password"]:focus {
		  border: 1px solid #000000;
		  
		}
		
		a{
		  color: #000000;
		  text-decoration: none;
		}
		
		a:hover {
		  text-decoration: underline;
		}
		
		 label input[type = "checkbox"] {
		  display: none; /* hide the default checkbox */
		}
		
		/* style the artificial checkbox */
		label span {
		  height: 13px;
		  width: 13px;
		  border: 2px solid #464d64;
		  border-radius: 2px;
		  display: inline-block;
		  position: relative;
		  cursor: pointer;
		  float: left;
		  left: 7.5%;
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
		  top: 79%;
		  left: 8%;
		  transition: 0.3s;
		  cursor: pointer;
		}
		
		.btn1:hover {
		  background: #C2E9F3;
		}
		
		.rmb {
		  position: absolute;
		  margin-left: -20%;
		  margin-top: 0px;
		  color: #000000;
		  font-size: 13px;
		}
		
		.forgetpass {
		  position: relative;
		  float: right;
		  right: 28px;
		  font-size: 13px;
		}
		.forgetid {
		  position: relative;
		  right: -75px;
		  font-size: 13px;
		  top:-2px;
		}
		
		.dnthave{
		    position: absolute;
		    top: 92%;
		    left: 43%;
		}
		
		[type=checkbox]:checked + span:before {/* <-- style its checked state */
		    font-family: FontAwesome;
		    font-size: 24px;
		    content: "v";
		    position: absolute;
		    top: -13px;
		    color: black;
		    left: -1px;
		    width: 13px;
		}
		
		.typcn {
		  position: absolute;
		  left: 339px;
		  top: 282px;
		  color: #3b476b;
		  font-size: 22px;
		  cursor: pointer;
		}      
		
		.typcn.active {
		  color: #7f60eb;
		}
		
		.error {
		  background: #ff3333;
		  text-align: center;
		  width: 337px;
		  height: 25px;
		  padding: 2px;
		  border: 0;
		  border-radius: 5px;
		  margin: 10px auto 10px;
		  position: absolute;
		  top: 25%;
		  left: 7.2%;
		  color: white;
		  display: none;
		}
		
		.footer {
		    position: relative;
		    left: 0;
		    bottom: 0;
		    top: 605px;
		    width: 100%;
		    color: #78797d;
		    font-size: 14px;
		    text-align: center;
		}
		
		.footer .fa {
		  color: #7f5feb;;
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
		<script>
			//이상한 아이디 저장 스크립트
			/* window.onload = function() {
				let pwd = document.getElementById('pwd');
				let eye = document.getElementById('eye');
				let usernameInput = document.querySelector('input[name="username"]');
				let rememberMeCheckbox = document.querySelector('input[type="checkbox"]');
	
			    eye.addEventListener('click', togglePass);
			    function togglePass() {
			      eye.classList.toggle('active');
			      (pwd.type === 'password') ? pwd.type = 'text' : pwd.type = 'password';
			    }
	
			    function checkStuff() {
			      let id = document.form1.id;
			      let password = document.form1.password;
			      let msg = document.getElementById('msg');
			      
			      if (id.value == "") {
			        msg.style.display = 'block';
			        msg.innerHTML = "아이디를 입력해주세요.";
			        id.focus();
			        return false;
			      } else {
			        msg.innerHTML = "";
			      }
	
			      if (password.value == "") {
			        msg.innerHTML = "비밀번호를 입력해주세요.";
			        password.focus();
			        return false;
			      } else {
			        msg.innerHTML = "";
			      }
			      
			      let re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
			      if (!re.test(id.value)) {
			        msg.innerHTML = "사용불가능한 아이디입니다.";
			        id.focus();
			        return false;
			      } else {
			        msg.innerHTML = "";
			      }
			    }
	
			    rememberMeCheckbox.addEventListener('change', function() {
			      if (this.checked) {
			        localStorage.setItem('username', usernameInput.value);
			      } else {
			        localStorage.removeItem('username');
			      }
			    });
	
			    if (localStorage.getItem('username')) {
			      usernameInput.value = localStorage.getItem('username');
			      rememberMeCheckbox.checked = true;
			    }
			  } */
		</script>
		<body id="particles-js">
			<div class="animated bounceInDown">
				<div class="container">
					<span class="error animated tada" id="msg"></span>
					<form method="post" name="form1" class="box" onsubmit="return formCheckId()" action="loginok.jsp">
				<h4>로그인 페이지<span></span></h4>
				<h5></h5>
					<input type="text" id="username" value="<%= cookie %>" name="username" placeholder="Id" autocomplete="off">
					<i class="typcn typcn-eye" id="eye"></i>
					<input type="password" name="password" placeholder="Passsword" id="pwd" autocomplete="off">
					
					<!-- <span class="rmb">
					    <input type="checkbox" id="checkId" name="checkId">                                         
					    <label for="checkId"></label>
					    아이디 저장
					</span> -->
					<label>
						<input type="checkbox" <%= !cookie.equals("") ? "checked" : "" %> id="checkId" name="checkId" class="checkId">
						<span></span>
						<small class="rmb">아이디 저장</small>
					</label>
						<a href="findid.jsp" class="forgetid">아이디 찾기</a>
						<a href="findpw.jsp" class="forgetpass">비밀번호찾기</a>
						<input type="submit" value="로그인" class="btn1" >
					</form>
						<a href="signup.jsp" class="dnthave">회원가입</a>
				</div> 	
			</div>
		</body>
<script>
let id = $("#username");
let pw = $("#pwd");

function formCheckId(){
	if(id.val().trim() == ""){
		id.focus();
		id.val("");
		alert("아이디를 입력해주세요.")
		return false;
	}
	if(pw.val().trim() == ""){
		pw.focus();
		pw.val("");
		alert("비밀번호를 입력해주세요.");
		return false;
	}
}
</script>
</html>