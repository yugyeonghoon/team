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
					padding: 20px;
				    max-width: 1000px;
				    margin: 40px auto;
				    background: white;
				    border-radius: 10px;
				    box-shadow: 0 2px 10px rgb(30 88 139 / 20%);
				    border: 2px solid #a9a9a9;
				   }
				h2{
					color: #000000;
					text-align: center;
					margin-bottom: 20px;
					font-size: 27px;
					}
				table{
					width: 100%;
					margin-top:20px;
					border-radius: 12px;
					border-style: hidden;
					border-collapse: collapse;
				}
				th,td {
					text-align: center;
					padding: 6px;
					font-size: 17px;
					border-radius: 12px;
				}
				th{
					background-color:#edebeb;
					color: #3d3838;
					font-size: 19px;
				}
				.action-buttons{
					text-align: center;
				}
				.action-buttons button{
					background: #000000;
					color: white;
					border: none;
					border-radius: 5px;
					cursor: pointer;
					font-size: 15px;
					margin-right: 5px;
					transition: background 0.3s;
					font-weight: bold;
					padding: 10px 10px;
				}
				.action-buttons button:hover {
					background:#283552;
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