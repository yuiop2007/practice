package study.urlmapping;

public class UrlMappingVO {
	private int idx;
	private String name;
	private int age;
	
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
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	@Override
	public String toString() {
		return "UrlMappingVO [idx=" + idx + ", name=" + name + ", age=" + age + "]";
	}
}
