package group;

import db.DBManager;

public class groupDAO extends DBManager{
	//1. 그룹 생성
	public void insertGroup(groupVO vo) {
		String gname = vo.getGroupName();
		int gnum = vo.getGroupNum();
		String gcreate_date = vo.getGcreate_date();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into calendargroup (groupname) ";
		sql += "value ('"+gname+"') ";
		
		executeUpdate(sql);
		
		String selectsql = "select last_insert_id() as no;";
		
		executeUpdate(selectsql);
		
		DBDisConnect();
		
	}

}
