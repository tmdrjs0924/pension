package util;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class MyJob {

	public static String comma(int num) {
		DecimalFormat df=new DecimalFormat("#,###");
		return df.format(num);
	}
	
	public static long getUntil(String adate, String bdate) {
		String[] imsi1=adate.split("-");
		String[] imsi2=bdate.split("-");
		
		int y1=Integer.parseInt(imsi1[0]);
		int m1=Integer.parseInt(imsi1[1]);
		int d1=Integer.parseInt(imsi1[2]);
		
		int y2=Integer.parseInt(imsi2[0]);
		int m2=Integer.parseInt(imsi2[1]);
		int d2=Integer.parseInt(imsi2[2]);
		
		LocalDate aday=LocalDate.of(y1, m1, d1);
		LocalDate bday=LocalDate.of(y2, m2, d2);
		
		long num=aday.until(bday, ChronoUnit.DAYS);
		
		return num;
	}
}