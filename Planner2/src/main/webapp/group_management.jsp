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
	
	List<groupVO> list = dao.view(null);
	
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
						groupVO vo = list.get(i);
						int no = vo.getGroupNum();
						String gname = vo.getGroupName();
						int groupType = vo.getGroupType();
						String id = vo.getId();
						%>
						<tr>
							<td><%= no %></td>
							<td><%= gname %></td>
							<td><%= id %></td>
							<td class="action-buttons">
								<button class="delete" onclick="deletegroup(<%=no%>, this)">그룹 삭제</button>
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
function deletegroup(no, obj){
	let result = confirm("그룹을 삭제하시겠습니까?")
	if(result == true){
		$.ajax({
			url : "groupDelete.jsp",
			type : "post",
			data : {
				no : no
			},
			success : function(result){
				console.log(result);
				if(result.trim() == "success"){
					alert("그룹을 삭제하셨습니다.");
					$(obj).parent().parent().remove();
				}
			},
			error : function(){
				console.log("error");
				alert("그룹 삭제실패");
			}
		});
	}
}
</script>
</html>