package com.choongang.spr.mapper;

import java.util.List;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.domain.ReplyDto;

public interface Mapper {
	// Board 관련 코드들
	List<BoardDto> selectBoard();
	BoardDto getBoard(int id);
	int updateBoard(BoardDto board);
	int deleteBoard(int id);
	int insertBoard(BoardDto board);
	
	// Reply 관련 코드들
	List<ReplyDto> selectReplyByBoardId(int boardId);
	int insertReply(ReplyDto reply);
	int updateReply(ReplyDto reply);
	int deleteReplyById(int id);
	void deleteReplyByBoard(int boardId);
}
