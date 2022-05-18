package com.choongang.spr.mapper;

import java.util.List;

import com.choongang.spr.domain.ReplyDto;

public interface ReplyMapper {
	// Reply 관련 코드들
	List<ReplyDto> selectReplyByBoardId(int boardId);
	int insertReply(ReplyDto reply);
	int updateReply(ReplyDto reply);
	int deleteReplyById(int id);
	void deleteReplyByBoard(int boardId);
}
