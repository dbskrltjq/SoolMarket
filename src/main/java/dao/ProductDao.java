package dao;

import java.sql.SQLException;
import java.util.List;

import helper.DaoHelper;
import vo.Category;
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
	
	public int getTotalRows() throws SQLException {
		String sql = "select count(*) cnt from sul_products ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		});
	}
	
	public int getTotalRows(int categoryNo) throws SQLException {
		String sql = "select count(*) cnt from sul_products where category_No = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo);
	}
	
	public int getTotalRows(String keyword) throws SQLException {
		String sql = "select count(*) cnt from sul_products where pd_name like '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	}
	
	public int getTotalRowsByCategory(String keyword, String categoryName) throws SQLException {
		String sql = "select count(*) cnt "
				+ "from sul_products P, sul_category C "
				+ "where pd_name like '%' || ? || '%' "
				+ "and P.category_no = C.category_no "
				+ "and C.category_name = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, categoryName);
	}
	
	public int getTotalRowsByCompany(String keyword, String company) throws SQLException {
		String sql = "select count(*) cnt "
				+ "from sul_products P, sul_category C "
				+ "where pd_name like '%' || ? || '%' "
				+ "and P.category_no = C.category_no "
				+ "and P.pd_company = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, company);
	}
	
	public int getTotalRows(String keyword, String categoryName, String company) throws SQLException {
		String sql = "select count(*) cnt "
				+ "from sul_products P, sul_category C "
				+ "where pd_name like '%' || ? || '%' "
				+ "and P.category_no = C.category_no "
				+ "and C.category_name = ? "
				+ "and P.pd_company = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword, categoryName, company);
	}
	
	public int getTotalQunatity(int categoryNo) throws SQLException {
		String sql = "select count(pd_no) cnt "
				+ "from sul_products "
				+ "where category_no = ? ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, categoryNo);
	}
	
	public int getTotalQunatity(String keyword) throws SQLException {
		String sql = "select count(pd_no) cnt "
				+ "from sul_products "
				+ "where pd_name like '%' || ? || '%' ";
		
		return helper.selectOne(sql, rs -> {
			return rs.getInt("cnt");
		}, keyword);
	} 
	
	public List<Product> getAllProducts(int beginIndex, int endIndex) throws SQLException {
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				   + "from(select row_number() over (order by pd_sale_quantity desc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				   + "from sul_products) "
			   	   + "where row_number >= ? and row_number <= ? ";
				
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, beginIndex, endIndex);
	}
	
	public List<Product> getItemBySaleQuantity(int categoryNo, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_sale_quantity desc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where category_no = ?) "
				+ "where row_number >= ? and row_number <= ?";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo, beginIndex, endIndex);
	}		
	
	public List<Product> getItemBySaleQuantity(String keyword, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_sale_quantity desc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where pd_name like '%' || ? || '%') "
				+ "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, keyword, beginIndex, endIndex);
	}
	
	public List<Product> getItemByMinPrice(int categoryNo, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_sale_price asc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where category_no = ? ) "
				+ "where row_number >= ? and row_number <= ?";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo, beginIndex, endIndex);
	}
	
	public List<Product> getItemByMinPrice(String keyword, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_sale_price asc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where pd_name like '%' || ? || '%') "
				+ "where row_number >= ? and row_number <= ?";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, keyword, beginIndex, endIndex);
	}
	
	public List<Product> getItemByMaxPrice(int categoryNo, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_sale_price desc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where category_no = ? ) "
				+ "where row_number >= ? and row_number <= ?";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo, beginIndex, endIndex);
	}
	
	public List<Product> getItemByMaxPrice(String keyword, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_sale_price desc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where pd_name like '%' || ? || '%') "
				+ "where row_number >= ? and row_number <= ?";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, keyword, beginIndex, endIndex);
	}
	
	public List<Product> getItemByDate(int categoryNo, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_created_date desc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where category_no = ? ) "
				+ "where row_number >= ? and row_number <= ?";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, categoryNo, beginIndex, endIndex);
	}
	
	public List<Product> getItemByDate(String keyword, int beginIndex, int endIndex) throws SQLException {
		
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from(select row_number() over (order by pd_created_date desc) row_number, pd_name, pd_price, pd_sale_price, pd_review_score "
				+ "from sul_products where pd_name like '%' || ? || '%' ) "
				+ "where row_number >= ? and row_number <= ?";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
		}, keyword, beginIndex, endIndex);
	}
	
	public List<Product> getCompanyByKeyword(String keyword) throws SQLException {
		String sql = "select distinct pd_company "
				   + "from sul_products "
				   + "where pd_name like '%' || ? || '%' ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setCompany(rs.getString("pd_company"));
			return product;
			
		}, keyword);
	}
	
	public List<Product> getItemByOptionCategory(String keyword, String categoryName, int beginIndex, int endIndex) throws SQLException {
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				   + "from(select row_number() over (order by pd_sale_quantity desc) row_number, P.pd_name, P.pd_price, P.pd_sale_price, P.pd_review_score "
				   + "     from sul_products P, sul_category C "
			   	   + "     where pd_name like '%' || ? || '%' "
				   + "     and P.category_no = C.category_no "
				   + "     and C.category_name = ?) "
				   + "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
			
		}, keyword, categoryName, beginIndex, endIndex);
	}
	
	public List<Product> getItemByOptionCompany(String keyword, String company, int beginIndex, int endIndex) throws SQLException {
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				   + "from(select row_number() over (order by pd_sale_quantity desc) row_number, P.pd_name, P.pd_price, P.pd_sale_price, P.pd_review_score "
				   + "     from sul_products P, sul_category C "
			   	   + "     where pd_name like '%' || ? || '%' "
				   + "     and P.category_no = C.category_no "
				   + "     and P.pd_company = ?) "
				   + "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));	
			
			return product;
			
		}, keyword, company, beginIndex, endIndex);
	}
	
	public List<Product> getItemByOption(String keyword, String categoryName, String company, int beginIndex, int endIndex) throws SQLException {
		String sql = "select pd_name, pd_price, pd_sale_price, pd_review_score "
				   + "from(select row_number() over (order by pd_sale_quantity desc) row_number, P.pd_name, P.pd_price, P.pd_sale_price, P.pd_review_score "
				   + "     from sul_products P, sul_category C "
			   	   + "     where pd_name like '%' || ? || '%' "
				   + "     and P.category_no = C.category_no "
				   + "     and C.category_name = ? "
				   + "	   and P.pd_company = ?) "
				   + "where row_number >= ? and row_number <= ? ";
		
		return helper.selectList(sql, rs -> {
			Product product = new Product();
			product.setName(rs.getString("pd_name"));
			product.setPrice(rs.getInt("pd_price"));
			product.setSalePrice(rs.getInt("pd_sale_price"));
			product.setReviewScore(rs.getInt("pd_review_score"));
			
			return product;
			
		}, keyword, categoryName, company, beginIndex, endIndex);
	}
	
}
