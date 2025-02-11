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
	
	//그룹멤버 추가
	public void insertMember(memberVO vo) {
		String id = vo.getId();
		int gnum = vo.getGroupnum();
		int gtype = vo.getGrouptype();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into groupmember(id, groupnum, grouptype) ";
		sql += "values ('"+id+"', "+gnum+", "+gtype+")";
		
		executeUpdate(sql);
		DBDisConnect();
	}
}