package vo;

public class BestItem {
	
	private int ranking;
	private int pdNo;
	
	public BestItem() {}

	public BestItem(int ranking, int pdNo) {
		super();
		this.ranking = ranking;
		this.pdNo = pdNo;
	}

	public int getRanking() {
		return ranking;
	}

	public void setRanking(int ranking) {
		this.ranking = ranking;
	}

	public int getPdNo() {
		return pdNo;
	}

	public void setPdNo(int pdNo) {
		this.pdNo = pdNo;
	}
	
	
	
	
}
