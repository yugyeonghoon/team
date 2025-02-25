<%@page import="board.BoardVO"%>
<%@page import="board.CalendarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String no = request.getParameter("no");
	if(no == null || no.isEmpty()){
		response.sendRedirect("calendar.jsp");
		return;
	}
	CalendarDAO dao = new CalendarDAO();
	BoardVO vo = dao.view(no);
	
	int bno = vo.getNo();
	String title = vo.getTitle();
	String start = vo.getStartTime();
	String end = vo.getEndTime();
	String content = vo.getContent();
	String author = vo.getAuthor();
	
	String startDate =  start.split(":")[0] + "시:" + start.split(":")[1] + "분";
	String endDate = end.split(":")[0] + "시:" + end.split(":")[1] + "분";
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./jquery.datetimepicker.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="./jquery.datetimepicker.full.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		font-family: 'Source Sans Pro', sans-serif;
		background: white;
		margin: 0;
		padding: 0;
		color: #333;
	}
	.page-container{
		padding: 20px;
		max-width: 900px;
		margin: 40px auto;
		background: #ffffff;
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
	}
	th, td {
		text-align: left;
		padding: 10px;
		border:none;
		text-align: center;
		font-size: 1.3rem;
	}
	.memo{
		padding: 10px;
	    margin-bottom: -21px;
	    border: 1px solid;
	    border-radius: 5px;
	    text-align: left;
	}
	.text-title{
		height: 3em;
		width: 98%;
		vertical-align: middle;
		padding: 10px;
		border-radius: 10px;
		resize: none;
		font-size:15px;
	}
	.text-content{
	    width: 98%;
	    height: 15em;
	    text-align: left;
	    padding: 10px;
	    border-radius: 10px;
	    resize: none;
	}
	input[type="text"] {
		height: 25px; 
		margin-top: 3px;
		font-size:15px;
	}
	.action-buttons{
		text-align: center;
	}
	.action-buttons button{
		background: #000000;
		color: #ffffff;
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
		transition: background 0.3s ease;
		margin: 0 64px;
		font-size: 14px;
		font-weight: bold;
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
	.memo{
		text-align: center;
		border: none;
	}
</style>
</head>
<script>
$.datetimepicker.setLocale('ko');
$(document).ready(function(){
	$('#datetimepicker_start_time').datetimepicker({
		format:'Y-m-d H시:i분',
		step:30,
		scrollMonth: false,
		onShow: function (ct) {
			console.log(ct);
            this.setOptions({
                maxDate: $('#datetimepicker_end_time').val() ? $('#datetimepicker_end_time').val() : false
            })
        }
	});
})
$(document).ready(function(){
	$('#datetimepicker_end_time').datetimepicker({
		format:'Y-m-d H시:i분',
		step:30,
		scrollMonth: false,
		onShow: function (ct) {
            this.setOptions({
                minDate: $('#datetimepicker_start_time').val() ? $('#datetimepicker_start_time').val() : false
            })
        }
	});
	
})

</script>
<body>
<div class="page-container">
		<h2>일정 수정</h2>
		<form action="modifyok.jsp" method="post">
			<input type="hidden" value="<%= no %>" name="no">
			<table>
				<thead>
					<tr>
						<th name="author"><%=author%></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><textarea class="text-title" name="title"><%=title %></textarea></td>
					</tr>
					<tr>
						<td>
						<p> 시작일 </p>
						<div class="date">
						<input id="datetimepicker_start_time" type="text" name="start" value="<%=startDate%>">
						</div>
						</td>
					</tr>
					<tr>
						<td>
						<p>종료일</p>
						<div class="date">
						<input id="datetimepicker_end_time" type="text" name="end" value="<%=endDate %>">
						</div>
						</td>
					</tr>
				</tbody>	
			</table>
			
			<div class="memo">Memo</div> <br>
			<textarea class="text-content" name="content"><%=content %></textarea><br>
			<% if(user != null && (user.getId().equals(author)|| user.getUserType() == 0)){
			%>
			<div class="action-buttons">
				<button type="submit">수정</button>
			</div>
			<% } %>
		</form>
	</div>
</body>
</html>