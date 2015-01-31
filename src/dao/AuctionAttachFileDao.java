package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import bean.AuctionAttachFile;
import db.JdbcContext;
import db.RowMapper;

public class AuctionAttachFileDao {
	JdbcContext jdbcTemplate;

	public AuctionAttachFileDao(){
		jdbcTemplate = new JdbcContext();
	}

	public int insertAttachFile(int article_id, String src) {
		String query = "INSERT INTO ah_goods_attachfile(article_id, attachfile_src) VALUES(?, ?) ";
		return jdbcTemplate.update(query, Integer.toString(article_id), src);
	}
	
	public AuctionAttachFile getAttachFile(int article_id){
		String query = "SELECT attachfile_id, attachfile_src, article_id FROM ah_goods_attachfile WHERE article_id = ?";
		try{
		return jdbcTemplate.query(query, new String[]{Integer.toString(article_id)}, new RowMapper<AuctionAttachFile>(){

			@Override
			public AuctionAttachFile mapRow(ResultSet rs)
					throws SQLException {
				AuctionAttachFile attachfile = new AuctionAttachFile();
				
				attachfile.setAttachfile_id(rs.getInt("attachfile_id"));
				attachfile.setArticle_id(rs.getInt("attachfile_id"));
					attachfile.setAttachfile_src(rs.getString("attachfile_src"));
				
				return attachfile;
			}
		}).get(0);
		} catch(Exception ex){
			return null;
		}
	}
}
