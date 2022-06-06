package com.choongang.spr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.domain.MemberDto;
import com.choongang.spr.mapper.BoardMapper;
import com.choongang.spr.mapper.MemberMapper;
import com.choongang.spr.mapper.ReplyMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	public boolean addMember(MemberDto dto) {
		// 평문 암호를 암호화(encoding)
		String encodedPassword = passwordEncoder.encode(dto.getPassword());
		
		// 암호화된 암호를 다시 셋팅
		dto.setPassword(encodedPassword);
		
		// insert member
		int count1 = memberMapper.insertMember(dto);
		
		// insert auth
		int count2 = memberMapper.insertAuth(dto.getId(), "ROLE_USER");
		
		return count1 == 1 && count2 == 1;
	}

	public boolean hasMemberId(String id) {
		
		return memberMapper.countMemberId(id) > 0;
	}

	public boolean hasMemberEmail(String email) {
		
		return memberMapper.countMemberEmail(email) > 0;
	}

	public boolean hasMemberNickName(String nickName) {
		
		return memberMapper.countMemberNickName(nickName) > 0;
	}

	public List<MemberDto> listMember() {
		
		return memberMapper.selectAllMember();
	}

	public MemberDto getMemberById(String id) {
		
		return memberMapper.selectMemberById(id);
	}

	@Transactional
	public boolean removeMember(MemberDto dto) {
		MemberDto member = memberMapper.selectMemberById(dto.getId());
		
		String rawPW = dto.getPassword();
		String encodedPW = member.getPassword();
		
		if (passwordEncoder.matches(rawPW, encodedPW)) {
			// 댓글 삭제
			replyMapper.deleteByMemberId(dto.getId());
			
			// 이 멤버가 쓴 게시글 삭제
			List<BoardDto> boardList = boardMapper.listByMemberId(dto.getId());
			for (BoardDto board : boardList) {
				boardService.removeBoard(board.getId());
			}
			
			// 권한 테이블 삭제
			memberMapper.deleteAuthById(dto.getId());
			
			// 멤버 테이블 삭제
			int count = memberMapper.deleteMemberById(dto.getId());
			
			return count == 1;
		}
		
		return false;
	}

	public boolean modifyMember(MemberDto dto, String oldPassword) {
		// DB에서 member 읽기
		MemberDto oldMember = memberMapper.selectMemberById(dto.getId());
		String encodePW = oldMember.getPassword();
		
		// 기존 password가 일치할 때만 계속 진행
		if (passwordEncoder.matches(oldPassword, encodePW)) {
			// 암호 인코딩
			dto.setPassword(passwordEncoder.encode(dto.getPassword()));
			
			return memberMapper.updateMember(dto) == 1;
		}
		
		return false;
	}

	public void initPassword(String id) {
		String pw = passwordEncoder.encode(id);
		
		memberMapper.updatePasswordById(id, pw);
		
	}



}
