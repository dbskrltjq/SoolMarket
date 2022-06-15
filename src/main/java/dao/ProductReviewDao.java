package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Review;

public class ProductReviewDao {

	private static ProductReviewDao instance = new ProductReviewDao();
	private ProductReviewDao() {}
	public static ProductReviewDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public List<Review> getProductReviews(int productNo) throws SQLException {
		String sql = "select R.review_no, U.user_no, U.user_id, R.pd_no, R.review_content, R.review_file_name "
					+ ", R.review_deleted,R.review_created_date, R.review_updated_date, R.review_score, R.review_like_count "
			       + "from sul_reviews R, sul_users U "
			       + "where R.user_no = U.user_no "
			       + "and R.pd_no = ? ";
		
		return helper.selectList(sql, rs -> {
			Review review = new Review();
			review.setNo(rs.getInt("review_no"));
			review.setUserNo(rs.getInt("user_no"));
			review.setUserId(rs.getString("user_id"));
			review.setPdNo(rs.getInt("pd_no"));
			review.setContent(rs.getString("review_content"));
			review.setFileName(rs.getString("review_file_name"));
			review.setDeleted(rs.getString("review_deleted"));
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setUpdatedDate(rs.getDate("review_updated_date"));
			review.setScore(rs.getInt("review_score"));
			review.setLikeCount(rs.getInt("review_like_count"));
			
			return review;
		},productNo);
	}
}
