package reply;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class ReplyDAO extends DBManager{

	//1. 댓글 쓰기
	//insert into reply ~
	public int write(ReplyVO vo) {
		String rauthor = vo.getRauthor();
		String no = vo.getNo();
		String rcontent = vo.getRcontent();
		
		driverLoad();
		DBConnect();
		
		String sql = "insert into reply(rauthor, no, rcontent) ";
		sql += "values('"+rauthor+"', '"+no+"', '"+rcontent+"')";
		
		String selectSql = "select last_insert_id() as rno";
		executeUpdate(sql);
		
		executeQuery(selectSql);
		if(next()) {
			int rno = getInt("rno");
			DBDisConnect();
			return rno;
		}else {
			DBDisConnect();
			return 0;
		}
		
	}
	
	//2. 댓글 수정
	//update reply set rcontent = '', update_date = now() where rno = ;
	public void modify(ReplyVO vo) {
		String rcontent = vo.getRcontent();
		String rno = vo.getRno();
		
		driverLoad();
		DBConnect();
		
		String sql = "update reply set rcontent = '"+rcontent+"', ";
		sql += "update_date = now() where rno = " + rno;
		
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//3. 댓글 삭제
	//delete from reply where = 
	public void delete(String rno) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from reply where rno = " + rno;
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//4. 댓글 조회
	//select * from reply where bno = "
	public List<ReplyVO> select(String no) {
		
		driverLoad();
		DBConnect();
		
		String sql = "select * from reply where no = " + no;
		sql += " order by rno desc";
		
		//select * from reply where no = 2 order
		
		executeQuery(sql);
		
		List<ReplyVO> list = new ArrayList<>();
		
		while(next()) {
			String rno = getString("rno");
			String rauthor = getString("rauthor");
			String rcontent = getString("rcontent");
			String createDate = getString("create_date");
			String updateDate = getString("update_date");
			
			ReplyVO vo = new ReplyVO();
			vo.setRno(rno);
			vo.setRauthor(rauthor);
			vo.setRcontent(rcontent);
			vo.setCreateDate(createDate);
			vo.setUpdateDate(updateDate);
			list.add(vo);
			
		}
		DBDisConnect();
		return list;
	}
}
