package bean;

public class Buy {
	private int buy_id;
	private int buy_article_id;
	private String user_id;
	private String buy_zipcode;
	private String addr1;
	private String addr2;

	public int getBuy_id() {
		return buy_id;
	}

	public void setBuy_id(int buy_id) {
		this.buy_id = buy_id;
	}

	public int getBuy_article_id() {
		return buy_article_id;
	}

	public void setBuy_article_id(int buy_article_id) {
		this.buy_article_id = buy_article_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getBuy_zipcode() {
		return buy_zipcode;
	}

	public void setBuy_zipcode(String buy_zipcode) {
		this.buy_zipcode = buy_zipcode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

}
