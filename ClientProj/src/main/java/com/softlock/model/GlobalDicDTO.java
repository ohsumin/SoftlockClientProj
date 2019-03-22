package com.softlock.model;

public class GlobalDicDTO {
	private String dic_id;
	private String dic_category;
	private String charc;
	private String title;
	private String dic_contents;
	private String code;
	private String engname;
	
	public GlobalDicDTO() {}
	
	public GlobalDicDTO(String dic_id, String dic_category, String charc, String title, String dic_contents,
			String code, String engname) {
		this.dic_id = dic_id;
		this.dic_category = dic_category;
		this.charc = charc;
		this.title = title;
		this.dic_contents = dic_contents;
		this.code = code;
		this.engname = engname;
	}
	
	public String getDic_id() {
		return dic_id;
	}
	public String getDic_category() {
		return dic_category;
	}
	public String getCharc() {
		return charc;
	}
	public String getTitle() {
		return title;
	}
	public String getDic_contents() {
		return dic_contents;
	}
	public String getCode() {
		return code;
	}
	public String getEngname() {
		return engname;
	}
	public void setDic_id(String dic_id) {
		this.dic_id = dic_id;
	}
	public void setDic_category(String dic_category) {
		this.dic_category = dic_category;
	}
	public void setCharc(String charc) {
		this.charc = charc;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setDic_contents(String dic_contents) {
		this.dic_contents = dic_contents;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public void setEngname(String engname) {
		this.engname = engname;
	}
	
	
	
	
	
}
