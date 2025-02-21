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
	.group-container {
	    padding: 20px;
	    max-width: 900px;
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
	}
	th,td {
		text-align: center;
		padding: 10px;
		font-size: 17px;
		width: 50%;
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
		padding: 5px 10px;
		border-radius: 5px;
		cursor: pointer;
		font-size: 15px;
		margin-right: 5px;
		transition: background 0.3s;
		font-weight: bold;
		padding: 10px 10px;
	}
	.action-buttons button:hover {
		background: #283552;
	}
	.action-buttons button.make {
		background: #000000;
	}
	input{
		width: 200px;
	    height: 32px;
	    font-size: 17px;
	    border: 0;
	    border-radius: 10px;
	    padding-left: 10px;
	    background-color: rgb(255 255 255);
	    box-shadow: 0 1px 10px rgb(30 88 139 / 20%);
	}
</style>
</head>
<body>
	<div class="group-container">
	<h2>그룹 만들기</h2>
		<div class="action-buttons">
			<button class="group"onclick="location.href='group.jsp'">My Group</button>
		</div>
		<form action="makegroupok.jsp" method="post">
			<table>
				<thead>
					<tr>	
						<th>그룹 이름</th>
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