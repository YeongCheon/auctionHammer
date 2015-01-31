package bean;

/*
 * author : YeongCheon Kim
 * email : kyc1682@gmail.com
 * 
 * */
/**
 * @author yeongcheon
 *
 */
public class User {
	private String user_id;
	private String user_nicname;
	private String user_password; // SHA-256 적용예정
	private String user_pwdHint;
	private String user_answer;
	private String user_name;
	private String user_gender;
	private String user_birthday;
	private String user_emailID;
	private String user_emailDomain;
	private String user_localNum;
	private String user_callNum;
	private String user_phone;
	private String user_zipcode;
	private String user_addr1;
	private String user_addr2;
	private String user_type;
	private int user_point;
	private String user_regDate;
	
	public static final String TYPE_SELLER = "SELLER";
	public static final String TYPE_CUSTOMER = "CUSTOMER";
	public static final String TYPE_ADMIN = "ADMIN";

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_nicname() {
		return user_nicname;
	}

	public void setUser_nicname(String user_nicname) {
		this.user_nicname = user_nicname;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getUser_pwdHint() {
		return user_pwdHint;
	}

	public void setUser_pwdHint(String user_pwdHint) {
		this.user_pwdHint = user_pwdHint;
	}

	public String getUser_answer() {
		return user_answer;
	}

	public void setUser_answer(String user_answer) {
		this.user_answer = user_answer;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public String getUser_birthday() {
		return user_birthday;
	}

	public void setUser_birthday(String user_birthday) {
		this.user_birthday = user_birthday;
	}

	public String getUser_emailID() {
		return user_emailID;
	}

	public void setUser_emailID(String user_emailID) {
		this.user_emailID = user_emailID;
	}

	public String getUser_emailDomain() {
		return user_emailDomain;
	}

	public void setUser_emailDomain(String user_emailDomain) {
		this.user_emailDomain = user_emailDomain;
	}

	public String getUser_localNum() {
		return user_localNum;
	}

	public void setUser_localNum(String user_localNum) {
		this.user_localNum = user_localNum;
	}

	public String getUser_callNum() {
		return user_callNum;
	}

	public void setUser_callNum(String user_callNum) {
		this.user_callNum = user_callNum;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_zipcode() {
		return user_zipcode;
	}

	public void setUser_zipcode(String user_zipcode) {
		this.user_zipcode = user_zipcode;
	}

	public String getUser_addr1() {
		return user_addr1;
	}

	public void setUser_addr1(String user_addr1) {
		this.user_addr1 = user_addr1;
	}

	public String getUser_addr2() {
		return user_addr2;
	}

	public void setUser_addr2(String user_addr2) {
		this.user_addr2 = user_addr2;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public int getUser_point() {
		return user_point;
	}

	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}

	public String getUser_regDate() {
		return user_regDate;
	}

	public void setUser_regDate(String user_regDate) {
		this.user_regDate = user_regDate;
	}

	public User(String id, String nicname, String password, String pwdHint,
			String answer, String name, String gender, String birthday,
			String emailID, String emailDomain, String localNum,
			String callNum, String phone, String zipcode, String addr1,
			String addr2, String type) {
		this.user_id = id;
		this.user_nicname = nicname;
		this.user_password = password;
		this.user_pwdHint = pwdHint;
		this.user_answer = answer;
		this.user_name = name;
		this.user_gender = gender;
		this.user_birthday = birthday;
		this.user_emailID = emailID;
		this.user_emailDomain = emailDomain;
		this.user_localNum = localNum;
		this.user_callNum = callNum;
		this.user_phone = phone;
		this.user_zipcode = zipcode;
		this.user_addr1 = addr1;
		this.user_addr2 = addr2;
		this.user_type = type;
	}

	public User() {

	}

}
