<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Study Calendar</title>
		<style>
		@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400');
		
		body, html {
		  font-family: 'Source Sans Pro', sans-serif;
		  background-color: #1d243d;
		  padding: 0;
		  margin: 0;
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
		  background-color: rgb( 33, 41, 66 );
		  border-radius: 9px;
		  border-top: 10px solid #79a6fe;
		  border-bottom: 10px solid #8BD17C;
		  width: 400px;
		  height: 500px;
		  box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53);
		}
		
		.box h4 {
		  font-family: 'Source Sans Pro', sans-serif;
		  color: #5c7fda; 
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
		  background: #262e49;
		  border: 0;
		  border-radius: 5px;
		  padding: 14px 10px;
		  width: 320px;
		  outline: none;
		  color: #d6d6d6;
		      -webkit-transition: all .2s ease-out;
		    -moz-transition: all .2s ease-out;
		    -ms-transition: all .2s ease-out;
		    -o-transition: all .2s ease-out;
		    transition: all .2s ease-out;
		  
		}
		::-webkit-input-placeholder {
		  color: #565f79;
		}
		
		.box input[type = "text"]:focus,.box input[type = "password"]:focus {
		  border: 1px solid #79A6FE;
		  
		}
		
		a{
		  color: #5c7fda;
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
		  background: #7f5feb;
		  color: #dfdeee;
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
		  background: #5d33e6;
		}
		
		.rmb {
		  position: absolute;
		  margin-left: -20%;
		  margin-top: 0px;
		  color: #5c7fda;
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
		    font-size: 16px;
		    content: "v";
		    position: absolute;
		    top: -4px;
		    color: #896cec;
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
		<body id="particles-js"></body>
			<div class="animated bounceInDown">
				<div class="container">
					<span class="error animated tada" id="msg"></span>
					<form method="post" name="form1" class="box" onsubmit="return checkStuff()" action="loginok.jsp">
				<h4>로그인 페이지<span></span></h4>
				<h5></h5>
					<input value="hong" type="text" id="username" name="username" placeholder="Id" autocomplete="off">
					<i class="typcn typcn-eye" id="eye"></i>
					<input value="12345" type="password" name="password" placeholder="Passsword" id="pwd" autocomplete="off">
					
					<!-- <span class="rmb">
					    <input type="checkbox" id="checkId" name="checkId">                                         
					    <label for="checkId"></label>
					    아이디 저장
					</span> -->
					<label>
						<input type="checkbox" id="checkId" name="checkId">
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
			$(document).ready(function(){
				let cookieId = getCookie("key");
				
				if(cookieId != ""){
					$("#username").val(cookieId);
					$("#checkId").attr("checked", true);		
				}
				
				function getCookie(key) {
		            key = key + "=";
		            let cookieData = document.cookie;
		            let firstCookie = cookieData.indexOf(key);
		            let cookieValue = "";

		            if(firstCookie != -1){
		                firstCookie += key.length;
		                let endCookie = cookieData.indexOf(';', firstCookie);
		                if(endCookie == -1){
		                    endCookie = cookieData.length;
		                    cookieValue = cookieData.substring(firstCookie , endCookie);
		                }
		            }
		            return unescape(cookieValue);
		        }

		        function setCookie(key , value , day){
		            let currentTime = new Date();
		            currentTime.setDate(currentTime.getDate() + day);
		            let cookieValue = escape(value) + ((day == null) ? "" : "; expires=" + currentTime.toGMTString());

		            document.cookie = key + "=" + cookieValue;
		        }

		        function deleteCookie(key){
		            let currentTime = new Date();
		            currentTime.setDate(currentTime.getDate() - 1);
		            document.cookie = key + "=" + "; expires=" + currentTime.toGMTString();
		        }

		        $("#btn1").click(function (){
		            if($("#checkId").is(":checked")){
		                setCookie("key" , $("#username").val() , 3);
		            }else{
		                deleteCookie("key");
		            }
		            document.form.submit();
		        })
			});
		</script>
</html>