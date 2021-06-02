package conn;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class TimeDiff {
	// 오늘(현재)날짜와 DB의 날짜와의 시간 차이를 구하는 메소드...
	public int timeDiff(String wCdate) {
		
		// 1. 형식(202106021235)을 맞추기 위해서 문자로 오늘 날짜를 변환
		// 오늘 날짜를 문자로 추출
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String strToday = sdf.format(cal.getTime());
		
		// 2. 날짜 연산을 위해서 문자형식의 오늘날짜를 다시 날짜 형식으로 변환한다.
		Date today = null;
		try {
			today = sdf.parse(strToday);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		// 3. DB에 저장된 날짜(2021-06-02 12:35:25.0)를 '년월일시분초(20210602123525)'형식으로 추출
		// 0         1         2         3
		// 01234567890123456789012345678901234567890
		// 2021-06-02 12:35:25.0
		String strWCdate = wCdate.substring(0,4)+wCdate.substring(5,7)+wCdate.substring(8,10)+wCdate.substring(11,13)+wCdate.substring(14,16);
		
   	// 4. 날짜 연산을 위해서 DB에서 가져온 문자형식의 조합한 날짜를 다시 날짜 형식으로 변환한다.
		Date dateWdate = null;
		try {
			dateWdate = sdf.parse(strWCdate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		// 5. 날짜형식으로 변경된 두자료(today, dateWdate)를 숫자형식(getTime)으로 변경 비교한다.(형식은 ms이다.)
		// [오늘날짜(today) - DB날짜(dateWdate)]의 결과를 시간으로 변환....
		long diffTime = (today.getTime() - dateWdate.getTime()) / (60 * 60 * 1000); 
		int res = (int) diffTime;
		
		return res;
	}
}
