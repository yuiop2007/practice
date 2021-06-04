package board;

public class BoardVO {
	private int idx;
	private String name;
	private String title;
	private String email;
	private String pwd;
	private String wDate;
	private int readNum;
	private String hostIp;
	private int good;
	private String content;
	
	// 날짜형식을 문자/숫자로 저장시키는 변수 선언
	private String wCdate;
	private int wNdate;
	
	// 댓글수를 위한 변수
	private int replyCount;
	
	// 이전글/다음글을 위한 변수
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	public BoardVO() {}
	
	public BoardVO(int idx, String name, String title, String email, String pwd, String wDate, int readNum, String hostIp, int good, String content) {
		this.idx = idx;
		this.name = name;
		this.title = title;
		this.email = email;
		this.pwd = pwd;
		this.wDate = wDate;
		this.readNum = readNum;
		this.hostIp = hostIp;
		this.good = good;
		this.content = content;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getwCdate() {
		return wCdate;
	}
	public void setwCdate(String wCdate) {
		this.wCdate = wCdate;
	}
	public int getwNdate() {
		return wNdate;
	}
	public void setwNdate(int wNdate) {
		this.wNdate = wNdate;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getPreIdx() {
		return preIdx;
	}
	public void setPreIdx(int preIdx) {
		this.preIdx = preIdx;
	}
	public int getNextIdx() {
		return nextIdx;
	}
	public void setNextIdx(int nextIdx) {
		this.nextIdx = nextIdx;
	}
	public String getPreTitle() {
		return preTitle;
	}
	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}
	public String getNextTitle() {
		return nextTitle;
	}
	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}

	@Override
	public String toString() {
		return "BoardVO [idx=" + idx + ", name=" + name + ", title=" + title + ", email=" + email + ", pwd=" + pwd
				+ ", wDate=" + wDate + ", readNum=" + readNum + ", hostIp=" + hostIp + ", good=" + good + ", content=" + content
				+ ", wCdate=" + wCdate + ", wNdate=" + wNdate + ", replyCount=" + replyCount + ", preIdx=" + preIdx
				+ ", nextIdx=" + nextIdx + ", preTitle=" + preTitle + ", nextTitle=" + nextTitle + "]";
	}
}
