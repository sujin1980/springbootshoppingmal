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

	@NotNull
    private String imagePath;
 
    @NotNull
    private String filePath;

    @NotNull
    private String type;
    
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
 
    
}
