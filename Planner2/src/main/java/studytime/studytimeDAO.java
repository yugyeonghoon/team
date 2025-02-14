package studytime;

import db.DBManager;

public class studytimeDAO extends DBManager{
	//1. 공부 시간 시작
	//insert into studytime(bno, id, startTime) value(?, '??', now())
	public void stime(studytimeVO vo) {
		int bno = vo.getBno();
		String id = vo.getId();
		String startTime = vo.getStartTime();
		
	}
}
