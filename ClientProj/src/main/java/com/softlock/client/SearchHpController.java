package com.softlock.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SearchHpController {
	
	@RequestMapping("/member/searchHp")
	public String searchHp() {
		
		return "member/search_hp";
	}
}
