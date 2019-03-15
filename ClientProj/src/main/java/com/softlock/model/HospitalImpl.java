package com.softlock.model;

import java.util.ArrayList;
import java.util.List;

public interface HospitalImpl{
	//실시간검색
	public List<HospListDTO> searchHp(String searchStr);
	
	public List<HospListDTO> searchHp(HospListDTO hDto);
	
	// 병원회원 회원가입
    public ArrayList<HospitalDTO> hpjoinAction(String hp_id, String hp_pw, String hp_name, String hp_num, String hp_username, String hp_email, 
          String hp_phone, String hp_address);
    
    // 회원아이디 중복여부 확인
    public int isUserId(String id);
    
    // 회원 존재여부 확인
  	public int isUser(String id, String pw);
     
	//병원회원 로그인 추상메소드
	public HospitalDTO login(String id, String pass);
 
     //회원탈퇴 처리
   	public int delete(String mem_id);
   	
   	//수정하기 폼 진입
   	public HospitalDTO view(String hp_id);
   	
   	//수정하기 처리
   	public int modifyAction(String hp_pw, String hp_phone, String hp_name, String hp_id);
}
