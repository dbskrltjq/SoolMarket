package dao;

import java.sql.SQLException;

import helper.DaoHelper;
import vo.Product;

public class ProductDao {

	private static ProductDao instance = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return instance;
	}
	
	private DaoHelper helper = DaoHelper.getInstance();
	
	public Product getProductByNo(int productNo) throws SQLException {
		
		String sql = "select * "
				   + "from sul_products "
				   + "where pd_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			Product product = new Product();
			product.setNo(rs.getInt("pd_no"));
			product.setCategoryNo(rs.getInt("category_no"));
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setStock(rs.getInt("pd_stock"));
			product.setOnSale(rs.getString("pd_onsale"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			product.setReviewCount(rs.getInt("pd_review_count"));
			product.setCompany(rs.getString("pd_company"));
			product.setSaleQuantity(rs.getInt("pd_sale_quantity"));
			product.setRecommended(rs.getString("pd_recommended"));
			product.setFileName(rs.getString("pd_file_name"));
			
			return product;
		},productNo);
	}
	
	public int getTotalRows(int categoryNo) throws SQLException {
		String sql = "select count(*) cnt from sul_products where category_No = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo);
	}
}
