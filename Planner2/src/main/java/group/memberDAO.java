package group;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.catalina.valves.RemoteAddrValve;

import db.DBManager;

public class memberDAO extends DBManager{
	//그룹 멤버 조회
	public List<memberVO> view(String id, String groupnum) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select g.*, u.name, u.email, c.groupname from groupmember g";
		sql += " inner join calendargroup c on g.groupnum = c.groupnum inner join user u on g.id = u.id where g.groupnum in ";
		sql += " (select groupnum from groupmember where id = '"+id+"')";
		if(groupnum != null) {
			sql += " and g.groupnum = " + groupnum;
		}
		
		executeQuery(sql);
		
		List<memberVO> list = new ArrayList<>();
		
		while(next()) {
			int no = getInt("no");
			String id2 = getString("id");
			int gnum = getInt("groupnum");
			int gtype = getInt("grouptype");
			String name = getString("name");
			String email = getString("email");
			String gname = getString("groupname");
					
			memberVO vo = new memberVO();
			
			vo.setNo(no);
			vo.setGroupnum(gnum);
			vo.setGrouptype(gtype);
			vo.setId(id2);
			vo.setEmail(email);
			vo.setName(name);
			vo.setGroupname(gname);
			
			list.add(vo);
		}
		
		DBDisConnect();
		return list;
		
	}
	
	//그룹 멤버 스터디 시간 조회
	public List<memberVO> memberList(String id, String bno,String groupnum) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		if(groupnum != null) {
		
		sql += "select (select sum(total_time) from studytime where id = g.id and bno = '"+bno+"') as cnt, g.*, u.name, u.email, c.groupname from groupmember g";
		sql += " inner join calendargroup c on g.groupnum = c.groupnum inner join user u on g.id = u.id where g.groupnum in ";
		sql += " (select groupnum from groupmember where id = '"+id+"' and groupnum = "+groupnum+")";
		}else {
			sql += "select sum(total_time) as cnt, s.bno, s.id, u.name from studytime s inner join user u  on s.id = u.id  where(bno = "+bno+" and s.id = '"+id+"')";
		}
		executeQuery(sql);
		
		List<memberVO> list = new ArrayList<>();
		
		while(next()) {
			String id2 = getString("id");
			String name = getString("name");
			int cnt = getInt("cnt");
					
			memberVO vo = new memberVO();
			
			vo.setId(id2);
			vo.setName(name);
			vo.setStudyTime(cnt);
			
			list.add(vo);
		}
		
		DBDisConnect();
		return list;
		
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
	
	//멤버 추방(삭제)
	public void deleteMember(String id) {
		driverLoad();
		DBConnect();
		
		String sql ="delete from groupmember where no = "+id;
		executeUpdate(sql);
		DBDisConnect();
		
	}
	
	//그룹초대 중복검사
	public int groupCheck(memberVO vo){
		driverLoad();
		DBConnect();
		String id = vo.getId();
		int gnum = vo.getGroupnum();
		
		String sql = "select count(*) as cnt from groupmember where id = '"+id+"' and groupnum = "+ gnum;
		executeQuery(sql);
		if(next()) {
			int cnt = getInt("cnt");
			DBDisConnect();
			return cnt;
		}else {
			DBDisConnect();
			return 0;
		}
	}

	//멤버 그룹나가기
	public void outmember(String id) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "delete from groupmember where id = '"+id+"'";
		executeUpdate(sql);
		DBDisConnect();
	}
	
	
}