package dao;

import java.sql.SQLException;
import java.util.List;

import dto.ReviewDto;
import helper.DaoHelper;
import vo.Review;

public class ProductReviewDao {

	private static ProductReviewDao instance = new ProductReviewDao();
	private ProductReviewDao() {}
	public static ProductReviewDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public void insertReview(Review review) throws SQLException {
		
		String sql = "insert into sul_reviews "
				   + "(review_no, user_no, pd_no, review_content, review_file_name, review_score) "
				   + "values"
				   + "(sul_reviews_seq.nextval, ?, ?, ?, ?, ?) ";
		
		helper.insert(sql, review.getUserNo(), review.getPdNo(), review.getContent(), review.getFileName(), review.getScore());
	}
	
	public List<ReviewDto> getProductReviews(int productNo) throws SQLException {
		
		String sql = "select R.review_no, U.user_no, U.user_id, R.pd_no, R.review_content, R.review_file_name "
					+ ", R.review_deleted,R.review_created_date, R.review_updated_date, R.review_score, R.review_like_count "
			       + "from sul_reviews R, sul_users U "
			       + "where R.user_no = U.user_no "
			       + "and R.pd_no = ? ";
		
		return helper.selectList(sql, rs -> {
			ReviewDto review = new ReviewDto();
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
	
	public int getReviewCount(int productNo, int userNo) throws SQLException {
		String sql = "select count(*) cnt "
				+ "from sul_orders O, sul_order_items I "
				+ "where O.order_no = I.order_no "
				+ "and I.pd_no = ? "
				+ "and O.user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
			
		},productNo,userNo);
	}
	
	public int getReviewUserCount(int productNo) throws SQLException {
		String sql = "select count(*) cnt "
				+ "from sul_reviews R, sul_users U "
				+ "where R.user_no = U.user_no "
				+ "and R.pd_no = ? ";
		
		return helper.selectOne(sql, rs-> {
			return rs.getInt("cnt");
			
		},productNo);
	}
}
