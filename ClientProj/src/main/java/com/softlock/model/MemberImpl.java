package com.softlock.model;

import org.apache.ibatis.annotations.Param;

public interface MemberImpl {
	
	// 일반회원 회원가입
	public void memjoinAction(String mem_id, String mem_pw, String mem_name, String mem_birth, 
			String mem_phone, String mem_gender, String mem_email);

	// 로그인 처리를 위한 추상메소드
	public MemberDTO login(String id, String pass);
	
	// 회원 존재여부 확인
	public int isUser(String id, String pw);
	
	// 회원아이디 중복여부 확인
	public int isUserId(String id);
	
	//수정하기 폼 진입
	public MemberDTO view(String mem_id);
	
	//수정하기 처리
	public int modifyAction(String mem_pw, String mem_phone, String mem_name, String mem_id);
	
	//회원탈퇴 처리
	public int delete(String mem_id);
	
	int GetKey(String mem_id, String mem_key); //유저 인증키 생성 메서드
	int alter_userKey(String mem_id, String key);// 유저 인증키 Y로 바꿔주는 메서드
	
	// 네이버회원 mem_auth를 y로 처리
	public void alter_naverKey(String mem_id);
	
	String searchId(@Param("mem_name")String mem_name, @Param("mem_phone")String mem_phone);

	public MemberDTO userInfo(String mem_id); // 유저 ID 찾기
	int searchPassword(String mem_id, String mem_email, String key); // 회원 임시 비밀번호 변경 메서드
	
	
}
