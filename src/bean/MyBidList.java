package bean;

import java.sql.Timestamp;

public class MyBidList {
	private int bid_id;
	private int article_id;
	private String attachfile_src;
	private String article_title;
	private String article_description;
	private int bid_price;
	private int article_startprice;
	private int article_marketprice;
	private Timestamp article_regdate;
	private Timestamp article_enddate;
	private String article_seller;
	private boolean boolean_isBid;

	public int getBid_id() {
		return bid_id;
	}

	public void setBid_id(int bid_id) {
		this.bid_id = bid_id;
	}

	public int getArticle_id() {
		return article_id;
	}

	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}

	public String getAttachfile_src() {
		return attachfile_src;
	}

	public void setAttachfile_src(String attachfile_src) {
		this.attachfile_src = attachfile_src;
	}

	public String getArticle_title() {
		return article_title;
	}

	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}

	public String getArticle_description() {
		return article_description;
	}

	public void setArticle_description(String article_description) {
		this.article_description = article_description;
	}

	public int getBid_price() {
		return bid_price;
	}

	public void setBid_price(int bid_price) {
		this.bid_price = bid_price;
	}

	public int getArticle_startprice() {
		return article_startprice;
	}

	public void setArticle_startprice(int article_startprice) {
		this.article_startprice = article_startprice;
	}

	public int getArticle_marketprice() {
		return article_marketprice;
	}

	public void setArticle_marketprice(int article_marketprice) {
		this.article_marketprice = article_marketprice;
	}

	public Timestamp getArticle_regdate() {
		return article_regdate;
	}

	public void setArticle_regdate(Timestamp article_regdate) {
		this.article_regdate = article_regdate;
	}

	public Timestamp getArticle_enddate() {
		return article_enddate;
	}

	public void setArticle_enddate(Timestamp article_enddate) {
		this.article_enddate = article_enddate;
	}

	public String getArticle_seller() {
		return article_seller;
	}

	public void setArticle_seller(String article_seller) {
		this.article_seller = article_seller;
	}

	public boolean isBoolean_isBid() {
		return boolean_isBid;
	}

	public void setBoolean_isBid(boolean boolean_isBid) {
		this.boolean_isBid = boolean_isBid;
	}

}
