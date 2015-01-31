package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import bean.RoadnameZipcode;
import db.JdbcContext;
import db.RowMapper;

public class RoadnameZipcodeDao{
	JdbcContext jdbcTemplate;

	public RoadnameZipcodeDao(){
		jdbcTemplate = new JdbcContext();
	}

	public List<RoadnameZipcode> getZipcodeList(String keyword) {
		List<RoadnameZipcode> result = null;

		String query = "SELECT * FROM ah_zipcode_roadname WHERE CONCAT(sido, ' ', road_nm, ' ', BUILDING_NO) LIKE CONCAT('%', ? , '%') ORDER BY ZIP_CD, SIDO, BUILDING_NO, BUILDING_NM, LAWDONG_NM ";
		result = jdbcTemplate.query(query, new String[]{keyword},
				new RowMapper<RoadnameZipcode>() {
					@Override
					public RoadnameZipcode mapRow(ResultSet rs)
							throws SQLException {
						RoadnameZipcode result = new RoadnameZipcode();
						
						result.setRoad_zip_cd(rs.getString("zip_cd"));
						result.setRoad_zip_seq(rs.getString("zip_seq"));
						result.setRoad_sido(rs.getString("sido"));
						result.setRoad_eng_sido(rs.getString("eng_sido"));
						result.setRoad_gungu(rs.getString("gungu"));
						result.setRoad_eupmyun("eupmyun");
						result.setRoad_eng_eupmyun(rs.getString("eng_eupmyun"));
						result.setRoad_road_cd(rs.getString("road_cd"));
						result.setRoad_road_nm(rs.getString("road_nm"));
						result.setRoad_jiha_yn(rs.getString("jiha_yn"));
						result.setRoad_building_no(rs.getString("building_no"));
						result.setRoad_building_dtl_no(rs.getString("building_dtl_no"));
						result.setRoad_building_mng_no(rs.getString("building_mng_no"));
						result.setRoad_bedal_nm(rs.getString("bedal_nm"));
						result.setRoad_building_nm(rs.getString("building_nm"));
						result.setRoad_lawdong_cd(rs.getString("lawdong_cd"));
						result.setRoad_lawdong_nm(rs.getString("lawdong_nm"));
						result.setRoad_ri(rs.getString("ri"));
						result.setRoad_sanji_yn(rs.getString("sanji_yn"));
						result.setRoad_jibun_no(rs.getString("jibun_no"));
						result.setRoad_eupmyun_no(rs.getString("eupmyun_no"));
						result.setRoad_jibun_dtl_no(rs.getString("jibun_dtl_no"));
						return result;
					}
				});

		return result;
	}
}
