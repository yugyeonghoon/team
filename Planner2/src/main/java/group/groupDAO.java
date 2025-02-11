package group;

import db.DBManager;

public class groupDAO extends DBManager{
	//1. 그룹 생성
	public int insertGroup(String gname) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into calendargroup (groupname) ";
		sql += "value ('"+gname+"') ";
		
		executeUpdate(sql);
		
		String selectsql = "select last_insert_id() as no;";
		
		executeQuery(selectsql);
		
		if(next()) {
			int no = getInt("no");
			DBDisConnect();
			return no;
		}else {
			DBDisConnect();
			return 0;
		}
	
	}
	// 그룹 목록 조회
	public void view(groupVO vo) {
		int gnum = vo.getGroupNum();
		String gname = vo.getGroupName();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select * from calendargroup;";
		
		executeQuery(sql);
		DBDisConnect();
	}
}