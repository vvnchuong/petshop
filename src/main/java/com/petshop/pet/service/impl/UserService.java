package com.petshop.pet.service.impl;

import com.petshop.pet.domain.Role;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.*;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.mapper.UserMapper;
import com.petshop.pet.repository.RoleRepository;
import com.petshop.pet.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;

@Service
public class UserService {

    private final UserRepository userRepository;

    private final RoleRepository roleRepository;

    private final PasswordEncoder passwordEncoder;

    private final UserMapper userMapper;

    public UserService(UserRepository userRepository,
                       RoleRepository roleRepository,
                       PasswordEncoder passwordEncoder,
                       UserMapper userMapper){
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.userMapper = userMapper;
    }

    public Page<User> getAllUsers(Specification<User> spec,
                                  Pageable page){
        return userRepository.findAll(spec, page);
    }

    public User getUserById(long id){
        return userRepository.findById(id).
                orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));
    }

    public void createUser(AdminCreateUserDTO userDTO){

        validateUniqueUsernameAndEmail(userDTO.getUsername(), userDTO.getEmail());

        userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword()));

        User user = userMapper.fromAdminCreateDTO(userDTO);

        userRepository.save(user);
    }

    public void updateUserByAdmin(long id, AdminUpdateDTO adminUpdateDTO){
        User user = userRepository.findById(id)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));

        userMapper.fromAdminUpdateDTO(user, adminUpdateDTO);

        userRepository.save(user);
    }

    public void deleteUser(long id){
        userRepository.deleteById(id);
    }

    public User getUserByUserName(String username){
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new BusinessException(ErrorCode.USER_NOT_FOUND));
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
            throw new BusinessException(ErrorCode.OLD_PASSWORD_INCORRECT);

        if(!passwordDTO.getNewPassword().equals(passwordDTO.getConfirmPassword()))
            throw new BusinessException(ErrorCode.NEW_PASSWORD_MISMATCH);

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

        validateUniqueUsernameAndEmail(registerDTO.getUsername(), registerDTO.getEmail());

        if(!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())){
            throw new BusinessException(ErrorCode.PASSWORD_MISMATCH);
        }

        User user = userMapper.fromRegisterDTO(registerDTO);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        Role role = roleRepository.findByName("CUSTOMER");
        user.setRole(role);

        userRepository.save(user);
    }

    private void validateUniqueUsernameAndEmail(String username, String email){
        if (userRepository.existsByUsername(username))
            throw new BusinessException(ErrorCode.USER_ALREADY_EXISTS);
        if (userRepository.existsByEmail(email))
            throw new BusinessException(ErrorCode.EMAIL_ALREADY_EXISTS);
    }

}
