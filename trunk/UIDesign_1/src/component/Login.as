package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	import valueObjects.BooleanAndDescriptionVO;
	import valueObjects.UserInformationVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("logout")]
	[SkinState("login")]
	
	public class Login extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="false")]public var user_id:TextInput;
		[SkinPart(required="false")]public var user_pw:TextInput;
		[SkinPart(required="false")]public var login:Button;
		[SkinPart(required="false")]public var join:Button;
		[SkinPart(required="false")]public var login_id:Label;
		[SkinPart(required="false")]public var point:Label;
		
		private var _cstat:String = "logout";
		public function get cstat():String { return _cstat; }
		public function set cstat(value:String):void { _cstat = value; }
		
		
		public function Login()
		{
			//TODO: implement function
			super();
			login_check();
		}
		/**
		 * login check
		 * */
		public function login_check():void {
			
			RemoteSingleManager.getInstance.addEventListener("getUserInformation", login_check_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getUserInformation();
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			return cstat;
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == join) join.addEventListener(MouseEvent.CLICK, join_clickHandler);
			else if (instance == login) login.addEventListener(MouseEvent.CLICK, login_clickHandler);
			else if (instance == login_id) login_id.text = Gv.user_id;
			else if (instance == point) point.text = SLibrary.addComma( String(Gv.point) );
			else if (instance == user_pw) user_pw.addEventListener(FlexEvent.ENTER, login_clickHandler); 
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if (instance == join) join.removeEventListener(MouseEvent.CLICK, join_clickHandler);
			else if (instance == login) login.removeEventListener(MouseEvent.CLICK, login_clickHandler);
			else if (instance == user_pw) user_pw.removeEventListener(FlexEvent.ENTER, login_clickHandler); 
		}
		
		/**
		 * join Handler
		 * */
		private function join_clickHandler(event:MouseEvent):void {
			
			Main(parentApplication).joinView();
		}
		
		/**
		 * login Handler
		 * */
		private function login_clickHandler(event:Event):void {
			
			if (user_id.text == "") SLibrary.alert("아이디를 입력 하세요");
			else if (user_pw.text == "") SLibrary.alert("비밀번호를 입력 하세요");
			else {
				RemoteSingleManager.getInstance.addEventListener("login", login_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.login(user_id.text, user_pw.text);
			}
		}
		/**
		 * login resultHandler
		 * */
		private function login_resultHandler(event:CustomEvent):void {
			
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				
				callLater(login_check);
				
			} else {
				SLibrary.alert("로그인 실패");
			}
		}
		
		
		/**
		 * login check resultHandler
		 * */
		private function login_check_resultHandler(event:CustomEvent):void {
			
			var uvo:UserInformationVO = event.result as UserInformationVO;
			if (uvo != null) {
				cstat = "login";
				Gv.bLogin = true;
				Gv.user_id = uvo.user_id;
				Gv.point = uint( uvo.point );
			} else {
				cstat = "logout";
			}
			invalidateSkinState();
		}
		
	}
}