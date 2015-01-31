package bean;

import java.sql.Timestamp;

public class AuctionBid {
	private int bid_id;
	private int bid_article_id;
	private String bid_user;
	private int bid_price;
	private Timestamp bid_date;

	public int getBid_id() {
		return bid_id;
	}

	public void setBid_id(int bid_id) {
		this.bid_id = bid_id;
	}

	public int getBid_article_id() {
		return bid_article_id;
	}

	public String getBid_user() {
		return bid_user;
	}

	public void setBid_user(String bid_user) {
		this.bid_user = bid_user;
	}

	public void setBid_article_id(int bid_article_id) {
		this.bid_article_id = bid_article_id;
	}

	public int getBid_price() {
		return bid_price;
	}

	public void setBid_price(int bid_price) {
		this.bid_price = bid_price;
	}

	public Timestamp getBid_date() {
		return bid_date;
	}

	public void setBid_date(Timestamp bid_date) {
		this.bid_date = bid_date;
	}
	
	public AuctionBid(){
		
	}

	public AuctionBid(int bid_article_id, String bid_user, int bid_price) {
		this.bid_article_id = bid_article_id;
		this.bid_user = bid_user;
		this.bid_price = bid_price;
	}

}
