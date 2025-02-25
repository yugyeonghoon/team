<%@page import="user.UserVO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");	

	UserVO user = (UserVO)session.getAttribute("user");

	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	if(name == null || email == null){
		response.sendRedirect("findid.jsp");
		return;
	}
	
	if(name.isEmpty() || email.isEmpty()){
		response.sendRedirect("findid.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	UserVO vo = new UserVO();
	
	vo.setName(name);
	vo.setEmail(email);
	
	String id  = dao.findid(vo);
	
	if(id == null){
		response.sendRedirect("findid.jsp");
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
			input{
				text-align: center;
				margin: 10px auto;
				background: #ffffff;
				border: 0;
				border-radius: 5px;
				outline: none;
				width: 250px;
				height: 35px;
				font-size: 0.9rem;
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
			.find-container{
				margin: 0;
				top: 180px;
				left: 50%;
				position: absolute;
				text-align: center;
				transform: translateX(-50%);
				background-color: #91CDE1;
				border-radius: 9px;
				border-top: 2px solid gray;
				border-bottom: 2px solid gray;
				border-right: 2px solid gray;
				border-left:2px solid gray;
				width: 500px;
				height: 250px;
				/* box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53); */
			}	
			label{
				display: block;
	            margin-bottom: 8px;
	            font-weight: bold;
	            color: black;
			}
			.find-box{
				position: absolute;
				top: 20%;
				left: 25%;
			}
			.btn1{
				font-size: 1rem;
				cursor: pointer;
				margin-top: 180px;
				border: 0;
				background:  #ffffff;
				color: #000000;
				border-radius: 100px;
				width: 130px;
				height: 35px;				
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
			<div class="find-container">
				<form>
					<div class="find-box">
						<label><%= name %> 님의 아이디는</label>
							<input type="text" value="<%=id %>" readonly>
						<label>입니다.</label>
					</div>	
				</form>
					<div>
						<button onclick="location.href='login.jsp'" class="btn1">login</button>
						<button onclick="location.href='findpw.jsp'" class="btn1">비밀번호 찾기</button>
					</div>
			</div>
		</div>	
	</body>
</html>