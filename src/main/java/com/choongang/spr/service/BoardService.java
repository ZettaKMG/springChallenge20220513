package com.choongang.spr.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.choongang.spr.domain.BoardDto;
import com.choongang.spr.mapper.BoardMapper;
import com.choongang.spr.mapper.ReplyMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	public List<BoardDto> listBoard(String type, String keyword){
		return boardMapper.selectBoardAll(type, "%" + keyword + "%");
	}
	
	@PostConstruct
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.s3 = S3Client.builder().region(region).build();
	}
		
	@PreDestroy
	public void destroy() {
		this.s3.close();
	}

	@Transactional
	public boolean writeBoard(BoardDto board, MultipartFile[] files) {
		// 게시글 등록
		int count = boardMapper.insertBoard(board);
		
		addFiles(board.getId(), files);
		
		return count == 1;
	}	
	
	private void addFiles(int id, MultipartFile[] files) {
		// 파일 등록
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {
					boardMapper.insertFile(id, file.getOriginalFilename());
					saveFileAwsS3(id, file); // s3에 파일 업로드
				}
			}
		}		
	}

	private void saveFileAwsS3(int id, MultipartFile file) {
		String key = "challenge/board/" + id + "/" + file.getOriginalFilename();
		
		PutObjectRequest putObjectRequest = PutObjectRequest.builder()
															.acl(ObjectCannedACL.PUBLIC_READ)
															.bucket(bucketName)
															.key(key)
															.build();
		
		RequestBody requestBody;
		
		try {
			requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			s3.putObject(putObjectRequest, requestBody);
		} catch (IOException e) {			
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	private void saveFile(int id, MultipartFile file) {
		// 디렉토리 만들기
		String pathStr = "C:/imgtmpcha/challenge/board/" + id + "/";
		File path = new File(pathStr);
		path.mkdirs();
		
		// 작성할 파일
		File des = new File(pathStr + file.getOriginalFilename());
		
		try {
			// 파일 저장
			file.transferTo(des);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public BoardDto getBoardById(int id) {
		BoardDto board = boardMapper.selectBoardById(id);
		List<String> fileNames = boardMapper.selectFileNameByBoard(id);
		
		board.setFileName(fileNames);
		
		return board;
	}
	
	@Transactional
	public boolean updateBoard(BoardDto dto, List<String> removeFileList, MultipartFile[] addFileList) {
		if (removeFileList != null) {
			for (String fileName : removeFileList) {
				deleteFromAwsS3(dto.getId(), fileName);
				boardMapper.deleteFileByBoardIdAndFileName(dto.getId(), fileName);
			}
		}
		
		if (addFileList != null) {
			// File 테이블에 추가된 파일 insert
			// s3에 업로드
			addFiles(dto.getId(), addFileList);
		}
		
		// Board 테이블 업데이트
		int count = boardMapper.updateBoard(dto);
		
		return count == 1;
	}
	
	@Transactional
	public boolean removeBoard(int id) {
		// 파일 목록 읽기
		List<String> fileList = boardMapper.selectFileNameByBoard(id);
		
		removeFiles(id, fileList);
		
		// 댓글 테이블 삭제
		replyMapper.deleteByBoardId(id);
		
		int count = boardMapper.deleteBoard(id);
		
		return count == 1;
	}

	private void removeFiles(int id, List<String> fileList) {
		// s3에서 파일 지우기
		for (String fileName : fileList) {
			deleteFromAwsS3(id, fileName);
		}
		
		// 파일 테이블 삭제
		boardMapper.deleteFileByBoardId(id);
	}

	private void deleteFromAwsS3(int id, String fileName) {
		String key = "challenge/board/" + id + "/" + fileName;
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
																	 .bucket(bucketName)
																	 .key(key)
																	 .build();
		
		s3.deleteObject(deleteObjectRequest);
		
	}

	public void deleteBoard(int id) {
		// TODO Auto-generated method stub
		
	}
}
