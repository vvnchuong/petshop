package com.petshop.pet.service.impl;

import com.petshop.pet.domain.PasswordResetToken;
import com.petshop.pet.domain.User;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.repository.PasswordResetTokenRepository;
import com.petshop.pet.repository.UserRepository;
import com.petshop.pet.service.EmailService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class PasswordRecoveryService {

    private final UserRepository userRepository;

    private final PasswordResetTokenRepository tokenRepository;

    private final EmailService emailService;

    private final PasswordEncoder passwordEncoder;

    @Value("${expiration-time-minutes}")
    private long EXPIRATION_MINUTES;

    @Value("${app.reset-password.base-url}")
    private String resetPasswordBaseUrl;

    public PasswordRecoveryService(UserRepository userRepository,
                                   PasswordResetTokenRepository tokenRepository,
                                   EmailService emailService,
                                   PasswordEncoder passwordEncoder){
        this.userRepository = userRepository;
        this.tokenRepository = tokenRepository;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
    }


    @Transactional
    public void generateResetToken(String email){
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));

        String token = UUID.randomUUID().toString();

        PasswordResetToken prt = PasswordResetToken.builder()
                .token(token)
                .user(user)
                .expiryDate(LocalDateTime.now().plusMinutes(EXPIRATION_MINUTES))
                .build();

        tokenRepository.save(prt);

        String resetLink = resetPasswordBaseUrl + token;

        String subject = "Đặt lại mật khẩu";
        String text = "Yêu cầu đặt lại mật khẩu.\n\n" +
                "Bấm vào link sau để đặt lại mật khẩu (có hiệu lực " + EXPIRATION_MINUTES + " phút):\n" +
                resetLink + "\n\n" +
                "Nếu bạn không yêu cầu, hãy bỏ qua email này.";

        emailService.sendSimpleMessage(user.getEmail(), subject, text);
    }

    @Transactional
    public void resetPassword(String token, String newPassword){
        PasswordResetToken prt = tokenRepository.findByToken(token)
                .orElseThrow(() -> new BusinessException(ErrorCode.TOKEN_INVALID));

        if(prt.isExpired()){
            tokenRepository.delete(prt);
            throw new BusinessException(ErrorCode.TOKEN_EXPIRED);
        }

        User user = prt.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        tokenRepository.delete(prt);
    }

}
