package com.petshop.pet.service;

import com.petshop.pet.domain.Role;
import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.AdminCreateUserDTO;
import com.petshop.pet.domain.dto.ChangePasswordDTO;
import com.petshop.pet.domain.dto.RegisterDTO;
import com.petshop.pet.domain.dto.UserUpdateDTO;
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
import java.util.List;

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
        return userRepository.findById(id).get();
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

        Role role = roleRepository.findByName(userDTO.getRole().getName());
        userDTO.setRole(role);

        String avatar = "7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg";
        if(userDTO.getAvatarUrl().isEmpty()){
            userDTO.setAvatarUrl(avatar);
        }

        User user = userMapper.fromAdminCreateDTO(userDTO);

        userRepository.save(user);
    }

    public void updateUser(long id, UserUpdateDTO userUpdate){
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));

        userMapper.updateUser(user, userUpdate);

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

        userMapper.updateUser(user, userUpdate);

        userRepository.save(user);
    }

    public void changePasswordByUser(ChangePasswordDTO passwordDTO, String username) {
        User user = getUserByUserName(username);

        if(user == null)
            throw new RuntimeException("User not found");

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

        String avatar = "7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg";
        user.setAvatarUrl(avatar);

        userRepository.save(user);
    }

}
