package com.choongang.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.spr.domain.ReplyDto;
import com.choongang.spr.mapper.ReplyMapper;

@Service
public class ChallengeReplyService {
	@Autowired
	private ReplyMapper replyMapper;
	
	public boolean addReply(ReplyDto reply) {
//		reply.setInserted(LocalDateTime.now());
		
		int count = replyMapper.insertReply(reply);
		
		return count == 1;
	}
	
	public List<ReplyDto> listReplyByBoardId(int id) {
		return replyMapper.selectReplyByBoardId(id);
	}

	public boolean removeReplyById(int id) {
		replyMapper.deleteReplyById(id);
		
		int count = replyMapper.deleteReplyById(id);
		
		return count == 1;
	}

	public boolean modifyReply(ReplyDto reply) {
		int count = replyMapper.updateReply(reply);
		
		return count == 1;
	}
}
