<%@page import="group.groupVO"%>
<%@page import="com.mysql.cj.x.protobuf.MysqlxCrud.Insert"%>
<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<% 
	UserVO user1 = (UserVO)session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹만들기</title>
<style>
	body{
		font-family: 'Source Sans Pro', sans-serif;
		background: white;
		margin: 0;
		padding: 0;
		color: #333;
	}
	.group-container{
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
		text-align: left;
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
	.action-buttons button.make {
		background: #2575fc;
		padding: 7px 10px;
	}
	.group_buttons{
		text-align: right;
	}
</style>
</head>
<body>
	<div class="group-container">
	<h2>그룹 만들기</h2>
		<div class="group_buttons">
			<button onclick="location.href='group.jsp'">My Group</button>
			<button class="group">그룹만들기</button>
		</div>
		<form action="makegroupok.jsp" method="post">
			<table>
				<thead>
					<tr>	
						<th>그룹 명</th>
						<th>그룹 생성자</th>
					
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<input name="gname"></input>
						</td>
						<td> <%=user1.getId() %> </td>
					</tr>
				</tbody>
			</table>
			<br>
				<div class="action-buttons"> 
					<button class="make" type="submit">그룹생성</button>
				</div>
		</form>
	</div>
</body>
</html>