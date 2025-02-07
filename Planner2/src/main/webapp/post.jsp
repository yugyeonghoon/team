<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
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
			<h2>제목</h2>
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
							<td>나중에 이쁘게 만들기</td>
						</tr>
					</table>	
				</table>
		</div>
	</body>
</html>