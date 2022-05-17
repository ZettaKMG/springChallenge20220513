package com.choongang.spr.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReplyDto {
	private int id;
	private int boardId;
	private String content;
	private LocalDateTime inserted;
}
