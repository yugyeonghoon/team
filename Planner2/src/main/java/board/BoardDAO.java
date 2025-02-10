package board;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class BoardDAO extends DBManager{
	//1. 글 작성
	//insert into board(author, title, content, board_type)
	//values('', '?', '?', 1);
	
	//insert into board(author, title, content, board_type, start_time, end_time)
	//values('hong', '제목1', '본문1', 1, '2025-01-24 11:47:00','2025-01-25 11:47:00');
	public int write(BoardVO vo) {
		String author = vo.getAuthor();
		String title = vo.getTitle();
		String content = vo.getContent();
		int boardType = vo.getBoardType();
		
		String startTime = vo.getStartTime();
		String endTime = vo.getEndTime();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		
		/*
		 * String sql1 = "insert into board(author, title, content, board_type)"; sql1
		 * += "values('"+author+"', '"+title+"', '"+content+"', "+boardType+")";
		 * 
		 * String sql2 =
		 * "insert into board(author, title, content, board_type, start_time, end_time)"
		 * ; sql2 +=
		 * "values('"+author+"', '"+title+"', '"+content+"', "+boardType+", '"+startTime
		 * +"','"+endTime+"')";
		 * 
		 * if(startTime != null && endTime != null) { //sql2 실행 executeQuery(sql2);
		 * }else { //sql1 실행 executeQuery(sql1); }
		 */
		
		  sql += "insert into board("; 
		  sql += "author, "; 
		  sql += "title, "; 
		  sql += "content, "; 
		  sql += "board_type"; 
		  
		  if(startTime != null && endTime != null) {
			  
		  sql += ", start_time"; 
		  sql += ", end_time"; 
		  } 
		  
		  sql += ")";
		  
		  sql += "values("; 
		  sql += "'"+author+"', "; 
		  sql += "'"+title+"', "; 
		  sql += "'"+content+"', "; 
		  sql += ""+boardType+"";
		  
		  if(startTime != null && endTime != null) { 
			  
			  sql += ", '"+startTime+"'";
			  sql += ", '"+endTime+"'"; 
		  }
		  
		  sql += ")";
		  
		  executeUpdate(sql);
		  
		  String sql2 = "select last_insert_id() as no";
		  executeQuery(sql2);
		 
		if(next()) {
			int no = getInt("no");
			DBDisConnect();
			return no;
		}else {
			DBDisConnect();
			return 0;
		}
	}
	
	//2. 글 수정
	//update board set title = '??', content = '??', update_date = now()
	//where no = ?;
	public void modify(BoardVO vo) {
		String title = vo.getTitle();
		String content = vo.getContent();
		int no = vo.getNo();
		
		driverLoad();
		DBConnect();
		
		String sql = "update board set title = '"+title+"', content = '"+content+"', update_date = now() ";
		sql += "where no = "+ no;
		executeQuery(sql);
		DBDisConnect();		
	}
	
	//3. 글 삭제
	//update board set board_type = 99 where no = ?;
	public void delete(String no) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update board set board_type = 99 where no = " + no;
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//4. 글 조회(단건)
	//select 
	public BoardVO view(String bno) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select * from board where board_type != 99 ";
		sql += "and bno = " + bno;
		executeQuery(sql);
		
		if(next()) {
			int no = getInt("bno");
			String title = getString("title");
			String content = getString("content");
			String author = getString("author");
			String startDate = getString("start_date");
			String endDate = getString("end_date");
			
			BoardVO vo = new BoardVO();
			vo.setNo(no);
			vo.setTitle(title);
			vo.setContent(content);
			vo.setAuthor(author);
			vo.setStartTime(startDate);
			vo.setEndTime(endDate);
			
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
	}
	
	//5. 글 조회(여러 건)
	public List<BoardVO> listView(){
		driverLoad();
		DBConnect();
		
		String sql = "select * from board where board_type != 99";
		executeQuery(sql);
		
		List<BoardVO> list = new ArrayList<>();
		while(next()) {
			int no = getInt("no");
			String title = getString("title");
			String author = getString("author");
			String createDate = getString("create_date");
			
			BoardVO vo = new BoardVO();
			vo.setNo(no);
			vo.setTitle(title);
			vo.setAuthor(author);
			vo.setCreateDate(createDate);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
}
