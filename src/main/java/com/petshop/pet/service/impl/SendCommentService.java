package com.petshop.pet.service.impl;

import com.petshop.pet.domain.dto.SendCommentDTO;
import com.petshop.pet.service.EmailService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class SendCommentService {

    private final EmailService emailService;

    @Value("${app.email-comment}")
    private String email;

    public SendCommentService(EmailService emailService){
        this.emailService = emailService;
    }

    public void sendComment(SendCommentDTO sendCommentDTO){
        String subject = "Phản hồi bài viết";
        String text = "Bài viết: " + sendCommentDTO.getNews().getTitle() +"\n" +
                "Tên người gửi: " + sendCommentDTO.getName() + "\n" +
                "Email: " + sendCommentDTO.getEmail() + "\n" +
                "Nội dung: " + sendCommentDTO.getContent();

        emailService.sendSimpleMessage(email, subject, text);
    }

}
