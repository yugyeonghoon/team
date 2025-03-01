<%@page import="reply.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="reply.ReplyDAO"%>
<%@page import="board.BoardDAO" %>
<%@page import="board.BoardVO" %>
<%@page import="board.CalendarDAO" %>
<%@page import="group.memberDAO" %>
<%@page import="group.memberVO" %>
<%@page import="studytime.studytimeDAO" %>
<%@page import="studytime.studytimeVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header_main.jsp" %>
<%
	String no = request.getParameter("no");
	String author = request.getParameter("author");
	String gnum = request.getParameter("gnum");

	if(no == null){
		response.sendRedirect("calendar.jsp");
		return;
	}

	//게시글 상세 조회
	//게시판 번호, 게시판 작성자, 게시판 제목, 게시판 본문
	BoardDAO dao = new BoardDAO();
	BoardVO vo = dao.view(no);
	vo.getAuthor();
	vo.getTitle(); //일정2
	vo.getBoardType();
	vo.getCreateDate();
	
	CalendarDAO cdao = new CalendarDAO();
	vo.getStartTime();
	vo.getEndTime();
	
	//댓글 여러건 조회
	ReplyDAO rdao = new ReplyDAO();
	List<ReplyVO> list = rdao.select(no);

	//같은 그룹 멤버 name 다 불어오기
	//로그인한 아이디의 name과 같은 groupnum을 가지고 있는 유저 테이 블에 있는 user를 다 불러오게 하기	
	String id = user.getId();
	memberDAO mdao = new memberDAO();
	List<memberVO> mlist = mdao.memberList(id, no, groupNum);
	
	studytimeDAO sdao = new studytimeDAO();
	studytimeVO svo = new studytimeVO();
	String statime = svo.getStartTime();
	
	//시작일자 .split("") ""기준 으로 분할해줌
	String startDate = vo.getStartTime();	//2025-02-20 18:12:00
	String[] startDateSplit = startDate.split(":");
		
	startDate = startDateSplit[0] + "시 : " + startDateSplit[1] + "분";	//2025-02-20 18:12
		
	String endDate = vo.getEndTime().split(":")[0] + "시 : " + vo.getEndTime().split(":")[1] + "분";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상세페이지</title>
<script src="./jquery-3.7.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	/* .content-container{
		text-align: center;
	} */
	body {
		padding: 30px;
	}
	.Btn {
	/* 버튼 클릭했을 때 리스트 뜨기 */
		float: right;
		margin-right: 2%;
		background-color: #0a0a23;
		color: #fff;
		border-radius: 50%;
		font-size: 50px;
		display: flex;
		text-align: center;
		align-items: center;
		justify-content: center;
		width: 45px;
		height:45px;
		
/* 		margin: 5px;
		padding : 15px; */
		
	}
	#wrapper {
		float: right;
	}
	
	.list {
		/* display: inline-block; */
    	/* margin-left: 30rem; */
    	margin-top: 3rem;
    	/* background-color: #eee; */
    	border-radius: 2rem;
	    padding: 2rem;
	    margin-right: 17rem;
	    margin-left: 12rem;
	    /* height: 30rem; */
	}
	
	 #timebox {
		float: right;
		border: 3px solid black;
		border-radius: 10px;
		margin-left: 2%;
		margin-right: 2%;
		padding : 10px;
		box-shadow: 3px 0px black;
	}
	.Stopwatch {
		float: inline-end;
		font-family: fantasy;
	}	
	#studyTime {
		text-align: center;
		font-weight: bold;
	}	
	.planList {
		/* font-size: 2rem; */
		/* margin-left: 2rem; */
		list-style: none;		
	}
	.Plan {
		/* padding : 10px; */
		/* margin : 10px; */
		/* width : 50rem; */
		/* height : 230px; */
		/* box-shadow: 4px 4px 4px 4px gray;
		border : 0;
		outline : 0;
		border-radius : 15px; */
		white-space: pre-line;
		/* word-break: keep-all; */
		font-size: large;
	}
	
	.PlanModify {
		margin : 10px;
		width : 50rem;
		height : 7rem;
		text-decoration: line-through;
		background-color : lightgray;
		border : 0;
		outline : 0;
		border-radius : 15px;
	}   
	.checkbox {
		vertical-align: middle;
		position: relative;
		/* right: 100px; */
		/* top: 8px; */
		/* margin-right: 2%; */
	}
	
	input[type="checkbox"] {
		width: 20px;
		height: 20px;
		accent-color: white;
	}
	  a {
	    text-decoration: none;
	    color: black;
	  }
	  #dropdown {
	      transition: all 0.2s ease-in-out;
	      overflow: hidden; /* overflow 속성 값을 hidden으로 해야 dropdown의 자식요소 부분이 숨겨진다. */
	      margin: 30px;
	      border: solid 1px rgb(222, 222, 222);
	      cursor: pointer;
	    }
	    .icon {
	      display: flex;
	      justify-content: space-between;
	      padding: 0 25px 0 10px;
	    }
	    .menu {
	      height: auto;
	      z-index: 0;
		    width: 20%;
		    position: absolute;
		    right: 20px;
		    top: 60px;
		    display : none;
		    background : white;
	    }
	    .menu li {
	      font-size: 20px;
	      text-align: center;
	      text-transform: uppercase;
	      padding: 14px 10px;
	      border-top: solid 1px rgb(202, 202, 202);
	    }
	  
	    .dropdown.closed .menu {
	      height: 0px;
	    }
	    
	    .menu-container{
	    	overflow: auto;
	    	display: contents;
	    	/* text-align: center; */
	    	margin-top: 2rem;
	    }

		 .divReply {
			/* border: 1px solid black;
			width: 100%; */
			margin-top: 2rem;
			margin-left: 8rem;
    		margin-right: 8rem;
		}
		 
		#todayReply {
			width: 13%;
			font-weight: bold;
			font-size: 25px;
			border-right: 2px solid black;
			border-bottom: 2px solid black;	
		}
		
	  	
	  	.replyBtn {
	 		/* background-color: black; */
	 		background-color: unset;
			border: none;
			/* color: white; */
			padding: 10px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 15px;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			/* opacity: 0.7; */
			margin-right: 2rem;
		}
		.replyBtn:hover {
  			/* background: #1d243d; */
		}
  		
  		#replyText {
  			font-size: x-large;
  			font-weight: bold;
  			margin: 1rem;
  			margin-left: inherit;
  		}
  		
  		.replyList {
  			list-style-type: none;
  		}
  		.dpnone {
        	display : none;
        	/* background-color: black; */
        	background-color: unset;
			border: none;
			/* color: white; */
			padding: 10px;
			text-align: center;
			text-decoration: none;
			font-size: 15px;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			/* opacity: 0.7; */
			margin-right: 2rem;
        }
        
        .dpnone:hover {
        	/* background: #1d243d; */
        }
        
        /* #backBtn {
        	background-color: #555555;
			border: none;
			color: white;
			padding: 10px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
        }
        
        #backBtn:hover {
        	background-color: #e7e7e7; color: black;
 			color: black;
        } */
        
        #modiBtn {
        	/* background-color: black; */
        	background-color: unset;
			border: none;
			/* color: white; */
			/* padding: 10px; */
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			/* margin-bottom: inherit;
			margin-left: inherit; */
			/* margin-top: 2rem; */
			float: inline-end;
        }
        
        #modiBtn:hover {
        	/* background: #1d243d; */
        }
        #inputReply {
        	resize: none;
        }
        
        /* div > ul > li {
        	margin: 1rem;
        } */
        
        .reWriter {
        	font-size: medium;
        	padding-bottom: 1rem;
        	opacity: 0.8;
        }
        
        .reply-content {
        	font-size: larger;
        	display: inline;
    		padding-right: 1rem;
        }
        
        .writeInput {
        	/* margin: 1rem; */
        	margin-left: 2rem;
        	/* padding-left: 20rem; */
    		/* padding-right: 20rem; */
        }
        .write {
        	font-size: large;
    		font-weight: bold;
    		/* text-align: center; */
    		margin: 1rem;
        }
        .title {
        	font-size: xx-large;
    		font-weight: bold;
    		/* text-align: center; */
    		/* margin: 1rem; */
        }
        .w-btn-indigo {
        	color: black;
		    background-color: lightgray;
		    border: none;
		    border-radius: 5px;
		    font-size: 16px;
		    padding: 6px;
		    font-family: fantasy;
        }
        hr {
        	/* width: 55%; */
        }
        /* .menu-container > div {
        	margin-top: 1.5rem;
        } */
        
        .RpyList {
       		margin: inherit;
        }
        .panel-body {
        	display: flex;
        }
        .RinputBtn {
        	display: contents;
        }
        #btnOk {
        	font-size: inherit;
        	background-color: black;
			border: none;
			color: white;
			padding: 10px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			/* font-size: 12px; */
			border: none;
			border-radius: 5px;
			cursor: pointer;
			opacity: 0.7;
        }
        #btnOk:hover {
  			background: #1d243d;
		}
        .conplan {
    		font-weight: bold;
    		font-size: large;
    		/* text-align: center; */
        }
        .consplan {
        	font-weight: bold;
    		font-size: x-large;
        }
        input {
        	field-sizing: content;
        }
</style>
</head>
<body>
		<div style="height: max-content">
			<div class="menu-container">
				<!-- 상단 스톱워치 및 공부시간 표시 -->
				<% if(vo.getBoardType() == 2) {
					%>
						<div>
		        			
		        			<div class="box" id="timebox">
							<p id="studyTime">TODAY 공부시간</p>
							<%
							for(int i = 0; i < mlist.size(); i++) {
							memberVO mvo = mlist.get(i);
							String mName = mvo.getName();
							String mId = mvo.getId();
							int toTime = mvo.getStudyTime();
				
								%>
									<%if(mName != null){%>
										<div class="gname"><%=mName %>: <%=toTime %>분</div>
									 <%}else{%>
									 	<div class="gname"><%=user.getName() %>: 0분</div>
									 <%}%>
								<%
							}
							%>
							</div>
							<div class="Stopwatch">
							<h5 style="text-align:center;">Stopwatch</h5>
		        			<h1 style="text-align:center;"><span id="hour">00</span>:<span id="min">00</span>:<span id="sec">00</span></h1>
		        			<button class="w-btn w-btn-indigo" id="start">start</button>
		        			<button class="w-btn w-btn-indigo" id="stop">stop</button>
		        			<button class="w-btn w-btn-indigo" id="clear">clear</button>
		        			</div>
		    			</div>
						
					<%
					}	
				%>
				
			</div>	
			<!-- 목록 -->
			<div class="list">
				<ul class="planList">
					<li>
						<div class="write"><%= vo.getAuthor() %></div>
						<div class="title"><%= vo.getTitle() %></div>
						<!-- <hr style="width:35%;margin:auto;"> -->
						<div id="Plan" class="Plan">
							<div id="plantime"></div>
							<div class="conplan">시작일 | <%= startDate %></div>
							<div class="conplan">종료일 | <%= endDate %> </div>
							<%-- <div>종료일자 : <%= endDate %> </div> --%>
							<div class="consplan">내용  </div>
							<div><%= vo.getContent() %></div>
						</div>
						
						<%
							if(id.equals(vo.getAuthor())) {
								%>
								<div>
								<button id="modiBtn" onclick="location.href='modify.jsp?no=<%=vo.getNo()%>'">수정</button>
								<button id="modiBtn" onclick="deleteBoard('<%= no %>')">삭제</button>
								</div>
								<%
							}
						%>
						
					</li>
				</ul>		
			</div>	
			<div class="divReply">
			<span id="replyText">댓글 리스트</span><br>
				<div class="RpyList">
					
				<%
					for(int i = 0; i < list.size(); i++) {
						ReplyVO rvo = list.get(i);
						String rno = rvo.getRno();
						String rcontent = rvo.getRcontent();
						String rauthor = rvo.getRauthor();
						String rcreateDate = rvo.getCreateDate();
							
						%>
							<ul class="replyList">
								<li>
									<div class="reWriter">작성자 : <%=rauthor %> | 작성일: <%= rcreateDate %></div>
									<div class="reply-content"><%=rcontent %></div>
						<%
						if(user != null && (user.getId().equals(rauthor) || user.getUserType() == 99)) {
							%>
									<div style="margin-top: inherit;float:inline-end">
										<button class="replyBtn" id="btnModify" onclick="modifyBtn(<%= rno %>, this)">수정</button>
										<input type="hidden">
			                    		<button class="dpnone" onclick="modifyReply(<%= rno %>, this)">확인</button>
			                    		<button class="dpnone" onclick="cancelBtn(this, '<%= rcontent %>')">취소</button>
										<button class="dpnone" id="btnDelete" onclick="deleteReply(<%=rno %>, this)">삭제</button>
									</div>
									<hr>
							<%
						}
						%>
								</li>
							</ul>
						<%
					}
					
					if(user != null) {
						%>
							<div class="writeInput">
								<div class="panel-body">
									<textarea id="inputReply" cols="160%" rows="2" placeholder="댓글을 입력하세요"></textarea>
									<div class="RinputBtn"><button class="replyBtn" id="btnOk">확인</button></div>
								</div>
								
							</div>
						<%
					}
				%>
				</div>
				
			</div>
		</div>	
</body>
<script>
	let userId = "<%= user == null ? "" : user.getId() %>"
	console.log(userId);
	
	//시작 버튼 눌렀을 때 인서트된 studytime의 번호
	let stdNo = 0;
	
	//일정 시간 뭐라하지
	<%-- let daliytime = "<%=vo.getStartTime().equals(vo.getEndTime()) ? "종일" : vo.getStartTime() + " ~ " + vo.getEndTime()%>" --%>
	//document.getElementById("plantime").innerHTML = daliytime;
	
	//ajax data에 start_time에 현재 시간 보낼 때
	let currentDate = new Date();
	let year = currentDate.getFullYear();
	let month = currentDate.getMonth() + 1;
	let day = currentDate.getDate();
	let hours = currentDate.getHours();
	let minutes = currentDate.getMinutes();
	let seconds = currentDate.getSeconds();

	let formatdate = year + "-" + String(month).padStart(2, '0') + "-" + String(day).padStart(2, '0') + " " + 
					String(hours).padStart(2, '0') + ":" + String(minutes).padStart(2, '0') + ":" + String(seconds).padStart(2, '0');
	
	//현재 보고있는 화면을 닫을 때 , 이동할 때 실행하는 함수
	//만약 시작버튼 눌러놓고 중지 안누르면 떠날 때 눌러주려고
	window.onbeforeunload = function() {
		if(stdNo != 0){
            $.ajax ({
            	url: "stdEndTime.jsp",
            	type: "post",
            	data: {
            		stnNo : stdNo
            	},
            	success: function(result) {
            		console.log(result);
            		stnNo = 0;
            	},
            	error: function() {
            		console.log("에러 발생");
            	}
            })
        }
	};
					
	//스톱워치
	window.onload = function(){
        
		let timer_sec;
        let timer_min;
        let timer_hour;

        let timer = 0;

        //click start button
         document.getElementById("start")?.addEventListener("click", function(){
            //console.log(timer);
            if(timer > 0){
                return;
            }
            
            var sec = parseInt(document.getElementById("sec").innerText);
            var min = parseInt(document.getElementById("min").innerText);
            var hour = parseInt(document.getElementById("hour").innerText);

            
            //start seconds
            timer_sec = setInterval(function(){
                //console.log(i);
                sec++;
                if(sec == 60) {
                    sec = "00";
                } else if(sec < 10){
                    sec = "0" + sec;
                }
                document.getElementById("sec").innerText = sec;
            }, 1000);

            //start minutes
            timer_min = setInterval(function(){
                min++;

                if(min == 60) {
                    min = 0;
                } else if(min < 10){
                    min = "0" + min;
                }

                document.getElementById("min").innerText = min;
            }, 60000);

            //start hours
            timer_hour = setInterval(function(){
                //console.log(hour);
                hour++;

                if(hour < 10){
                    hour = "0" + hour;
                }

                document.getElementById("hour").innerText = hour;

            }, 3600000);

            timer++;
            //console.log(timer);
            
             //ajax로 다른 jsp에 요청해서
            //studytime 테이블에 insert
            //bno, id, start_time
            
			$.ajax ({
				url: "stdStartTime.jsp",
				type: "post",
				data: {
					no: <%=no%>,
					id: "<%=id%>",
					startTime: formatdate
				},
				
				success: function(result) {
					console.log(result);
					console.log(formatdate);
					stdNo = result.trim();
				},
				error: function() {
					console.log("에러 발생");
					
				}
			})
        });

        //click stop button
        document.getElementById("stop")?.addEventListener("click", function(){
            stop();
            if(stdNo != 0){
	            $.ajax ({
	            	url: "stdEndTime.jsp",
	            	type: "post",
	            	data: {
	            		stnNo : stdNo
	            	},
	            	success: function(result) {
	            		console.log(result);
	            		stnNo = 0;
	            	},
	            	error: function() {
	            		console.log("에러 발생");
	            	}
	            })
            }
        });

        function stop(){
            clearInterval(timer_sec);
            clearInterval(timer_min);
            clearInterval(timer_hour);

            timer--;
            if(timer < 0)
                timer = 0;
        }

        //click clear button
        document.getElementById("clear")?.addEventListener("click", function(){
            stop();
            document.getElementById("sec").innerText = "00";
            document.getElementById("min").innerText = "00";
            document.getElementById("hour").innerText = "00";
        });
    };
	
	
	/* 공부 시간 확인 박스 */
	function startTimer() { // 1초, 2초......시간 계산하는 함수
	  centiseconds++;  // 1증가 // centiseconds = centiseconds + 1
	  if(centiseconds <= 9) spanCentiseconds.innerText = '0'+centiseconds;
	  else spanCentiseconds.innerText = centiseconds;
	 
	  if(centiseconds > 99) {
	    seconds++; // 1초 상승
	    if(seconds <= 9) spanSeconds.innerText = '0' + seconds;
	    else spanSeconds.innerText = seconds;
	    centiseconds = 0;
	    spanCentiseconds.innerText = '00';
	  }
	}
	
	/* //checkbox 누를 시 studyPlan 색상 변경
	$(document).ready(function() {
		$("[id^=check]").change(function() {
			let num = this.id.replace("check", "");
			
			let target = $("#Plan");
			$(target).toggleClass("PlanModify", this.checked);
		});
	}); */
	
	/* 댓글 */
	
	//댓글 작성 시간
	function getTime() {
		let date = new Date();
		console.log(date);
		
		let year = date.getFullYear();
		let month = (date.getMonth() + 1).toString().padStart(2,"0");
		let day = date.getDate().toString().padStart(2,"0");
		let hour = date.getHours().toString().padStart(2,"0");
		let minute = date.getMinutes().toString().padStart(2,"0");
		let second = date.getSeconds().toString().padStart(2,"0");
		
		let time = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second
		return time;
	}
	
	//댓글 확인
	function Replyok(rno, obj) {
	console.log(rno);
	}

	$("#btnOk").click(function(){
		let rcontent = $("#inputReply").val();
		if(rcontent == "") {
			console.log("빈문자");
			return;
		}
		
		$.ajax({
			url: "replyok.jsp",
			type: "post",
			data: {
				reply: rcontent,
				no: <%= no %>
			},
			success: function(result) {
				let time = getTime();
				console.log(result);
				
				let rno = result.trim();
				if(rno == "fail") {
					return;
				}
				let html = "";
					html += "<ul class='replyList'>";
					html += "	<li>";
					html += "	<div class='reWriter'>작성자 : "+userId+" | 작성일: "+time+"</div>";
					html += "		<div class='reply-content'>"+rcontent+"</div>";
					html += "		<div style='margin-top: inherit;float:inline-end'>";
					html += "			<button class='replyBtn' id='btnModify' onclick='modifyBtn("+rno+", this)'>수정</button>";
					html += "			<input type='hidden'>";
            		html += "			<button class='dpnone' onclick='modifyReply("+rno+", this)'>확인</button>";
					html += "			<button class='dpnone' onclick='cancelBtn(this, '"+rcontent+"')'>취소</button>";
					html += "			<button class='dpnone' id='btnDelete' onclick='deleteReply("+rno+", this)'>삭제</button>";
					html += "		</div>";
					html += "	</li>";
					html += "</ul>	";
					html += "<hr>	";
					
					$(".RpyList").prepend(html);
					$("#inputReply").val("");
			},
			error: function() {
				console.log("에러 발생");
			}
		})
	})
	
	//댓글 삭제
	function deleteReply(rno, obj) {
		console.log(rno + "번 댓글 삭제");
		let result = confirm("정말 삭제하시겠습니까?");
		if(result == true){
			$.ajax({
				url: "deleteReplyok.jsp",
				type: "post",
				data: {
					rno: rno
				},
				success: function(result) {
					if(result.trim() == "success") {
						$(obj).parent().parent().parent().remove();
					}
				},
				error: function() {
					console.log("에러 발생");
				}
			})
		}
	}

	
	function cancelBtn(obj, text) {
		let input = $(obj).parent().parent().children("input");
		console.log(input);
		/* input.replaceWith("<div>"+text+"</div>");
		
		$(obj).prev().prev().prev().css("display", "inline");
		$(obj).parent().children(".dpnone").css("display", "none"); */
		location.reload();
	}
	
	//댓글 수정 버튼
	function modifyBtn(rno, obj) {
 		let el = $(".replyList");
 		
		for(let i = 0; i < el.length; i++) {
			//hidden 찾기
			let value = el.eq(i).children().children("input").val();
			let input = el.eq(i).children().children("input");
			input.replaceWith("<div>"+value+"</div>");
			
			el.eq(i).children().children().children().eq(0).css("display", "inline");
			el.eq(i).children().children().children(".dpnone").css("display", "none");
		}
		
		
		let div = $(obj).parent().parent().children(".reply-content");
		$(obj).next().val(div.text());
		
		div.replaceWith("<input type='text' value='"+div.text()+"'>");
		
		$(obj).css("display", "none");
		$(obj).parent().children(".dpnone").css("display", "inline");
		
	}
	
	//댓글 수정
	//댓글 확인 버튼
	function modifyReply(rno, obj) {
		console.log(rno);
		let input = $(obj).parent().parent().children("input");
		
		let reply = input.val();
		
		if(reply != null && reply.trim() != "") {
			let cresult = confirm("댓글을 수정하시겠습니까?");
			if(cresult == true) {
				$.ajax({
					url: "modifyReplyok.jsp",
					type: "post",
					data: {
						rno: rno,
						rcontent: reply
					},
					success: function(data) {
						if(data.trim() == "success") {
							input.replaceWith("<div>"+reply+"</div>");
							$(obj).parent().children(".dpnone").css("display", "none");
							$(obj).prev().prev().css("display", "inline");
							$(obj).next().attr("onclick", "modifyReply(this, '"+reply+"')");
							location.reload();
						}
						
					},
					error: function() {
						console.log("에러 발생");
					}
				})
			}
		}	
	}
	function deleteBoard(no){
		
		let result = confirm("정말 일정을 삭제하시겠습니까?");
		if(result == true){
			$.ajax({
				url : "deleteboard.jsp",
				type : "post",
				data : {
					no : no
				},
				success: function(result){
					if(result.trim() == "success"){
						alert("일정을 삭제하셨습니다.")
						location.href="calendar.jsp"
					}
				},
				error: function(){
					console.log("error");
				}
			})	
		}
	}
</script>
</html>