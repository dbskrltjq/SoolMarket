package vo;

public class ReviewLikeUser {

	private Review review;
	private User user;
	
	public ReviewLikeUser(int reviewNo, int userNo) {
		this.review = new Review();
		review.setNo(reviewNo);
		
		this.user = new User();
		user.setNo(userNo);
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
}
