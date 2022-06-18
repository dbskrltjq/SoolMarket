package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.User;

public class UserDao {

	private static UserDao instance = new UserDao();
	private UserDao() {};
	public static UserDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public void insertUser(User user) throws SQLException {
		
		String sql = "insert into sul_users "
				   + "(user_no, user_id, user_pw, user_name, user_email, user_tel, user_post_code, user_address, user_detail_address) "
				   + "values "
				   + "(sul_users_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?) ";
		
		helper.insert(sql, user.getId(), user.getPassword(), user.getName(), user.getEmail(), user.getTel(), user.getPostCode(), user.getAddress(), user.getDetailAddress());
	}
	
	public void updateUser(User user) throws SQLException {
		String sql = "update sul_users "
				   + "	set user_pw = ?, "
				   + "      user_name = ?, "
				   + "      user_email = ?, "
				   + "      user_tel = ?, "
				   + "      user_post_code = ?, "
				   + "      user_address = ?,"
				   + " 		user_detail_address = ?, "
				   + "		user_deleted = ? "
				   + "where user_no =? ";
		helper.update(sql, user.getPassword(), user.getName(), user.getEmail(), user.getTel(), user.getPostCode(), user.getAddress(), user.getDetailAddress(), user.getDeleted(), user.getNo());
	}
	
	public User getUserById(String id) throws SQLException {
		
		String sql = "select * from sul_users where user_id = ? ";
		
		return helper.selectOne(sql, rs -> {
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_pw"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setPostCode(rs.getString("user_post_code"));
			user.setAddress(rs.getString("user_address"));
			user.setDetailAddress(rs.getString("user_detail_address"));
			user.setPoint(rs.getInt("user_point"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			
			return user;
		}, id);
	}
	
	public User getUserByEmail(String email) throws SQLException {
		
		String sql = "select * "
				   + "from sul_users "
				   + "where user_email = ? ";
		
		return helper.selectOne(sql, rs -> {
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_pw"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setPostCode(rs.getString("user_post_code"));
			user.setAddress(rs.getString("user_address"));
			user.setDetailAddress(rs.getString("user_detail_address"));
			user.setPoint(rs.getInt("user_point"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			
			return user;
		}, email);
	}
	
	public User getUserByTel(String tel) throws SQLException {
		
		String sql = "select * "
				+ "from sul_users "
				+ "where user_tel = ? ";
		
		return helper.selectOne(sql, rs -> {
			User user = new User();
			user.setNo(rs.getInt("user_no"));
			user.setId(rs.getString("user_id"));
			user.setPassword(rs.getString("user_pw"));
			user.setName(rs.getString("user_name"));
			user.setEmail(rs.getString("user_email"));
			user.setTel(rs.getString("user_tel"));
			user.setPostCode(rs.getString("user_post_code"));
			user.setAddress(rs.getString("user_address"));
			user.setDetailAddress(rs.getString("user_detail_address"));
			user.setPoint(rs.getInt("user_point"));
			user.setDeleted(rs.getString("user_deleted"));
			user.setCreatedDate(rs.getDate("user_created_date"));
			user.setUpdatedDate(rs.getDate("user_updated_date"));
			
			return user;
		}, tel);
	}
	
	
}
