package bean;

import java.sql.Date;

public class BoardComment {
	private int comment_id;
	private int article_id;
	private String comment_writer;
	private String comment_memo;
	private Date comment_regdate;
	private String comment_ip;
	private int comment_rereplay;
	private float comment_level;

	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public int getArticle_id() {
		return article_id;
	}

	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}

	public String getComment_writer() {
		return comment_writer;
	}

	public void setComment_writer(String comment_writer) {
		this.comment_writer = comment_writer;
	}

	public String getComment_memo() {
		return comment_memo;
	}

	public void setComment_memo(String comment_memo) {
		this.comment_memo = comment_memo;
	}

	public Date getComment_regdate() {
		return comment_regdate;
	}

	public void setComment_regdate(Date comment_regdate) {
		this.comment_regdate = comment_regdate;
	}

	public String getComment_ip() {
		return comment_ip;
	}

	public void setComment_ip(String comment_ip) {
		this.comment_ip = comment_ip;
	}

	public int getComment_rereplay() {
		return comment_rereplay;
	}

	public void setComment_rereplay(int comment_rereplay) {
		this.comment_rereplay = comment_rereplay;
	}

	public float getComment_level() {
		return comment_level;
	}

	public void setComment_level(float comment_level) {
		this.comment_level = comment_level;
	}

	public BoardComment(int id, int articleId, String writer, String memo,
			Date regdate, String ip) {
		this.comment_id = id;
		this.article_id = articleId;
		this.comment_writer = writer;
		this.comment_memo = memo;
		this.comment_regdate = regdate;
		this.comment_ip = ip;
	}

	public BoardComment(int articleId, String writer, String memo, String ip,
			int rereply) {
		this.article_id = articleId;
		this.comment_writer = writer;
		this.comment_memo = memo;
		this.comment_ip = ip;
		this.comment_rereplay = rereply;
	}

	public BoardComment() {

	}
}