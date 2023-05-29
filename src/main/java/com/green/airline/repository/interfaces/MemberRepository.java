package com.green.airline.repository.interfaces;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.SocialJoinFormDto;
import com.green.airline.repository.model.Member;

@Mapper
public interface MemberRepository {

	public Member selectById(String id);

	// 카카오 로그인 api에 쓸 것
	public SocialDto selectBySocialUserInfo(String id);

	// 일반 회원가입 처리
	public int insertMember(JoinFormDto joinFormDto);
	// 소셜 회원가입 처리
	public int insertSocialMember(SocialJoinFormDto socialJoinFormDto);
	
	// ??
	// 소셜 회원가입 필수값 처리
	public int insertSocialMemberByRequired(SocialJoinFormDto socialJoinFormDto);
	
	// 소셜 회원가입 필수값 처리
	public int insertBySocialDto(@Param("id") String id, @Param("nickname") String nickname,
			@Param("email") String email, @Param("gender") String gender);

	// 아이디 중복 확인
	public Member existsById(String id);
	
}
