package com.softlock.model;

public class PagingUtil {
   public static String pagingImg(int totalRecordCount,
         int pageSize, 
         int blockPage, 
         int nowPage, 
         String page ,String tab){

      String pagingStr="";
      
      //1.전체페이지 구하기
      int totalPage =
         (int)(Math.ceil(((double)totalRecordCount/pageSize)));
      
      //현재페이지를 통해 이전 페이지블럭에 해당하는 페이지를 구함
      int intTemp = 
         ((nowPage-1) / blockPage) * blockPage + 1;
      
            //처음페이지 & 이전페이지를 위한 로직
      if(nowPage == 1) {
            //첫번째 페이지 블럭에서는 출력되지 않음
            //두번째 페이지 블럭부터 출력됨.
            pagingStr += ""
                  + "<li class=\"page-item\">\r\n" + 
                  "              <a class=\"page-link\" href='"+page+"tab=1&nowPage=1'aria-label=\"Previous\">\r\n" + 
                        "                  <span aria-hidden=\"true\">&laquo;</span>\r\n" + 
                        "                  <span class=\"sr-only\">Previous</span>\r\n" + 
                        "              </a>\r\n" + 
                        "          </li>";
         } else {
            pagingStr += ""
                  + "<li class=\"page-item\">\r\n" + 
                  "              <a class=\"page-link\" href='"+page+"tab=1&nowPage="+ (nowPage-1) +"'aria-label=\"Previous\">\r\n" + 
                        "                  <span aria-hidden=\"true\">&laquo;</span>\r\n" + 
                        "                  <span class=\"sr-only\">Previous</span>\r\n" + 
                        "              </a>\r\n" + 
                        "          </li>";
         }
      
      //페이지표시 제어를 위한 변수
      int blockCount = 1;
      
      //페이지를 뿌려주는 로직 : 블럭페이지 수만큼 혹은 마지막
      //페이지가 될때까지 페이지를 표시한다.
      while(blockCount<=blockPage && intTemp<=totalPage)
        {
           if(intTemp==nowPage) {
              pagingStr +=  "<li class=\"page-item\"><a class=\"page-link\" href='"+page
                    +"tab=1&nowPage="+intTemp+"'>"+
                    intTemp+"</a></li>";
           }
           else {
              pagingStr += "<li class=\"page-item\"><a class=\"page-link\" href='"+page
                 +"tab=1&nowPage="+intTemp+"'>"+
                 intTemp+"</a></li>";
           }
           intTemp++;
           blockCount++;
        }
      
      //다음 및 마지막 페이지를 위한 로직
       if(nowPage == totalPage) {
               pagingStr += "<li class=\"page-item\">\r\n" + 
                     "              <a class=\"page-link\" href='"+page+"tab=1&nowPage="+totalPage+"'aria-label=\"Next\">\r\n" + 
                           "                  <span aria-hidden=\"true\">&raquo;</span>\r\n" + 
                           "                  <span class=\"sr-only\">Next</span>\r\n" + 
                           "              </a>\r\n" + 
                           "          </li>";
         } else {
            pagingStr += "<li class=\"page-item\">\r\n" + 
                  "              <a class=\"page-link\" href='"+page+"tab=1&nowPage="+ (nowPage+1) +"'aria-label=\"Next\">\r\n" + 
                  "                  <span aria-hidden=\"true\">&raquo;</span>\r\n" + 
                  "                  <span class=\"sr-only\">Next</span>\r\n" + 
                  "              </a>\r\n" + 
                  "          </li>";
         }
      System.out.println("pagingStr="+pagingStr);
      return pagingStr;
   }   
}