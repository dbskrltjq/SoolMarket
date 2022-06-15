package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Question;

public class ProductQuestionDao {

	private static ProductQuestionDao instance = new ProductQuestionDao();
	private ProductQuestionDao() {}
	public static ProductQuestionDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public List<Question> getProductQuestions(int productNo) throws SQLException {
		String sql = "select Q.q_no, U.user_no, U.user_name, Q.pd_no, Q.q_title, Q.q_content, "
				   + "Q.a_content, Q.q_deleted, Q.q_created_date, Q.q_updated_date, Q.a_created_date "
				   + "from sul_questions Q, sul_users U "
				   + "where Q.user_no = U.user_no "
				   + "and Q.pd_no = ? ";
		
		return helper.selectList(sql, rs -> {
			Question question = new Question();
			question.setNo(rs.getInt(""));
		},productNo);
	}
}
