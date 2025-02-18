package studytime;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;
import reply.ReplyVO;

public class studytimeDAO extends DBManager {
	//1. 공부 시간 시작
	//stopwatch start 버튼 눌렀을 때 starttime 칼럼에 현재 시간 입력
	//insert into studytime(bno, id, startTime) value(?, '??', now())
	public int start(studytimeVO vo) {
		String no = vo.getNo();
		String id = vo.getId();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into studytime(bno, id, startTime) ";
		sql += "values('"+no+"', '"+id+"', now())";
		
		String selectSql = "select last_insert_id() as stdno";
		executeUpdate(sql);
		
		executeQuery(selectSql);
		if(next()) {
			int stdno = getInt("stdno");
			DBDisConnect();
			return stdno;
		}else {
			DBDisConnect();
			return 0;
		}
		
	}
	
	//2. 공부 시간 업데이트
	//stopwatch stop 버튼을 클릭했을 때 endTime 칼럼에 현재 시간 입력 및
	//totalTime 칼럼에 현재 시간 - startTime() = 값 나올 수 있도록 함
	//update studytime set endTime = '', 
	//totalTime =  ROUND(TIMESTAMPDIFF(SECOND, startTime, now()) / 60) where stdno = '';
	
	public void update(studytimeVO vo) {
		String startTime = vo.getStartTime();
		String endTime = vo.getEndTime();
		int totalTime = vo.getTotalTime();
		int stdno = vo.getStdno();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update studytime set endTime = now(), ";
		sql += "'"+totalTime+"' =  ROUND(TIMESTAMPDIFF(SECOND, '"+startTime+"', '"+endTime+"') / 60) ";
		sql += "where stdno = '"+stdno+"'";
		
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//3. 공부 시간 조회(단건)
		//select * from studytime where no =  and id = ''"
		public studytimeVO view(int no, String id) {
			driverLoad();
			DBConnect();
			
			String sql = "";
			sql += "select * from studytime where bno = " + no;
			sql += " and id = '"+id+"'";
			
			executeQuery(sql);
			
			if(next()) {
				int stdno = getInt("stdno");
				String startTime = getString("start_time");
				String endTime = getString("end_time");
				int totalTime = getInt("total_time");
				
				studytimeVO svo = new studytimeVO();
				svo.setStdno(stdno);
				svo.setStartTime(startTime);
				svo.setEndTime(endTime);
				svo.setTotalTime(totalTime);
				
				DBDisConnect();
				return svo;
			}else {
				DBDisConnect();
				return null;
			}
			
		}
	
	//4. 공부 시간 조회(여러 건)
	//select * from studytime where no = "
	/*
	 * public List<studytimeVO> listview(String no) { driverLoad(); DBConnect();
	 * 
	 * String sql = "select * from reply where no = " + no;
	 * 
	 * executeQuery(sql);
	 * 
	 * List<studytimeVO> list = new ArrayList<>();
	 * 
	 * while(next()) { int stdno = getInt("stdno"); String id = getString("id");
	 * String startTime = getString("startTime"); String endTime =
	 * getString("endTime"); int totalTime = getInt("totalTime");
	 * 
	 * studytimeVO svo = new studytimeVO(); svo.setStdno(stdno); svo.setId(id);
	 * svo.setStartTime(startTime); svo.setEndTime(endTime);
	 * svo.setTotalTime(totalTime);
	 * 
	 * } DBDisConnect(); return list;
	 * 
	 * }
	 */
	
	
	
}
