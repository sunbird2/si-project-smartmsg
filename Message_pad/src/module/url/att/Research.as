package module.url.att
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import module.url.att.skin.ResearchSkin;
	import module.url.att.skin.ResearchSkinRendererEdit1;
	import module.url.att.skin.ResearchSkinRendererEdit2;
	import module.url.att.skin.ResearchSkinRendererEdit3;
	import module.url.att.skin.ResearchSkinRendererView1;
	import module.url.att.skin.ResearchSkinRendererView2;
	import module.url.att.skin.ResearchSkinRendererView3;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	
	import spark.components.Button;
	import spark.components.ButtonBar;
	import spark.components.DropDownList;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.TextArea;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Research extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		
		[SkinPart(required="true")]public var question:Label;
		[SkinPart(required="true")]public var answer:List;
		
		[SkinPart(required="true")]public var qInput:TextInput;
		[SkinPart(required="true")]public var aType:ButtonBar;
		[SkinPart(required="true")]public var answerAdd:Button;
		
		
		private var _att:Object;
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var _stat:String = "default";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			_stat = value;
			autoListRenderer();
			invalidateSkinState();
		}
		
		[Bindable]
		public var questionLabel:String = "질문...";
		[Bindable]
		public var answerType:int = 0;
		
		[Bindable]
		private var acAnswer:ArrayCollection = new ArrayCollection(["",""]);
		
		private var acAnswerOne:ArrayCollection = new ArrayCollection([""]);
		
		private var acAnswerType:ArrayCollection = new ArrayCollection(["하나선택","여러개 선택","입력"]);
		
		public function Research(val:Object){ 
			super();
			att = val;
			init();
			setStyle("skinClass", ResearchSkin);
		}
		private function init():void {
			if (att != null) {
				questionLabel = att.q;
				answerType = att.a.type;
				acAnswer = new ArrayCollection(att.a.value);
			}
		}
		
		public function getJson():String { return null; }
		public function setJson(json:String):void { }
		
		
		override protected function getCurrentSkinState():String
		{
			if (att != null && _stat == "actEmpty") _stat = "actContent";
			else if (att != null && _stat == "default") {
				_stat = "view";
			}
			return this._stat;
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == question) question.text = questionLabel;
			else if (instance == answer) {
				answer.dataProvider = answerType == 2? acAnswerOne:acAnswer;
				answer.itemRenderer = getViewRenderer();
			}
			else if (instance == qInput) {
				qInput.text = questionLabel;
				qInput.addEventListener(KeyboardEvent.KEY_UP, qInput_keyupHandler);
			}
			else if (instance == aType) {
				aType.dataProvider = acAnswerType;
				aType.selectedIndex = answerType;
				aType.addEventListener(IndexChangeEvent.CHANGE, aType_changeHandler);
			}
			else if (instance == answerAdd) {
				answerAdd.addEventListener(MouseEvent.CLICK, answerAdd_clickHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function autoListRenderer():void {
			if (_stat == "default" || _stat == "view" ) {
				answer.itemRenderer = getViewRenderer();
			} else {
				answer.itemRenderer = getEditRenderer();
			}
		}
		
		private function getViewRenderer():ClassFactory {
			
			var cf:ClassFactory = null;
			switch(answerType) {
				case 0: { cf = new ClassFactory(ResearchSkinRendererView1); break; }
				case 1: { cf = new ClassFactory(ResearchSkinRendererView2); break; }
				case 2: { cf = new ClassFactory(ResearchSkinRendererView3); break; }
				default: { break; }
			}
			
			return cf;
		}
		private function getEditRenderer():ClassFactory {
			
			var cf:ClassFactory = null;
			switch(answerType) {
				case 0: { cf = new ClassFactory(ResearchSkinRendererEdit1); break; }
				case 1: { cf = new ClassFactory(ResearchSkinRendererEdit2); break; }
				case 2: { cf = new ClassFactory(ResearchSkinRendererEdit3); break; }
				default: { break; }
			}
			return cf;
		}
		
		private function aType_changeHandler(event:IndexChangeEvent):void {
			
			answerType = event.newIndex;
			answerDataProviderChange();
			autoListRenderer();
		}
		private function answerDataProviderChange():void {
			
			var ac:ArrayCollection = answerType == 2? acAnswerOne:acAnswer;
			answer.dataProvider = ac;
		}
		
		private function answerAdd_clickHandler(event:MouseEvent):void {
			acAnswer.addItem("정답입니다.");
		}
		
		private function qInput_keyupHandler(event:KeyboardEvent):void {
			questionLabel = qInput.text;
		}
		
	}
}