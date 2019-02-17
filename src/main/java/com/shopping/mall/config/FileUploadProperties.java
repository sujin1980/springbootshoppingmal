package com.shopping.mall.config;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
 
/**
 * 书属性
 *
 * Created by bysocket on 27/09/2017.
 */
@Component
public class FileUploadProperties {
 
    /**
     * 书名
     */
    @Value("${file.upload.imagePath}")
    private String imagePath;
 
    /**
     * 作者
     */
    @Value("${file.upload.filePath}")
    private String filePath;

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
 
    
}
