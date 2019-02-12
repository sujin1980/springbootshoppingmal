package com.shopping.mall.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
	public static String cutTabReturn(String str) {
		if(str == null) {
			return str;
		}
		
    	Pattern p = Pattern.compile("\t|\r|\n");
    	Matcher m = p.matcher(str);
    	str = m.replaceAll("");
    	return str.trim();
	}
}
