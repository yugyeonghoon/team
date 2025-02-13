<%@page import="java.util.List"%>
<%@page import="group.memberVO"%>
<%@page import="group.memberDAO"%>
<%@page import="group.groupVO"%>
<%@page import="group.groupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<% 
	UserVO user1 = (UserVO)session.getAttribute("user");
	memberDAO dao = new memberDAO();
	memberVO vo = new memberVO();
	
	
	List<memberVO> list = dao.view(user1.getId());
	int grouptype = vo.getGrouptype();
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
	<h2>my group</h2>
		<div class="group_buttons">
			<button class="invite">초대하기</button>
			<button class="group"  onclick="location.href='makegroup.jsp'">그룹만들기</button>
		</div>
		<table>
			<thead>
				<tr>	
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
			<%for(int i = 0; i < list.size(); i++){
					memberVO vo2 = list.get(i);
					int no = vo2.getNo();
					String id = vo2.getId();
					String name = vo2.getName();
					String email = vo2.getEmail();
					int gnum = vo2.getGroupnum();
					%>
				
				<tr>
					<td><%= id%></td>
					<td><%= name %></td>
					<td><%= email %></td>
					<td class="action-buttons">
						<button>수정</button>
						<button type="submit" class="delete" onclick="deletemember(<%= no %>, this)">삭제</button>
						<button type="submit" class="invite" onclick="invite(<%= gnum %>)">초대</button>
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
function invite(gnum){
	let result = prompt('초대하실 id를 입력해주세요', 'id');
	console.log(result);
		$.ajax({
			url : "invite.jsp",
			type : "post",
			data :{
				id : result,
				gnum : gnum
			},
			success : function(data){
				console.log(data);
				alert("초대하였습니다.");
				if(data.trim() == "nouser"){
					alert("없는 사용자입니다.");
				}else if(data.trim() == "inUser"){
					alert("이미 그룹에 속한 사용자 입니다.");
				}
				
			},
			error : function(){
				console.log("에러발생");
			}
		});
}
function deletemember(no, obj){
	console.log(no);
	
	let result = confirm("삭제하시겠습니까?");
	if(result == true){
		$.ajax({
			url : "delete.jsp",
			type : "post",
			data :{
				id : no
			},
			success : function(result){
				if(result.trim() == "success"){
					//버튼이 눌린 순서와 동일한 tr 전체 삭제
					$(obj).parent().parent().remove();
				}
			},
			error : function(){
				console.log("error");
			}
		});
	}else{
		
	}
}


</script>
</html>