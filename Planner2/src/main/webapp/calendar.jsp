<%@page import="board.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="board.CalendarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header_main.jsp" %>
<%
	CalendarDAO dao = new CalendarDAO();

	List<BoardVO> list = dao.listView(user.getId(), groupNum);
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>Study Calendar</title>
		<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
		<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		<script src='https://unpkg.com/popper.js/dist/umd/popper.min.js'></script>
		<script src='https://unpkg.com/tooltip.js/dist/umd/tooltip.min.js'></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.13/dayjs.min.js" integrity="sha512-FwNWaxyfy2XlEINoSnZh1JQ5TRRtGow0D6XcmAWmYCRgvqOUTnzCxPc9uF35u5ZEpirk1uhlPVA19tflhvnW1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<style>
			.fc-day-grid{
				color : black;
				text-decoration: none;
			}
			.fc-day-wed a {
			  color: black;
			  text-decoration: none;
			}
			.fc-day-tue a {
			  color: black;
			  text-decoration: none;
			}
			.fc-day-mon a {
			  color: black;
			  text-decoration: none;
			}
			.fc-day-sun a {
			  color: red;
			  text-decoration: none;
			}
			.fc-day-sat a {
			  color: blue;
			  text-decoration: none;
			}
			.fc-day-fri a {
			  color: black;
			  text-decoration: none;
			}
			.fc-day-thu a {
			  color: black;
			  text-decoration: none;
			}
			.popper,
			.tooltip {
				position: absolute;
				z-index: 9999;
				background: #FFC107;
				color: black;
				width: 150px;
				border-radius: 3px;
				box-shadow: 0 0 2px rgba(0,0,0,0.5);
				padding: 10px;
				text-align: center;
			}
			.style5 .tooltip {
				background: #1E252B;
				color: #FFFFFF;
				max-width: 200px;
				width: auto;
				font-size: .8rem;
				padding: .5em 1em;
			}
			.popper .popper__arrow,
			.tooltip .tooltip-arrow {
				width: 0;
				height: 0;
				border-style: solid;
				position: absolute;
				margin: 5px;
			}
			
			.tooltip .tooltip-arrow,
			.popper .popper__arrow {
				border-color: #FFC107;
			}
			.style5 .tooltip .tooltip-arrow {
				border-color: #1E252B;
			}
			.popper[x-placement^="top"],
			.tooltip[x-placement^="top"] {
				margin-bottom: 5px;
			}
			.popper[x-placement^="top"] .popper__arrow,
			.tooltip[x-placement^="top"] .tooltip-arrow {
				border-width: 5px 5px 0 5px;
				border-left-color: transparent;
				border-right-color: transparent;
				border-bottom-color: transparent;
				bottom: -5px;
				left: calc(50% - 5px);
				margin-top: 0;
				margin-bottom: 0;
			}
			.popper[x-placement^="bottom"],
			.tooltip[x-placement^="bottom"] {
				margin-top: 5px;
			}
			.tooltip[x-placement^="bottom"] .tooltip-arrow,
			.popper[x-placement^="bottom"] .popper__arrow {
				border-width: 0 5px 5px 5px;
				border-left-color: transparent;
				border-right-color: transparent;
				border-top-color: transparent;
				top: -5px;
				left: calc(50% - 5px);
				margin-top: 0;
				margin-bottom: 0;
			}
			.tooltip[x-placement^="right"],
			.popper[x-placement^="right"] {
				margin-left: 5px;
			}
			.popper[x-placement^="right"] .popper__arrow,
			.tooltip[x-placement^="right"] .tooltip-arrow {
				border-width: 5px 5px 5px 0;
				border-left-color: transparent;
				border-top-color: transparent;
				border-bottom-color: transparent;
				left: -5px;
				top: calc(50% - 5px);
				margin-left: 0;
				margin-right: 0;
			}
			.popper[x-placement^="left"],
			.tooltip[x-placement^="left"] {
			 	margin-right: 5px;
			}
			.popper[x-placement^="left"] .popper__arrow,
			.tooltip[x-placement^="left"] .tooltip-arrow {
				 border-width: 5px 0 5px 5px;
				 border-top-color: transparent;
				 border-right-color: transparent;
				 border-bottom-color: transparent;
				 right: -5px;
				 top: calc(50% - 5px);
				 margin-left: 0;
				 margin-right: 0;
			}
		
			html, body {
				overflow: hidden;
				font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
				font-size: 14px;
			}
			.fc-header-toolbar {
				padding-top: 1em;
				padding-left: 1em;
				padding-right: 1em;
			}
		</style>
		</head>
		<script>
		$(function(){
		  var calendarEl = $('#calendar')[0];
		  var calendar = new FullCalendar.Calendar(calendarEl, {
			allDay :false,
			nextDayThreshold: '00:00',
		    height: '700px', // calendar 높이 설정
		    expandRows: true, // 화면에 맞게 높이 재설정
		    displayEventTime: true, // 일정표시 시간
		    slotMinTime: '00:00', // Day 캘린더에서 시작 시간
		    slotMaxTime: '23:59', // Day 캘린더에서 종료 시간
		    //해더에 표시할 툴바
		    headerToolbar: {
		      left: 'prev,next today',
		      center: 'title',
		      right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		    },
		    initialView: 'dayGridMonth',
		    //initialDate: '2025-02-01', //달력시작일
		    editable: false,
		    selectable: true,
		    dayMaxEvents: true,
		    nowIndicator: true,
		    locale: 'ko',
		    eventDidMount: function(info) {
		      var tooltip = new Tooltip(info.el, {
		        title: info.event.extendedProps.description,
		        placement: 'top',
		        trigger: 'hover',
		        container: 'body',
		        html: true
		      });
		    },
			//modal
		    select: function(arg) { //일정추가
		    	let startDate = arg.startStr;
		    	startDate = dayjs(startDate);
		    	//클릭 시작된 날짜
		    	
		    	let endDate = arg.endStr;
		    	endDate = dayjs(endDate);
		    	
		    	const duration = endDate.diff(startDate, 'days');
		    	startDate = startDate.format("YYYY-MM-DD");
		    	
		    	let endBeforeDay = endDate.subtract(1, "days").format("YYYY-MM-DD");
		    	let endRealBeforDay = "";
		    	
		    	if(duration > 1){
		    		//여러 날짜(드래그)
		        	endRealBeforDay = endDate.format("YYYY-MM-DD");
		    	}else{
		    		endRealBeforDay = endDate.subtract(1, "days").format("YYYY-MM-DD");
		    	}
		    	
		    	//클릭이나 드래그 끝난 지점의 날짜
		    	$("#choose-date").val(startDate);
		    	$("#choose-end-date").val(endBeforeDay);
		    	$("#choose-real-end-date").val(endRealBeforDay);
		    	var myModal = bootstrap.Modal.getOrCreateInstance('#exampleModal');
		        myModal.show();
		    	calendar.unselect()
		    },
		    events :[
		    	<%
		    		for(int i = 0; i < list.size(); i ++){
		    			BoardVO vo = list.get(i);
		    			int no = vo.getNo();
		    			int boardType = vo.getBoardType();
		    			String title = vo.getTitle();
		    			String start = vo.getStartTime();
		    			String end = vo.getEndTime();
		    			
		    			%>
		    				{
		    					id : <%= no %>,
		    					title : "<%= title %>",
		    					start : "<%=start%>",
		    					end : "<%=end %>",
		    					url : "page.jsp?no=<%=no%>",
		    					
		    				<%	if(boardType == 1){
							%>	backgroundColor: '#0000ff',<%
		    					}else{
							%>	backgroundColor: '#ff0000',<%
		    					}%>
		    				},
		    			<%
		    		}
		    	%>
		    ]
		
		  });
		  //모달창 이벤트
		  $("#saveChanges").on("click", function () {
		  	  var eventData = {
		  	    title: $("#title").val(),
		  	    content: $("#content").val(),
		  	    start: $("#choose-date").val(),
		  	    end: $("#choose-real-end-date").val(),
		  	  	boardType : $("#boardType").val()
		  	  };
		  	  //빈값입력시 오류
		  	  if (
		  	    eventData.title == "" ||
		  	    eventData.content == "" ||
		  	    eventData.start == "" ||
		  	    eventData.end == ""
		  	  ) {
		  	    alert("입력하지 않은 값이 있습니다.");
				return;
		  	    //끝나는 날짜가 시작하는 날짜보다 값이 크면 안됨
		  	  } else if ($("#start").val() > $("#end").val()) {
		  	    alert("시간을 잘못입력 하셨습니다.");
		  	  	return;
		  	  } else {
		  	    // 이벤트 ajax 전달
		  	    calendar.addEvent(eventData);
		  	    $("#exampleModal").modal("hide");
		  	    $("#title").val("");
		  	    $("#content").val("");
		  	    $("#start").val("");
		  	    $("#end").val("");
		  	    
		  	    $.ajax({
		  	    	url : "calendarok.jsp",
		  	    	type : "post",
		  	    	data :{
		  	    		title : eventData.title,
		  	    		content : eventData.content,
		  	    		start : eventData.start,
		  	    		end : eventData.end,
		  	    		boardType : eventData.boardType
		  	    	},
		  	    	success : function(result){
		  	    		console.log(result);
		  	    	},
		  	    	error : function(){
		  	    		console.log("error");
		  	    	}
		  	    });
		  	  }
		  	});
		  	
		  	calendar.render();
		  	
		  });
		  
		</script>
	<body style="padding:30px;">
	<div id='calendar'></div>
		<div id="calendar"></div>
		<!-- Button trigger modal -->
		<button hidden type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" >
		  일정등록하기
		</button>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" modal-dialog-centered>
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">일정 작성</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form>
		          <div class="mb-3">
		            <label for="choose-date" class="col-form-label">시작일: </label>
		            <input type="text" class="form-control" id="choose-date" readonly="readonly">
		          </div>
		          <div class="mb-3">
		            <label for="choose-end-date" class="col-form-label">종료일: </label>
		            <input type="text" class="form-control" id="choose-end-date" readonly="readonly">
		            <input type="hidden" class="form-control" id="choose-real-end-date" readonly="readonly">
		          </div>
		          <div>
		          	<label col-form-label>일정 타입:</label>
		          	<select class="select" id="boardType">
		          		<option value="1">일정</option>
		          		<option value="2">공부</option>
		          	</select>
		          </div>
		          <div class="mb-3">
		            <label for="recipient-name" class="col-form-label">제목 : </label>
		            <input type="text" class="form-control" id="title">
		          </div>
		          <div class="mb-3">
		            <label for="message-text" class="col-form-label">내용 : </label>
		            <textarea class="form-control" id="content"></textarea>
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary" id="saveChanges">저장</button>
		      </div>
		    </div>
		  </div>
		</div>
	</body>
</html>