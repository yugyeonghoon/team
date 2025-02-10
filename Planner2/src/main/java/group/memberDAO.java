package group;

import db.DBManager;

public class memberDAO extends DBManager{
	//그룹 멤버 조회
	public void view(memberVO vo) {
		String id = vo.getId();
		int groupnum = vo.getGroupnum();
		int group = vo.getGrouptype();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select * from member where groupnum = " + groupnum ; 
		
		executeQuery(sql);
		DBDisConnect();
	}
	
}