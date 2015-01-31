package dao;

import static org.junit.Assert.assertThat;
import static org.hamcrest.CoreMatchers.is;

import org.junit.Before;
import org.junit.Test;

/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
public class RoadnameZipcodeDaoTest {
	RoadnameZipcodeDao zipcodeDao;

	@Before
	public void setUp() {
		zipcodeDao = new RoadnameZipcodeDao();
	}

	@Test
	public void getZipcodeListTest() {
		int getListCount = zipcodeDao.getZipcodeList("올림픽로").size();
		
		assertThat(getListCount, is(2330));

	}
}

