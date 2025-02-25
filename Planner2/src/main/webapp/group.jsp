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
	System.out.println(groupNum);
	List<memberVO> list = dao.view(user1.getId(), groupNum);

	
	int grouptype = 0;
	String mid = user1.getId();
	String gname = "";
	
	for(int i = 0; i < list.size(); i ++){
		//그룹원 전체를 순회하며 로그인한 사용자의 아이디랑 동일한 그룹원의 그룹타입을 꺼낸다.
		memberVO vo2 = list.get(i);
		String id = vo2.getId();
		int gtype = vo2.getGrouptype();
		gname = vo2.getGroupname();
		
		if(id.equals(user1.getId())){
			grouptype = gtype;
			
		}
	}
	
	int gnum = list.size() > 0 ? list.get(0).getGroupnum() : 0;
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
		border-collapse: collapse;
		margin-top:20px;
		border-radius: 12px;
		border-style: hidden;
		border-collapse: collapse;
	}
	th,td {
		text-align: center;
		padding: 10px;
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
		background: #283552;
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
	.group, .invite {
		margin:5px;
	}
	.ii{
	 pointer-events : none;
	 }
</style>
</head>
<body>
	<div class="group-container">
	<%if(groupNum != null){
	%>
		<h2 id="group-name"><%= gname %></h2>
	<%	
		}else{
		%>
			<h2 id="group-name">MY Group Member</h2>
		<%
	}
	%>
		<div class="action-buttons">
			<%if(groupNum == null){
				%>
				<button class="group"  onclick="location.href='makegroup.jsp'">그룹만들기</button>
				<%
			}%>
			<%if(groupNum != null && grouptype == 1){
				%>
				<button type="button" class="invite" onclick="invite(<%= gnum %>)">초대하기</button>
				<button type="submit" class="updategname" onclick="updategname('<%=gname%>', <%=gnum%>)">그룹이름변경</button>
			<%
				}%>
			<%if(groupNum != null && grouptype == 1){
				%>
				<button class="delete" onclick="deleteGroup(<%= gnum%>, this)">그룹삭제</button>
			<%
				}else if(groupNum != null){
				%>
				<button class="delete" onclick="outmember('<%= mid %>')">그룹나가기</button>
			<%
				}%>
			
		</div>
		<table>
			<thead>
				<tr>	
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<% if(grouptype == 1 && groupNum != null){
						%>
							<th>관리</th>
						<%
					}%>
				</tr>
			</thead>
			<tbody>
			<%for(int i = 0; i < list.size(); i++){
					memberVO vo2 = list.get(i);
					int no = vo2.getNo();
					String id = vo2.getId();
					String name = vo2.getName();
					String email = vo2.getEmail();
					%>
				
				<tr>
					<td><%= id%></td>
					<td><%= name %></td>
					<td><%= email %></td>
					<%if(grouptype == 1 && groupNum != null){
						%>
					
						<td class="action-buttons">
							
							<% if(!id.equals(user1.getId())) {
								%>
									<button type="submit" class="delete" onclick="deleteMember(<%= no %>, this)">삭제</button>
								<%
							}else{
							%><%
							%>
							<button class="ii">관리자</button>
							<%}%>
						</td>
					<%}%>
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
				//alert("초대하였습니다.");
				if(data.trim() == "nouser"){
					alert("없는 사용자입니다.");
				}else if(data.trim() == "inUser"){
					alert("이미 그룹에 속한 사용자 입니다.");
				}else{
					location.reload();
				}
				
			},
			error : function(){
				console.log("에러발생");
			}
		});
}
function deleteMember(no, obj){
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
function deleteGroup(gnum, obj){
	console.log(gnum);
	let result = confirm("그룹을 삭제하시겠습니까 ?");
	if(result == true){
		$.ajax({
			url : "deletegroup.jsp",
			type : "post",
			data : {
				gnum : gnum
			},
			success: function(result){
				if(result.trim() == "success"){
					$(obj).parent().parent().children("table").children("tbody").remove();
				}
			},
			error : function(){
				console.log("error");
			}
		});
	}
}
function outmember(mid){
	console.log(mid);
	let result = confirm("그룹을 나가시겠습니까 ?");
	if(result == true){
		$.ajax({
			url : "outmember.jsp",
			type : "post",
			data : {
				mid : mid
			},
			success : function(data){
				if(data.trim() == "success"){
					location.href="calendar.jsp"
				}
			},
			error : function(){
				console.log("error");
			}
		});
	}
}
function updategname(gname, gnum){
	let result = prompt('변경하실 그룹명을 적어주세요', '변경하실 그룹이름');
	console.log(result)
	if(result == null){
		return;
	}
	$.ajax({
		url : "updategroupgname.jsp",
		type : "post",
		data : {
			gname : result,
			gnum : gnum
		},
		success : function(data){
			if(data.trim() == "success"){
				$("#group-name").text(result);
			}
		},
		error : function(){
			console.log("error");
		}
	});
}

</script>
</html>