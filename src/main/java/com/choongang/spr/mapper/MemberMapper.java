package com.choongang.spr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.choongang.spr.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto dto);

	int countMemberId(String id);

	int countMemberEmail(String email);

	int countMemberNickName(String nickName);

	List<MemberDto> selectAllMember();

	MemberDto selectMemberById(String id);

	int deleteMemberById(String id);

	int updateMember(MemberDto dto);

	int insertAuth(@Param("id") String id, @Param("auth") String auth);

	void deleteAuthById(String id);

	void updatePasswordById(@Param("id") String id, @Param("pw") String pw);

}
