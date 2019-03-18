package com.softlock.model;

public class ReviewDTO {
	private int rvw_idx;
	private int rvw_mem_idx;
	private int rvw_hp_idx;
	private int rvw_score;
	private String rvw_content;
	private String rvw_regidate;
	

	public ReviewDTO() {
	
	}
	
	
	public ReviewDTO(int rvw_idx, int rvw_mem_idx, int rvw_hp_idx, int rvw_score, String rvw_content,
			String rvw_regidate) {
		super();
		this.rvw_idx = rvw_idx;
		this.rvw_mem_idx = rvw_mem_idx;
		this.rvw_hp_idx = rvw_hp_idx;
		this.rvw_score = rvw_score;
		this.rvw_content = rvw_content;
		this.rvw_regidate = rvw_regidate;
	}
	public int getRvw_idx() {
		return rvw_idx;
	}
	public void setRvw_idx(int rvw_idx) {
		this.rvw_idx = rvw_idx;
	}
	public int getRvw_mem_idx() {
		return rvw_mem_idx;
	}
	public void setRvw_mem_idx(int rvw_mem_idx) {
		this.rvw_mem_idx = rvw_mem_idx;
	}
	public int getRvw_hp_idx() {
		return rvw_hp_idx;
	}
	public void setRvw_hp_idx(int rvw_hp_idx) {
		this.rvw_hp_idx = rvw_hp_idx;
	}
	public int getRvw_score() {
		return rvw_score;
	}
	public void setRvw_score(int rvw_score) {
		this.rvw_score = rvw_score;
	}
	public String getRvw_content() {
		return rvw_content;
	}
	public void setRvw_content(String rvw_content) {
		this.rvw_content = rvw_content;
	}
	public String getRvw_regidate() {
		return rvw_regidate;
	}
	public void setRvw_regidate(String rvw_regidate) {
		this.rvw_regidate = rvw_regidate;
	}
	
	
	
}
