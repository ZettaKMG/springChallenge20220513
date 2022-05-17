package com.choongang.spr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.mapper.Mapper;

@Service
public class Service {
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
	
	// Reply 관련 코드(Board 관련 코드 일부 포함)
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
