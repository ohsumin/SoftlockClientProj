package com.softlock.model;

import java.util.ArrayList;

public interface SearchHpImpl {

	// 진료과로 검색
	public ArrayList<HospitalDTO> searchHpType(String hp_type);
	// 병원이름으로 검색
	public ArrayList<HospitalDTO> searchHpName(String hp_name);
	// 야간진료병원 검색
	public ArrayList<HospitalDTO> searchHpNight();
	// 주말진료병원 검색
	public ArrayList<HospitalDTO> searchHpWeekend();
}
