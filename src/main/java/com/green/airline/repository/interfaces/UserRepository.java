package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;

import com.green.airline.dto.LoginFormDto;
import com.green.airline.repository.model.User;

@Mapper
public interface UserRepository {

	public User selectByIdAndPassword(LoginFormDto loginFormDto);
	
}
