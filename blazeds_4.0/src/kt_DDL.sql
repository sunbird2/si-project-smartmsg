CREATE TABLE `SDK_SMS_SEND` (
  `MSG_ID` int(11) NOT NULL auto_increment,
  `USER_ID` varchar(20) NOT NULL  COMMENT '아이디',
  `SCHEDULE_TYPE` int(11) NOT NULL default '0' COMMENT '0:즉시, 1:예약',
  `SUBJECT` varchar(50) default NULL COMMENT '제목',
  `SMS_MSG` varchar(200) default NULL COMMENT '메시지',
  `CALLBACK_URL` varchar(200) default NULL COMMENT 'URL',
  `NOW_DATE` varchar(20) default NULL COMMENT 'DB입력시간:YYYYMMDDHHMMSS',
  `SEND_DATE` varchar(20) NOT NULL COMMENT '발송시간:YYYYMMDDHHMMSS',
  `CALLBACK` varchar(20) default NULL COMMENT '회신번호',
  `DEST_TYPE` int(11) NOT NULL default '0' COMMENT '수신자 정보저장 타입 ',
  `DEST_COUNT` int(11) NOT NULL default '0' COMMENT '수신자목록 개수(MAX:100)',
  `DEST_INFO` text NOT NULL COMMENT '착신자이름과 번호:홍길동^0100002222|',
  `KT_OFFICE_CODE` varchar(20) default NULL COMMENT 'KT 유통망코드',
  `CDR_ID` varchar(20) default NULL COMMENT '과금ID',
  `RESERVED1` varchar(64) default NULL COMMENT '로그키',
  `RESERVED2` varchar(50) default NULL COMMENT '아이피',
  `RESERVED3` varchar(50) default NULL COMMENT '보상여부:Y',
  `RESERVED4` varchar(50) default NULL COMMENT '전송타입:I,R',
  `RESERVED5` varchar(50) default NULL COMMENT '',
  `RESERVED6` varchar(50) default NULL COMMENT '',
  `SEND_STATUS` int(11) NOT NULL default '0' COMMENT '',
  `SEND_COUNT` int(11) NOT NULL default '0' COMMENT '',
  `SEND_RESULT` int(11) NOT NULL default '0' COMMENT '결과  0:대기,2:성공',
  `SEND_PROC_TIME` varchar(20) default NULL COMMENT '',
  `STD_ID` int(11) default NULL COMMENT '',
  PRIMARY KEY  (`MSG_ID`),
  KEY `IDX_SDK_S_S_1` (`SEND_STATUS`),
  KEY `IDX_SDK_S_S_2` (`SEND_DATE`),
  KEY `IDX_SDK_S_S_3` (`SCHEDULE_TYPE`),
  KEY `IDX_SDK_S_S_0` (`SEND_STATUS`,`SCHEDULE_TYPE`,`SEND_DATE`),
  KEY `search_user` (`USER_ID`),
  KEY `search_log` (`USER_ID`, `RESERVED1`)
)  DEFAULT CHARSET=utf8;


CREATE TABLE `SDK_SMS_REPORT` (
  `MSG_ID` int(11) NOT NULL,
  `USER_ID` varchar(20) NOT NULL COMMENT '아이디',
  `JOB_ID` int(11) NOT NULL default '0' COMMENT '메시지고유ID',
  `SCHEDULE_TYPE` int(11) NOT NULL default '0' COMMENT '0:즉시, 1:예약',
  `SUBJECT` varchar(50) default NULL COMMENT '제목',
  `SMS_MSG` varchar(200) default NULL COMMENT '메시지',
  `CALLBACK_URL` varchar(200) default NULL COMMENT 'URL',
  `NOW_DATE` varchar(20) default NULL COMMENT 'DB입력시간',
  `SEND_DATE` varchar(20) NOT NULL COMMENT '발송희망시간',
  `CALLBACK` varchar(20) default NULL COMMENT '회신번호',
  `DEST_TYPE` int(11) NOT NULL default '0' COMMENT '0',
  `DEST_COUNT` int(11) NOT NULL default '0' COMMENT '수신자목록 개수',
  `DEST_INFO` text NOT NULL COMMENT '이름^전화번호',
  `KT_OFFICE_CODE` varchar(20) default NULL COMMENT 'KT 유통망 코드',
  `CDR_ID` varchar(20) default NULL COMMENT '과금ID',
  `RESERVED1` varchar(64) default NULL COMMENT '로그키',
  `RESERVED2` varchar(50) default NULL COMMENT '아이피',
  `RESERVED3` varchar(50) default NULL COMMENT '보상여부:Y',
  `RESERVED4` varchar(50) default NULL COMMENT '전송타입:I,R',
  `RESERVED5` varchar(50) default NULL COMMENT '',
  `RESERVED6` varchar(50) default NULL COMMENT '',
  `SUCC_COUNT` int(11) NOT NULL default '0' COMMENT '성공개수',
  `FAIL_COUNT` int(11) NOT NULL default '0' COMMENT '실패개수',
  `CANCEL_STATUS` int(11) NOT NULL default '0' COMMENT '',
  `CANCEL_COUNT` int(11) NOT NULL default '0' COMMENT '',
  `CANCEL_REQ_DATE` varchar(20) default NULL COMMENT '',
  `CANCEL_RESULT` int(11) NOT NULL default '0' COMMENT '',
  `DELIVER_STATUS` int(11) NOT NULL default '0' COMMENT '',
  `DELIVER_COUNT` int(11) NOT NULL default '0' COMMENT '',
  `DELIVER_REQ_DATE` varchar(20) default NULL COMMENT '',
  `DELIVER_RESULT` int(11) NOT NULL default '0' COMMENT '',
  `STD_ID` int(11) default NULL,
  PRIMARY KEY  (`MSG_ID`),
  KEY `IDX_SDK_S_R_1` (`JOB_ID`),
  KEY `IDX_SDK_S_R_2` (`CANCEL_STATUS`,`CANCEL_COUNT`),
  KEY `IDX_SDK_S_R_3` (`DELIVER_STATUS`,`DELIVER_COUNT`),
  KEY `IDX_SDK_S_R_4` (`SEND_DATE`),
  KEY `IDX_SDK_S_R_5` (`SCHEDULE_TYPE`),
  KEY `search_user` (`USER_ID`),
  KEY `search_log` (`USER_ID`, `RESERVED1`)
) DEFAULT CHARSET=utf8;


CREATE TABLE `SDK_SMS_REPORT_DETAIL` (
  `MSG_ID` int(11) NOT NULL,
  `USER_ID` varchar(20) NOT NULL COMMENT '아이디',
  `JOB_ID` int(11) NOT NULL default '0' COMMENT '고유아이디',
  `SUBJOB_ID` int(11) NOT NULL COMMENT '동보일경우 세부ID',
  `SEND_DATE` varchar(20) NOT NULL COMMENT '발송희망시간',
  `DEST_NAME` varchar(20) NOT NULL COMMENT '수신자이름',
  `PHONE_NUMBER` varchar(20) NOT NULL COMMENT '전화번호',
  `RESULT` int(11) NOT NULL default '0' COMMENT '전송결과값 0:대기,2:성공',
  `TCS_RESULT` int(11) default NULL COMMENT '상세결과 0:성공',
  `FEE` float default NULL COMMENT '요금',
  `DELIVER_DATE` varchar(20) default NULL COMMENT '전달시간',
  `REPORT_RES_DATE` varchar(20) default NULL COMMENT '결과시간DB',
  `MSG_SUBJOB_TYPE` int(11) default NULL COMMENT '0x01:문자메시지',
  `STAT_STATUS` int(11) NOT NULL default '0' COMMENT '상태:0:초기입력,1:통계처리시작,2:중,3:완료',
  `TELCOINFO` varchar(8) default NULL COMMENT '이통사 01690:KT, 01190:SKT, 01990:LGT',
  PRIMARY KEY  (`MSG_ID`,`SUBJOB_ID`),
  KEY `IDX_SDK_S_RD_1` (`JOB_ID`),
  KEY `IDX_SDK_S_RD_2` (`SEND_DATE`),
  KEY `IDX_SDK_S_RD_3` (`RESULT`),
  KEY `IDX_SDK_S_RD_4` (`TCS_RESULT`),
  KEY `IDX_SDK_S_RD_5` (`STAT_STATUS`),
  KEY `search_user` (`USER_ID`)
) DEFAULT CHARSET=utf8;



CREATE TABLE `SDK_MMS_SEND` (
  `MSG_ID` int(11) NOT NULL auto_increment,
  `USER_ID` varchar(20) NOT NULL COMMENT '아이디',
  `SCHEDULE_TYPE` int(11) NOT NULL default '0' COMMENT '0:즉시, 1:예약',
  `SUBJECT` varchar(64) default NULL COMMENT '제목',
  `NOW_DATE` varchar(16) NOT NULL COMMENT 'DB시간',
  `SEND_DATE` varchar(16) NOT NULL COMMENT '발송희망시간',
  `CALLBACK` varchar(20) NOT NULL COMMENT '회신번호',
  `DEST_COUNT` int(11) NOT NULL default '0' COMMENT '수신자목록개수',
  `DEST_INFO` text NOT NULL COMMENT '이름^전화번호',
  `MMS_MSG` text COMMENT '메시지 최대 4000byte',
  `CONTENT_COUNT` int(11) NOT NULL default '0' COMMENT '컨텐츠 수',
  `CONTENT_DATA` varchar(250) default NULL COMMENT '파일명(100kb) test.jpg^1^0|test2.jpg^1^1',
  `KT_OFFICE_CODE` varchar(20) default NULL COMMENT 'KT 유통망 코드',
  `CDR_ID` varchar(20) default NULL COMMENT '과금 ID',
  `RESERVED1` varchar(50) default NULL COMMENT '로그키',
  `RESERVED2` varchar(50) default NULL COMMENT '아이피',
  `RESERVED3` varchar(50) default NULL COMMENT '보상여부:Y',
  `RESERVED4` varchar(50) default NULL COMMENT '전송타입:I,R',
  `RESERVED5` varchar(50) default NULL COMMENT '',
  `RESERVED6` varchar(50) default NULL COMMENT '',
  `SEND_STATUS` int(11) NOT NULL default '0' COMMENT '0:입력,1:처리시작,2:전송중,3:완료(삭제됨),-1:실패',
  `SEND_COUNT` int(11) NOT NULL default '0' COMMENT '',
  `SEND_RESULT` int(11) NOT NULL default '0' COMMENT '전송결과 0:대기,2:성공',
  `SEND_PROC_TIME` varchar(20) default NULL COMMENT '서버로전송시간',
  `MSG_TYPE` int(11) NOT NULL default '0' COMMENT '',
  `STD_ID` int(11) default NULL COMMENT '',
  PRIMARY KEY  (`MSG_ID`),
  KEY `IDX_SDK_M_S_1` (`SEND_STATUS`),
  KEY `IDX_SDK_M_S_2` (`SEND_DATE`),
  KEY `IDX_SDK_M_S_3` (`SCHEDULE_TYPE`),
  KEY `IDX_SDK_M_S_0` (`SEND_STATUS`,`SCHEDULE_TYPE`,`SEND_DATE`),
  KEY `search_user` (`USER_ID`),
  KEY `search_log` (`USER_ID`, `RESERVED1`)
)  DEFAULT CHARSET=utf8;


CREATE TABLE `SDK_MMS_REPORT` (
  `MSG_ID` int(11) NOT NULL,
  `USER_ID` varchar(20) default NULL COMMENT '아이디',
  `JOB_ID` int(11) NOT NULL default '0' COMMENT '서버 고유ID',
  `SCHEDULE_TYPE` int(11) NOT NULL default '0' COMMENT '0:즉시, 1:예약',
  `SUBJECT` varchar(64) default NULL COMMENT '제목',
  `NOW_DATE` varchar(16) default NULL COMMENT 'DB시간',
  `SEND_DATE` varchar(16) NOT NULL COMMENT '발송희망시간',
  `CALLBACK` varchar(20) NOT NULL COMMENT '회신번호',
  `MMS_MSG` text COMMENT '메시지',
  `CONTENT_COUNT` int(11) NOT NULL default '0' COMMENT '컨텐츠개수',
  `CONTENT_DATA` varchar(250) default NULL COMMENT '파일명(100kb) test.jpg^1^0|test2.jpg^1^1',
  `DEST_COUNT` int(11) NOT NULL default '0' COMMENT '수신자수',
  `DEST_INFO` text NOT NULL COMMENT '이름^전화번호',
  `KT_OFFICE_CODE` varchar(20) default NULL COMMENT 'KT 유통망 코드',
  `CDR_ID` varchar(20) default NULL COMMENT '과금ID',
  `RESERVED1` varchar(50) default NULL COMMENT '로그키',
  `RESERVED2` varchar(50) default NULL COMMENT '아이피',
  `RESERVED3` varchar(50) default NULL COMMENT '보상여부:Y',
  `RESERVED4` varchar(50) default NULL COMMENT '전송타입:I,R',
  `RESERVED5` varchar(50) default NULL COMMENT '',
  `RESERVED6` varchar(50) default NULL COMMENT '',
  `SUCC_COUNT` int(11) NOT NULL default '0' COMMENT '성공수',
  `FAIL_COUNT` int(11) NOT NULL default '0' COMMENT '실패수',
  `MSG_TYPE` int(11) NOT NULL default '0' COMMENT 'TEXT:0, HTML:1',
  `STD_ID` int(11) default NULL COMMENT '',
  PRIMARY KEY  (`MSG_ID`),
  KEY `IDX_SDK_M_R_1` (`JOB_ID`),
  KEY `IDX_SDK_M_R_2` (`SEND_DATE`),
  KEY `IDX_SDK_M_R_3` (`SCHEDULE_TYPE`),
  KEY `search_user` (`USER_ID`),
  KEY `search_log` (`USER_ID`, `RESERVED1`)
)  DEFAULT CHARSET=utf8;


CREATE TABLE `SDK_MMS_REPORT_DETAIL` (
  `MSG_ID` int(11) NOT NULL,
  `USER_ID` varchar(20) NOT NULL COMMENT '아이디',
  `JOB_ID` int(11) NOT NULL default '0' COMMENT '서버 고유ID',
  `SUBJOB_ID` int(11) NOT NULL COMMENT '동보일경우ID',
  `SEND_DATE` varchar(16) default NULL COMMENT '발송희망시간',
  `DEST_NAME` varchar(20) default NULL COMMENT '수신자이름',
  `PHONE_NUMBER` varchar(20) default NULL COMMENT '전화번호',
  `RESULT` int(11) NOT NULL default '0' COMMENT '결과 0:대기,2:성공',
  `TCS_RESULT` int(11) default NULL COMMENT '상세결과 0:성공',
  `DELIVER_DATE` varchar(20) default NULL COMMENT '전달시간',
  `READ_TIME` varchar(20) default NULL COMMENT '메시지확인시간',
  `MOBILE_INFO` int(11) default NULL COMMENT '1:SKT, 2:KTF, 3:LGT',
  `FEE` int(11) default NULL COMMENT '요금',
  `REPORT_RES_DATE` varchar(20) default NULL COMMENT '서버로부터 응답시간',
  `STAT_STATUS` int(11) NOT NULL default '0' COMMENT '통계처리상태',
  `STIME` varchar(16) default NULL COMMENT 'KT->이통사발송시간',
  `RTIME` varchar(16) default NULL COMMENT '이통사->KT수신시간',
  PRIMARY KEY  (`MSG_ID`,`SUBJOB_ID`),
  KEY `IDX_SDK_M_RD_1` (`JOB_ID`),
  KEY `IDX_SDK_M_RD_2` (`SEND_DATE`),
  KEY `IDX_SDK_M_RD_3` (`RESULT`),
  KEY `IDX_SDK_M_RD_4` (`TCS_RESULT`),
  KEY `IDX_SDK_M_RD_5` (`STAT_STATUS`),
  KEY `search_user` (`USER_ID`)
) DEFAULT CHARSET=utf8;


-- SMS 발송
INSERT INTO SDK_SMS_SEND 
	( SEND_DATE, USER_ID,DEST_INFO, CALLBACK,  SMS_MSG, RESERVED1,RESERVED2, SEND_STATUS, SEND_RESULT, SUBJECT, CALLBACK_URL, NOW_DATE, SCHEDULE_TYPE, DEST_COUNT) 
VALUES 
	(?, ?, ?, ? , ?, ?, ?, ?, ?, '','', DATE_FORMAT(NOW(),'%Y%m%d%H%i%S'), 1, 1);

-- LMS 발송
INSERT INTO SDK_MMS_SEND
	(SEND_DATE, USER_ID,DEST_INFO, CALLBACK,  MMS_MSG, RESERVED1,RESERVED2, SUBJECT, SEND_STATUS, SEND_RESULT, CALLBACK_URL, NOW_DATE, SCHEDULE_TYPE, DEST_COUNT, MSG_TYPE, CONTENT_COUNT, CONTENT_DATA)
values
	(?, ?, ?, ? , ?, ?, ?, ?, ?, ?, '', DATE_FORMAT(NOW(),'%Y%m%d%H%i%S'), 1, 1, 0, 0, '');

-- MMS 발송
INSERT INTO SDK_MMS_SEND
	(SEND_DATE, USER_ID,DEST_INFO, CALLBACK,  MMS_MSG, RESERVED1,RESERVED2, SUBJECT, SEND_STATUS, SEND_RESULT, CALLBACK_URL, NOW_DATE, SCHEDULE_TYPE, DEST_COUNT, MSG_TYPE, CONTENT_COUNT, CONTENT_DATA)
values
	(?, ?, ?, ? , ?, ?, ?, ?, ?, ?, '', DATE_FORMAT(NOW(),'%Y%m%d%H%i%S'), 1, 1, 0, ?, ?);
