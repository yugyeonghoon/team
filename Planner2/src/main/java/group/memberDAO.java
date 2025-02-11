package group;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class memberDAO extends DBManager{
	//그룹 멤버 조회
	public List<memberVO> view(String id) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select g.*, u.name, u.email from groupmember g";
		sql += " inner join user u on g.id = u.id where groupnum = ";
		sql += " (select groupnum from groupmember where id = '"+id+"')";
		
		executeQuery(sql);
		
		List<memberVO> list = new ArrayList<>();
		
		while(next()) {
			String id2 = getString("id");
			int gnum = getInt("groupnum");
			int gtype = getInt("grouptype");
			String name = getString("name");
			String email = getString("email");
					
			memberVO vo = new memberVO();
			
			vo.setGroupnum(gnum);
			vo.setGrouptype(gtype);
			vo.setId(id2);
			vo.setEmail(email);
			vo.setName(name);
			
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
}