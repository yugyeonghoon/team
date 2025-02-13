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
	public List<groupVO> view(){
		driverLoad();
		DBConnect();
		
		String sql = "select * from calendargroup c inner join groupmember g on c.groupnum = g.groupnum where g.grouptype =1;";
		
		executeQuery(sql);
		
		List<groupVO> list = new ArrayList<>();
		
		while(next()) {
			int gnum = getInt("groupnum");
			String gname = getString("groupname");
			int gtype = getInt("group_type");
			String id = getString("id");
			
			groupVO vo = new groupVO();
			
			vo.setGroupNum(gnum);
			vo.setGroupName(gname);
			vo.setGroupType(gtype);
			vo.setId(id);
			
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
		sql += "update calendargroup set gdelete_date = now(), group_type = 0 where groupnum = "+ no;
		
		executeUpdate(sql);
		DBDisConnect();
	}
}