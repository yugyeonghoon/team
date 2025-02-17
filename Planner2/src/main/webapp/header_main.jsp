<%@page import="invate.inviteVO"%>
<%@page import="invate.inviteDAO"%>
<%@page import="java.util.List"%>
<%@page import="group.memberVO"%>
<%@page import="group.memberDAO"%>
<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO user = (UserVO)session.getAttribute("user");
	if(user ==null){
		response.sendRedirect("login.jsp");
		return;
	}
	memberDAO dao1 = new memberDAO();
	memberVO vo1 = new memberVO();
	List<memberVO> list1 = dao1.view(user.getId());
	
	
	inviteDAO iDao = new inviteDAO();
	inviteVO iVo = new inviteVO();
	
	List<inviteVO> invitelist = iDao.listinvite(user.getId());
	for(int i = 0; i < invitelist.size(); i++){
		inviteVO vo = invitelist.get(i);
		System.out.println(vo.getInviteno());
		System.out.println(vo.getGroupnum());
		System.out.println(vo.getGroupname());
	}
	
	
%>    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Study Calendar</title>
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	 <link
	    rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
	  />
	    <style>
	        header {
	        	height : 55px;
	            background: white;
	            color: #333;
	            padding: 15px;
	            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	            position: relative;
	            border-top: 3px solid gray;
				border-bottom: 3px solid gray;
	        }
	        .menu-toggle {
	            position: absolute;
	            top: 2px;
	            right: 15px;
	            background:black;
	            color: white;
	            border: none;
	            padding: 12px;
	            border-radius: 5px;
	            cursor: pointer;
	        }
	        .group-toggle {
	            position: absolute;
	            top: 2px;
	            right: 85px;
	            background:black;
	            color: white;
	            border: none;
	            padding: 12px;
	            border-radius: 5px;
	            cursor: pointer;
	        }
	        .menu-toggle:hover {
	            background: #1d243d;
	        }
	        .group-toggle:hover {
	            background: #1d243d;
	        }
	        .dropdown-menu {
	            display: none;
	            position: absolute;
	            top: 60px;
	            right: 80px;
	            background: white;
	            border: 1px solid #ddd;
	            border-radius: 0px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	            z-index: 1000;
	        }
	        .dropdown-menu2 {
	            display: none;
	            position: absolute;
	            top: 60px;
	            right: 80px;
	            background: white;
	            border: 1px solid #ddd;
	            border-radius: 0px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	            z-index: 1000;
	        }
	        .dropdown-menu3 {
	            display: none;
	            position: absolute;
	            top: 60px;
	            right: 80px;
	            background: white;
	            border: 1px solid #ddd;
	            border-radius: 0px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	            z-index: 1000;
	        }
	        .dropdown-menu a {
	            display: block;
	            padding: 10px;
	            color: #333;
	            text-decoration: none;
	            border-bottom: 1px solid #ddd;
	        }
	        .dropdown-menu2 a {
	            display: block;
	            padding: 10px;
	            color: #333;
	            text-decoration: none;
	            border-bottom: 1px solid #ddd;
	        }
	        .dropdown-menu3 a {
	            display: block;
	            padding: 10px;
	            color: #333;
	            text-decoration: none;
	            border-bottom: 1px solid #ddd;
	        }
	        .dropdown-menu a:last-child {
	            border-bottom: none;
	        }
	        .dropdown-menu2 a:last-child {
	            border-bottom: none;
	        }
	        .dropdown-menu a:hover {
	            background: #f4f4f4;
	        }
	        .dropdown-menu2 a:hover {
	            background: #f4f4f4;
	        }
	        .dropdown-menu3 a:hover {
	            background: #f4f4f4;
	        }
	        .dropdown-menu3 a:hover {
	            background: #f4f4f4;
	        }
	        .overlay {
	            display: none;
	            position: fixed;
	            top: 0;
	            left: 0;
	            width: 100%;
	            height: 100%;
	            background: rgba(0, 0, 0, 0.1);
	            z-index: 999;
	        }
	        .overlay2 {
	            display: none;
	            position: fixed;
	            top: 0px;
	            left: 0;
	            width: 100%;
	            height: 100%;
	            background: rgba(0, 0, 0, 0.1);
	            z-index: 999;
	        }
	        .overlay3 {
	            display: none;
	            position: fixed;
	            top: 0px;
	            left: 0;
	            width: 100%;
	            height: 100%;
	            background: rgba(0, 0, 0, 0.1);
	            z-index: 999;
	        }
	        .input{
	        	background:black;
	            color: white;
	        	top: 15px;
	            right: 15px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	        }
	        .ui-datepicker-calendar { display: none; }
	        
	        .ui-datepicker-calendar {
	        display: none;
	    	}
	    	.a{
	   			height: 70px;
			    position: absolute;
			    font-size:30px;
			    top: 80%;
			    left: 49%;
			    transform: translate(-50%, -50%);
			    color:cornflowerblue;
			    text-decoration-line:none;
	    	}
	    	p{
	    		margin-top: 10px;
	    		font-size: 15px;
	    	}
	    	
	    	.fa-bell{
				position: absolute;
			    top: 3px;
			    right: 150px;
			    background: black;
			    color: white;
			    border: none;
			    padding: 15px;
			    border-radius: 5px;
			    cursor: pointer;
	    	}
	    	.fa-bell:hover {
	            background: #1d243d;
	        }
	    </style>
		<script>
	        function toggleMenu() {
	            var menu = document.getElementById('dropdown-menu');
	            var overlay = document.getElementById('overlay');
	            if (menu.style.display === 'block') {
	                menu.style.display = 'none';
	                overlay.style.display = 'none';
	            } else {
	                menu.style.display = 'block';
	                overlay.style.display = 'block';
	            }
	        }
	        function closeMenu() {
	            var menu = document.getElementById('dropdown-menu');
	            var overlay = document.getElementById('overlay');
	            menu.style.display = 'none';
	            overlay.style.display = 'none';
	        }
	        
	        function toggleMenu2() {
	            var menu2 = document.getElementById('dropdown-menu2');
	            var overlay2 = document.getElementById('overlay2');
	            if (menu2.style.display === 'block') {
	                menu2.style.display = 'none';
	                overlay2.style.display = 'none';
	            } else {
	                menu2.style.display = 'block';
	                overlay2.style.display = 'block';
	            }
	        }
	        function closeMenu2() {
	            var menu2 = document.getElementById('dropdown-menu2');
	            var overlay2 = document.getElementById('overlay2');
	            menu2.style.display = 'none';
	            overlay2.style.display = 'none';
	        }
	        function toggleMenu3() {
	            var menu3 = document.getElementById('dropdown-menu3');
	            var overlay3 = document.getElementById('overlay3');
	            if (menu3.style.display === 'block') {
	                menu3.style.display = 'none';
	                overlay3.style.display = 'none';
	            } else {
	                menu3.style.display = 'block';
	                overlay3.style.display = 'block';
	            }
	        }
	        function closeMenu3() {
	            var menu3 = document.getElementById('dropdown-menu3');
	            var overlay3 = document.getElementById('overlay3');
	            menu3.style.display = 'none';
	            overlay3.style.display = 'none';
	        };
		</script>
	</head>
	<body>
	<header>
	<div><p><%= user == null ? "사용자" : user.getNick() %>님! 어서오세요.</p></div>
	<button class="far fa-bell" onclick="toggleMenu3()"></button>
		<div class="dropdown-menu3" id="dropdown-menu3">
		<% for(int i = 0; i < invitelist.size(); i++){
			inviteVO vo = invitelist.get(i);
			String sender = vo.getSender();
			int gnum = vo.getGroupnum();
			String gname = vo.getGroupname();
			int no = vo.getInviteno();
			%>
			<a><%=sender %>이 <%=gname %> 에 초대하였습니다.
				<button type="submit" onclick="inviteuser('<%=user.getId()%>', <%= gnum%>, this, <%= no %>)">수락</button>
				
				<button type="submit" onclick="refuse(<%=no%>)">거절</button>
				
			</a>
		<%
		}%>
		</div>
		<div class="overlay3" id="overlay3" onclick="closeMenu3()"></div>
	<button class="group-toggle" onclick="toggleMenu2()">그룹</button>
		<div class="dropdown-menu2" id="dropdown-menu2">
			<%for(int i = 0; i < list1.size(); i++){
				memberVO vo2 = list1.get(i);
				String name = vo2.getName();
			%>
				<a><%= name %></a>
			<%
				} %>
		</div>
		<div class="overlay2" id="overlay2" onclick="closeMenu2()"></div>
	<button class="menu-toggle" onclick="toggleMenu()">메뉴</button>
			<div class="dropdown-menu" id="dropdown-menu">
				<a href="calendar.jsp">홈</a>
				<%
					if(user != null){
						%>
							<a href="profile.jsp">마이페이지</a>
							<a href="group.jsp">내 그룹</a>
							<%
								if(user.getUserType() == 0){
									%>
										<a href="user_management.jsp">회원 관리</a>
										<a href="group_management.jsp">그룹 관리</a>
										<a href="manager.jsp">관리자 목록</a>
									<%
								}
						%>
							<a href="logout.jsp">로그아웃</a>
						<%
					}else{
						%>
							<a href="login.jsp">로그인</a>
							<a href="signup.jsp">회원가입</a>
						<%
					}
				%>
				
			</div>
			<div class="overlay" id="overlay" onclick="closeMenu()"></div>
	    	<div class="box">
	    		<a href="calendar.jsp" class="a" id="a" >스터디 캘린더</a>
	   	 </div>
	</header>
</body>
<script>
	function inviteuser(id, gnum, obj, no){
		$.ajax({
			url : "inviteok.jsp",
			type : "post",
			data : {
				id : id,
				gnum : gnum,
				no : no
			},
			success : function(data){
				console.log(data.trim());
				if(data.trim() == "success"){
					closeMenu3()
					$(obj).parent().remove();
					alert("그룹에 입장하셨습니다.");
					location.reload();
				}
			},
			error : function(){
				console.log("에러발생");
			}
		});
	}
	function refuse(no){
		$.ajax({
			url : "inviteno.jsp",
			type : "post",
			data :{
				no : no
			},
			success : function(data){
				alert("그룹을 거절하셨습니다.");
				location.reload();
			},
			error : function(){
				console.log("에러발생");
			}
		})
	}
</script>
</html>