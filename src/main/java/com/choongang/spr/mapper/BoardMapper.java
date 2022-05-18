package com.choongang.spr.mapper;

import java.util.List;

import com.choongang.spr.domain.BoardDto;

public interface BoardMapper {
	List<BoardDto> selectBoard();
	BoardDto getBoard(int id);
	int updateBoard(BoardDto board);
	int deleteBoard(int id);
	int insertBoard(BoardDto board);		
}
