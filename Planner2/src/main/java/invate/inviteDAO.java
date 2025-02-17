package invate;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class inviteDAO extends DBManager{
	
	//1. 초대 알림확인
	public void invite(inviteVO vo) {
		driverLoad();
		DBConnect();
		String sender = vo.getSender();
		String receiver = vo.getReceiver();
		
		String sql = "";
		sql += "select * from invite where '"+sender+"' = '"+receiver+"'";
		
		executeQuery(sql);
		DBDisConnect();
	}
	
	//2. 그룹원 초대
	public void insert(inviteVO vo){
		String sender = vo.getSender();
		String receiver = vo.getReceiver();
		int groupnum = vo.getGroupnum();
		driverLoad();
		DBConnect();
		
		String sql = "insert into invite(sender, receiver, groupnum)";
		sql += "values('"+sender+"', '"+receiver+"', "+groupnum+")";
		
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//3. 초대목록 리스트 
	public List<inviteVO> listinvite(String id){
		driverLoad();
		DBConnect();
		
		String sql = "select * from invite i inner join calendargroup c on i.groupnum =";
		sql += " c.groupnum  where receiver = '"+id+"'";
		executeQuery(sql);
		
		List<inviteVO> list = new ArrayList<>();
		
		while(next()) {
			String sender = getString("sender");
			String receiver = getString("receiver");
			int groupnum = getInt("groupnum");
			int no = getInt("inviteno");
			String gname = getString("groupname");
			
			inviteVO vo = new inviteVO();
			vo.setSender(sender);
			vo.setReceiver(receiver);
			vo.setGroupnum(groupnum);
			vo.setInviteno(no);
			vo.setGroupname(gname);
			list.add(vo);
		}
		DBDisConnect();
		return list;
		
	}
	
	//
	
	
	//초대 거절
	public void refuse(int no) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from invite where inviteno = "+ no;
		
		executeUpdate(sql);
		DBDisConnect();
	}
}
