package group;

import db.DBManager;

public class groupDAO extends DBManager{
	//1. 그룹 생성
	//insert into group (gname, id, group_creat_date)
	//value ('1그룹', 'hong', default now());
	public void insertGroup(groupVO vo) {
		String gname = vo.getGname();
		String id = vo.getId();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into group (gname, id, group_create_date) ";
		sql += "value ('"+gname+"', '"+id+"', now()) ";
		executeUpdate(sql);
		DBDisConnect();
		
	}
	

}
