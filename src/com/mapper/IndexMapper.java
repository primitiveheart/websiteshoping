package com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.entity.User;

public interface IndexMapper {
	String getIndex();
	
	String getSecretKey();
}
