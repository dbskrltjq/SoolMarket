package dto;

public class CartItemDto {
	private int cartNo;
	private int userNo;
	private int pdNo;
	private String fileName;
	private String pdName;
	private int cartItemQuantity;
	private int pdPrice;
	private int pdEarnPoint;
	
	public CartItemDto () {}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getPdNo() {
		return pdNo;
	}

	public void setPdNo(int pdNo) {
		this.pdNo = pdNo;
	}

	public String getPdName() {
		return pdName;
	}

	public void setPdName(String pdName) {
		this.pdName = pdName;
	}

	public int getPdPrice() {
		return pdPrice;
	}

	public void setPdPrice(int pdPrice) {
		this.pdPrice = pdPrice;
	}

	public int getPdEarnPoint() {
		return pdEarnPoint;
	}

	public void setPdEarnPoint(int pdEarnPoint) {
		this.pdEarnPoint = pdEarnPoint;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getCartItemQuantity() {
		return cartItemQuantity;
	}

	public void setCartItemQuantity(int cartItemQuantity) {
		this.cartItemQuantity = cartItemQuantity;
	}
	
	
	
	
}
