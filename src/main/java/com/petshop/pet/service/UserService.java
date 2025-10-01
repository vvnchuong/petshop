package com.petshop.pet.service;

import com.petshop.pet.domain.Role;
import com.petshop.pet.domain.User;
import com.petshop.pet.repository.RoleRepository;
import com.petshop.pet.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
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

    public List<User> getAllUsers(){
        return userRepository.findAll();
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
}
