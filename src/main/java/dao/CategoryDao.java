package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Category;

public class CategoryDao {

	private static CategoryDao instance = new CategoryDao();
	private CategoryDao () {}
	public static CategoryDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public List<Category> getCategories() throws SQLException {
		String sql = "select * "
					+"from sul_category " ;
		
		
		return helper.selectList(sql, rs -> {
			Category category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			return category;
		});
			
	}
}
