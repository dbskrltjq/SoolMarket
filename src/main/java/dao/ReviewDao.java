package dao;

import java.sql.SQLException;
import java.util.List;

import dto.ReviewDto;
import helper.DaoHelper;

public class ReviewDao {

	private static ReviewDao instance = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByDate(int beginIndex, int endIndex, int categoryNo) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name " 
			     +"from (select row_number() over (order by r.review_no) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? ) r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? "
				 +"order by r.review_created_date desc ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},categoryNo, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByScore(int beginIndex, int endIndex, int categoryNo) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name " 
			     +"from (select row_number() over (order by r.review_no) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? ) r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? "
				 +"order by r.review_score desc ";
				
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},categoryNo, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByLikeCount(int beginIndex, int endIndex, int categoryNo) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name " 
			     +"from (select row_number() over (order by r.review_no) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? ) r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? "
				 +"order by r.review_like_count desc ";
				
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},categoryNo, beginIndex, endIndex);
	}
	
	
	
	
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByDate(int beginIndex, int endIndex, int categoryNo, String keyword) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name " 
			     +"from (select row_number() over (order by r.review_no) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? and r.review_content like '%' || ? || '%') r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? "
				 +"order by r.review_created_date desc ";
				
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		}, categoryNo, keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByScore(int beginIndex, int endIndex, int categoryNo, String keyword) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name " 
			     +"from (select row_number() over (order by r.review_no) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? and r.review_content like '%' || ? || '%') r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? "
				 +"order by r.review_score desc ";
				
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},categoryNo, keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByLikeCount(int beginIndex, int endIndex, int categoryNo, String keyword) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name " 
			     +"from (select row_number() over (order by r.review_no) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? and r.review_content like '%' || ? || '%') r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? "
				 +"order by r.review_like_count desc ";
				
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},categoryNo, keyword, beginIndex, endIndex);
	}
	
	
	
	
	
	
	
	
	
	public List<ReviewDto> getReviewsOrderByDate(int beginIndex, int endIndex) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name "
				    +"from (select row_number() over (order by review_no) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date "
					+"from sul_reviews) r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? "
					+"order by r.review_created_date desc ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		}, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByScore(int beginIndex, int endIndex) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name "
				    +"from (select row_number() over (order by review_no) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date "
					+"from sul_reviews) r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? "
					+"order by r.review_score desc ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		}, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByLikeCount(int beginIndex, int endIndex) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name "
				    +"from (select row_number() over (order by review_no) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date "
					+"from sul_reviews) r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? "
					+"order by r.review_like_count desc ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		}, beginIndex, endIndex);
	}
	
	
	
	
	
	
	
	public List<ReviewDto> getReviewsOrderByDate(int beginIndex, int endIndex, String keyword) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name "
				    +"from (select row_number() over (order by review_no) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date "
					+"from sul_reviews where review_content like '%' || ? || '%') r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? "
					+"order by r.review_created_date desc ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByScore(int beginIndex, int endIndex, String keyword) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name "
				    +"from (select row_number() over (order by review_no) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date "
					+"from sul_reviews where review_content like '%' || ? || '%') r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? "
					+"order by r.review_score desc ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByLikeCount(int beginIndex, int endIndex, String keyword) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name "
				    +"from (select row_number() over (order by review_no) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date "
					+"from sul_reviews where review_content like '%' || ? || '%') r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? "
					+"order by r.review_like_count desc ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setNo(rs.getInt("review_no"));
			
			return review;
		},keyword, beginIndex, endIndex);
	}
	
	
	
	
	
	
	
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from sul_reviews "
				   + "where review_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
	
	public int getTotalRows(String keyword) throws SQLException {
		String sql = "select count(*) cnt "
					+"from sul_reviews "
					+"where review_deleted = 'N' and review_content like '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}
}
