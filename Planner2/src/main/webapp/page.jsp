<%@page import="reply.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//게시글 번호 받아오기
	String no = request.getParameter("no");

	//게시글 상세 조회
	//게시판 번호, 게시판 작성자, 게시판 제목, 게시판 본문
	
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
	
	div.box {
		float: right;
		border: 3px solid black;
		border-radius: 10px;
		margin-left: 2%;
		margin-right: 2%;
		padding : 10px;
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
	.studyPlan {
		/* padding : 10px; */
		margin : 10px;
		width : 50rem;
		height : 4rem;
		box-shadow: 4px 4px 4px 4px gray;
		border : 0;
		outline : 0;
		border-radius : 15px;
	}
	
	.studyPlanModify {
		margin : 10px;
		width : 50rem;
		height : 4rem;
		text-decoration: line-through;
		background-color : lightgray;
		border : 0;
		outline : 0;
		border-radius : 15px;
	}
	.Plan {
		/* padding : 10px; */
		margin : 10px;
		width : 50rem;
		height : 4rem;
		box-shadow: 4px 4px 4px 4px gray;
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
	    }

 	    .divReply {
			border: 1px solid black;
			width: 100%;
		}
		
		#todayReply {
			width: 13%;
			font-weight: bold;
			font-size: 25px;
			border-right: 2px solid black;
			border-bottom: 2px solid black;	
		}
	
		/* .replyBtn {
			float: right;
			border: 0;
	  		background-color: transparent;
	  		font-size: 15px;
	  	} */
	  	
	  	.replyBtn {
	 		background-color: #555555;
			border: none;
			color: white;
			padding: 10px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
		}
		.replyBtn:hover {
  			background-color: #e7e7e7; color: black;
 			color: black;
		}
  		
  		#replyText {
  			font-size: 20px;
  			font-weight: bold;
  		}
  		
  		#replyList {
  			list-style-type: none;
  		}
</style>
</head>
<body>
	<div style="height: max-content">
		<div class="menu-container">
			<!-- 현재 날짜 및 시간 -->
			<h5 id="clock" style="color:black; display: inline;">clock</h5>
			
			<!-- 일정등록 버튼 -->	
			<div class="dropdown">
			  <button class="Btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    +
			  </button>
			  <ul class="dropdown-menu">
			    <li><a class="dropdown-item" href="studyPlan.jsp">스터디 계획</a></li>
			    <li><a class="dropdown-item" href="dailyPlan.jsp">일정 계획</a></li>
			  </ul>
			</div>
			<!-- <div class="hover">
				<a href="studyPlanPage.jsp"><span>스터디 계획</span></a><br>
				<a href="PlanPage.jsp"><span>일정 계획</span></a><br>
			</div> -->
			
			<!-- 상단 공부시간 표시 -->
			<div class="box">
				<p id="studyTime">TODAY 공부시간</p>
				<div class="time"><span id="hour">00</span>:<span id="min">00</span>:<span id="sec">00</span></div>
				<div class="time">3H 40M</div>
				<div class="time">5H</div>
			</div>
		   	
		   	<div style="text-align: right;">
	        <h5>Stopwatch</h5>
	        <!-- <h1><span id="hour">00</span>:<span id="min">00</span>:<span id="sec">00</span><span id="micro">00</span></h1> -->
	        <button class="w-btn w-btn-green" id="start">start</button>
	        <button class="w-btn w-btn-indigo" id="stop">stop</button>
	        <button class="w-btn w-btn-indigo" id="clear">clear</button>
	    	</div>
		</div>
	
	
	<!-- 목록 -->
	<div class="list">
		<ul class="planList">
			<li>
				<input type="text" id="studyPlan1" class="studyPlan">
				<input type="checkbox" id="check1" class="checkbox">
				<label for="check1"></label>
				<!-- <input type="button" value="추가" onclick="addList()"> -->
 				
			</li>
			<li>
				<input type="text" id="studyPlan2" class="studyPlan">
				<input type="checkbox" id="check2" class="checkbox">
 				<label for="check2"></label>
			</li>
			<li>
				<input type="text" id="studyPlan3" class="studyPlan">
 				<input type="checkbox" id="check3" class="checkbox">
 				<label for="check3"></label>
			</li>
			
			<li>
				<input type="text" id="Plan1" class="Plan">
			</li>
			<li>
				<input type="text" id="Plan2" class="Plan">
			</li>
			<li>
				<input type="text" id="Plan3" class="Plan">
			</li>
		</ul>
	</div>
	
	
	<!-- 댓글 쓰기 -->
	<%-- <div class="divReply">
		<div id="todayReply">TODAY Reply</div>
		<div class="inputReply">
			<!-- 확인 버튼을 눌렀을 때 나와야 함 -->
			 <%
				for(int i = 0; i < list.size(); i ++) {
					ReplyVO rvo = list.get(i);
					String rno = rvo.getBno();
					String rauthor = rvo.getRauthor();
					String rcontent = rvo.getRcontent();
					String createDate = rvo.getCreateDate();
					%>
						<div class="writeReply">작성자: <%=rauthor %> | 작성일: <%= createDate %></div>
	                			<p><%= rcontent %></p>
	                	<%
	                		//댓글 작성자가 로그인한 사용자의 아이디와 같으면 수정 삭제 버튼을 보여주는 작업 이걸 정말 꼭 해야겠지
	                		//BoardVO, BoardDAO import 안 해놓음
	                	%>
					<%
				}
			%> 
			<div class="writeReply">
			<button id="btnModify" class="replyBtn" type="button" onclick="replyModifyok">수정</button>
			<button id="btnDelete" class="replyBtn" type="button" onclick="replyDeleteok">삭제</button>
			<textarea rows="2" cols="200%" placeholder="댓글을 입력하세요" id="content"></textarea>
			<button id="btnSave" type="button" onclick="replyok">확인</button>
		</div>
		</div>
		
	</div> --%>
	

	<div class="divReply">
		<div class="ReplyList"><span id="replyText">댓글 리스트</span><br>
			<ul id="replyList">
				<li>
					<div class="reWriter">작성자 : 홍길동</div>
					<div class="writeContent">댓글 내용입니다.</div>
					<div>
						<button class="replyBtn" id="btnModify">수정</button>
						<button class="replyBtn" id="btnDelete">삭제</button>
					</div>
				</li>
			</ul>
		</div>
		<div class="writeInput">
			<div class="panel-body"><textarea class="content" id="content" cols="100%" rows="2"></textarea></div>
			<div class="writeReplyBtn"><button class="replyBtn" id="btnOk">확인</button></div>
		</div>		
	</div>
</div>
</body>
<script>
	/* 현재 날짜 및 실시간 표시*/
	var Target = document.getElementById("clock");
	function clock() {
	    var time = new Date();
	
	    var month = time.getMonth();
	    var date = time.getDate();
	    var day = time.getDay();
	    var week = ['일', '월', '화', '수', '목', '금', '토'];
	
	    var hours = time.getHours();
	    var minutes = time.getMinutes();
	    var seconds = time.getSeconds();
	
	    Target.innerText = 
	    (month + 1) + "월 " + date + "일 " + week[day] + "요일 " +
	    (hours < 10 ? "0"+hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds)	        
	}
	clock();
	setInterval(clock, 1000);
	 
	//스톱워치
	window.onload = function(){
        
        let timer_sec;
        let timer_min;
        let timer_hour;

        let timer = 0;

        //click start button
        document.getElementById("start").addEventListener("click", function(){
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
        });

        //click stop button
        document.getElementById("stop").addEventListener("click", function(){
            stop();
        });

        function stop(){
            /* clearInterval(timer_micro); */
            clearInterval(timer_sec);
            clearInterval(timer_min);
            clearInterval(timer_hour);

            timer--;
            if(timer < 0)
                timer = 0;
        }

        //click clear button
        document.getElementById("clear").addEventListener("click", function(){
            stop();
            /* document.getElementById("micro").innerText = "00"; */
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
	
	//checkbox 누를 시 studyPlan 색상 변경
	$(document).ready(function() {
		$("[id^=check]").change(function() {
			let num = this.id.replace("check", "");
			
			let target = $("#studyPlan" + num);
			$(target).toggleClass("studyPlanModify", this.checked);
		});
	});
	
	/* //목록 자동화
	function addList() {
		
		let studyPlan1 = $("#studyPlan1").val();
	} */
	
	/* 댓글 */
	//댓글 수정 함수
	function modifyReply(rno, obj) {
	console.log(rno);
}

//댓글 id = btnSave인 확인 버튼 클릭했을 때

	/* $(document).ready(function(){
		ReplyList();
	});

	$("#btnSave").click(function() {
		$.ajax({
			//replyok
			url : "replyok.jsp",
			type : "post",
			data : {
				//게시글 번호 맞나..?
				no : "",
				//로그인한 사용자의 아이디
				rauthor : rauthor,
				//rcontent input에 입력한 텍스트
				rcontent : $("#rcontent").val()
			},
			success : function(result) {
				/* let time = getTime();
				console.log(result);
				
			if(result.trim() != "0") {
				let rcontent = $("#rcontent");
				
			
			}else {
				
			}
		},
		error : function() {
			console.log("에러 발생");
		}
	})
})

/* 	$("#dropdown").click(function(){
		let display = $(".menu").css("display");
		//display : 안보일 때 none, 보일 때 block
		//안보일 때 보이게, 보일 때 안보이게
		if(display == "none"){
			$(".menu").css("display", "block");
		}else{
			$(".menu").css("display", "none");
		}
	}); */
	$("#btnOk").click(function(){
		let content = $("#content").val();
		if(content == "") {
			return;
		}
		
		$.ajax({
			url: "replyok.jsp",
			type: "post",
			data: {
				reply: content,
				no: <%= no %>
			},
			success: function(result) {
				console.log(result);
			},
			error: function() {
				console.log("에러 발생");
			}
		})
	})
</script>
</html>