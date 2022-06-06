package com.choongang.spr.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.domain.PageInfoDto;
import com.choongang.spr.service.BoardService;
import com.choongang.spr.service.PageInfoService;

@Controller
@RequestMapping("challenge")
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private PageInfoService pageInfoService;	
	
	@RequestMapping("/board/list")
	public void list(@RequestParam(name = "keyword", defaultValue = "") String keyword, @RequestParam(name = "type", defaultValue = "") String type, Model model) {
		List<BoardDto> list = boardService.listBoard(type, keyword);
		model.addAttribute("boardList", list);
	}
	
	@GetMapping("/board/write")
	public void writeBoard() {
		
	}
	
	@PostMapping("/board/write")
	public String writeBoardProcess(BoardDto board, MultipartFile[] file, Principal principal, RedirectAttributes rttr) {
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			board.setFileName(fileList);
		}
		
		board.setMemberId(principal.getName());
		boolean success = boardService.writeBoard(board, file);
		
		if (success) {
			rttr.addFlashAttribute("message", "새 게시글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 게시글이 등록되지 않았습니다.");
		}
		
		return "redirect:/challenge/board/list";
	}
	
//	@GetMapping("/board/write")
//	public void writeBoard() {
//		
//	}
//	
//	@PostMapping("/board/write")
//	public String writeBoardProcess(BoardDto board, RedirectAttributes rttr) {
//		boolean success = boardService.addBoard(board);
//		
//		if (success) {
//			rttr.addFlashAttribute("message", "게시글 등록 성공");
//		} else {
//			rttr.addFlashAttribute("message", "게시글 등록 실패");
//		}
//		
//		return "redirect:/challenge/board/list"; // + board.getId();
//	}	
		
	@GetMapping("/board/get")
	public void getBoard(int id, Model model) {
		BoardDto dto = boardService.getBoardById(id);
//		List<ReplyDto> replyList = replyService.listReplyByBoardId(id);
		model.addAttribute("board", dto);
		
//		model.addAttribute("replyList", replyList);
		
//		return "/challenge/board/get";
	}
	
	@PostMapping("/board/modify")
	public String modifyBoard(BoardDto dto, @RequestParam(name = "removeFileList", required = false) ArrayList<String> removeFileList, MultipartFile[] addFileList, Principal principal, RedirectAttributes rttr) {
		BoardDto oldBoard = boardService.getBoardById(dto.getId());
		
		
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = boardService.updateBoard(dto, removeFileList, addFileList);
			
			if (success) {
				rttr.addFlashAttribute("message", "게시글 수정 성공하였습니다.");
			} else {
				rttr.addFlashAttribute("message", "게시글 수정 실패하였습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "게시글 수정 권한 없습니다.");
		}		
		
		rttr.addAttribute("id", dto.getId());
		return "redirect:/challenge/board/get"; // + dto.getId();
	}
	
	@PostMapping("/board//remove")
	public String removeBoard(BoardDto dto, Principal principal, RedirectAttributes rttr) {
		// 게시물 정보 얻기
		BoardDto oldBoard = boardService.getBoardById(dto.getId());
		
		// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 다음 절차 진행
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = boardService.removeBoard(dto.getId());
			
			if (success) {
				rttr.addFlashAttribute("message", "게시글이 삭제 되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "게시글이 삭제 되지 않았습니다.");
			}
			
			return "redirect:/challenge/board/list";	
			
		} else {
			rttr.addFlashAttribute("message", "게시글 삭제 권한이 없습니다.");
			rttr.addAttribute("id", dto.getId());
			
			return "redirect:/challenge/board/get";
		}		
	}	
	
	// pagination 코드
	@GetMapping("/board/list")
	public String pageInfoProcess(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		int rowPerPage = 5;
		
		List<BoardDto> list = pageInfoService.listBoardPage(page, rowPerPage);
		int totalRecords = pageInfoService.countBoard();
		
		int end = (totalRecords - 1) / (rowPerPage) + 1;
		
		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
		
//		System.out.println(pageInfo);
//		System.out.println(pageInfo.getLeft());
//		System.out.println(pageInfo.getRight());
		
		model.addAttribute("boardList", list);
		model.addAttribute("pageInfo", pageInfo);
		
		return "/challenge/board/list";
	}	
}
