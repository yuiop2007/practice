package member;

public class HashTableVO {
	private int pwdKey;
	private String pwdValue;
	
	public int getPwdKey() {
		return pwdKey;
	}
	public void setPwdKey(int pwdKey) {
		this.pwdKey = pwdKey;
	}
	public String getPwdValue() {
		return pwdValue;
	}
	public void setPwdValue(String pwdValue) {
		this.pwdValue = pwdValue;
	}
	@Override
	public String toString() {
		return "HashTable [pwdKey=" + pwdKey + ", pwdValue=" + pwdValue + "]";
	}
}
