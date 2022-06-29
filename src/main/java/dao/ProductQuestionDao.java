package dao;

import java.sql.SQLException;
import java.util.List;

import dto.QuestionDto;
import helper.DaoHelper;
import vo.Question;

public class ProductQuestionDao {

	private static ProductQuestionDao instance = new ProductQuestionDao();
	private ProductQuestionDao() {}
	public static ProductQuestionDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public void insertQuestion(Question question) throws SQLException {
		String sql = "insert into sul_questions "
			     + "(q_no, user_no, pd_no, q_title, q_content) "
			     + "values "
			     + "(sul_questions_seq.nextval, ?, ?, ?, ?) ";
		
		helper.insert(sql, question.getUserNo(), question.getPdNo(), question.getTitle(), question.getContent());
	}
	
	// 관리자가 상품문의 답글을 넣을 때 사용하는 메소드
	public void addAnswer(QuestionDto questionDto) throws SQLException {
		String sql = "update sul_questions "
				   + " set "
				   + "   a_content = ?, "
				   + "   a_created_date = sysdate,  "
				   + "   a_answered = ? "
				   + "where q_no = ? ";
		
		helper.update(sql, questionDto.getAnswerContent(), questionDto.getAnswered(), questionDto.getNo());
	}
	
	public QuestionDto getProductQuestion(int questionNo) throws SQLException {
		String sql = "select * "
				   + "from sul_questions "
				   + "where q_no = ? "
				   + "and q_deleted = 'N' ";
		return helper.selectOne(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			
			return question;
		}, questionNo);
	}
	
	public List<QuestionDto> getProductQuestions(int productNo) throws SQLException {
		String sql = "select P.category_no, Q.q_no, U.user_no, U.user_name, Q.pd_no, Q.q_title, Q.q_content, "
				   + "Q.a_content, Q.q_deleted, Q.q_created_date, Q.q_updated_date, Q.a_created_date, Q.a_answered "
				   + "from sul_questions Q, sul_products P, sul_users U "
				   + "where Q.user_no = U.user_no "
				   + "and Q.pd_no = P.pd_no "
				   + "and q_deleted != 'Y' "
				   + "and Q.pd_no = ? ";
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			
			return question;
			
		},productNo);
	}
	
	public void updateQuestionDelete(QuestionDto question) throws SQLException {
		String sql = "update sul_questions "
			       + "set "
			       + "		q_deleted = ? "
			       +"where q_no = ? ";
		
		helper.update(sql,question.getDeleted(), question.getNo());
	}

	
	public List<QuestionDto> getQuestionsWithoutKeyword(int period, String answered, int beginIndex, int endIndex) throws SQLException {
			
			String sql = "select * "
					   + "from (select row_number() over (order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
					   + "		from sul_questions Q, sul_products P,  sul_users U "
					   + "		where Q.user_no = U.user_no "
					   + "		and Q.pd_no = P.pd_no "
					   + "		AND q.q_created_date >= trunc(sysdate - ?) "
					   + "		and Q.a_answered = ? "
					   + "      and Q.q_deleted = 'N' ) "
					   + "where row_number >= ? and row_number <= ? ";
					   
			
			return helper.selectList(sql, rs -> {
				QuestionDto question = new QuestionDto();
				question.setCategoryNo(rs.getInt("category_no"));
				question.setNo(rs.getInt("q_no"));
				question.setUserNo(rs.getInt("user_no"));
				question.setUserName(rs.getString("user_name"));
				question.setPdNo(rs.getInt("pd_no"));
				question.setTitle(rs.getString("q_title"));
				question.setContent(rs.getString("q_content"));
				question.setAnswerContent(rs.getString("a_content"));
				question.setDeleted(rs.getString("q_deleted"));
				question.setCreatedDate(rs.getDate("q_created_date"));
				question.setUpdatedDate(rs.getDate("q_updated_date"));
				question.setAnswerCreatedDate(rs.getDate("a_created_date"));
				question.setAnswered(rs.getString("a_answered"));
				question.setPdName(rs.getString("pd_name"));
				
				return question;
				
			}, period, answered, beginIndex, endIndex);
		}
	
	public int getTotalRowsWithoutKeyword(int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, period, answered);
	}
	
	public List<QuestionDto> getQuestionsWithoutKeyword(int categoryNo, int period, String answered, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select * "
				+ "from (select row_number() over (partition by P.category_no order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
				+ "		from sul_questions Q, sul_products P,  sul_users U "
				+ "		where Q.user_no = U.user_no "
				+ "		and Q.pd_no = P.pd_no "
				+ "		AND q.q_created_date >= trunc(sysdate - ?) "
				+ "		and Q.a_answered = ? "
				+ "      and Q.q_deleted = 'N' ) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? ";
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			question.setPdName(rs.getString("pd_name"));
			
			return question;
			
		}, period, answered, beginIndex, endIndex, categoryNo);
	}
	
	
	public int getTotalRowsWithoutKeyword(int categoryNo, int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "and P.category_no = ? "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo, period, answered);
	}
	
	
	
	
	/**
	 * 카테고리: 전체보기, 키워드검색조건: 상품명
	 * @param keyword
	 * @param period
	 * @param answered
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionDto> getQuestionsByPdNameKeyword(String keyword, int period, String answered, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select * "
				   +"from (select row_number() over (order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
				   + "		from sul_questions Q, sul_products P,  sul_users U "
				   + "		where Q.user_no = U.user_no "
				   + "		and Q.pd_no = P.pd_no "
				   + "		and P.pd_name like '%' || ? || '%' "
				   + "		AND q.q_created_date >= trunc(sysdate - ?) "
				   + "		and Q.a_answered = ? "
				   + "      and Q.q_deleted = 'N' ) "
				   + "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			question.setPdName(rs.getString("pd_name"));
			
			return question;
			
		}, keyword, period, answered, beginIndex, endIndex);
	}
	public int getTotalRowsByPdNameKeyword(String keyword, int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "and P.pd_name like '%' || ? || '%' "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, period, answered);
	}
	
	public List<QuestionDto> getQuestionsByPdNameKeyword(int categoryNo, String keyword, int period, String answered, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select * "
				+ "from(select row_number() over (partition by P.category_no order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
				+ "		from sul_questions Q, sul_products P, sul_users U "
				+ "		where Q.user_no = U.user_no "
				+ "		and Q.pd_no = P.pd_no "
				+ "		and P.pd_name like '%' || ? || '%' "
				+ "		AND q.q_created_date >= trunc(sysdate - ?) "
				+ "		and Q.a_answered = ? "
				+ "      and Q.q_deleted = 'N' ) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? ";
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			question.setPdName(rs.getString("pd_name"));
			
			return question;
			
		}, keyword, period, answered, beginIndex, endIndex, categoryNo);
	}
	
	public int getTotalRowsByPdNameKeyword(int categoryNo, String keyword, int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "and P.category_no = ? "
				+ "and P.pd_name like '%' || ? || '%' "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo, keyword, period, answered);
	}
	
	/**
	 * 카테고리: 전체보기, 키워드검색조건: 문의제목
	 * @param keyword
	 * @param period
	 * @param answered
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionDto> getQuestionsBytitleKeyword(String keyword, int period, String answered, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select * "
					+ "from (select row_number() over (order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
					+ "     from sul_questions Q, sul_products P, sul_users U "
					+ "		where Q.user_no = U.user_no "
					+ "		and Q.pd_no = P.pd_no "
					+ "		and Q.q_title like '%' || ? || '%' "
					+ "		and q.q_created_date >= trunc(sysdate - ?) "
					+ "		and Q.a_answered = ? "
					+ "      and Q.q_deleted = 'N' ) "
					+ "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			question.setPdName(rs.getString("pd_name"));
			
			return question;
			
		}, keyword, period, answered, beginIndex, endIndex);
	}
	
	public int getTotalRowsBytitleKeyword(String keyword, int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "and Q.q_title like '%' || ? || '%' "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, period, answered);
	}
	
	public List<QuestionDto> getQuestionsBytitleKeyword(int categoryNo ,String keyword, int period, String answered, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select * "
				+ "from (select row_number() over (partition by P.category_no order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
				+ "      from sul_questions Q, sul_products P, sul_users U "
				+ "		where Q.user_no = U.user_no "
				+ "		and Q.pd_no = P.pd_no "
				+ "		and Q.q_title like '%' || ? || '%' "
				+ "		AND q.q_created_date >= trunc(sysdate - ?) "
				+ "		and Q.a_answered = ? "
				+ "      and Q.q_deleted = 'N' ) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? ";
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			question.setPdName(rs.getString("pd_name"));
			
			return question;
			
		}, keyword, period, answered, beginIndex, endIndex, categoryNo);
	}
	
	public int getTotalRowsBytitleKeyword(int categoryNo ,String keyword, int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "and P.category_no = ? "
				+ "and Q.q_title like '%' || ? || '%' "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo , keyword, period, answered);
	}
	
	/**
	 * 카테고리: 전체보기, 키워드검색조건: 문의내용
	 * @param keyword
	 * @param period
	 * @param answered
	 * @return
	 * @throws SQLException
	 */
	public List<QuestionDto> getQuestionsBycontentKeyword(String keyword, int period, String answered, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select * "
				+ "from(select row_number() over (order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
				+ "     from sul_questions Q, sul_products P, sul_users U "
				+ "		where Q.user_no = U.user_no "
				+ "		and Q.pd_no = P.pd_no "
				+ "		and Q.q_content like '%' || ? || '%' "
				+ "		AND q.q_created_date >= trunc(sysdate - ?) "
				+ "		and Q.a_answered = ? "
				+ "      and Q.q_deleted = 'N' ) "
				+ "where row_number >= ? and row_number <= ? ";
				
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			question.setPdName(rs.getString("pd_name"));
			
			return question;
			
		}, keyword, period, answered, beginIndex, endIndex);
	}
	
	public int getTotalRowsBycontentKeyword(String keyword, int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "and Q.q_content like '%' || ? || '%' "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, period, answered);
	}
	
	
	public List<QuestionDto> getQuestionsBycontentKeyword(int categoryNo, String keyword, int period, String answered, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select * "
				+ "from (select  row_number() over (partition by P.category_no order by Q.q_no desc) row_number, Q.*, P.category_no, P.pd_name, U.user_name "
				+ "      from sul_questions Q, sul_products P, sul_users U "
				+ "		 where Q.user_no = U.user_no "
				+ "		 and Q.pd_no = P.pd_no "
				+ "      and Q.q_content like '%' || ? || '%' "
				+ "      AND q.q_created_date >= trunc(sysdate - ?) "
				+ "      and Q.a_answered = ? "
				+ "      and Q.q_deleted = 'N' ) "
				+ "where row_number >= ? and row_number <= ? "
				+ "and category_no = ? ";
		
		return helper.selectList(sql, rs -> {
			QuestionDto question = new QuestionDto();
			question.setCategoryNo(rs.getInt("category_no"));
			question.setNo(rs.getInt("q_no"));
			question.setUserNo(rs.getInt("user_no"));
			question.setUserName(rs.getString("user_name"));
			question.setPdNo(rs.getInt("pd_no"));
			question.setTitle(rs.getString("q_title"));
			question.setContent(rs.getString("q_content"));
			question.setAnswerContent(rs.getString("a_content"));
			question.setDeleted(rs.getString("q_deleted"));
			question.setCreatedDate(rs.getDate("q_created_date"));
			question.setUpdatedDate(rs.getDate("q_updated_date"));
			question.setAnswerCreatedDate(rs.getDate("a_created_date"));
			question.setAnswered(rs.getString("a_answered"));
			question.setPdName(rs.getString("pd_name"));
			
			return question;
			
		}, keyword, period, answered, beginIndex, endIndex, categoryNo);
	}
	public int getTotalRowsBycontentKeyword(int categoryNo, String keyword, int period, String answered) throws SQLException {
		
		String sql = "select count(*) cnt "
				+ "from sul_questions Q, sul_products P,  sul_users U "
				+ "where Q.user_no = U.user_no "
				+ "and Q.pd_no = P.pd_no "
				+ "and P.category_no = ? "
				+ "and Q.q_content like '%' || ? || '%' "
				+ "AND q.q_created_date >= trunc(sysdate - ?) "
				+ "and Q.a_answered = ? "
				+ "and Q.q_deleted = 'N' "
				+ "order by Q.q_no desc ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo, keyword, period, answered);
	}

	public void deleteQuestionByNo(int questionNo) throws SQLException {
		String sql = "update sul_questions "
				   + " set "
				   + "  q_deleted = 'Y' "
				   + "where q_no = ? ";
		helper.update(sql, questionNo);
	}
	
}
