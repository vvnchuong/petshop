package com.petshop.pet.service;

import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

public interface UserService {

    Page<User> getAllUsers(Specification<User> spec, Pageable page);

    User getUserById(long id);

    void createUser(AdminCreateUserDTO userDTO);

    void updateUserByAdmin(long id, AdminUpdateDTO adminUpdateDTO);

    void deleteUser(long id);

    User getUserByUserName(String username);

    UserUpdateDTO getUserUpdateDTO(String username);

    void updateUserByUser(String username, UserUpdateDTO userUpdate);

    void changePasswordByUser(ChangePasswordDTO passwordDTO, String username);

    void registerAccount(RegisterDTO registerDTO);

}
