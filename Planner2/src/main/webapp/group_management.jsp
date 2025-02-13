<%@page import="group.memberVO"%>
<%@page import="group.memberDAO"%>
<%@page import="group.groupVO"%>
<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<% 
	if(user == null || user.getUserType() != 0){
		response.sendRedirect("calendar.jsp");
		return;
	}

	groupDAO dao = new groupDAO();
	
	List<groupVO> list = dao.view();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹페이지</title>
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
	.action-buttons button.delete {
		background: #ff1a1a;
	}
	.action-buttons button.delete:hover{
		background: #e60000;
	}
	.group_buttons{
		text-align: right;
	}
</style>
</head>
<body>
	<div class="group-container">
	<h2>그룹 관리</h2>
		<table>
			<thead>
				<tr>	
					<th>그룹번호</th>
					<th>그룹명</th>
					<th>그룹장</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(int i = 0; i < list.size(); i++){
						groupVO gvo = list.get(i);
						int no = gvo.getGroupNum();
						String gname = gvo.getGroupName();
						int groupType = gvo.getGroupType();
						String id = gvo.getId();
						%>
						<tr style="color:<%= groupType == 1 ? "black" : "red" %>;">
							<td><%= no %></td>
							<td><%= gname %></td>
							<td><%= id %></td>
							<td class="action-buttons">
								<button class="delete" onclick="location.href='groupDelete.jsp?no=<%= no %>'">그룹 삭제</button>
							</td>
						</tr>
						<%
					}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>