package com.choongang.spr.domain;

import lombok.ToString;

@ToString
public class PageInfoDto {
	private int current;
	private int end;
	
	public void setCurrent(int current) {
		this.current = current;
	}
	
	public int getCurrent() {
		return current;
	}
	
	public int getLeft() {
		return (current - 1) / 10 * 10 + 1;
	}
	
	public int getRight() {
		return Math.min(getLeft() + 9, end);
	}
	
	public void setEnd(int end) {
		this.end = end;
	}
	
	public int getEnd() {
		return end;
	}
}
