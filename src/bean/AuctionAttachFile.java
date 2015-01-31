package bean;

public class AuctionAttachFile {
	private int attachfile_id;
	private int article_id;
	private String attachfile_src;

	public int getAttachfile_id() {
		return attachfile_id;
	}

	public void setAttachfile_id(int attachfile_id) {
		this.attachfile_id = attachfile_id;
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
}