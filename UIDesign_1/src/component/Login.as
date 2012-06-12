package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import lib.BooleanAndDescriptionVO;
	import lib.Gv;
	import lib.RemoteManager;
	import lib.SLibrary;
	
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Button;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
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
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		/**
		 * join Handler
		 * */
		private function join_clickHandler(event:MouseEvent):void {
			
			if ( parentApplication.join )
				parentApplication.join.visible = true;
		}
		
		/**
		 * login Handler
		 * */
		private function login_clickHandler(event:MouseEvent):void {
			
			if (user_id.text == "") SLibrary.alert("아이디를 입력 하세요");
			else if (user_pw.text == "") SLibrary.alert("비밀번호를 입력 하세요");
			else {
				RemoteManager.getInstance.result = login_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.login(user_id.text, user_pw.text);
			}
		}
		/**
		 * login resultHandler
		 * */
		private function login_resultHandler(event:ResultEvent):void {
			
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				cstat = "login";
				invalidateSkinState();
			} else {
				SLibrary.alert("로그인 실패");
			}
		}
		
		/**
		 * login check
		 * */
		private function login_check():void {
			
			RemoteManager.getInstance.result = login_check_resultHandler;
			RemoteManager.getInstance.callresponderToken 
				= RemoteManager.getInstance.service.getUserInformation();
		}
		/**
		 * login check resultHandler
		 * */
		private function login_check_resultHandler(event:ResultEvent):void {
			
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