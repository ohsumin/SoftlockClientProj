package com.softlock.client;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softlock.model.AndroidImpl;

@Controller
public class AndroidController {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping("/Android/join")
	@ResponseBody
	public Map<String, Object> join(HttpServletRequest req){
		
		String mem_id = req.getParameter("mem_id"); 
		String mem_pw = req.getParameter("mem_pw");
		String mem_name = req.getParameter("mem_name");
		String mem_phone = req.getParameter("mem_phone");
		String mem_gender = req.getParameter("mem_gender");
		String mem_email = req.getParameter("mem_email");
		String mem_birth_year = req.getParameter("mem_birth_year"); 
		String mem_birth_month =  req.getParameter("mem_birth_month");
		String mem_birth_day = req.getParameter("mem_birth_day");
		String mem_birth = mem_birth_year+mem_birth_month+mem_birth_day;
		String mem_auth = req.getParameter("mem_auth");
		
		System.out.println(mem_birth_year);
		System.out.println(mem_birth_month);
		System.out.println(mem_birth_day);
		System.out.println(mem_birth);
				
		Map<String, Object> map = new HashMap<String, Object>();

		sqlSession.getMapper(AndroidImpl.class).memjoinAction(mem_id, mem_pw, mem_name, mem_birth, mem_phone, mem_gender, mem_email, mem_auth);
		
		map.put("isSuccess", "success");
		return map; 
	}
}
