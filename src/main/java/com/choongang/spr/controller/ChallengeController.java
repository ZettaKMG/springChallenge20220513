package com.choongang.spr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.domain.PageInfoDto;
import com.choongang.spr.domain.ReplyDto;
import com.choongang.spr.service.ChallengeBoardService;
import com.choongang.spr.service.ChallengePageInfoService;
import com.choongang.spr.service.ChallengeReplyService;

@Controller
@RequestMapping("challenge")
public class ChallengeController {
	@Autowired
	private ChallengeBoardService boardService;
	
	@Autowired
	private ChallengeReplyService replyService;
	
	@Autowired
	private ChallengePageInfoService pageInfoService;
	
	
	// Board 관련 코드		
	@GetMapping("/board/{id}")
	public String getBoard(@PathVariable("id") int id, Model model) {
		BoardDto dto = boardService.getBoard(id);
		List<ReplyDto> replyList = replyService.listReplyByBoardId(id);
		
		model.addAttribute("board", dto);
		model.addAttribute("replyList", replyList);
		
		return "/challenge/board/get";
	}
	
	@PostMapping("/board/modify")
	public String modifyBoard(BoardDto board, RedirectAttributes rttr) {
		boolean success = boardService.updateBoard(board);
		
		if (success) {
			rttr.addFlashAttribute("message", "게시글 수정 성공");
		} else {
			rttr.addFlashAttribute("message", "게시글 수정 실패");
		}
		
		return "redirect:/challenge/board/list"; // + board.getId();
	}
	
	@PostMapping("/board/remove")
	public String removeBoard(int id, RedirectAttributes rttr) {
		boolean success = boardService.removeBoardById(id);
		
		if (success) {
			rttr.addFlashAttribute("message", "게시물 삭제 성공");
		} else {
			rttr.addFlashAttribute("message", "게시물 삭제 실패");
		}
		
		return "redirect:/challenge/board/list";
	}
	
	@GetMapping("/board/write")
	public void writeBoard() {
		
	}
	
	@PostMapping("/board/write")
	public String writeBoardProcess(BoardDto board, RedirectAttributes rttr) {
		boolean success = boardService.addBoard(board);
		
		if (success) {
			rttr.addFlashAttribute("message", "게시글 등록 성공");
		} else {
			rttr.addFlashAttribute("message", "게시글 등록 실패");
		}
		
		return "redirect:/challenge/board/list"; // + board.getId();
	}
	
	@GetMapping("/board/list")
	public String pageInfoProcess(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		int rowPerPage = 5;
		
		List<BoardDto> list = pageInfoService.listBoardPage(page, rowPerPage);
		int totalRecords = pageInfoService.countBoard();
		
		int end = (totalRecords - 1) / (rowPerPage) + 1;
		
		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
		
		model.addAttribute("boardList", list);
		model.addAttribute("pageInfo", pageInfo);
		
		return "/challenge/board/list";
	}
	
	
	// Reply 관련 코드
	@PostMapping("/reply/add")
	public String addReply(ReplyDto reply, RedirectAttributes rttr) {
		boolean success = replyService.addReply(reply);
		
		if (success) {
			rttr.addFlashAttribute("message", "댓글 등록 성공");
		} else {
			rttr.addFlashAttribute("message", "댓글 등록 실패");
		}
		
		return "redirect:/challenge/board/" + reply.getBoardId();
	}
	
	@PostMapping("/reply/remove")
	public String removeReply(ReplyDto reply, RedirectAttributes rttr) {
		boolean success = replyService.removeReplyById(reply.getId());
		
		if (success) {
			rttr.addFlashAttribute("message", "댓글 삭제 성공");
		} else {
			rttr.addFlashAttribute("message", "댓글 삭제 실패");
		}
		
		return "redirect:/challenge/board/" + reply.getBoardId();
	}
	
	@PostMapping("/reply/modify")
	public String modifyReply(ReplyDto reply, RedirectAttributes rttr) {
		boolean success = replyService.modifyReply(reply);
		
		if (success) {
			rttr.addFlashAttribute("message", "댓글 수정 성공");
		} else {
			rttr.addFlashAttribute("message", "댓글 수정 실패");
		}
		
		return "redirect:/challenge/board/" + reply.getBoardId();
	}	
	
}
