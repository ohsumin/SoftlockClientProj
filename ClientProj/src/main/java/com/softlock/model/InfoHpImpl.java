package com.softlock.model;

import java.util.ArrayList;

public interface InfoHpImpl {

	// 병원 회원정보 가져오기
	public HospitalDTO getHpInfo(String hp_idx);
	public ArrayList<TreattimeDTO> getHpTimeInfo(String treat_hp_idx, String treat_dy);
}
