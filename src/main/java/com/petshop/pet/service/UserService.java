package com.petshop.pet.service;

import com.petshop.pet.domain.Role;
import com.petshop.pet.domain.User;
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

    public UserService(UserRepository userRepository,
                       RoleRepository roleRepository,
                       PasswordEncoder passwordEncoder){
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Page<User> getAllUsers(Specification<User> spec,
                                  Pageable page){
        return userRepository.findAll(spec, page);
    }

    public User getUserById(long id){
        return userRepository.findById(id).get();
    }

    public User createUser(User user){
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        Role role = roleRepository.findByName(user.getRole().getName());
        user.setRole(role);
        user.setCreatedAt(Instant.now());

        return userRepository.save(user);
    }

    public User updateUser(long id, User userUpdate){
        User user = userRepository.findById(id).get();
        user.setFullName(userUpdate.getFullName());
        user.setPhone(userUpdate.getPhone());
        user.setAddress(userUpdate.getAddress());
        user.setUpdatedAt(Instant.now());
        if(userUpdate.getAvatarUrl() != null)
            user.setAvatarUrl(userUpdate.getAvatarUrl());

        return userRepository.save(user);
    }

    public void deleteUser(long id){
        userRepository.deleteById(id);
    }

    public User getUserByUserName(String username){
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    public void updateUserByUser(String username, User userUpdate){
        User user = getUserByUserName(username);
        user.setFullName(userUpdate.getFullName());
        user.setPhone(userUpdate.getPhone());
        user.setAddress(userUpdate.getAddress());
        user.setAvatarUrl(userUpdate.getAvatarUrl());
        user.setUpdatedAt(Instant.now());

        userRepository.save(user);
    }

    public boolean changePasswordByUser(String oldPassword, String newPassword,
                                        String confirmPassword, String username) {

        User user = getUserByUserName(username);
        if(passwordEncoder.matches(oldPassword, user.getPassword())){
           if(newPassword.equals(confirmPassword)){
               user.setPassword(passwordEncoder.encode(newPassword));
           }else{
               return false;
           }
        }else{
            return false;
        }

        userRepository.save(user);

        return true;
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

}
