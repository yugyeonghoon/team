<%@page import="java.util.List"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	if(user == null || user.getUserType() != 0){
		response.sendRedirect("calendar.jsp");
		return;
	}
	
	UserDAO dao = new UserDAO();
	List<UserVO> list = dao.getAllManager();
%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>매니저 관리</title>
		<style>
				body{
					font-family: 'Source Sans Pro', sans-serif;
					background: white;
					margin: 0;
					padding: 0;
					color: #333;
				}
				.user-container{
					padding : 20px;
					max-width: 900px;
					margin: 40px auto;
					background: white;
					border-radius: 10px;
					box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
				}
				h2{
					color: #0073e6;
					text-align: center;
					margin-bottom: 20px;
				}
				table{
					width: 100%;
					border-collapse: collapse;
					margin-top:20px;
				}
				th,td {
					text-align: center;
					padding: 10px;
					border: 1px solid #000000;
				}
				th{
					background-color:#edebeb;
					color: #3d3838;
				}
				.action-buttons{
					text-align: center;
				}
				.action-buttons button{
					background: #2575fc;
					color: white;
					border: none;
					padding: 5px 10px;
					border-radius: 5px;
					cursor: pointer;
					font-size: 0.9rem;
					margin-right: 5px;
					transition: background 0.3s;
				}
				.action-buttons button:hover {
					background: #1a5fc4;
				}
				.action-buttons button.delete {
					background: #ff1a1a;
				}
				.action-buttons button.delete:hover{
					background: #e60000;
				}
			</style>
		</head>
	<body>
		<div class="user-container">
			<h2>매니저 관리</h2>
			<table>
				<thead>
					<tr>
						<th>등급</th>
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(int i = 0; i < list.size(); i++){
							UserVO vo = list.get(i);
							int userType = vo.getUserType();
							String id = vo.getId();
							String name = vo.getName();							
							String nick = vo.getNick();
							String email = vo.getEmail();
					%>
						<tr style="color:<%= userType == 0 ? "black" : "red" %>;">
							<td><%= userType %></td>
							<td><%= i+1 %></td>
							<td><%= id %></td>	
								<input type="hidden" name="id" value="<%= id %>">			
							<td><%= name %></td>
							<td><%= nick %></td>
							<td><%= email %></td>
							<td class="action-buttons">
								<button onclick="location.href='manager_update.jsp?id=<%= id %>'">수정</button>
								<button class="delete" onclick="deleteUser('<%= id %>')">삭제</button>
							</td>
						</tr>				
					<%
						}
				%>
				</tbody>
			</table>
		</div>
	</body>
	<script>
		function deleteUser(id){
			let result = confirm("회원을 탈퇴 하시겠습니까 ?")
			if(result == true){
				$.ajax({
					url : "joinout.jsp",
					type : "post",
					data : {
						id : id
					},
					success : function(result){
						if(result.trim() == "success"){
							alert("회원을 탈퇴시켰습니다.");
							location.href = "manager.jsp"
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