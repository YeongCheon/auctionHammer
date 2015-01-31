package bean;

import java.sql.Timestamp;

public class BoardArticle {
	private int id;
	private int listId;
	private String writer;
	private String title;
	private String content;
	private int hit;
	private boolean isNotice = false;
	private Timestamp regdate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getListId() {
		return listId;
	}

	public void setListId(int listId) {
		this.listId = listId;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public boolean getIsNotice() {
		return isNotice;
	}

	public void setIsNotice(boolean isNotice) {
		this.isNotice = isNotice;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	
	

	public BoardArticle() {

	}

	public BoardArticle(int id, int listId, String writer, String title,
			String content, int hit, boolean isNotice, Timestamp regdate) {
		this.id = id;
		this.listId = listId;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.hit = hit;
		this.isNotice = isNotice;
		this.regdate = regdate;
	}

	public BoardArticle(int listId, String writer, String title,
			String content, boolean isNotice) { //using insert
		this.listId = listId;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.isNotice = isNotice;
	}

}
