package bean;

import java.sql.Timestamp;

public class AuctionArticle {
	private int article_id;
	private String article_seller;
	private Timestamp article_startdate;
	private Timestamp article_enddate;
	private int article_marketprice;
	private int article_startprice;
	private String article_title;
	private String article_content;
	private int article_type;
	private Timestamp article_regdate;
	private String article_description;

	public int getArticle_id() {
		return article_id;
	}

	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}

	public String getArticle_seller() {
		return article_seller;
	}

	public void setArticle_seller(String article_seller) {
		this.article_seller = article_seller;
	}

	public Timestamp getArticle_startdate() {
		return article_startdate;
	}

	public void setArticle_startdate(Timestamp article_startdate) {
		this.article_startdate = article_startdate;
	}

	public Timestamp getArticle_enddate() {
		return article_enddate;
	}

	public void setArticle_enddate(Timestamp article_enddate) {
		this.article_enddate = article_enddate;
	}

	public int getArticle_marketprice() {
		return article_marketprice;
	}

	public void setArticle_marketprice(int article_marketprice) {
		this.article_marketprice = article_marketprice;
	}

	public int getArticle_startprice() {
		return article_startprice;
	}

	public void setArticle_startprice(int article_startprice) {
		this.article_startprice = article_startprice;
	}

	public String getArticle_title() {
		return article_title;
	}

	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}

	public String getArticle_content() {
		return article_content;
	}

	public void setArticle_content(String article_content) {
		this.article_content = article_content;
	}

	public int getArticle_type() {
		return article_type;
	}

	public void setArticle_type(int article_type) {
		this.article_type = article_type;
	}

	public Timestamp getArticle_regdate() {
		return article_regdate;
	}

	public void setArticle_regdate(Timestamp article_regdate) {
		this.article_regdate = article_regdate;
	}

	public String getArticle_description() {
		return article_description;
	}

	public void setArticle_description(String article_description) {
		this.article_description = article_description;
	}

}
