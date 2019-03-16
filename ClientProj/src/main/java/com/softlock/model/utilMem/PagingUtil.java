package com.softlock.model.utilMem;

import org.omg.CORBA.Request;

public class PagingUtil {
	//페이지번호와 페이지블럭 이미지를 같이 출력
		//해주는 메소드
		public static String pagingImg(
			int totalRecordCount, int pageSize, int blockPage,
			int nowPage, String page, String tab) {
			
			String pagingStr = "";
			
			//1.전체페이지 구하기
			int totalPage = 
			(int)(Math.ceil(((double)totalRecordCount/pageSize)));
			
			/*2.현재페이지번호를 통해 이전 페이지블럭에
			해당하는 페이지를 구한다.

			blockPage=5
			nowPage=1~5일때 => 1
			nowPage=6~10 => 6
			
			
			<li class="page-item">
              <a class="page-link" href="#" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                  <span class="sr-only">Previous</span>
              </a>
          </li>
			*/
			int intTemp = 
				(((nowPage-1) / blockPage) * blockPage) + 1;
			
			//3.처음페이지 바로가기 & 이전페이지블럭 바로가기
			System.out.println("nowPage="+nowPage);
			if(nowPage == 1) {
				//첫번째 페이지 블럭에서는 출력되지 않음
				//두번째 페이지 블럭부터 출력됨.
				pagingStr += ""
						+ "<li class=\"page-item\">\r\n" + 
						"              <a class=\"page-link\" href='"+page+"tab="+tab+"&nowPage=1'aria-label=\"Previous\">\r\n" + 
								"                  <span aria-hidden=\"true\">&laquo;</span>\r\n" + 
								"                  <span class=\"sr-only\">Previous</span>\r\n" + 
								"              </a>\r\n" + 
								"          </li>";
			} else {
				pagingStr += ""
						+ "<li class=\"page-item\">\r\n" + 
						"              <a class=\"page-link\" href='"+page+"tab="+tab+"&nowPage="+ (nowPage-1) +"'aria-label=\"Previous\">\r\n" + 
								"                  <span aria-hidden=\"true\">&laquo;</span>\r\n" + 
								"                  <span class=\"sr-only\">Previous</span>\r\n" + 
								"              </a>\r\n" + 
								"          </li>";
			}
			
			//페이지표시 제어를 위한 변수
			int blockCount = 1;
			/*
			4.페이지를 뿌려주는 로직 : blockPage의 수만큼 또는
				마지막페이지가 될때까지 페이지를 출력한다.
			*/
			while(blockCount<=blockPage && intTemp<=totalPage)
			{
				if(intTemp==nowPage) {
					pagingStr +=  "<li class=\"page-item\"><a class=\"page-link\" href='"+page
							+"tab="+tab+"&nowPage="+intTemp+"'>"+
							intTemp+"</a></li>";
				}
				else {
					pagingStr += "<li class=\"page-item\"><a class=\"page-link\" href='"+page
						+"tab="+tab+"&nowPage="+intTemp+"'>"+
						intTemp+"</a></li>";
				}
				intTemp++;
				blockCount++;
			}
			
			//5.다음페이지블럭 & 마지막페이지 바로가기
			if(nowPage == totalPage) {
				pagingStr += "<li class=\"page-item\">\r\n" + 
						"              <a class=\"page-link\" href='"+page+"tab="+tab+"&nowPage="+totalPage+"'aria-label=\"Next\">\r\n" + 
								"                  <span aria-hidden=\"true\">&raquo;</span>\r\n" + 
								"                  <span class=\"sr-only\">Next</span>\r\n" + 
								"              </a>\r\n" + 
								"          </li>";
			} else {
				pagingStr += "<li class=\"page-item\">\r\n" + 
						"              <a class=\"page-link\" href='"+page+"tab="+tab+"&nowPage="+ (nowPage+1) +"'aria-label=\"Next\">\r\n" + 
						"                  <span aria-hidden=\"true\">&raquo;</span>\r\n" + 
						"                  <span class=\"sr-only\">Next</span>\r\n" + 
						"              </a>\r\n" + 
						"          </li>";
			}		
			return pagingStr;
		}
		
		public static String pagingImgServlet(
				int totalRecordCount, int pageSize, int blockPage,
				int nowPage, String page) {
			
			String pagingStr = "";
			
			//1.전체페이지 구하기
			int totalPage = 
					(int)(Math.ceil(((double)totalRecordCount/pageSize)));
			
			/*2.현재페이지번호를 통해 이전 페이지블럭에
			해당하는 페이지를 구한다.

			blockPage=5
			nowPage=1~5일때 => 1
			nowPage=6~10 => 6
			 */
			int intTemp = 
					(((nowPage-1) / blockPage) * blockPage) + 1;
			
			//3.처음페이지 바로가기 & 이전페이지블럭 바로가기
			if(intTemp != 1) {
				//첫번째 페이지 블럭에서는 출력되지 않음
				//두번째 페이지 블럭부터 출력됨.
				pagingStr += ""
						+ "<li><a href='"+page+"nowPage=1'>"
						+ "<span class='glyphicon glyphicon-hand-left'></span></a></li>";
				
				pagingStr += ""
						+ "<li><a href='"+page+"nowPage="+
						(intTemp-blockPage)+"'>"
						+ "<span class='glyphicon glyphicon-fast-backward'></span></a></li>";
			}
			
			//페이지표시 제어를 위한 변수
			int blockCount = 1;
			/*
			4.페이지를 뿌려주는 로직 : blockPage의 수만큼 또는
				마지막페이지가 될때까지 페이지를 출력한다.
			 */
			while(blockCount<=blockPage && intTemp<=totalPage)
			{
				if(intTemp==nowPage) {
					//현제페이지를 표시하는 부분
					pagingStr += "<li class='active'><a href='#'>"+intTemp+"</a></li>";
				}
				else {
					//나머지 페이지를 표시하는 부분
					pagingStr += "<li><a href='"+page
							+"nowPage="+intTemp+"'>"+
							intTemp+"</a></li>";
				}
				intTemp++;
				blockCount++;
			}
			
			//5.다음페이지블럭 & 마지막페이지 바로가기
			/*
			 <li class="page-item">
              <a class="page-link" href="#" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                  <span class="sr-only">Next</span>
              </a>
          </li>
			
			 */
			
			//5.다음페이지블럭 & 마지막페이지 바로가기
			if(intTemp <= totalPage) {
				pagingStr += "<li><a href='"+page+"nowPage="+intTemp+"'>"
						+ "<span class='glyphicon glyphicon-fast-forward'></span></a></li>";
				
				pagingStr += "<li><a href='"+page+"nowPage="+totalPage+"'>"
						+ "<span class='glyphicon glyphicon-hand-right'></span></a></li>";
			}		
			
			return pagingStr;
		}

}
