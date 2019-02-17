package com.shopping.mall.config;


import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;
 
import javax.validation.constraints.NotNull;
 
/**
 * 书属性
 *
 */
@Component
@ConfigurationProperties(prefix = "file.upload")
@Validated
public class FileUploadComponent {
 
    /**
     * 书名
     */
	@NotNull
    private String imagePath;
 
    /**
     * 作者
     */
    @NotNull
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
