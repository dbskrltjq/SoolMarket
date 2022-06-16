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
	

	public String getCategroyNameByNo(int categoryNo) throws SQLException {
		String sql = "select category_name "
				   + "from sul_category "
				   + "where category_no= ? ";
		
		return helper.selectOne(sql, rs ->	{
			
			return rs.getString("category_name");
		}, categoryNo);
	}
	
	public int getTotalQunatity(int categoryNo) throws SQLException {
		String sql = "select count(pd_no) cnt "
				+ "from sul_products "
				+ "where category_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo);
	}
	
	public List<Product> getItemBySaleQuantity(int categoryNo) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score from sul_products where category_no = ? order by pd_sale_quantity desc ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo);
}		
	
	public List<Product> getItemByMinPrice(int categoryNo) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score from sul_products where category_no = ? order by pd_sale_price asc";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo);
	}
	
	public List<Product> getItemByMaxPrice(int categoryNo) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score from sul_products where category_no = ? order by pd_sale_price desc";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo);
	}
	
	public List<Product> getItemByDate(int categoryNo) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score from sul_products where category_no = ? order by pd_created_date desc";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo);
	}
}