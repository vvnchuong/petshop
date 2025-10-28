package com.petshop.pet.mapper;

import com.petshop.pet.domain.News;
import com.petshop.pet.domain.dto.NewsCreateDTO;
import com.petshop.pet.domain.dto.NewsUpdateDTO;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.time.Instant;
import java.time.LocalDateTime;

@Mapper(componentModel = "spring")
public interface NewsMapper {

    News toNews(NewsCreateDTO newsCreateDTO);

    @Mapping(target = "thumbnail", ignore = true)
    void updateNews(@MappingTarget News news, NewsUpdateDTO newsUpdateDTO);

    @AfterMapping
    default void setCreatedAt(@MappingTarget News news){
        if(news.getCreatedAt() == null)
            news.setCreatedAt(Instant.now());
    }

    @AfterMapping
    default void setUpdatedAt(@MappingTarget News news){
        news.setCreatedAt(Instant.now());
    }

    @AfterMapping
    default void setImageUrl(@MappingTarget News news,
                             NewsUpdateDTO newsUpdateDTO){
        if(newsUpdateDTO.getThumbnail() != null &&
                !newsUpdateDTO.getThumbnail().isEmpty()){
            news.setThumbnail(newsUpdateDTO.getThumbnail());
        }
    }

}
