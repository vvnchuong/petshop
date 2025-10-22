package com.petshop.pet.service;

import com.petshop.pet.domain.PasswordResetToken;
import com.petshop.pet.domain.Role;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.*;
import com.petshop.pet.mapper.UserMapper;
import com.petshop.pet.repository.PasswordResetTokenRepository;
import com.petshop.pet.repository.RoleRepository;
import com.petshop.pet.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.UUID;

@Service
public class UserService {

    private final UserRepository userRepository;

    private final RoleRepository roleRepository;

    private final PasswordEncoder passwordEncoder;

    private final UserMapper userMapper;

    private final PasswordResetTokenRepository tokenRepository;

    private final EmailService emailService;

    private final long EXPIRATION_MINUTES = 30;

    private static final String DEFAULT_AVATAR = "7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg";

    @Value("${app.reset-password.base-url}")
    private String resetPasswordBaseUrl;

    public UserService(UserRepository userRepository,
                       RoleRepository roleRepository,
                       PasswordEncoder passwordEncoder,
                       UserMapper userMapper,
                       PasswordResetTokenRepository tokenRepository,
                       EmailService emailService){
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.userMapper = userMapper;
        this.tokenRepository = tokenRepository;
        this.emailService = emailService;
    }

    public Page<User> getAllUsers(Specification<User> spec,
                                  Pageable page){
        return userRepository.findAll(spec, page);
    }

    public User getUserById(long id){
        return userRepository.findById(id).
                orElseThrow(() -> new RuntimeException("User not found"));
    }

    public void createUser(AdminCreateUserDTO userDTO){

        if(userRepository.findByUsername(userDTO.getUsername())
                .isPresent()){
            throw new RuntimeException("User already exists");
        }

        if(userRepository.findByEmail(userDTO.getEmail()).isPresent()){
            throw new RuntimeException("Email already exists");
        }

        userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword()));

        if(userDTO.getAvatarUrl().isEmpty())
            userDTO.setAvatarUrl(DEFAULT_AVATAR);

        User user = userMapper.fromAdminCreateDTO(userDTO);

        userRepository.save(user);
    }

    public void updateUserByAdmin(long id, AdminUpdateDTO adminUpdateDTO){
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));

        userMapper.fromAdminUpdateDTO(user, adminUpdateDTO);

        userRepository.save(user);
    }

    public void deleteUser(long id){
        userRepository.deleteById(id);
    }

    public User getUserByUserName(String username){
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    public UserUpdateDTO getUserUpdateDTO(String username){
        User user = getUserByUserName(username);

        return userMapper.toUserDTO(user);
    }

    public void updateUserByUser(String username, UserUpdateDTO userUpdate){
        User user = getUserByUserName(username);

        userMapper.fromUpdateUser(user, userUpdate);

        userRepository.save(user);
    }

    public void changePasswordByUser(ChangePasswordDTO passwordDTO, String username) {
        User user = getUserByUserName(username);

        if (!passwordEncoder.matches(passwordDTO.getOldPassword(), user.getPassword()))
            throw new RuntimeException("Old password is incorrect");

        if(!passwordDTO.getNewPassword().equals(passwordDTO.getConfirmPassword()))
            throw new RuntimeException("New password and confirmation do not match");

        user.setPassword(passwordEncoder.encode(passwordDTO.getNewPassword()));

        userRepository.save(user);
    }

    public long countTotalUsers(){
        return userRepository.count();
    }

    public long countNewUsersToday(){
        Instant startOfToday = LocalDate.now(ZoneId.of("Asia/Ho_Chi_Minh"))
                .atStartOfDay(ZoneId.of("Asia/Ho_Chi_Minh"))
                .toInstant();
        return userRepository.countByCreatedAtAfter(startOfToday);
    }

    public void registerAccount(RegisterDTO registerDTO) {

        if(userRepository.findByUsername(registerDTO.getUsername())
                .isPresent()){
            throw new RuntimeException("User already exists");
        }

        if(userRepository.findByEmail(registerDTO.getEmail()).isPresent()){
            throw new RuntimeException("Email already exists");
        }

        if(!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())){
            throw new RuntimeException("Password and confirm password do not match");
        }

        User user = userMapper.fromRegisterDTO(registerDTO);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        Role role = roleRepository.findByName("CUSTOMER");
        user.setRole(role);

        user.setAvatarUrl(DEFAULT_AVATAR);

        userRepository.save(user);
    }

    @Transactional
    public void generateResetToken(String email){
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

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
                .orElseThrow(() -> new RuntimeException("Token Invalid"));

        if(prt.isExpired()){
            tokenRepository.delete(prt);
            throw new RuntimeException("Token has expired");
        }

        User user = prt.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        tokenRepository.delete(prt);
    }

}
