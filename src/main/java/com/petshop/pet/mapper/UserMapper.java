package com.petshop.pet.mapper;

import com.petshop.pet.domain.User;
import com.petshop.pet.domain.dto.AdminCreateUserDTO;
import com.petshop.pet.domain.dto.AdminUpdateDTO;
import com.petshop.pet.domain.dto.RegisterDTO;
import com.petshop.pet.domain.dto.UserUpdateDTO;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.time.Instant;

@Mapper(componentModel = "spring")
public interface UserMapper {

    UserUpdateDTO toUserDTO(User user);

    @Mapping(target = "avatarUrl", ignore = true)
    @Mapping(target = "role", ignore = true)
    User fromRegisterDTO(RegisterDTO registerDTO);

    User fromAdminCreateDTO(AdminCreateUserDTO adminCreateUserDTO);

    @AfterMapping
    default void setCreatedAt(@MappingTarget User user){
        if(user.getCreatedAt() == null){
            user.setCreatedAt(Instant.now());
        }
    }

    @Mapping(target = "email", ignore = true)
    @Mapping(target = "avatarUrl", ignore = true)
    void fromUpdateUser(@MappingTarget User user, UserUpdateDTO userUpdateDTO);

    @Mapping(target = "email", ignore = true)
    @Mapping(target = "avatarUrl", ignore = true)
    void fromAdminUpdateDTO(@MappingTarget User user, AdminUpdateDTO adminUpdateDTO);

    @AfterMapping
    default void setAvatarUrl(@MappingTarget User user, UserUpdateDTO userUpdateDTO){
        if(userUpdateDTO.getAvatarUrl() != null &&
                !userUpdateDTO.getAvatarUrl().isEmpty()){
            user.setAvatarUrl(userUpdateDTO.getAvatarUrl());
        }
    }

    @AfterMapping
    default void setAvatarAdminUrl(@MappingTarget User user, AdminUpdateDTO adminUpdateDTO){
        if(adminUpdateDTO.getAvatarUrl() != null &&
                !adminUpdateDTO.getAvatarUrl().isEmpty()){
            user.setAvatarUrl(adminUpdateDTO.getAvatarUrl());
        }
    }

    @AfterMapping
    default void setUpdatedAt(@MappingTarget User user){
        user.setUpdatedAt(Instant.now());
    }

}
