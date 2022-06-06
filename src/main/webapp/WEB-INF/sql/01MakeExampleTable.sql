DROP DATABASE mydb7;
CREATE DATABASE mydb7;
USE mydb7;

CREATE TABLE Board
SELECT * FROM mydb4.Board;

CREATE TABLE Reply
SELECT * FROM mydb4.Reply;

DESC Board;
DESC Reply;

ALTER TABLE Board MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE Reply MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE Reply ADD FOREIGN KEY (board_id) REFERENCES Board(id);

DROP TABLE Member;
CREATE TABLE Member (
	id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(20) NOT NULL UNIQUE,
    nickName VARCHAR(20) NOT NULL UNIQUE,
    inserted DATETIME NOT NULL DEFAULT NOW()
);

-- 권한 테이블
CREATE TABLE Auth (
	memberId VARCHAR(20) NOT NULL,
    role VARCHAR(20) NOT NULL,
    FOREIGN KEY (memberId) REFERENCES Member(id)
);

ALTER TABLE Member
MODIFY COLUMN email VARCHAR(50) NOT NULL UNIQUE;

ALTER TABLE Member
MODIFY COLUMN password VARCHAR(100) NOT NULL;

DESC Member;

SELECT * FROM Member;
SELECT * FROM Auth;
INSERT INTO Auth
VALUES ('admin', 'ROLE_ADMIN');

INSERT INTO Auth (memberId, role)
(SELECT id, 'ROLE_USER' 
 FROM Member 
 WHERE id NOT IN (SELECT memberId FROM Auth));
 
-- Board 테이블에 Member의 id 참조하는 컬럼 추가
DESC Board;
ALTER TABLE Board
ADD COLUMN memberId VARCHAR(20) NOT NULL DEFAULT 'user' REFERENCES Member(id) AFTER body;

-- 에러코드 1452 발생
-- 외래키 제약 조건 무시처리/ 원하는 코드 등록 후 다시 한번 치면 제약 조건 활성화
SET foreign_key_checks=0;

ALTER TABLE Board
MODIFY COLUMN memberId VARCHAR(20) NOT NULL;

SELECT * FROM Board ORDER BY 1 DESC;

-- 여기까지 일단 진행
-- 이 아래부터 에러코드 1823 발생하여 진행 못함

-- Reply에 memberId 컬럼 추가(Member 테이블 id 컬럼 참조키 제약사항, not null 제약사항 추가)
ALTER TABLE Reply
ADD COLUMN memberId VARCHAR(20) NOT NULL DEFAULT 'user' REFERENCES Member(id) AFTER content;

DESC Reply;

ALTER TABLE Reply
MODIFY COLUMN memberId VARCHAR(20) NOT NULL AFTER content;

SELECT * FROM Reply ORDER BY 1 DESC;


	SELECT r.id, 
	       r.board_id boardId,
	       r.content,
	       m.nickName writerNickName,
	       r.inserted,
		   IF (m.id = 'user3', 'true', 'false') own
	FROM Reply r JOIN Member m ON r.memberId = m.id
	WHERE r.board_id = 15
	ORDER BY r.id
;
-- Board에 fileName 컬럼 추가????? 그러지 말고 파일 테이블을 만들자
DESC Board;

CREATE TABLE File (
	id INT PRIMARY KEY AUTO_INCREMENT,
	boardId INT NOT NULL REFERENCES Board(id),
    fileName VARCHAR(255) NOT NULL
);

DESC File;

SELECT * FROM File;
SELECT * FROM Board ORDER BY 1 DESC;

SELECT * FROM File WHERE boardId = 49;