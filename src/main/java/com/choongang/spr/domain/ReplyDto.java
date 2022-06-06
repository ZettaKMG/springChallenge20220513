package com.choongang.spr.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReplyDto {
	private int id;
	private int boardId;
	private String content;
	private String memberId;
	private String writerNickName;
	private boolean own;
	private LocalDateTime inserted;
	
	public String getPrettyInserted() {
		// 댓글 게시 24시간 이내 -> 시간 표시, 24시간 초과 -> 년-월-일 표기
		LocalDateTime now = LocalDateTime.now();
		if (now.minusHours(24).isBefore(inserted)) {
			return inserted.toLocalTime().toString();
		} else {
			return inserted.toLocalDate().toString();
		}
	}
}
