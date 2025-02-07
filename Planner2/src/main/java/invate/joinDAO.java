package invate;

import db.DBManager;

public class joinDAO extends DBManager{
	//1.그룹 생성
	public void makeGroup(joinVO vo) {
		String id = vo.getInviter();
		int gno = vo.getGno();
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "";
		
	}
}
