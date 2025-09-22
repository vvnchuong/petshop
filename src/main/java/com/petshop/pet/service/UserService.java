package com.petshop.pet.service;

import com.petshop.pet.domain.User;
import com.petshop.pet.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository,
                       PasswordEncoder passwordEncoder){
        this.userRepository = userRepository;
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

       return userRepository.save(user);
    }

    public User updateUser(long id, User userUpdate){
        User user = userRepository.findById(id).get();
        user.setFullName(userUpdate.getFullName());
        user.setPhone(userUpdate.getPhone());
        user.setAddress(userUpdate.getAddress());
        return userRepository.save(user);
    }

    public void deleteUser(long id){
        userRepository.deleteById(id);
    }

}
