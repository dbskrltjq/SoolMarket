package dao;

import java.sql.SQLException;
import java.util.List;

import dto.ReviewDto;
import helper.DaoHelper;
import vo.Review;
import vo.ReviewLikeUser;

public class ReviewDao {

	private static ReviewDao instance = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByDate(int beginIndex, int endIndex, int categoryNo) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content " 
			     +"from (select row_number() over (order by r.review_created_date desc) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date, r.review_a_content review_a_content " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? ) r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? ";
				 
					
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		},categoryNo, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByScore(int beginIndex, int endIndex, int categoryNo) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content " 
			     +"from (select row_number() over (order by r.review_score desc) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date, r.review_a_content review_a_content " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? ) r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? ";
				 
				
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		},categoryNo, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByLikeCount(int beginIndex, int endIndex, int categoryNo) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content " 
			     +"from (select row_number() over (order by r.review_like_count desc) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date, r.review_a_content review_a_content " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? ) r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? ";
				 
				
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_admin_content"));
			
			return review;
		},categoryNo, beginIndex, endIndex);
	}
	
	
	
	
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByDate(int beginIndex, int endIndex, int categoryNo, String keyword) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content " 
			     +"from (select row_number() over (order by r.review_created_date desc) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date, r.review_a_content review_a_content " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? and r.review_content like '%' || ? || '%') r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? ";
				
				
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		}, categoryNo, keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByScore(int beginIndex, int endIndex, int categoryNo, String keyword) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content " 
			     +"from (select row_number() over (order by r.review_score desc) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date, r.review_a_content review_a_content " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? and r.review_content like '%' || ? || '%') r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? ";
				 
				
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		},categoryNo, keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsUseCategoryNoOrderByLikeCount(int beginIndex, int endIndex, int categoryNo, String keyword) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content " 
			     +"from (select row_number() over (order by r.review_like_count desc) row_number, r.review_no review_no, r.review_score review_score, r.review_content review_content, r.review_file_name review_file_name, r.review_like_count review_like_count, r.pd_no pd_no, r.user_no user_no, r.review_created_date review_created_date, r.review_a_content review_a_content " 
				 +"from sul_reviews r, sul_products p where r.pd_no = p.pd_no and p.category_no = ? and r.review_content like '%' || ? || '%') r, sul_users u, sul_products p " 
				 +"where r.user_no = u.user_no " 
				 +"and r.pd_no = p.pd_no "
				 +"and r.row_number >= ? and r.row_number <= ? ";
				 
				
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		},categoryNo, keyword, beginIndex, endIndex);
	}
	
	
	
	
	
	
	
	
	
	public List<ReviewDto> getReviewsOrderByDate(int beginIndex, int endIndex) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content "
				    +"from (select row_number() over (order by review_created_date desc) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date, review_a_content "
					+"from sul_reviews) r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? ";
					
					
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		}, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByScore(int beginIndex, int endIndex) throws SQLException{
		String sql = "select r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content "
				    +"from (select row_number() over (order by review_score desc) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date, review_a_content "
					+"from sul_reviews) r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? ";
				
					
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		}, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByLikeCount(int beginIndex, int endIndex) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content "
				    +"from (select row_number() over (order by review_like_count desc) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date, review_a_content "
					+"from sul_reviews) r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? ";
					
					
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		}, beginIndex, endIndex);
	}
	
	
	
	
	
	
	
	public List<ReviewDto> getReviewsOrderByDate(int beginIndex, int endIndex, String keyword) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content "
				    +"from (select row_number() over (order by review_created_date desc) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date, review_a_content "
					+"from sul_reviews where review_content like '%' || ? || '%') r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? ";
					
					
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		},keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByScore(int beginIndex, int endIndex, String keyword) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content "
				    +"from (select row_number() over (order by review_score desc) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date, review_a_content "
					+"from sul_reviews where review_content like '%' || ? || '%') r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? ";
					
					
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
			
			return review;
		},keyword, beginIndex, endIndex);
	}
	
	public List<ReviewDto> getReviewsOrderByLikeCount(int beginIndex, int endIndex, String keyword) throws SQLException{
		String sql = "select  r.review_no, r.review_created_date, u.user_id, r.review_score, r.review_like_count, p.pd_name, r.review_content, r.review_file_name, r.pd_no, p.pd_image_url, r.review_a_content review_a_content "
				    +"from (select row_number() over (order by review_like_count desc) row_number, review_no, review_score, review_content, review_file_name, review_like_count, pd_no, user_no, review_created_date, review_a_content "
					+"from sul_reviews where review_content like '%' || ? || '%') r, sul_users u, sul_products p "
					+"where r.user_no = u.user_no "
					+"and r.pd_no = p.pd_no "
					+"and r.row_number >= ? and r.row_number <= ? ";
					
					
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
			review.setPdNo(rs.getInt("pd_no"));
			review.setImageUrl(rs.getString("pd_image_url"));
			review.setAnswerContent(rs.getString("review_a_content"));
		
			
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
	
	public int getTotalRows(int categoryNo) throws SQLException {
		String sql = "select count(*) cnt " 
					+"from sul_reviews r, sul_products p "
					+"where r.review_deleted = 'N' "
					+"and r.pd_no = p.pd_no "
					+"and p.category_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo);
	}
	
	public int getTotalRows(String keyword, int categoryNo	) throws SQLException {
		String sql = "select count(*) cnt " 
					+"from sul_reviews r, sul_products p "
					+"where r.review_deleted = 'N' and r.review_content like '%' || ? || '%' "
					+"and r.pd_no = p.pd_no "
					+"and p.category_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, categoryNo);
	}
	
	
	
	public ReviewLikeUser getReviewLikeUser(int reviewNo, int userNo) throws SQLException {
		String sql = "select review_no, user_no "
				   + "from sul_review_like_users "
				   + "where review_no = ? and user_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return new ReviewLikeUser(reviewNo, userNo);
		}, reviewNo, userNo);
	}
	
	public void insertReviewLikeUser(ReviewLikeUser reviewLikeUser) throws SQLException {
		String sql = "insert into sul_review_like_users(review_no, user_no) values(?, ?)";
		
		helper.insert(sql, reviewLikeUser.getReview().getNo(), reviewLikeUser.getUser().getNo());
		
	}
	
	public Review getReviewByNo(int reviewNo) throws SQLException {
		String sql = "select review_no, user_no, pd_no, review_content, review_created_date, review_like_count, review_score "
				   + "from sul_reviews "
				   + "where review_no = ?" ;
		
		return helper.selectOne(sql, rs -> {
			Review review = new Review();
			review.setNo(rs.getInt("review_no"));
			review.setUserNo(rs.getInt("user_no"));
			review.setPdNo(rs.getInt("pd_no"));
			review.setContent(rs.getString("review_content"));
			review.setCreatedDate(rs.getDate("review_created_date"));
			review.setLikeCount(rs.getInt("review_like_count"));
			review.setScore(rs.getInt("review_score"));
			return review;
		}, reviewNo);
	}
	
	public void updateReviewLikeCount(Review review) throws SQLException {
		String sql = "update sul_reviews "
				   + "set "
				   + "		review_like_count = ?  "
				   + "where review_no = ? ";
		
		helper.update(sql, review.getLikeCount(), review.getNo());
	}
	
	public void insertReview(Review review) throws SQLException {
		String sql = "insert into sul_reviews "
					+"(review_no, user_no, pd_no, review_content, review_file_name, review_score) "
					+"values (sul_reviews_seq.nextval, ?, ?, ?, ?, ?) ";
		
		helper.insert(sql, review.getUserNo(), review.getPdNo(), review.getContent(), review.getFileName(), review.getScore());
	}
	
	public int countReviewByUserNoPdNo(int userNo, int pdNo) throws SQLException {
		String sql = "select count(*) cnt "
					+"from sul_reivews "
					+"where user_no = ? "
					+"and pd_no = ? " ;
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, userNo, pdNo);
	}
	
	public void updateReviewDelete(Review review) throws SQLException {
		String sql = "update sul_reviews "
				   + "set "
				   + "    review_deleted = ? "
				   + "where review_no = ? ";
		
		helper.update(sql,review.getDeleted(), review.getNo());
	}


	
	////////////////////////////////////////////////////////////// 관리자페이지 상품리뷰관리///////////////////////////////////////////////////////////////////////
	
	public void addReviewAnswer(ReviewDto reviewDto) throws SQLException {
		String sql = "update sul_reviews "
				   + "	set "
				   + "		review_a_content = ?, "
				   + "		review_answered = ?, "
				   + "		review_a_created_date = sysdate "
				   + "where review_no = ? ";
		helper.update(sql, reviewDto.getAnswerContent(), reviewDto.getAnswered(), reviewDto.getNo());
				   
	}
	
	public void deleteReviewByNo(int reviewNo) throws SQLException {
		String sql = "update sul_reviews "
				   + " set "
				   + "  review_deleted = 'Y' "
				   + "where review_no = ? ";
		helper.update(sql, reviewNo);
	}
	
	
	
	public List<ReviewDto> getAllReviewDtos() throws SQLException {
		String sql = "select * "
				   + "from sul_reviews R, sul_users U, sul_products P "
				   + "where R.user_no = U.user_no "
				   + "and R.pd_no = P.pd_no " 
				   + "order by R.review_created_date desc ";
			
		return helper.selectList(sql, rs -> {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setUserId(rs.getString("user_id"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setPdNo(rs.getInt("pd_no"));
			reviewDto.setPdName(rs.getString("pd_name"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setFileName(rs.getString("review_file_name"));
			reviewDto.setDeleted(rs.getString("review_deleted"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setUpdatedDate(rs.getDate("review_updated_date"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setScore(rs.getInt("review_score"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setAnswerContent(rs.getString("review_a_content"));
			reviewDto.setAnswered(rs.getString("review_answered"));
			reviewDto.setAnswerCreatedDate(rs.getDate("review_a_created_date"));
			return reviewDto;
		});
	}
	
	public ReviewDto getReviewDtoByreviewNo(int reviewNo) throws SQLException {
		String sql = "select * "
				   + "from sul_reviews R, sul_users U, sul_products P "
				   + "where R.user_no = U.user_no "
				   + "and R.pd_no = P.pd_no " 
				   + "and R.review_no = ? "; 
		return helper.selectOne(sql, rs -> {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setUserId(rs.getString("user_id"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setPdNo(rs.getInt("pd_no"));
			reviewDto.setPdName(rs.getString("pd_name"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setFileName(rs.getString("review_file_name"));
			reviewDto.setDeleted(rs.getString("review_deleted"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setUpdatedDate(rs.getDate("review_updated_date"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setScore(rs.getInt("review_score"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setAnswerContent(rs.getString("review_a_content"));
			reviewDto.setAnswered(rs.getString("review_answered"));
			reviewDto.setAnswerCreatedDate(rs.getDate("review_a_created_date"));
			return reviewDto;
		}, reviewNo);
	}
	
	
	public int getTotalRowsByCategoryNo(int categoryNo, String deleted, int period) throws SQLException {
		String sql = "select count(*) cnt "
				   + "from sul_reviews R, sul_products P "
				   + "where R.pd_no = P.pd_no "
				   + "and P.category_no = ? "
				   + "and R.review_deleted = ? "
				   + "and R.review_created_date >= trunc(sysdate - ?) ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo, deleted, period);
	}
	
	public String test(int categoryNo, String deleted, int period) {
		return "no: " + categoryNo + " deleted : " + deleted + " period: " + period;
	}
	
	public int getTotalRowsByPdNameKeyword(int categoryNo, String deleted, String keyword, int period) throws SQLException {
		String sql =  "select count(*) cnt "
				   + "from sul_reviews R, sul_products P "
				   + "where R.pd_no = P.pd_no "
				   + "and category_no = ? "
				   + "and review_deleted = ? "
				   + "and P.pd_name like '%' || ? || '%' "
				   + "and R.review_created_date >= trunc(sysdate - ?) ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo, deleted, keyword, period);
	}
	
	public int getTotalRowsByTitleKeyword(int categoryNo, String deleted, String keyword, int period) throws SQLException {
		String sql =  "select count(*) cnt "
				+ "from sul_reviews R, sul_products P "
				+ "where R.pd_no = P.pd_no "
				+ "and category_no = ? "
				+ "and review_deleted = ? "
				+ "and R.review_title like '%' || ? || '%' "
				+ "and R.review_created_date >= trunc(sysdate - ?) ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo, deleted, keyword, period);
	}
	
	public int getTotalRowsByContentKeyword(int categoryNo, String deleted, String keyword, int period) throws SQLException {
		String sql =  "select count(*) cnt "
				+ "from sul_reviews R, sul_products P "
				+ "where R.pd_no = P.pd_no "
				+ "and category_no = ? "
				+ "and review_deleted = ? "
				+ "and R.review_content like '%' || ? || '%' "
				+ "and R.review_created_date >= trunc(sysdate - ?) ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo, deleted, keyword, period);
	}
	
	

	
	public List<ReviewDto> getReviewDtoByCategoryNo(int categoryNo, String deleted, int period, int beginIndex, int endIndex) throws SQLException {
		String sql = "select * "
				+ "from (select row_number() over (partition by P.category_no order by R.review_no desc) row_number, R.*, P.category_no,  P.pd_name, U.user_name "
				+ "      from sul_reviews R, sul_products P, sul_users U "
				+ "		where R.user_no = U.user_no "
				+ "		and R.pd_no = P.pd_no "
				+ "		AND R.review_created_date >= trunc(sysdate - ?) "
				+ "		and R.review_deleted = ?) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? "; 
		
		return helper.selectList(sql, rs -> {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setPdNo(rs.getInt("pd_no"));
			reviewDto.setPdName(rs.getString("pd_name"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setFileName(rs.getString("review_file_name"));
			reviewDto.setDeleted(rs.getString("review_deleted"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setUpdatedDate(rs.getDate("review_updated_date"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setScore(rs.getInt("review_score"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setAnswerContent(rs.getString("review_a_content"));
			reviewDto.setAnswered(rs.getString("review_answered"));
			reviewDto.setAnswerCreatedDate(rs.getDate("review_a_created_date"));
			return reviewDto;
		}, period, deleted, beginIndex, endIndex, categoryNo);
	}
	
	public List<ReviewDto> getReviewDtoByPdNameKeyword(int categoryNo, String deleted, String keyword, int period, int beginIndex, int endIndex) throws SQLException {
		String sql = "select * "
				+ "from (select row_number() over (partition by P.category_no order by R.review_no desc) row_number, R.*, P.category_no,  P.pd_name, U.user_name "
				+ "      from sul_reviews R, sul_products P, sul_users U "
				+ "		where R.user_no = U.user_no "
				+ "		and R.pd_no = P.pd_no "
				+ "		and P.pd_name like '%' || ? || '%' "
				+ "		AND R.review_created_date >= trunc(sysdate - ?) "
				+ "		and R.review_deleted = ?) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? ";
	
		return helper.selectList(sql, rs -> {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setPdNo(rs.getInt("pd_no"));
			reviewDto.setPdName(rs.getString("pd_name"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setFileName(rs.getString("review_file_name"));
			reviewDto.setDeleted(rs.getString("review_deleted"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setUpdatedDate(rs.getDate("review_updated_date"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setScore(rs.getInt("review_score"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setAnswerContent(rs.getString("review_a_content"));
			reviewDto.setAnswered(rs.getString("review_answered"));
			reviewDto.setAnswerCreatedDate(rs.getDate("review_a_created_date"));
			return reviewDto;
		}, keyword, period, deleted, beginIndex, endIndex, categoryNo);
	}
	
	
	public List<ReviewDto> getReviewDtoByTitleKeyword(int categoryNo, String deleted, String keyword, int period, int beginIndex, int endIndex) throws SQLException {
		String sql = "select * "
				+ "from (select row_number() over (partition by P.category_no order by R.review_no desc) row_number, R.*, P.category_no,  P.pd_name, U.user_name "
				+ "      from sul_reviews R, sul_products P, sul_users U "
				+ "		where R.user_no = U.user_no "
				+ "		and R.pd_no = P.pd_no "
				+ "		and R.review_title like '%' || ? || '%' "
				+ "		AND R.review_created_date >= trunc(sysdate - ?) "
				+ "		and R.review_deleted = ?) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? ";
	
		return helper.selectList(sql, rs -> {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setPdNo(rs.getInt("pd_no"));
			reviewDto.setPdName(rs.getString("pd_name"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setFileName(rs.getString("review_file_name"));
			reviewDto.setDeleted(rs.getString("review_deleted"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setUpdatedDate(rs.getDate("review_updated_date"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setScore(rs.getInt("review_score"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setAnswerContent(rs.getString("review_a_content"));
			reviewDto.setAnswered(rs.getString("review_answered"));
			reviewDto.setAnswerCreatedDate(rs.getDate("review_a_created_date"));
			return reviewDto;
		}, keyword, period, deleted, beginIndex, endIndex, categoryNo);
	}
	
	public List<ReviewDto> getReviewDtoByContentKeyword(int categoryNo, String deleted, String keyword, int period, int beginIndex, int endIndex) throws SQLException {
		String sql = "select * "
				+ "from (select row_number() over (partition by P.category_no order by R.review_no desc) row_number, R.*, P.category_no,  P.pd_name, U.user_name "
				+ "      from sul_reviews R, sul_products P, sul_users U "
				+ "		where R.user_no = U.user_no "
				+ "		and R.pd_no = P.pd_no "
				+ "		and R.review_content like '%' || ? || '%' "
				+ "		AND R.review_created_date >= trunc(sysdate - ?) "
				+ "		and R.review_deleted = ?) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? ";
	
		return helper.selectList(sql, rs -> {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setPdNo(rs.getInt("pd_no"));
			reviewDto.setPdName(rs.getString("pd_name"));
			reviewDto.setContent(rs.getString("review_content"));
			reviewDto.setFileName(rs.getString("review_file_name"));
			reviewDto.setDeleted(rs.getString("review_deleted"));
			reviewDto.setCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setUpdatedDate(rs.getDate("review_updated_date"));
			reviewDto.setLikeCount(rs.getInt("review_like_count"));
			reviewDto.setScore(rs.getInt("review_score"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setAnswerContent(rs.getString("review_a_content"));
			reviewDto.setAnswered(rs.getString("review_answered"));
			reviewDto.setAnswerCreatedDate(rs.getDate("review_a_created_date"));
			return reviewDto;
		}, keyword, period, deleted, beginIndex, endIndex, categoryNo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
