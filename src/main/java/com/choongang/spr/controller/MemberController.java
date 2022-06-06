package com.choongang.spr.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choongang.spr.domain.MemberDto;
import com.choongang.spr.service.MemberService;

@Controller
@RequestMapping("challenge")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/member/signup")
	public void signupForm() {
		
	}
	
	@PostMapping("/member/signup")
	public String signupProcess(MemberDto dto, RedirectAttributes rttr) {
		boolean success = memberService.addMember(dto);
		
		if (success) {
			rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
			return "redirect:/challenge/board/list";
		} else {
			rttr.addFlashAttribute("message", "회원가입이 실패하였습니다.");
			rttr.addFlashAttribute("member", dto);
			
			return "redirect:/challenge/member/signup";
		}
	}
	
	@GetMapping(path="check", params = "id")
	@ResponseBody
	public String idCheck(String id) {
		boolean exist = memberService.hasMemberId(id);
		
		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
	@GetMapping(path = "check", params = "email")
	@ResponseBody
	public String emailCheck(String email) {
		boolean exist = memberService.hasMemberEmail(email);
		
		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
	@GetMapping(path = "check", params = "nickName")
	@ResponseBody
	public String nickNameCheck(String nickName) {
		boolean exist = memberService.hasMemberNickName(nickName);
		
		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
	@GetMapping("/member/list")
	public void list(Model model) {
		List<MemberDto> list = memberService.listMember();
		model.addAttribute("memberList", list);
	}
	
	@GetMapping("/member/get")
	public String getMember(String id, Principal principal, HttpServletRequest request, Model model) {
		if (hasAuthOrAdmin(id, principal, request)) {
			MemberDto dto = memberService.getMemberById(id);
			model.addAttribute("member", dto);
			
			return null;
		}
		
		return "redirect:/challenge/member/login";
	}

	private boolean hasAuthOrAdmin(String id, Principal principal, HttpServletRequest req) {
		
		return req.isUserInRole("ROLE_ADMIN") || (principal != null && principal.getName().equals(id));
	}
	
	@PostMapping("/member/remove")
	public String removeMember(MemberDto dto, Principal principal, HttpServletRequest req, RedirectAttributes rttr) {
		if (hasAuthOrAdmin(dto.getId(), principal, req)) {
			boolean success = memberService.removeMember(dto);
			
			if (success) {
				rttr.addFlashAttribute("message", "회원 탈퇴 되었습니다.");
				return "redirect:/challenge/board/list";
			} else {
				rttr.addAttribute("id", dto.getId());
				return "redirect:/challenge/member/get";
			}
		} else {
			return "redirect:/challenge/member/login";
		}
	}
	
	@PostMapping("/member/modify")
	public String modifyMember(MemberDto dto, String oldPassword, Principal principal, HttpServletRequest req, RedirectAttributes rttr) {
		if (hasAuthOrAdmin(dto.getId(), principal, req)) {
			boolean success = memberService.modifyMember(dto, oldPassword);
			
			if (success) {
				rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
			}
			
			rttr.addFlashAttribute("member", dto); // model object
			rttr.addAttribute("id", dto.getId()); // query string
			
			return "redirect:/challenge/member/get";
		} else {
			return "redirect:/challenge/member/login";
		}
	}
	
	@GetMapping("/member/login")
	public void loginPage() {
		
	}
	
	@GetMapping("/member/initpw")
	public void initpwPage() {
		
	}
	
	@PostMapping("/member/initpw")
	public String initpwProcess(String id) {
		memberService.initPassword(id);
		
		return "redirect:/challenge/board/list";
	}
}
