package util;

public class PageNumber {
	public String[] createPageNumber(int blockSize, int nowPage,
			int totalRecordCnt, int showRecordCnt, String pageName) {
		// blockSize : 출력할 페이지 갯수
		// nowPage : 현재 페이지
		// pageName : viewPage 이름
		// totalRecordCnt : record 총 갯수
		// showRecordCnt : 한 페이지에 보여줄 record 갯수

		String result[] = null;
		int page_min =(nowPage <= blockSize || nowPage / blockSize == 0?1:(nowPage)/blockSize*blockSize+1);
		//System.out.println("page min : " + page_min);
		int page_max = (int)(Math.ceil((double)totalRecordCnt / (double)showRecordCnt));
		//System.out.println("temp page max : " + page_max);
		
		if(nowPage <= blockSize && page_max > blockSize){
			page_max = blockSize;
			//System.out.println("active1");
		} else if(nowPage/blockSize*blockSize + blockSize < page_max){
			page_max = nowPage/blockSize*blockSize + blockSize;
			//System.out.println("active2");
		}
		//System.out.println("page max : " + page_max);
		
		
		int cnt=0;
		if(page_min < blockSize && page_max - page_min + 1 >= blockSize){
			result = new String[blockSize + 1];
			result[result.length - 1] = "<a href='" + pageName + "?pageNum=" + (page_max+1) + "'>▶</a>";
			cnt=0;
		} else if(page_max % blockSize != 0 && page_min != 1){
			result = new String[page_max - page_min + 1 + 1];
			result[0] = "<a href='" + pageName + "?pageNum=" + (page_min-1) + "'>◀</a>";
			cnt=1;			
		} else if(page_max - page_min + 1 >= blockSize){
			result = new String[blockSize + 2];
			result[0] = "<a href='" + pageName + "?pageNum=" + (page_min-1) + "'>◀</a>";
			result[result.length - 1] = "<a href='" + pageName + "?=pageNum=" + (page_max+1) + "'>▶</a>";
			cnt=1;
		} else{
			result = new String[page_max - page_min + 1];
			cnt=0;
		}
		
		for(int i = page_min; i<=page_max; i++){
			if(i == nowPage){
				result[cnt] = "<a href='" + pageName + "?pageNum=" + i + "'><b>"+i+"</b></a>";
			} else{
				result[cnt] = "<a href='" + pageName + "?pageNum=" + i + "'>"+i+"</a>";
			}
			cnt++;
		}
		
		
		return result;
	}
}
