package dao;

import java.sql.SQLException;
import java.util.List;

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
				   + "		user_deleted = ?, "
				   + "		user_updated_date = sysdate "	
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
			user.setIsAdmin(rs.getString("is_admin"));
			
			return user;
		}, id);
	}
	
	public User getAdminById(String id) throws SQLException {
		
		String sql = "select * from sul_users where is_admin = 'Y' and user_id = ? ";
		
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
			user.setIsAdmin(rs.getString("is_admin"));
			
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
			user.setIsAdmin(rs.getString("is_admin"));
			
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
			user.setIsAdmin(rs.getString("is_admin"));
			
			return user;
		}, tel);
	}
	
	public List<User> getAllCurrentUsers() throws SQLException {
		
		String sql = "select * from sul_users where user_deleted = 'N' order by user_no ";
		
		return helper.selectList(sql, rs -> {
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
			user.setIsAdmin(rs.getString("is_admin"));
			
			return user;
		});
	}
	
	public int getTotalCurrentUsersCnt() throws SQLException {
		String sql = "select count(*) cnt from sul_users where user_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return 	rs.getInt("cnt");
		});
	}
	public int getTotalDeletedUsersCnt() throws SQLException {
		String sql = "select count(*) cnt from sul_users where user_deleted = 'Y' ";
		
		return helper.selectOne(sql, rs -> {
			return 	rs.getInt("cnt");
		});
	}
	
	public List<User> getUsers(int beginIndex, int endIndex) throws SQLException {
		String sql = "select * "
				   + "from (select ROW_NUMBER() OVER (ORDER BY user_no) row_number, U.* "
				   + "      from sul_users U "
				   + "      where U.user_deleted = 'N') "
				   + "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
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
			user.setIsAdmin(rs.getString("is_admin"));
			
			return user;
		}, beginIndex, endIndex);
	}
	
	public List<User> getDeletedUsers(int beginIndex, int endIndex) throws SQLException {
		String sql = "select * "
				   + "from (select ROW_NUMBER() OVER (ORDER BY user_no) row_number, U.* "
				   + "      from sul_users U "
				   + "      where U.user_deleted = 'Y') "
				   + "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
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
			user.setIsAdmin(rs.getString("is_admin"));
			
			return user;
		}, beginIndex, endIndex);
	}
	
	public List<User> getAllDeletedUsers() throws SQLException {
		String sql = "select * from sul_users where user_deleted = 'Y' ";
		
		return helper.selectList(sql, rs -> {
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
			user.setIsAdmin(rs.getString("is_admin"));
			
			return user;
		});
	}
	
}
