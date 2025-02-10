<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%
	String no = request.getParameter("no");
	UserVO user = (UserVO)session.getAttribute("user");
	
	String author = null;
	if(user == null){
		author = null;
	}else{
		author = user.getId();
	}
%>
<!DOCTYPE html>
<html>
	<head>
	<script src="./jquery-3.7.1.js"></script>
		<meta charset="UTF-8">
		<title>상세상세</title>
		<style>
			body{
				font-family: 'Seoul 1980', sans-serif;
	            background-color: white;
	            margin: 0;
	            padding: 0;
	            color: #333;
	            height: 100vh;
	            display: flex;
	            justify-content: center;
			}
			h2, .author{
				text-align: center;
			}
			.author{
				font-size: 1.3rem
			}
			.table1{
				border-top: 3px solid black;
				border-left: 3px solid black;
				border-right: 3px solid black;
				border-bottom: 3px solid black;
			}
			.table2{
				border-top: none;
				border-left: 3px solid black;
				border-right: 3px solid black;
				border-bottom: 3px solid black;
			}
			.a{
				text-align: center;
				font-size: 1.5rem
			}
		</style>
	</head>
	<body>
		<div>
			<form action="StdPlanPostok.jsp" method="post">
			
				<h2>제목 : <input type="text" id="title" name="title"></h2>
				<div class="author">작성자</div>
				<div class="a">2025-01-31 14:23 &emsp; &#10140; &emsp; 2025-01-31 16:30</div>
				<!-- <span class="a">2025-01-31 14:23</span>
				<span class="b">&#10140;</span>
				<span class="c">2025-01-31 16:30</span> -->
				<table class="table1" border="0" align="center" width="1080px">
					<tr>
						<td align="center">메모</td>
					</tr>
					<table class="table2" width="1080px">
						<tr height="760px">
							<td><textarea rows="45" cols="150px" id="memo" name="memo"></textarea>나중에 이쁘게 만들기</td>
						</tr>
					</table>	
				</table>
				<div>
					<button type="submit" id="saveBtn">저장</button>
				</div>
			</form>
		</div>
	</body>
	<script>
		function checkPost(no) {
			console.log(no);
		}
	
		$(document).ready(function() {
			
			<%-- $("#saveBtn").click(function(){
				let title = $("#title").val();
				let memo = $("#memo").val();
				
				if(title == "") {
					alert("제목을 입력해주세요");
				}
				else if(memo == "") {
					alert("내용을 입력해주세요");
				}
				else {
					
					//내용 입력 후 버튼을 클릭하고 page.jsp로 이동하면서 page.jsp에 html 코드 실행과 더불어 같이 데이터도 넘어가게 하고 싶은데 이게 맞나
							
					$.ajax({
						url: "StdPlanPostok.jsp",
						type: "post",
						data: {
							no: "<%=no %>",
							title: $("#title").val(),
							content: $("#memo").val(),
							author: "<%=author %>"
						},
						success: function(result) {
							
								let html = "";
									html += "<div class='list'>";
									html += 	"<ul class='planList'>";
									html += 		"<li>";
									html += 			"<p>"+memo+"</p>";
									html +=				"<input type='checkbox' id='check1' class='checkbox'>";
									html +=				"<label for='check1'></label>";
									html +=			"</li>";
									html +=		"</ui>";
									html += "</div>";

								$(".list").append(html);
								
								console.log($("#title").val());
								console.log(memo);
						},
						error: function() {
							console.log("실패");
						}
					});	
				};
			}); --%>
		});
			
	</script>
</html>