package com.choongang.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.mapper.BoardMapper;
import com.choongang.spr.mapper.ReplyMapper;

@Service
public class ChallengeBoardService {
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
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

}
