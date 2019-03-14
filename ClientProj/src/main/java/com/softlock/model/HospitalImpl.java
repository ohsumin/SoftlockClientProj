package com.softlock.model;

import java.util.ArrayList;
import java.util.List;

public interface HospitalImpl{
	
	//실시간검색
	public List<HospListDTO> searchHp(String searchStr);
	
	// 병원회원 회원가입
    public ArrayList<HospitalDTO> hpjoinAction(String hp_id, String hp_pw, String hp_name, String hp_num, String hp_username, String hp_email, 
          String hp_phone, String hp_address);
    
    // 회원아이디 중복여부 확인
    public int isUserId(String id);
}
