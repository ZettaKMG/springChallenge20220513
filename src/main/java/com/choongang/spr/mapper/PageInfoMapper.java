package com.choongang.spr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.choongang.spr.domain.BoardDto;

public interface PageInfoMapper {
	List<BoardDto> listBoardPage(@Param("from") int from, @Param("rowPerPage") int rowPerPage);
	
	int countBoard();
}
