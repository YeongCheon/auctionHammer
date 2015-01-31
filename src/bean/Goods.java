package bean;

import java.sql.Date;

public class Goods {
	private String article_id;
	private String article_seller;
	private Date article_startdate;
	private Date article_enddate;
	private int article_marketprice;
	private int article_realprice;
	private String article_title;
	private String article_content;
	private int article_type;

	private static final int TYPE_UP = 1;
	private static final int TYPE_DOWN = 2;
	private static final int TYPE_PRIVATE = 3;

	public String getArticle_id() {
		return article_id;
	}

	public void setArticle_id(String article_id) {
		this.article_id = article_id;
	}

	public String getArticle_seller() {
		return article_seller;
	}

	public void setArticle_seller(String article_seller) {
		this.article_seller = article_seller;
	}

	public Date getArticle_startdate() {
		return article_startdate;
	}

	public void setArticle_startdate(Date article_startdate) {
		this.article_startdate = article_startdate;
	}

	public Date getArticle_enddate() {
		return article_enddate;
	}

	public void setArticle_enddate(Date article_enddate) {
		this.article_enddate = article_enddate;
	}

	public int getArticle_marketprice() {
		return article_marketprice;
	}

	public void setArticle_marketprice(int article_marketprice) {
		this.article_marketprice = article_marketprice;
	}

	public int getArticle_realprice() {
		return article_realprice;
	}

	public void setArticle_realprice(int article_realprice) {
		this.article_realprice = article_realprice;
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

}
