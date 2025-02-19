package group;

import java.util.ArrayList;
import java.util.List;

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
	//2. 그룹 목록 조회
	public List<groupVO> view(String uid){
		driverLoad();
		DBConnect();
		
		String sql = "";
		
		if(uid != null) {
			sql = "select * from calendargroup where groupnum in (select groupnum from groupmember where id = '"+uid+"')";
		}else {
			sql = "select * from calendargroup";
		}
		
		executeQuery(sql);
		
		List<groupVO> list = new ArrayList<>();
		
		while(next()) {
			int gnum = getInt("groupnum");
			String gname = getString("groupname");
			int gtype = getInt("group_type");
			
			groupVO vo = new groupVO();
			
			vo.setGroupNum(gnum);
			vo.setGroupName(gname);
			vo.setGroupType(gtype);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	//3. 그룹 삭제
	public void delete(int no) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "delete from calendargroup where groupnum = "+ no;
		
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//4. 그룹이름 변경
	public void updateGname(groupVO vo) {
		int gnum = vo.getGroupNum();
		String gname = vo.getGroupName();
		driverLoad();
		DBConnect();
		
		String sql = "update calendargroup set groupname = '"+gname+"' where groupnum = " +gnum;
		
		executeUpdate(sql);
		DBDisConnect();
	}
}