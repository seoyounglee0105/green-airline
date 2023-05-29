package com.green.airline.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import com.green.airline.dto.kakao.SocialDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.dto.request.SocialJoinFormDto;
import com.green.airline.enums.UserRole;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.interfaces.MemberRepository;
import com.green.airline.repository.interfaces.UserRepository;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private MemberRepository memberRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Value("${green.key}")
	private String greenKey;

	/**
	 * @author 서영 로그인
	 */
	public User readUserByIdAndPassword(LoginFormDto loginFormDto) {
		User userEntity = userRepository.selectById(loginFormDto);

		if (userEntity == null) {
			throw new CustomRestfullException("아이디가 존재하지 않습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		boolean isPwdMatched = passwordEncoder.matches(loginFormDto.getPassword(), userEntity.getPassword());

		if (isPwdMatched == false) {
			throw new CustomRestfullException("비밀번호가 틀렸습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return userEntity;
	}

	/**
	 * @author 서영
	 * @return 회원 정보
	 */
	public Member readMemberById(String id) {
		Member memberEntity = memberRepository.selectById(id);
		return memberEntity;
	}

	// 일반 회원가입 처리
	public void createMember(JoinFormDto joinFormDto) {

		int result = memberRepository.insertMember(joinFormDto);
		String rawPwd = joinFormDto.getPassword();
		String hashPwd = passwordEncoder.encode(rawPwd);
		joinFormDto.setPassword(hashPwd); // 암호화 처리

		int result2 = userRepository.insertByUser(joinFormDto.getId(), joinFormDto.getPassword(), UserRole.DEFAULT);
		if (result == 1 && result2 == 1) {
			System.out.println("회원가입 성공");
		}
	}

	// 소셜 회원가입 처리
	public void createSocialMember(SocialJoinFormDto socialJoinFormDto) {

		int result = memberRepository.insertSocialMember(socialJoinFormDto);
		// 소셜 회원가입 (email, gender, id 중 하나라도 동의하지 않은 경우)
		int result2 = userRepository.insertByUser(socialJoinFormDto.getId(), greenKey, UserRole.SOCIAL);
		if (result == 1 && result2 == 1) {
			System.out.println("회원가입 성공");
		}
	}

	public SocialDto readBySocialUserInfo(String id) {
		SocialDto socialMember = memberRepository.selectBySocialUserInfo(id);

		return socialMember;
	}

	// 소셜회원 회원가입 (email, gender, id 모두 동의한 경우, 회원가입 페이지를 거치지 않고 카카오 로그인 동의하기 누르자마자
	// 회원가입이 된 경우)
	public void createByUser(SocialDto socialDto) {

		if ("male".equals(socialDto.getKakaoAccount().getGender())) {
			socialDto.getKakaoAccount().setGender("M");
		} else {
			socialDto.getKakaoAccount().setGender("F");
		}

		// member_tb에 저장
		int result = memberRepository.insertBySocialDto(socialDto.getId(), socialDto.getProperties().getNickname(),
				socialDto.getKakaoAccount().getEmail(), socialDto.getKakaoAccount().getGender());

		// user_tb에 저장
		int result2 = userRepository.insertByUser(socialDto.getId(), greenKey, UserRole.SOCIAL);
		if (result == 1 && result2 == 1) {
			System.out.println("insert 성공");
		}

	}

	public User readSocialDtoById(String id) {
		// 본인 데이터 베이스에 조회
		User userEntity = userRepository.selectSocialDtoById(id);
		return userEntity;
	}

	// 회원가입 시 에러메세지 내려주기
	public Map<String, String> validateHandler(Errors errors) {
		// 회원가입 실패시 message 값들을 모델에 매핑해서 View로 전달
		Map<String, String> validateResult = new HashMap<>();

		for (FieldError error : errors.getFieldErrors()) { // 유효성 검사에 실패한 필드 목록
			String validKeyName = "valid_" + error.getField(); // 유효성 검사에 실패한 필드명
			validateResult.put(validKeyName, error.getDefaultMessage()); // 유효성 검사에 실패한 필드에 정의된 메세지
		}

		return validateResult;
	}

	// 소셜 회원가입 필수값 처리
	public void createSocialMemberByRequired(SocialJoinFormDto socialJoinFormDto) {

		memberRepository.insertSocialMemberByRequired(socialJoinFormDto);
	}

	// 아이디 중복 확인
	public Member readById(String id) {
		Member memberEntity = memberRepository.existsById(id);
		return memberEntity;
	}

}
