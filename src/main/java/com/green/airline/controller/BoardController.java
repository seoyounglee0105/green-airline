package com.green.airline.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.green.airline.dto.BoardDto;
import com.green.airline.dto.BoardUpdateDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.interfaces.BoardRepository;
import com.green.airline.repository.model.Board;
import com.green.airline.repository.model.LikeHeart;
import com.green.airline.repository.model.User;
import com.green.airline.service.BoardService;
import com.green.airline.utils.Define;

/**
 * @author 치승 추천 여행지 게시글
 */

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private BoardRepository boardRepository;

	@Autowired
	private HttpSession session;

	// 게시글 전체 보기
	@GetMapping("/list")
	public String boardListAllPage(Model model) {

		List<Board> boardList = boardService.boardList();

		if (boardList.isEmpty()) {
			model.addAttribute("boardList", null);
		} else {
			model.addAttribute("boardList", boardList);
		}

		return "/board/recommendBoard";
	}

	// 게시글 작성하기
	@GetMapping("/insert")
	public String boardWrite() {

		return "/board/boardWrite";
	}

	// 게시글 작성하기
	@PostMapping("/insert")
	public String boardWirteProc(BoardDto boardDto) {

		if (boardDto.getTitle() == null || boardDto.getTitle().isEmpty()) {
			throw new CustomRestfullException("제목을 입력해주세요", HttpStatus.BAD_REQUEST);
		}
		if (boardDto.getContent() == null || boardDto.getContent().isEmpty()) {
			throw new CustomRestfullException("내용을 입력해주세요", HttpStatus.BAD_REQUEST);
		}

		MultipartFile file = boardDto.getFile();

		if (!file.isEmpty()) {
			// 파일 사이즈 체크
			if (file.getSize() > Define.MAX_FILE_SIZE) {
				throw new CustomRestfullException("파일 크기는 20MB이상 줄 수 없습니다.", HttpStatus.BAD_REQUEST);
			}

			try {
				// 파일 저장 기능
				String saveDirectory = Define.UPLOAD_DIRECTORY;

				File dir = new File(saveDirectory);

				// 파일이 있는지 없는지 확인
				if (dir.exists() == false) {
					// 폴더가 없으면 폴더 생성
					dir.mkdirs();
				}

				UUID uuid = UUID.randomUUID();
				String fileName = uuid + "_" + file.getOriginalFilename();

				// 전체 경로 지정
				String uploadPath = Define.UPLOAD_DIRECTORY + File.separator + fileName;

				File destination = new File(uploadPath);

				file.transferTo(destination);

				boardDto.setOriginName(file.getOriginalFilename());
				boardDto.setFileName(fileName);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		boardService.insertByBoard(boardDto);

		return "redirect:/board/list";
	}

	// 게시글 수정하기
	@GetMapping("/update/{id}")
	public String boardByUpdate(@PathVariable Integer id, Model model) {

		BoardDto boardDto = boardService.boardListDetail(id);
		model.addAttribute("boardDto", boardDto);

		return "/board/updateBoard";
	}

	// 게시글 수정하기
	@PostMapping("/update/{id}")
	public String boardByUpdate(@PathVariable("id") Integer id, BoardUpdateDto boardUpdateDto) {
		MultipartFile file = boardUpdateDto.getFile();

		if (!file.isEmpty()) {
			// 파일 사이즈 체크
			if (file.getSize() > Define.MAX_FILE_SIZE) {
				throw new CustomRestfullException("파일 크기는 20MB이상 줄 수 없습니다.", HttpStatus.BAD_REQUEST);
			}

			try {
				// 파일 저장 기능
				String saveDirectory = Define.UPLOAD_DIRECTORY;

				File dir = new File(saveDirectory);

				// 파일이 있는지 없는지 확인
				if (dir.exists() == false) {
					// 폴더가 없으면 폴더 생성
					dir.mkdirs();
				}

				UUID uuid = UUID.randomUUID();
				String fileName = uuid + "_" + file.getOriginalFilename();

				// 전체 경로 지정
				String uploadPath = Define.UPLOAD_DIRECTORY + File.separator + fileName;

				File destination = new File(uploadPath);

				file.transferTo(destination);

				boardUpdateDto.setOriginName(file.getOriginalFilename());
				boardUpdateDto.setFileName(fileName);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		boardService.updateByBoard(id, boardUpdateDto);
		System.out.println(boardUpdateDto);
		return "redirect:/board/list";
	}

	// 게시글 삭제하기
	@PostMapping("/delete/{id}")
	public String boardByDelete(Integer id) {

		boardService.deleteByBoard(id);
		System.out.println("삭제완료");

		return "redirect:/board/list";
	}

	// 추천여행지 상세 보기
	@ResponseBody
	@GetMapping("/detail/{id}")
	public BoardDto boardDetail(@PathVariable Integer id, HttpServletRequest request, HttpServletResponse response) {

		User user = (User) session.getAttribute(Define.PRINCIPAL);

		// 좋아요 수 조회
		BoardDto boardDto = boardService.selectLikeHeart(id);

		// 쿠키 추가, 조회수 증가
		boolean viewUp = boardService.viewCountCookie(id, request, response);

		// 모달창 띄웠을 때 조회수 증가한 화면 보여주기
		if (viewUp) {
			boardDto.setViewCount(boardDto.getViewCount() + 1);
		}

		// 게시물 찜 목록에 현재 로그인 되어있는 id가 있는지 확인
		List<LikeHeart> list = boardRepository.selectByBoardIdAndLikeUser(id, user.getId());
		// 찜을 누른 유저인지 판별
		// 안눌렀으면 꽉찬 하트
		// 지났으면 빈하트 출력
		if (list.isEmpty() || list == null) {
			boardDto.setStatement(false);
		} else {
			boardDto.setStatement(true);
		}

		return boardDto;
	}

	// 좋아요 버튼 클릭
	@ResponseBody
	@PostMapping("/detail/{id}")
	public Integer likeHeartButton(@PathVariable Integer id, HttpServletRequest request) {

		boardService.heartInDecrease(id); // true, false 반환

		// 좋아요 수 다시 세팅
		Integer heartCount = boardService.selectLikeHeart(id).getHeartCount();

		return heartCount;
	}

}
