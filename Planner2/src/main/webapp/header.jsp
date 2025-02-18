<%@page import="java.util.ArrayList"%>
<%@page import="invate.inviteVO"%>
<%@page import="invate.inviteDAO"%>
<%@page import="group.groupDAO"%>
<%@page import="group.groupVO"%>
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
	String groupNum = request.getParameter("groupnum");
	
	memberDAO mdao = new memberDAO();
	memberVO mvo = new memberVO();
	
	List<memberVO> mlist = mdao.view(user.getId(), null);
	
	groupDAO gdao = new groupDAO();
	groupVO gvo = new groupVO();
	
	List<groupVO> glist = gdao.view(user.getId());
	
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
	        	height : 20px;
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
	            top: 3px;
	            right: 15px;
	            background:black;
	            color: white;
	            border: none;
	            padding: 13px;
	            border-radius: 5px;
	            cursor: pointer;
	        }
	        .group-toggle {
	            position: absolute;
	            top: 3px;
	            right: 85px;
	            background:black;
	            color: white;
	            border: none;
	            padding: 13px;
	            border-radius: 5px;
	            cursor: pointer;
	        }
	        .groupnum-toggle {
	            position: absolute;
	            top: 3px;
	            right: 165px;
	            background:black;
	            color: white;
	            border: none;
	            padding: 13px;
	            border-radius: 5px;
	            cursor: pointer;
	        }
	        .menu-toggle:hover {
	            background: #1d243d;
	        }
	        .group-toggle:hover {
	            background: #1d243d;
	        }
	        .groupnum-toggle:hover {
	            background: #1d243d;
	        }
	        .dropdown-menu {
	            display: none;
	            position: absolute;
	            top: 60px;
	            right: 15px;
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
	            border-radius: 5px;
	            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	            z-index: 1000;
	        }
	        .dropdown-menu3 {
	            display: none;
	            position: absolute;
	            top: 60px;
	            right: 120px;
	            background: white;
	            border: 1px solid #ddd;
	            border-radius: 5px;
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
	        .dropdown-menu3 a:last-child {
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
	   			height: 68px;
			    position: absolute;
			    font-size:32px;
			    top: 70%;
			    left: 50%;
			    transform: translate(-50%, -50%);
			    color:cornflowerblue;
			    text-decoration-line:none;
	    	}
	    	p{
	    		margin-top: -2px;
	    		font-family: Verdana, Geneva, Arial, sans-serif;    		
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
	        };

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
	<body style="padding:30px;">
		<header>
		<div><p><%= user == null ? "사용자" : user.getNick() %>님! 어서오세요.</p></div>
		<button class="groupnum-toggle" onclick="toggleMenu3()">그룹</button>
		<div class="dropdown-menu3" id="dropdown-menu3">
			<% for(int i = 0; i<glist.size(); i++){
				groupVO vo2 = glist.get(i);
				String gname = vo2.getGroupName();
				int gnum = vo2.getGroupNum();
				%>
				<a href ="group.jsp?groupnum=<%=gnum%>"><%=gname %></a>
				<%
			}%>
		</div>
		<div class="overlay3" id="overlay3" onclick="closeMenu3()"></div>
		<button class="group-toggle" onclick="toggleMenu2()">그룹원</button>
			<div class="dropdown-menu2" id="dropdown-menu2">
			<%
				//중복된 그룹번호 저장	
				List<Integer> glist1 = new ArrayList<>();
			
				for(int i = 0; i < mlist.size(); i ++){
					//그룹번호 꺼내오기
					memberVO vo = mlist.get(i);
					int gnum = vo.getGroupnum();
					String name = vo.getName();
					String groupName = vo.getGroupname();
					String id = vo.getId();
					
					//glist에 gnum이 포함되어있으면(중복) 그룹 번호를 다시 출력할 필요 x
					if(glist1.contains(gnum)){
						%>
							<a href="user_profile.jsp?id=<%=id%>">&nbsp;&nbsp;&nbsp;&nbsp;- <%= name %></a>
						<%
					}else{
						//glist에 gnum이 포함되어있지 않으면 glist에 gnum을 추가하고, 그룹번호 출력
						glist1.add(gnum);
						%>
							<a href="calendar.jsp?groupnum=<%=gnum%>"><%= groupName %></a>
							<a href="user_profile.jsp?id=<%=id%>">&nbsp;&nbsp;&nbsp;&nbsp;- <%= name %></a>
						<%
					}
					
				}
			%>
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
	
	</script>
</html>