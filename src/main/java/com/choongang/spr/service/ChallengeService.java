package com.choongang.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.domain.ReplyDto;
import com.choongang.spr.mapper.Mapper;

@Service
public class ChallengeService {
	// Board, Reply Mapper 불러오기
	@Autowired
	private Mapper boardMapper;
	
	@Autowired
	private Mapper replyMapper;
	
	
	// Board 관련 코드	
	public List<BoardDto> listBoard(){
		return boardMapper.selectBoard();
	}
	
	public BoardDto getBoard(int id) {
		return boardMapper.getBoard(id);
	}
	
	public boolean updateBoard(BoardDto board) {
		int count = boardMapper.updateBoard(board);
		
		return count == 1;
	}
	
	@Transactional
	public boolean removeBoardById(int id) {
		replyMapper.deleteReplyByBoard(id);
		
		int count = boardMapper.deleteBoard(id);
		
		return count == 1;
	}
	
	public boolean addBoard(BoardDto board) {
		board.setInserted(LocalDateTime.now());
		
		int count = boardMapper.insertBoard(board);
		
		return count == 1;
	}
	
	
	// Reply 관련 코드
	public List<ReplyDto> listReplyByBoardId(int id) {
		return replyMapper.selectReplyByBoardId(id);
	}
	
	public boolean addReply(ReplyDto reply) {
		reply.setInserted(LocalDateTime.now());
		
		int count = replyMapper.insertReply(reply);
		
		return count == 1;
	}

	public boolean modifyReply(ReplyDto reply) {
		int count = replyMapper.updateReply(reply);
		
		return count == 1;
	}

	public boolean removeReplyById(int id) {
		replyMapper.deleteReplyById(id);
		
		int count = replyMapper.deleteReplyById(id);
		
		return count == 1;
	}

}
