package com.m.send;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Hashtable;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.common.Filtering;
import com.m.common.Gv;
import com.m.common.PointManager;
import com.m.common.Refuse;
import com.m.member.UserInformationVO;
import com.m.send.telecom.KT;
import com.m.send.telecom.LG;
import com.m.send.telecom.PP;


public class SendManager implements ISend {

	public static final int SMS_BYTE = 90;
	public static final int SMS_CODE = 11;
	public static final int LMS_CODE = 41;
	public static final int MMS_CODE = 21;
	
	static ISend send = new SendManager();
	public static ISend getInstance() {
		return send;
	}
	private SendManager(){}
	
	@Override
	public LogVO send(Connection conn, UserInformationVO uvo, SendMessageVO smvo)
			throws Exception {
		
		LogVO lvo = null;
		ArrayList<MessageVO> al = null;
		int idx = 0;
		int rslt = 0;
		
		checkSendMessageVO(smvo);
		Gv.setStatus(uvo.getUser_id(), "message check..");
		checkAuth(conn, uvo, smvo);
		Gv.setStatus(uvo.getUser_id(), "auth check..");
		
		lvo = makeLogVO(uvo, smvo);
		idx = insertLog(conn, lvo);
		
		Gv.setStatus(uvo.getUser_id(), "save log..");
		
		int typePoint =  SLibrary.intValue(VbyP.getValue(getMode(smvo)+"_COUNT"));
		int point = smvo.getAl().size() * typePoint;
		
		if (idx > 0)
			rslt = updatePoint(conn, uvo, lvo.getMode(), point);
		else throw new Exception("insertLog Error!!");
		Gv.setStatus(uvo.getUser_id(), "update point");
		
		if (rslt > 0){
			al = makeMessageVOArrayList(uvo, smvo, idx);
			Gv.setStatus(uvo.getUser_id(), "list make");
			rslt = insertData(conn, lvo.getMode(), uvo, al, uvo.getLine());
			if ( rslt <= 0 ) throw new Exception("전송데이터가 등록되지 않았습니다.");
			
			if (rslt*typePoint < point) {
				VbyP.accessLog(uvo.getUser_id()+" >> fail add : "+ (point - (rslt*typePoint)));
				rslt = updateFailPoint(conn, uvo, lvo.getMode(), point - (rslt*typePoint));
				if ( rslt <= 0 ) VbyP.errorLog(uvo.getUser_id()+" >> fail add : "+ (point - (rslt*typePoint))+" "+lvo.getMode()+" Fail!!!!!");
			}
			
			Gv.setStatus(uvo.getUser_id(), "Success!!");
		}
		else throw new Exception("insertData Error!!");
		
		lvo.setIdx(idx);
		
		return lvo;
	}
	
	public LogVO Adminsend(Connection conn, UserInformationVO uvo, SendMessageVO smvo)
			throws Exception {
		
		LogVO lvo = null;
		ArrayList<MessageVO> al = null;
		int idx = 0;
		int rslt = 0;
		
		checkSendMessageVO(smvo);
		
		lvo = makeLogVO(uvo, smvo);
		idx = insertLog(conn, lvo);
		
		Gv.setStatus(uvo.getUser_id(), "save log..");

		
		if (idx <= 0){
			al = makeMessageVOArrayList(uvo, smvo, idx);
			Gv.setStatus(uvo.getUser_id(), "list make");
			rslt = insertData(conn, lvo.getMode(), uvo, al, uvo.getLine());
			if ( rslt <= 0 ) throw new Exception("전송데이터가 등록되지 않았습니다.");
			Gv.setStatus(uvo.getUser_id(), "Success!!");
		}
		else throw new Exception("insertLog Error!!");
		
		lvo.setIdx(idx);
		
		return lvo;
	}
	

	@Override
	public int insertLog(Connection conn, LogVO lvo) throws Exception {
		
		int rslt = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertSendLog"));
		pq.setString(1, lvo.getUser_id());
		pq.setString(2, lvo.getLine());
		pq.setString(3, lvo.getMode());
		pq.setString(4, lvo.getMethod());
		pq.setString(5, lvo.getMessage());
		pq.setInt(6, lvo.getCnt());
		pq.setString(7, lvo.getUser_ip());
		pq.setString(8, lvo.getTimeSend());
		rslt = pq.executeUpdate();
		
		if (rslt <= 0) return 0;
		else return getSMSLogKey(conn);
	}

	@Override
	public int updatePoint(Connection conn, UserInformationVO uvo, String type, int count) throws Exception {
		
		int code = 0;
		if (type.equals("LMS")) { code = SendManager.LMS_CODE;}
		else if (type.equals("MMS")) { code = SendManager.MMS_CODE; }
		else { code = SendManager.SMS_CODE; }
		
		PointManager pm = PointManager.getInstance();		
		return pm.insertUserPoint(conn, uvo, code, count *-1);
	}

	@Override
	public int insertData(Connection conn, String mode, UserInformationVO uvo, ArrayList<MessageVO> al, String line) throws Exception {

		int count = al.size();
		int resultCount = 0;
		
		if (count > 0) {
			
			MessageVO vo = null;
			int maxBatch = SLibrary.parseInt( VbyP.getValue("executeBatchCount") );
			ILineSet ls = getLineInstance(line);
			
			Hashtable<String, String> hashTable_refuse = Refuse.getRefusePhoneFromDB(uvo.getUser_id());
			Hashtable<String, String> hashTable_duple = new Hashtable<String, String>();
			
			PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
			
			try {
				
				//conn.setAutoCommit(false);
				pq.setPrepared( conn, ls.getInsertQuery(mode) );
				
				VbyP.accessLog(" - conn.getAutoCommit() : "+conn.getAutoCommit());
			
				for (int i = 0; i < count; i++) {
					
					vo = al.get(i);
					/*
					if (Refuse.isRefuse(hashTable_refuse, vo.getPhone())) // refuse
						ls.insertClientPqSetter_fail(mode, pq, vo, VbyP.getValue("refuse_code"));
					else if (hashTable_duple.containsKey(vo.getPhone())) // duple
						ls.insertClientPqSetter_fail(mode, pq, vo, VbyP.getValue("duple_code"));
					else {
						hashTable_duple.put(vo.getPhone(), "");
						ls.insertClientPqSetter(mode, pq, vo);
					}
					*/
					if (!Refuse.isRefuse(hashTable_refuse, vo.getPhone()) && !hashTable_duple.containsKey(vo.getPhone())) {
						hashTable_duple.put(vo.getPhone(), "");
						ls.insertClientPqSetter(mode, pq, vo);
						pq.addBatch();
						
						if (i >= maxBatch && (i%maxBatch) == 0 ) {
							
							resultCount += pq.executeBatchNoClose();
							VbyP.accessLog(" - complete : "+resultCount);
						}
					}
					
												
	
					Gv.setStatus(uvo.getUser_id(), Integer.toString(i+1));
					
					
					
				}
				resultCount += pq.executeBatch();
				
				
			
			} catch (Exception e) {
				
			} finally {
				pq.close();
			}
		}
		
		return resultCount;
	}
	
	private int updateFailPoint(Connection conn, UserInformationVO uvo, String type, int count) throws Exception {
		
		int code = 0;
		int typeCnt = 0;
		if (type.equals("LMS")) { code = 47; typeCnt = SLibrary.intValue(VbyP.getValue("LMS_COUNT")); }
		else if (type.equals("MMS")) { code = 27; typeCnt = SLibrary.intValue(VbyP.getValue("MMS_COUNT")); }
		else { code = 17; typeCnt = SLibrary.intValue(VbyP.getValue("SMS_COUNT")); }
		
		PointManager pm = PointManager.getInstance();		
		return pm.insertUserPoint(conn, uvo, code, count * typeCnt);
	}
	
	
	private ILineSet getLineInstance(String line) throws Exception {
		
		ILineSet ls = null;
		
		if (line.equals("lg")) ls = LG.getInstance();
		else if (line.equals("pp")) ls = PP.getInstance();
		else if (line.equals("kt")) ls = KT.getInstance();
		else throw new Exception("no line class!!");
		
		return ls;
	}
	
	private int getSMSLogKey(Connection conn) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("getSendLogInsertKey") );
		return pq.ExecuteQueryNum();
				
	}
	
	private ArrayList<MessageVO> makeMessageVOArrayList(UserInformationVO uvo, SendMessageVO smvo, int groupKey) throws Exception {
		
		ArrayList<MessageVO> al = new ArrayList<MessageVO>();
		PhoneVO pvo = null;
		MessageVO vo = null;
		String sendDate = "";
		String dFormat = uvo.getLine().equals("kt")? "yyyyMMddHHmmss": "yyyy-MM-dd HH:mm:ss";
		
		String img = "";
		ILineSet ls = getLineInstance(uvo.getLine());
		
		
		int count = smvo.getAl().size();
		
		if (smvo.isbReservation())
			sendDate = smvo.getReservationDate();
		else
			sendDate = SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss");
		
		sendDate = ls.parseDate(sendDate);
		img = ls.parseMMSPath(smvo.getImagePath());
		
		for (int i = 0; i < count; i++) {
			
			vo = new MessageVO();
			pvo = smvo.getAl().get(i);
			if (smvo.isbInterval() && i != 0 && (i+1) % smvo.getItCount() == 0) 
				sendDate = SLibrary.getDateAddSecond(dFormat, sendDate, smvo.getItMinute() * 60);
			
			
			vo.setGroupKey(groupKey);
			vo.setSendDate(sendDate);
			vo.setUser_id(uvo.getUser_id());
			vo.setPhone(pvo.getpNo());
			vo.setName(pvo.getpName());
			vo.setCallback(smvo.getReturnPhone());
			vo.setMsg(smvo.getMessage());
			vo.setSendMode( smvo.isbReservation() ? "R" : "I");
			vo.setImagePath( img );
			
			al.add(vo);
		}
		return al;
	}

	private LogVO makeLogVO(UserInformationVO uvo, SendMessageVO smvo) {
		
		LogVO lvo = new LogVO();
		
		lvo.setUser_id( uvo.getUser_id() );
		lvo.setLine( uvo.getLine() );
		lvo.setMode( getMode(smvo) );
		lvo.setMethod( getMethod(smvo) );
		lvo.setMessage( smvo.getMessage() );
		lvo.setCnt( smvo.getAl().size() );
		lvo.setUser_ip( smvo.getReqIP() );
		lvo.setTimeSend( smvo.isbReservation()? smvo.getReservationDate() : SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss") );
		lvo.setTimeWrite( SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss") );
		return lvo;
	}

	private String getMethod(SendMessageVO smvo) {
		
		String method = "N";
		if (smvo.isbReservation()) method = "R";
		if (smvo.isbInterval()) method = "I";
		
		return method;
	}

	private String getMode(SendMessageVO smvo) {

		String mode = "SMS";
		if (!SLibrary.isNull(smvo.getImagePath()))
			mode = "MMS";
		else if ( SLibrary.getByte( smvo.getMessage() ) > SendManager.SMS_BYTE)
			mode = "LMS";
		return mode;
	}

	private void checkAuth(Connection conn, UserInformationVO uvo, SendMessageVO smvo) throws Exception{
		
		int sendCount = smvo.getAl().size();
		//최대 발송건수
		if ( Integer.parseInt(VbyP.getValue("maxSendCount")) < sendCount )
			throw new Exception( VbyP.getValue("maxSendCount")+" 건 이상 발송 하실 수 없습니다.");
		
		//탈퇴회원 체크
		if( uvo.getLevaeYN().equals("Y") ){ throw new Exception("잘못된 접근입니다."); 	}
		
		if( Integer.parseInt(uvo.getPoint()) < sendCount )
			throw new Exception("잔여건수가 부족합니다. ( "+ Integer.toString(sendCount)+" / "+ uvo.getPoint()+" )");
		
		//message 필터링
		if ( Integer.parseInt(VbyP.getValue("filterMinCount")) <= sendCount  ) {
			
			String filterMessage = null;
			filterMessage = Filtering.globalMessageFiltering(smvo.getMessage());
			if (filterMessage == null )
				filterMessage = Filtering.messageFiltering(uvo.getUser_id(), smvo.getMessage());
			
			
			if (filterMessage != null) {
				
				VbyP.accessLog(uvo.getUser_id() +" >> 전송 요청 : 스팸필터 ("+filterMessage+")");
//						AdminSMS asms = AdminSMS.getInstance();
//						asms.sendAdmin(conn, 
//								"M["+bGlobal+"스팸필터]\r\n" + mvo.getUser_id() + "\r\n" 
//								+ filterMessage  );
				throw new Exception("스팸성 문구가 발견 되었습니다.");
			}
		}
		//ip 필터링
		if ( Filtering.ipFiltering(uvo.getUser_id(), smvo.getReqIP()) != null ) {
			VbyP.accessLog(uvo.getUser_id() +" >> 전송 요청 : IP필터 ("+Filtering.ipFiltering(uvo.getUser_id(), smvo.getReqIP())+")");
			throw new Exception("고객님은 현재 발송이 제한되어 있습니다.");
		}
		
		if (SLibrary.getByte(smvo.getMessage()) > 2000) throw new Exception("2000byte 이상 발송 할수 없습니다.");
		
		//메시지 이통사 미적용 한글 확인
		String isMessage = isMessage(smvo.getMessage());
		if ( isMessage != null )
			throw new Exception("["+isMessage+"] 문자가 맞춤법에 어긋납니다.수정하세요.");
	}

	private void checkSendMessageVO(SendMessageVO smvo) throws Exception {
		
		if (SLibrary.isNull(smvo.getMessage()) && SLibrary.isNull(smvo.getImagePath()))	throw new Exception("메시지가 없습니다.");
		if (smvo.getAl() == null || smvo.getAl().size() <= 0)	throw new Exception("전화번호가 없습니다.");
		if (SLibrary.isNull(smvo.getReqIP()))	throw new Exception("발송자 아이피 정보가 없습니다.");
		
		// interval check
		if (smvo.isbInterval()) {
			if (smvo.getItCount() <= 0 || smvo.getItMinute() <= 0) throw new Exception("0 보다 작은수 입니다.");
		}
		
		// reservation check
		if ( smvo.isbReservation() && SLibrary.getTime(smvo.getReservationDate(), "yyyy-MM-dd HH:mm:ss") == 0 )
			throw new Exception("형식에 맞지 않는 예약일자 입니다.");
		
		if ( smvo.isbReservation()	
				&& SLibrary.getTime(smvo.getReservationDate(), "yyyy-MM-dd HH:mm:ss") < (SLibrary.parseLong( SLibrary.getUnixtimeStringSecond() ) + 0)*1000 ){
			throw new Exception("과거시간으로 예약 하실 수 없습니다.");
		}
	}

	/**
	 * euc-kr check
	 * @param message
	 * @return
	 */
	private String isMessage(String message) {
		
		String rslt = null;
		if (message != null) {
			StringBuffer buf = new StringBuffer();
			buf.append("가각간갇갈갉갊감갑값갓갔강갖갗같갚갛개객갠갤갬갭갯갰갱갸갹갼걀걋걍걔걘걜거걱건걷걸걺검겁것겄겅겆겉겊겋게겐겔겜겝겟겠겡겨격겪견겯결겸겹겻겼경곁계곈곌곕곗고곡곤곧골곪곬곯곰곱곳공곶과곽관괄괆괌괍괏광괘괜괠괩괬괭괴괵괸괼굄굅굇굉교굔굘굡굣구국군굳굴굵굶굻굼굽굿궁궂궈궉권궐궜궝궤궷귀귁귄귈귐귑귓규균귤그극근귿글긁금급긋긍긔기긱긴긷길긺김깁깃깅깆깊까깍깎깐깔깖깜깝깟깠깡깥깨깩깬깰깸깹깻깼깽꺄꺅꺌꺼꺽꺾껀껄껌껍껏껐껑께껙껜껨껫껭껴껸껼꼇꼈꼍꼐꼬꼭꼰꼲꼴꼼꼽꼿꽁꽂꽃꽈꽉꽐꽜꽝꽤꽥꽹꾀꾄꾈꾐꾑꾕꾜꾸꾹꾼꿀꿇꿈꿉꿋꿍꿎꿔꿜꿨꿩꿰꿱꿴꿸뀀뀁뀄뀌뀐뀔뀜뀝뀨끄끅끈끊끌끎끓끔끕끗끙끝끼끽낀낄낌낍낏낑나낙낚난낟날낡낢남납낫났낭낮낯낱낳내낵낸낼냄냅냇냈냉냐냑냔냘냠냥너넉넋넌널넒넓넘넙넛넜넝넣네넥넨넬넴넵넷넸넹녀녁년녈념녑녔녕녘녜녠노녹논놀놂놈놉놋농높놓놔놘놜놨뇌뇐뇔뇜뇝뇟뇨뇩뇬뇰뇹뇻뇽누눅눈눋눌눔눕눗눙눠눴눼뉘뉜뉠뉨뉩뉴뉵뉼늄늅늉느늑는늘늙늚늠늡늣능늦늪늬늰늴니닉닌닐닒님닙닛닝닢다닥닦단닫달닭닮닯닳담답닷닸당닺닻닿대댁댄댈댐댑댓댔댕댜더덕덖던덛덜덞덟덤덥덧덩덫덮데덱덴델뎀뎁뎃뎄뎅뎌뎐뎔뎠뎡뎨뎬도독돈돋돌돎돐돔돕돗동돛돝돠돤돨돼됐되된될됨됩됫됴두둑둔둘둠둡둣둥둬뒀뒈뒝뒤뒨뒬뒵뒷뒹듀듄듈듐듕드득든듣들듦듬듭듯등듸디딕딘딛딜딤딥딧딨딩딪따딱딴딸땀땁땃땄땅땋때땍땐땔땜땝땟땠땡떠떡떤떨떪떫떰떱떳떴떵떻떼떽뗀뗄뗌뗍뗏뗐뗑뗘뗬또똑똔똘똥똬똴뙈뙤뙨뚜뚝뚠뚤뚫뚬뚱뛔뛰뛴뛸뜀뜁뜅뜨뜩뜬뜯뜰뜸뜹뜻띄띈띌띔띕띠띤띨띰띱띳띵라락란랄람랍랏랐랑랒랖랗래랙랜랠램랩랫랬랭랴략랸럇량러럭런럴럼럽럿렀렁렇레렉렌렐렘렙렛렝려력련렬렴렵렷렸령례롄롑롓로록론롤롬롭롯롱롸롼뢍뢨뢰뢴뢸룀룁룃룅료룐룔룝룟룡루룩룬룰룸룹룻룽뤄뤘뤠뤼뤽륀륄륌륏륑류륙륜률륨륩륫륭르륵른를름릅릇릉릊릍릎리릭린릴림립릿링마막만많맏말맑맒맘맙맛망맞맡맣매맥맨맬맴맵맷맸맹맺먀먁먈먕머먹먼멀멂멈멉멋멍멎멓메멕멘멜멤멥멧멨멩며멱면멸몃몄명몇몌모목몫몬몰몲몸몹못몽뫄뫈뫘뫙뫼묀묄묍묏묑묘묜묠묩묫무묵묶문묻물묽묾뭄뭅뭇뭉뭍뭏뭐뭔뭘뭡뭣뭬뮈뮌뮐뮤뮨뮬뮴뮷므믄믈믐믓미믹민믿밀밂밈밉밋밌밍및밑바박밖밗반받발밝밞밟밤밥밧방밭배백밴밸뱀뱁뱃뱄뱅뱉뱌뱍뱐뱝버벅번벋벌벎범법벗벙벚베벡벤벧벨벰벱벳벴벵벼벽변별볍볏볐병볕볘볜보복볶본볼봄봅봇봉봐봔봤봬뵀뵈뵉뵌뵐뵘뵙뵤뵨부북분붇불붉붊붐붑붓붕붙붚붜붤붰붸뷔뷕뷘뷜뷩뷰뷴뷸븀븃븅브븍븐블븜븝븟비빅빈빌빎빔빕빗빙빚빛빠빡빤빨빪빰빱빳빴빵빻빼빽뺀뺄뺌뺍뺏뺐뺑뺘뺙뺨뻐뻑뻔뻗뻘뻠뻣뻤뻥뻬뼁뼈뼉뼘뼙뼛뼜뼝뽀뽁뽄뽈뽐뽑뽕뾔뾰뿅뿌뿍뿐뿔뿜뿟뿡쀼쁑쁘쁜쁠쁨쁩삐삑삔삘삠삡삣삥사삭삯산삳살삵삶삼삽삿샀상샅새색샌샐샘샙샛샜생샤샥샨샬샴샵샷샹섀섄섈섐섕서석섞섟선섣설섦섧섬섭섯섰성섶세섹센셀셈셉셋셌셍셔셕션셜셤셥셧셨셩셰셴셸솅소속솎손솔솖솜솝솟송솥솨솩솬솰솽쇄쇈쇌쇔쇗쇘쇠쇤쇨쇰쇱쇳쇼쇽숀숄숌숍숏숑수숙순숟술숨숩숫숭숯숱숲숴쉈쉐쉑쉔쉘쉠쉥쉬쉭쉰쉴쉼쉽쉿슁슈슉슐슘슛슝스슥슨슬슭슴습슷승시식신싣실싫심십싯싱싶싸싹싻싼쌀쌈쌉쌌쌍쌓쌔쌕쌘쌜쌤쌥쌨쌩썅써썩썬썰썲썸썹썼썽쎄쎈쎌쏀쏘쏙쏜쏟쏠쏢쏨쏩쏭쏴쏵쏸쐈쐐쐤쐬쐰쐴쐼쐽쑈쑤쑥쑨쑬쑴쑵쑹쒀쒔쒜쒸쒼쓩쓰쓱쓴쓸쓺쓿씀씁씌씐씔씜씨씩씬씰씸씹씻씽아악안앉않알앍앎앓암압앗았앙앝앞애액앤앨앰앱앳앴앵야약얀얄얇얌얍얏양얕얗얘얜얠얩어억언얹얻얼얽얾엄업없엇었엉엊엌엎에엑엔엘엠엡엣엥여역엮연열엶엷염엽엾엿였영옅옆옇예옌옐옘옙옛옜오옥온올옭옮옰옳옴옵옷옹옻와왁완왈왐왑왓왔왕왜왝왠왬왯왱외왹왼욀욈욉욋욍요욕욘욜욤욥욧용우욱운울욹욺움웁웃웅워웍원월웜웝웠웡웨웩웬웰웸웹웽위윅윈윌윔윕윗윙유육윤율윰윱윳융윷으윽은을읊음읍읏응읒읓읔읕읖읗의읜읠읨읫이익인일읽읾잃임입잇있잉잊잎자작잔잖잗잘잚잠잡잣잤장잦재잭잰잴잼잽잿쟀쟁쟈쟉쟌쟎쟐쟘쟝쟤쟨쟬저적전절젊점접젓정젖제젝젠젤젬젭젯젱져젼졀졈졉졌졍졔조족존졸졺좀좁좃종좆좇좋좌좍좔좝좟좡좨좼좽죄죈죌죔죕죗죙죠죡죤죵주죽준줄줅줆줌줍줏중줘줬줴쥐쥑쥔쥘쥠쥡쥣쥬쥰쥴쥼즈즉즌즐즘즙즛증지직진짇질짊짐집짓징짖짙짚짜짝짠짢짤짧짬짭짯짰짱째짹짼쨀쨈쨉쨋쨌쨍쨔쨘쨩쩌쩍쩐쩔쩜쩝쩟쩠쩡쩨쩽쪄쪘쪼쪽쫀쫄쫌쫍쫏쫑쫓쫘쫙쫠쫬쫴쬈쬐쬔쬘쬠쬡쭁쭈쭉쭌쭐쭘쭙쭝쭤쭸쭹쮜쮸쯔쯤쯧쯩찌찍찐찔찜찝찡찢찧차착찬찮찰참찹찻찼창찾채책챈챌챔챕챗챘챙챠챤챦챨챰챵처척천철첨첩첫첬청체첵첸첼쳄쳅쳇쳉쳐쳔쳤쳬쳰촁초촉촌촐촘촙촛총촤촨촬촹최쵠쵤쵬쵭쵯쵱쵸춈추축춘출춤춥춧충춰췄췌췐취췬췰췸췹췻췽츄츈츌츔츙츠측츤츨츰츱츳층치칙친칟칠칡침칩칫칭카칵칸칼캄캅캇캉캐캑캔캘캠캡캣캤캥캬캭컁커컥컨컫컬컴컵컷컸컹케켁켄켈켐켑켓켕켜켠켤켬켭켯켰켱켸코콕콘콜콤콥콧콩콰콱콴콸쾀쾅쾌쾡쾨쾰쿄쿠쿡쿤쿨쿰쿱쿳쿵쿼퀀퀄퀑퀘퀭퀴퀵퀸퀼큄큅큇큉큐큔큘큠크큭큰클큼큽킁키킥킨킬킴킵킷킹타탁탄탈탉탐탑탓탔탕태택탠탤탬탭탯탰탱탸턍터턱턴털턺텀텁텃텄텅테텍텐텔템텝텟텡텨텬텼톄톈토톡톤톨톰톱톳통톺톼퇀퇘퇴퇸툇툉툐투툭툰툴툼툽툿퉁퉈퉜퉤튀튁튄튈튐튑튕튜튠튤튬튱트특튼튿틀틂틈틉틋틔틘틜틤틥티틱틴틸팀팁팃팅파팍팎판팔팖팜팝팟팠팡팥패팩팬팰팸팹팻팼팽퍄퍅퍼퍽펀펄펌펍펏펐펑페펙펜펠펨펩펫펭펴편펼폄폅폈평폐폘폡폣포폭폰폴폼폽폿퐁퐈퐝푀푄표푠푤푭푯푸푹푼푿풀풂품풉풋풍풔풩퓌퓐퓔퓜퓟퓨퓬퓰퓸퓻퓽프픈플픔픕픗피픽핀필핌핍핏핑하학한할핥함합핫항해핵핸핼햄햅햇했행햐향허헉헌헐헒험헙헛헝헤헥헨헬헴헵헷헹혀혁현혈혐협혓혔형혜혠혤혭호혹혼홀홅홈홉홋홍홑화확환활홧황홰홱홴횃횅회획횐횔횝횟횡효횬횰횹횻후훅훈훌훑훔훗훙훠훤훨훰훵훼훽휀휄휑휘휙휜휠휨휩휫휭휴휵휸휼흄흇흉흐흑흔흖흗흘흙흠흡흣흥흩희흰흴흼흽힁히힉힌힐힘힙힛힝");
			buf.append("　！'，．／：；？＾＿｀｜￣、。·‥…¨〃­―∥＼～´?ˇ˘˝˚˙¸˛¡¿ː＂（）［］｛｝‘’“”〔〕〈〉《》「」『』【】+－＜=＞±×÷≠≤≥∞∴♂♀∠⊥⌒∂∇≡≒≪≫√∽∝∵∫∬∈∋⊆⊇⊂⊃∪∩∧∨￢⇒⇔∀∃∮∑∏＄％￦Ｆ′″℃Å￠￡￥¤℉‰㎕㎖㎗ℓ㎘㏄㎣㎤㎥㎦㎙㎚㎛㎜㎝㎞㎟㎠㎡㎢㏊㎍㎎㎏㏏㎈㎉㏈㎧㎨㎰㎱㎳㎴㎵㎶㎷㎸㎹㎀㎁㎂㎃㎄㎺㎻㎼㎽㎾㎿㎐㎑㎒㎓㎔Ω㏀㏁㎊㎋㎌㏖㏅㎭㎭㎮㎯㏛㎩㎪㎫㎬㏝㏐㏓㏃㏉㏜㏆＃＆＊＠■※☆★○●◎◇◆□■△▲▽▼→←↑↓↔〓◁◀▷▶♤♠♡♥♧♣⊙◈▣◐◑▒▤▥▨▧▦▩♨☏☎☜☞■†‡↕↗↙↖↘♭♩♪♬㉿㈜№㏇™㏂㏘℡■■─│┌┐┘└├┬┤┴┼━┃┏┓┛┗┣┳┫┻╋┠┯┨┷┿┝┰┥┸╂┒┑┚┙┖┕┎┍┞┟┡┢┦┧┩┪┭┮┱┲┵┶┹┺┽┾╀╁╃╄╅╆╇╈╉╊㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩㉪㉫㉬㉭㉮㉯㉰㉱㉲㉳㉴㉵㉶㉷㉸㉹㉺㉻㈀㈁㈂㈃㈄㈅㈆㈇㈈㈉㈊㈋㈌㈍㈎㈏㈐㈑㈒㈓㈔㈕㈖㈗㈘㈙㈚㈛ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨⒩⒪⒫⒬⒭⒮⒯⒰⒱⒲⒳⑻⒵⑴⑵⑶⑷⑸⑹⑺⒴⑼⑽⑾⑿⒀⒁⒂ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ½⅔⅔¼¾⅛⅜⅝⅞¹²³⁴ⁿ₁₂₃₄ㄱㄲㄳㄴㄵㄶㄷㄸㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅃㅄㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣㅥㅦㅧㅨㅩㅪㅫㅬㅭㅮㅯㅰㅱㅲㅳㅴㅵㅶㅷㅸㅹㅺㅻㅼㅽㅾㅿㆀㆁㆂㆃㆄㆅㆆㆇㆈㆉㆊㆋㆌㆍㆎＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚㅍΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩαβγδεζηθικλμνξοπρστυφχψω");
			buf.append("ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ");
			buf.append("ㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣ");
			buf.append("ァィゥェォアイウエオカキクケコガギグゲゴサシスセソザジズゼゾタチッツテトダヂヅデドナニヌネノハヒフヘホバビブベボパピプペポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶ");
			buf.append("ぁぃぅぇぉあいうえおかきくけこがぎぐげごさしすせそざじずぜぞたちっつてとだぢづでどなにぬねのはひふへほばびぶべぼぱぴぷぺぽまみむめもゃやゅゆょよらりるれろゎわゐゑをん");
			String str = buf.toString();
			int count = message.length();
			char chr;
			
			
			
			for (int i = 0; i < count; i++) {
				
				chr = message.charAt(i);
				
				if ( (int)message.charAt(i) > 127) {
						if ( str.indexOf( chr ) < 0 ) {
							Character cr = new Character(chr);
							rslt = cr.toString();
							break;
						}
				}
			}
		}
		return rslt;
	}
	

}
