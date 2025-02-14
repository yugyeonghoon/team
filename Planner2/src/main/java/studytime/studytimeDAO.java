package studytime;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;
import reply.ReplyVO;

public class studytimeDAO extends DBManager {
	//1. 공부 시간 시작
	//stopwatch start 버튼 눌렀을 때 starttime 칼럼에 현재 시간 입력
	//insert into studytime(bno, id, startTime) value(?, '??', now())
	public int stime(studytimeVO vo) {
		int bno = vo.getBno();
		String id = vo.getId();
		String startTime = vo.getStartTime();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into studytime(bno, id, startTime) ";
		sql += "values('"+bno+"', '"+id+"', '"+startTime+"')";
		
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
	
	public void utime(studytimeVO vo) {
		String startTime = vo.getStartTime();
		String endTime = vo.getEndTime();
		int totalTime = vo.getTotalTime();
		int stdno = vo.getStdno();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update studytime set endTime = now(), ";
		sql += "totalTime =  ROUND(TIMESTAMPDIFF(SECOND, '"+startTime+"', now()) / 60) ";
		sql += "where stdno = '"+stdno+"'";
		
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//3. 공부 시간 조회
	//select * from studytime where id = "
	public List<studytimeVO> view(String id) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from reply where id = " + id;
		
		executeQuery(sql);
		
		List<studytimeVO> list = new ArrayList<>();
		
		while(next()) {
			int stdno = getInt("stdno");
			int bno = getInt("bno");
			String startTime = getString("startTime");
			String endTime = getString("endTime");
			String totalTime = getString("totalTime");
			
			studytimeVO svo = new studytimeVO();
			svo.setStdno(stdno);
			svo.setBno(bno);
			svo.setStartTime(startTime);
			svo.setEndTime(endTime);
			svo.setTotalTime(stdno);
			
		}
		DBDisConnect();
		return list;
		
	}
}
