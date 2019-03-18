package com.softlock.model.utilMem;

import javax.servlet.jsp.JspWriter;

public class JavascriptUtil {

	//문자열만 반환하고 JSP페이지에서 출력하는 방식. 반환타입은
	//String 타입임.
	public static String jsAlertLocation(String msg,
			String url) {
		String str = ""
				+ "<script>"
				+ " alert('"+msg+"'); "
				+ " location.href='"+url+"'; "
				+ "</script>";
		return str;
	}
	public static String jsAlertBack(String msg) {
		
		String str = ""
				+ "<script>"
				+ " alert('"+msg+"'); "
				+ " history.back(); "
				+ "</script>";
		return str;
	}
	
	//출력까지 처리하는 방식. 메소드내에서 출력을 진행하므로 별도의
	//반환값은 없음. 단, 출력을 위한 매개변수 out내장객체를 전달받음
	//out 내장객체는 JspWriter타입을 가진다.
	public static void jsAlertLocation(String msg,
			String url, JspWriter out) {
		try {
		String str = ""
				+ "<script>"
				+ " alert('"+msg+"'); "
				+ " location.href='"+url+"'; "
				+ "</script>";
		out.println(str);
		}
		catch(Exception e) {}
	}
	public static void jsAlertBack(String msg
			, JspWriter out) {
		
		try {
			String str = ""
					+ "<script>"
					+ " alert('"+msg+"'); "
					+ " history.back(); "
					+ "</script>";
			out.println(str);
			}
			catch(Exception e) {}
	}
	
}
