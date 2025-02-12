package board;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class CalendarDAO extends DBManager{
	
	public void writeMemo(BoardVO vo) {
		String title = vo.getTitle();
		String content = vo.getContent();
		String start = vo.getStartTime();
		String end = vo.getEndTime();
		int boardType = vo.getBoardType();
		String author = vo.getAuthor();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into board(author, title, content, start_date, end_date, board_type)";
		sql += " values('"+author+"', '"+title+"', '"+content+"', '"+start+"', '"+end+"', "+boardType+")";
		executeUpdate(sql);
		
		String selectSql = "select last_insert_id() as no;";
		executeQuery(selectSql);
		
		DBDisConnect();
	};
	
	//일정 수정
	public void modify(BoardVO vo) {
		int no = vo.getNo();
		String title = vo.getTitle();
		String content = vo.getContent();
		String start = vo.getStartTime();
		String end = vo.getEndTime();
		
		driverLoad();
		DBConnect();
		
		String sql = "update board set title = '"+title+"', content = '"+content+"',";
		sql += " start_date = '"+start+"', end_date = '"+end+"', update_date = now()";
		sql += " where bno = "+no;
		
		executeUpdate(sql);
		DBDisConnect();
	}
	//일정 조회(단건)
	public BoardVO view(String bno) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from board where bno ="+bno;
		executeQuery(sql);
		
		if(next()) {
			int no = getInt("bno");
			String title = getString("title");
			String content = getString("content");
			String start = getString("start_date");
			String end = getString("end_date");
			String author = getString("author");
			int boardType = getInt("board_type");
			
			BoardVO vo = new BoardVO();
			vo.setAuthor(author);
			vo.setContent(content);
			vo.setTitle(title);
			vo.setStartTime(start);
			vo.setEndTime(end);
			vo.setNo(no);
			vo.setBoardType(boardType);
			DBDisConnect();
			return vo;
		}else {
			DBDisConnect();
			return null;
		}
	}
	
	
	//일정 조회
		public List<BoardVO> listView(String id) {
			driverLoad();
			DBConnect();
			
			//select groupnum from groupmember where id = 'hong'
			//로그인한 사용자가 속해있는 그룹 번호
			//ex) 10
			
			//select id from groupmember where groupnum = 10;
			//select id from groupmember where groupnum = (select groupnum from groupmember where id = 'hong');
			//10번 그룹에 속한 사용자의 아이디만 가져오는 쿼리
			//ex) hong, sung, winter, summer
			
			//select * from board where author in(select id from groupmember where groupnum = (select groupnum from groupmember where id = 'hong'));
			//select * from board where author = 'hong' or author = 'sung' or author = 'summer' or author = 'winter';
			
			String sql = "select * from board where author in(select id from groupmember where groupnum = (select groupnum from groupmember where id = '"+id+"'));";
			executeQuery(sql);
			
			List<BoardVO> list = new ArrayList<>();
			while(next()) {
				String author = getString("author");
				String title = getString("title");
				String content = getString("content");
				String start = getString("start_date");
				String end = getString("end_date");
				int no = getInt("bno");
				int boardType = getInt("board_type");
				
				BoardVO vo = new BoardVO();
				vo.setAuthor(author);
				vo.setContent(content);
				vo.setTitle(title);
				vo.setStartTime(start);
				vo.setEndTime(end);
				vo.setNo(no);
				vo.setBoardType(boardType);
				
				list.add(vo);
			}
			DBDisConnect();
			return list;
		}
		
		//일정 삭제
		public void delete(String no) {
			driverLoad();
			DBConnect();
			
			String sql ="delete from board where no ="+ no ;
			executeQuery(sql);
			DBDisConnect();
		}

}
