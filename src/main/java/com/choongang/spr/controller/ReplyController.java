package com.choongang.spr.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.choongang.spr.domain.ReplyDto;
import com.choongang.spr.service.ReplyService;

@RestController
@RequestMapping("challenge")
public class ReplyController {	
	
	@Autowired
	private ReplyService replyService;

	@PostMapping(path = "write", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> addReply(ReplyDto dto, Principal principal) {
		if (principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			String memberId = principal.getName();
			dto.setMemberId(memberId);
			
			boolean success = replyService.addReply(dto);
			
			if (success) {
				return ResponseEntity.ok("새 댓글 등록 성공했습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}			
		}
//		return "redirect:/challenge/board/" + reply.getBoardId();
	}

	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> modifyReply(@RequestBody ReplyDto dto, Principal principal) {
		if (principal == null) {
			return ResponseEntity.status(401).build();
			
		} else {
			boolean success = replyService.updateReply(dto, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글이 수정되었습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
		}	
		
//		return "redirect:/challenge/board/" + reply.getBoardId();
	}
	
	@DeleteMapping(path = "remove/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> removeReply(@PathVariable("id") int id, Principal principal) {
		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = replyService.removeReply(id, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글이 삭제되었습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
		}
		
//		return "redirect:/challenge/board/" + reply.getBoardId();
	}
	
	@GetMapping("/reply/list")
	public List<ReplyDto> list(int boardId, Principal principal) {
		if (principal == null) {
			return replyService.getReplyByBoardId(boardId);
		} else {
			return replyService.getReplyWithOwnByBoardId(boardId, principal.getName());
		}
	}
}
