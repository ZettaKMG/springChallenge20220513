package com.choongang.spr.domain;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class BoardDto {
	private int id;
	private String title;
	private String body;
	private LocalDateTime inserted;
	private String memberId;
	private String writerNickName;
	private int numOfReply;
	private List<String> fileName;
	private boolean hasFile;
	
	public String getPrettyInserted() {
		// 게시글 게시 24시간 이내 -> 시간 표시, 24시간 초과 -> 년-월-일 표기
		LocalDateTime now = LocalDateTime.now();
		if (now.minusHours(24).isBefore(inserted)) {
			return inserted.toLocalTime().toString();
		} else {
			return inserted.toLocalDate().toString();
		}
	}
}
