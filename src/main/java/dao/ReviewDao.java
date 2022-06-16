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
	
	public List<ReviewDto> getReviews(int beginIndex, int endIndex) throws SQLException{
		String sql = "select  r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name "
					+"from (select row_number() over (order by review_created_date) row_number, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date "
					+"from sul_reviews) r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? ";
					
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
			review.setCreateDate(rs.getDate("review_created_date"));
			review.setUserId(rs.getString("user_id"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setPdName(rs.getString("pd_name"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			
			return review;
		}, beginIndex, endIndex);
		
	}
	
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from sul_reviews "
				   + "where review_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
}
