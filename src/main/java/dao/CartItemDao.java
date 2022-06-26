package dao;

import java.sql.SQLException;
import java.util.List;

import dto.CartItemDto;
import helper.DaoHelper;
import vo.Cart;

public class CartItemDao {
	
	public static CartItemDao instance = new CartItemDao();
	private CartItemDao() {}
	public static CartItemDao getInstance() {
		return instance;
	}
	
	DaoHelper helper = DaoHelper.getInstance();
	
	// 카트 번호로 저장된 장바구니 아이템정보를 반환한다. - orderForm
	public CartItemDto getCartItemByCartNo(int cartNo) throws SQLException {
		String sql = "select C.CART_NO, U.USER_NO, P.PD_NO, P.PD_NAME, C.CART_ITEM_QUANTITY, P.PD_SALE_PRICE, floor((P.PD_SALE_PRICE * C.CART_ITEM_QUANTITY)*0.01) EarnPoint "
				+ "from SUL_USERS U, SUL_PRODUCTS P, SUL_CARTS C "
				+ "where C.CART_NO = ? "
				+ "and U.USER_NO = C.USER_NO "
				+ "and C.PD_NO = P.PD_NO "
				+ "order by C.CART_ITEM_CREATED_DATE DESC ";
		
		return helper.selectOne(sql, rs -> {
			CartItemDto cartItemDto = new CartItemDto();
			cartItemDto.setCartNo(rs.getInt("CART_NO"));
			cartItemDto.setUserNo(rs.getInt("USER_NO"));
			cartItemDto.setPdNo(rs.getInt("PD_NO"));
			cartItemDto.setPdName(rs.getString("PD_NAME"));
			cartItemDto.setCartItemQuantity(rs.getInt("CART_ITEM_QUANTITY"));
			cartItemDto.setPdPrice(rs.getInt("PD_SALE_PRICE"));
			cartItemDto.setPdEarnPoint(rs.getInt("EARNPOINT"));
			return cartItemDto;
		}, cartNo);
		
	}

	// 지정된 사용자 번호로 저장된 장바구니 아이템정보를 반환한다. - 유저가 자기 장바구니 보려고 할 떄
	public List<CartItemDto> getCartItemByUser(int userNo) throws SQLException {
		String sql = "select C.CART_NO, U.USER_NO, P.PD_NO, P.PD_NAME, C.CART_ITEM_QUANTITY, P.PD_SALE_PRICE, floor((P.PD_SALE_PRICE * C.CART_ITEM_QUANTITY)*0.01) EarnPoint "
				+ "from SUL_USERS U, SUL_PRODUCTS P, SUL_CARTS C "
				+ "where U.USER_NO = ? "
				+ "and U.USER_NO = C.USER_NO "
				+ "and C.PD_NO = P.PD_NO "
				+ "order by C.CART_ITEM_CREATED_DATE DESC ";
		
		return helper.selectList(sql, rs -> {
			CartItemDto cartItemDto = new CartItemDto();
			cartItemDto.setCartNo(rs.getInt("CART_NO"));
			cartItemDto.setUserNo(rs.getInt("USER_NO"));
			cartItemDto.setPdNo(rs.getInt("PD_NO"));
			cartItemDto.setPdName(rs.getString("PD_NAME"));
			cartItemDto.setCartItemQuantity(rs.getInt("CART_ITEM_QUANTITY"));
			cartItemDto.setPdPrice(rs.getInt("PD_SALE_PRICE"));
			cartItemDto.setPdEarnPoint(rs.getInt("EARNPOINT"));
			return cartItemDto;
		}, userNo);
		
	}
	
	// 선생님 이 메소드 봐 주세요!!
	// userNo가 필요한가요 로그인을 했어도? (이 메소드는 반드시 로그인된 상태에서만 실행된다.) ㅇㅇ 필요함
	// 지정된 장바구니 아이템 정보를 전달받아서 동일한 정보가 존재하면 수량을 증가시키고, 정보가 존재하지 않으면 추가한다. - add
	// 여긴 userNo 필요
	public void mergeCartItem(Cart cart) throws SQLException {
		String sql = "merge "
				+ "   into sul_carts c "
				+ "using dual "
				+ "   on (c.user_no = ? and c.pd_no = ?) "
				+ "when matched then "
				+ "   update "
				+ "       set "
				+ "           c.CART_ITEM_QUANTITY = c.CART_ITEM_QUANTITY + ?, "
				+ "           c.CART_ITEM_UPDATED_DATE = sysdate "
				+ "when not matched then "
				+ "    insert (c.cart_no, c.user_no, c.pd_no, c.CART_ITEM_QUANTITY) "
				+ "    values (SUL_CARTS_SEQ.nextval, ?, ?, ?) ";
		// update
		helper.update(sql, cart.getUserNo(), cart.getPdNo(), cart.getQuantity(), cart.getUserNo(), cart.getPdNo(), cart.getQuantity());

	}
	
	// 지정된 장바구니 아이템 정보를 전달받아서 수량을 업데이트한다.
	public void updateCartItem(Cart cart) throws SQLException {
		String sql = "update SUL_CARTS "
				+ "set CART_ITEM_QUANTITY = ? , "
				+ "	   CART_ITEM_UPDATED_DATE = sysdate "
				+ "where cart_no = ? ";
		
		helper.update(sql, cart.getQuantity(), cart.getNo());
	}

	
	// 지정된 장바구니 아이템번호와 일치하는 장바구니 아이템정보를 반환한다. - 장바구니에서 아이템 사진이나 이름 누르면 실행되는 거
	public Cart getCartItemByPdNo(int pdNo) throws SQLException {
		String sql = "select * "
				+ "from SUL_CARTS "
				+ "where pd_No = ? ";
		
		return helper.selectOne(sql, rs -> {
			Cart cart = new Cart();
			cart.setNo(rs.getInt("CART_NO"));
			cart.setUserNo(rs.getInt("USER_NO"));
			cart.setPdNo(rs.getInt("PD_NO"));
			cart.setQuantity(rs.getInt("CART_ITEM_QUANTITY"));
			cart.setCreatedDate(rs.getDate("CART_ITEM_CREATED_DATE"));
			cart.setUpdatedDate(rs.getDate("CART_ITEM_UPDATED_DATE"));
			
			return cart;
			
		}, pdNo);		
	}
	
	
	// 지정된 장바구니 아이템번호화 일치하는 장바구니 아이템정보를 삭제한다. - delete
	public void deleteCartItem(int cartNo) throws SQLException {
		String sql = "delete from SUL_CARTS "
				+ "where CART_NO = ? ";
	
		helper.delete(sql, cartNo);
	}

	// 지정된 아이템 번호와 일치하는 장바구니 아이템정보를 삭제한다. - delete
	public void deleteCartItemByPdNo(int pdNo) throws SQLException {
		String sql = "delete from SUL_CARTS "
				+ "where PD_NO = ? ";
		
		helper.delete(sql, pdNo);
	}

}
