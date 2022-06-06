package com.choongang.spr.service;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.spr.domain.ReplyDto;
import com.choongang.spr.mapper.ReplyMapper;

@Service
public class ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;
	
	public boolean addReply(ReplyDto dto) {		
		int count = replyMapper.insertReply(dto);		
		return count == 1;
	}
	
	public List<ReplyDto> getReplyByBoardId(int boardId) {
		return replyMapper.selectAllBoardId(boardId, null);
	}
	
	public boolean updateReply(ReplyDto dto, Principal principal) {
		ReplyDto old = replyMapper.selectReplyById(dto.getId());
		
		if (old.getMemberId().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 일치하면 수정
			return replyMapper.updateReply(dto) == 1;
		} else {
			// 일치하지 않으면 수정 불가
			return false;
		}
	}
	
	public boolean removeReply(int id, Principal principal) {		
		ReplyDto old = replyMapper.selectReplyById(id);
		
		if (old.getMemberId().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 일치하면 삭제
			return replyMapper.deleteReply(id) == 1;			
		} else {
			// 일치하지 않으면 삭제 불가
			return false;
		}
	}
	
	public List<ReplyDto> getReplyWithOwnByBoardId(int boardId, String memberId) {
		return replyMapper.selectAllBoardId(boardId, memberId);
	}


}
