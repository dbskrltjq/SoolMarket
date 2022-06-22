package vo;

import java.util.Date;

public class Order {

	private int no;
	private int userNo;
	private String title;
	private int totalPrice;
	private int usedPoint;
	private int paymentPrice;
	private int depositPoint;
	private int totalQuantity;
	private Date createdDate;
	private Date updatedDate;
	private String status;					// 결재완료, 배송중, 배송완료
	private String deleted;					
	private String receiveName;					
	private String receiveAddress;					
	private String receiveDetailAddress;
	private int receivePostCode;
	private String payment;					
	private String deliveryMemo;					
	
	
	public Order() {}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public int getUserNo() {
		return userNo;
	}


	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public int getTotalPrice() {
		return totalPrice;
	}


	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}


	public int getUsedPoint() {
		return usedPoint;
	}


	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}


	public int getPaymentPrice() {
		return paymentPrice;
	}


	public void setPaymentPrice(int paymentPrice) {
		this.paymentPrice = paymentPrice;
	}


	public int getDepositPoint() {
		return depositPoint;
	}


	public void setDepositPoint(int depositPoint) {
		this.depositPoint = depositPoint;
	}


	public int getTotalQuantity() {
		return totalQuantity;
	}


	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}


	public Date getCreatedDate() {
		return createdDate;
	}


	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}


	public Date getUpdatedDate() {
		return updatedDate;
	}


	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getDeleted() {
		return deleted;
	}


	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}


	public String getReceiveName() {
		return receiveName;
	}


	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}


	public String getReceiveAddress() {
		return receiveAddress;
	}


	public void setReceiveAddress(String receiveAddress) {
		this.receiveAddress = receiveAddress;
	}


	public String getReceiveDetailAddress() {
		return receiveDetailAddress;
	}


	public void setReceiveDetailAddress(String receiveDetailAddress) {
		this.receiveDetailAddress = receiveDetailAddress;
	}


	public String getPayment() {
		return payment;
	}


	public void setPayment(String payment) {
		this.payment = payment;
	}


	public String getDeliveryMemo() {
		return deliveryMemo;
	}


	public void setDeliveryMemo(String deliveryMemo) {
		this.deliveryMemo = deliveryMemo;
	}


	public int getReceivePostCode() {
		return receivePostCode;
	}


	public void setReceivePostCode(int receivePostCode) {
		this.receivePostCode = receivePostCode;
	};
	
	
	
	
	
	
}
