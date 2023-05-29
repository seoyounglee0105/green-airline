package com.green.airline.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.green.airline.repository.model.Member;
import com.green.airline.service.UserService;

@RestController
public class MemberApiController {

	@Autowired
	private UserService userService;

	@GetMapping("/existsById")
	public boolean existsById(@RequestParam String id) {
		Member memberId = userService.readById(id);
		if (memberId == null) {
			return true;
		} else {
			return false;
		}

	}

}
