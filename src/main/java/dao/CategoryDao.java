package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Category;
import vo.Product;

public class CategoryDao {

	private static CategoryDao instance = new CategoryDao();
	private CategoryDao() {};
	public static CategoryDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	


	public String getCategoryNameByNo(int categoryNo) throws SQLException {
		String sql = "select category_name "
				   + "from sul_category "
				   + "where category_no= ? ";
		
		return helper.selectOne(sql, rs ->	{
			
			return rs.getString("category_name");
		}, categoryNo);
	}
	
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
	
	public List<Category> getCategoryNameByKeyword(String keyword) throws SQLException {
		String sql = "select distinct C.category_name "
				   + "from sul_products P, sul_category C "
				   + "where pd_name like '%' || ? || '%' "
				   + "and P.category_no = C.category_no ";
		
		return helper.selectList(sql, rs -> {
			Category category = new Category();
			category.setName(rs.getString("category_name"));
			
			return category;
		}, keyword);
	}
	
	public List<Category> getCategoryNameByKeywordCategory(String keyword, String categoryName) throws SQLException {
		String sql = "select distinct C.category_name "
				   + "from sul_products P, sul_category C "
				   + "where pd_name like '%' || ? || '%' "
				   + "and P.category_no = C.category_no "
				   + "and C.category_name = ? ";
		
		return helper.selectList(sql, rs -> {
			Category category = new Category();
			category.setName(rs.getString("category_name"));
			
			return category;
		}, keyword, categoryName);
	}
	
	public List<Category> getCategoryNameByKeywordCompany(String keyword, String company) throws SQLException {
		String sql = "select distinct C.category_name "
				   + "from sul_products P, sul_category C "
				   + "where pd_name like '%' || ? || '%' "
				   + "and P.category_no = C.category_no "
				   + "and P.pd_company = ? ";
		
		return helper.selectList(sql, rs -> {
			Category category = new Category();
			category.setName(rs.getString("category_name"));
			
			return category;
		}, keyword, company);
	}
	
	public List<Category> getCategoryNameByKeyword(String keyword, String categoryName, String company) throws SQLException {
		String sql = "select distinct C.category_name "
				   + "from sul_products P, sul_category C "
				   + "where pd_name like '%' || ? || '%' "
				   + "and P.category_no = C.category_no "
				   + "and C.category_name = ? "
				   + "and P.pd_company = ? ";
		
		return helper.selectList(sql, rs -> {
			Category category = new Category();
			category.setName(rs.getString("category_name"));
			
			return category;
		}, keyword, categoryName, company);
	}
}

