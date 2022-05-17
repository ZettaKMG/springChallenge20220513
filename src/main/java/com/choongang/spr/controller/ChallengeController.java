package com.choongang.spr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.domain.ReplyDto;
import com.choongang.spr.service.ChallengeService;

@Controller
@RequestMapping("challenge")
public class ChallengeController {
	// Board, Reply Service 연동
	@Autowired
	private ChallengeService boardService;
	
	@Autowired
	private ChallengeService replyService;
	
	
	// Board 관련 코드	
	@GetMapping("board/list")
	public void listBoard(Model model) {
		List<BoardDto> list = boardService.listBoard();
		
		model.addAttribute("boardList", list);
	}
	
	@GetMapping("board/{id}")
	public String getBoard(@PathVariable("id") int id, Model model) {
		BoardDto dto = boardService.getBoard(id);
		List<ReplyDto> replyList = replyService.listReplyByBoardId(id);
		
		model.addAttribute("board", dto);
		model.addAttribute("replyList", replyList);
		
		return "/challenge/board/get";
	}
	
	@PostMapping("board/modify")
	public String modifyBoard(BoardDto board) {
		boolean success = boardService.updateBoard(board);
		
		if (success) {
			
		} else {
			
		}
		
		return "redirect:/challenge/board/" + board.getId();
	}
	
	@PostMapping("board/remove")
	public String removeBoard(int id) {
		boolean success = boardService.removeBoardById(id);
		
		if (success) {
			
		} else {
			
		}
		
		return "redirect:/challenge/board/list";
	}
	
	@GetMapping("board/write")
	public void writeBoard() {
		
	}
	
	@PostMapping("board/write")
	public String writeBoardProcess(BoardDto board) {
		boolean success = boardService.addBoard(board);
		
		if (success) {
			
		} else {
			
		}
		
		return "redirect:/challenge/board/" + board.getId();
	}
	
	
	// Reply 관련 코드
	@PostMapping("reply/add")
	public String addReply(ReplyDto reply) {
		boolean success = replyService.addReply(reply);
		
		if (success) {
			
		} else {
			
		}
		
		return "redirect:/challenge/board/" + reply.getBoardId();
	}
	
	@PostMapping("reply/remove")
	public String removeReply(ReplyDto reply) {
		boolean success = boardService.removeReplyById(reply.getId());
		
		if (success) {
			
		} else {
			
		}
		
		return "redirect:/challenge/board/" + reply.getBoardId();
	}
	
	public String modifyReply(ReplyDto reply) {
		boolean success = boardService.modifyReply(reply);
		
		if (success) {
			
		} else {
			
		}
		
		return "redirect:/challenge/board/" + reply.getBoardId();
	}
}
