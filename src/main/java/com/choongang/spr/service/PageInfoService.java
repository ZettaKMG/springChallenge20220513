package com.choongang.spr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.mapper.PageInfoMapper;

@Service
public class PageInfoService {
	@Autowired
	private PageInfoMapper pageInfoMapper;
	
	public List<BoardDto> listBoardPage(int page, int rowPerPage){
		int from = (page - 1) * rowPerPage;
		
		return pageInfoMapper.listBoardPage(from, rowPerPage);
	}
	
	public int countBoard() {
		return pageInfoMapper.countBoard();
	}
}
