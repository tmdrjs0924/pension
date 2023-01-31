package util;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class MyJob {

	public static String comma(int num) {
		DecimalFormat df=new DecimalFormat("#,###");
		return df.format(num);
	}
}