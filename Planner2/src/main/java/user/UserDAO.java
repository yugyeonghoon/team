package user;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class UserDAO extends DBManager{
	//1.회원가입
	public void join(UserVO vo) {
		String id = vo.getId();
		String pw = vo.getPw();
		String name = vo.getName();
		String email = vo.getEmail();
		String birth = vo.getBirth();
		String nick = vo.getNick();
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into user(id, pw, email, name,  birth, nick) ";
		sql += "value ('"+id+"', '"+pw+"', '"+email+"','"+name+"', '"+birth+"', '"+nick+"')";
		executeUpdate(sql);
		
		DBDisConnect();
		
	}
	//2.로그인
	public UserVO login(UserVO vo) {
		String id = vo.getId();
		String pw = vo.getPw();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select * from user where";
		sql += " id = '"+id+"' and pw = '"+pw+"' and user_type != 2";
		executeQuery(sql);
		
		if(next()) {
			String uid = getString("id");
			String nick = getString("nick");
			int userType = getInt("user_type");
			String email = getString("email");
			
			UserVO uvo = new UserVO();
			uvo.setId(uid);
			uvo.setNick(nick);
			uvo.setUserType(userType);
			uvo.setEmail(email);
			
			DBDisConnect();
			return uvo;
		}else {
			DBDisConnect();
			return null;
		}
	}
	//3. 회원정보 수정
	public void update(UserVO vo) {
		String id = vo.getId();
		String pw = vo.getPw();
		String nick = vo.getNick();
		String email = vo.getEmail();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update user set ";
		sql += "pw = '"+pw+"', nick = '"+nick+"', update_date = now() ";
		sql += "where id = '"+id+"'";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	//4. 회원탈퇴
	public void delete(String id) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "update user set delete_date = now(), user_type = 2 where id = '"+id+"'";
		executeUpdate(sql);
		DBDisConnect();	
	}
	//5. id 중복검사
	public int idCheck(String id) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql +="select count(*) as cnt from user where id = '"+id+"'";
		executeQuery(sql);
		if(next()) {
			int cnt = getInt("cnt");
			DBDisConnect();
			return cnt;
		}else {
			DBDisConnect();
			return 0 ;
		}
	}
	
	//5.1 닉네임 중복 검사
	public int nickCheck(String nick) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql +="select count(*) as cnt from user where nick = '"+nick+"'";
		executeQuery(sql);
		if(next()) {
			int cnt = getInt("cnt");
			DBDisConnect();
			return cnt;
		}else {
			DBDisConnect();
			return 0 ;
		}
	}
	
	//6. 회원 목록 조회
	public List<UserVO> getAllUser() {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "select * from user where user_type != 0";
		executeQuery(sql);
		List<UserVO> list = new ArrayList<>();
		while(next()) {
			String id = getString("id");
			String nick = getString("nick");
			String email = getString("email");
			int userType = getInt("user_type");
			
			UserVO vo = new UserVO();
			vo.setId(id);
			vo.setNick(nick);
			vo.setEmail(email);
			vo.setUserType(userType);
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	//7. 아이디 찾기
	public String findid(UserVO vo) {
		String nick = vo.getNick();
		String email = vo.getEmail();
		
		driverLoad();
		DBConnect();
		String sql = "select id from user ";
		sql += "where nick = '"+nick+"' and email = '"+email+"'";
		executeQuery(sql);
		System.out.println(sql);
		
		if(next()) {
			String id = getString("id");
			DBDisConnect();
			return id;
		}else {
			DBDisConnect();
			return null;
		}
	}
	
	//8.비밀번호 변경
		public void changepw(UserVO vo) {
			String id = vo.getId();
			String pw = vo.getPw();
			
			driverLoad();
			DBConnect();
			
			String sql = "";
			sql += "update user set ";
			sql += "pw = '"+pw+"', update_date = now() ";
			sql += "where id = '"+id+"'";
			executeUpdate(sql);
			
			DBDisConnect();
		}
}
