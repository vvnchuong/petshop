package com.petshop.pet.service.impl;

import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import jakarta.servlet.ServletContext;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class UploadService {

    private final ServletContext servletContext;

    public UploadService(ServletContext servletContext){
        this.servletContext = servletContext;
    }

    public String handleUploadFile(MultipartFile file,
                                   String targetFolder,
                                   boolean required) {
        // 1. Kiểm tra có file không
        if (file == null || file.isEmpty()) {
            if(required) {
                throw new BusinessException(ErrorCode.IMAGE_NOT_SELECTED);
            }else{
                return null;
            }
        }

        // 2. Kiểm tra kiểu file (chỉ cho phép ảnh)
        String contentType = file.getContentType();
        if (contentType == null ||
                !(contentType.equals("image/jpg") ||
                        contentType.equals("image/jpeg") ||
                        contentType.equals("image/png"))) {
            throw new BusinessException(ErrorCode.INVALID_IMAGE_FORMAT);
        }

        // 3. Kiểm tra đuôi file để an toàn hơn
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null) originalFilename = "file";
        String lowerCase = originalFilename.toLowerCase();
        if (!(lowerCase.endsWith(".jpg") || lowerCase.endsWith(".jpeg") ||
                lowerCase.endsWith(".png"))) {
            throw new BusinessException(ErrorCode.INVALID_IMAGE_FORMAT);
        }

        // 4. Xử lý lưu file
        String rootPath = servletContext.getRealPath("/resources/admin/images");
        File dir = new File(rootPath + File.separator + sanitizeFolder(targetFolder));
        if (!dir.exists()) dir.mkdirs();

        String finalName = System.currentTimeMillis() + "-" + sanitizeFilename(originalFilename);
        File serverFile = new File(dir, finalName);

        try (BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile))) {
            file.getInputStream().transferTo(stream);
        } catch (IOException e) {
            throw new BusinessException(ErrorCode.IMAGE_UPLOAD_FAILED);
        }

        return finalName;
    }

    private String sanitizeFilename(String filename) {
        return filename.replaceAll("[^a-zA-Z0-9\\.\\-\\_]", "_");
    }

    private String sanitizeFolder(String folder) {
        if (folder == null || folder.isEmpty()) return "default";
        return folder.replaceAll("[^a-zA-Z0-9\\-\\_]", "_");
    }

}
