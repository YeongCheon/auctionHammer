package util;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileUpload {
	HttpServletRequest request;
	MultipartRequest multi;

	public FileUpload(HttpServletRequest request) {
		this.request = request;
		
		String realPath = request.getSession().getServletContext().getRealPath("upload");
		
		//String realFolder = "/home/yckim/auctionHammerUpload/";
		String encType = "UTF-8";
		int maxSize = 1024 * 1024 * 5;
		
		try {
			this.multi = new MultipartRequest(request, realPath, maxSize,
					encType, new DefaultFileRenamePolicy());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public MultipartRequest getMultipartRequest(){
		return this.multi;
	}

	public String upload() throws Exception {
		String filename1 = null;
		try {
			
			Enumeration<?> files = multi.getFileNames();
			String file1 = (String) files.nextElement();
			filename1 = multi.getFilesystemName(file1);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// String fullpath = realFolder + filename1;
		// System.out.println(fullpath);
		return "http://" + "211.208.174.69" + ":" + request.getServerPort()
				+ request.getContextPath() + "/upload/" + filename1;
	}
}
