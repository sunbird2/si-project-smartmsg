<%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	int instance = SLibrary.intValue(request.getParameter("instance"));

%><br/>
<form name="tx_editor_form<%=instance%>" id="tx_editor_form<%=instance%>" method="post" accept-charset="utf-8">
		<div id="tx_trex_container<%=instance%>" class="tx-editor-container">
			<div id="tx_toolbar_basic<%=instance%>" class="tx-toolbar tx-toolbar-basic"><div class="tx-toolbar-boundary">
				<ul class="tx-bar tx-bar-left">
					<li class="tx-list">
						<div unselectable="on" class="tx-slt-42bg tx-fontsize" id="tx_fontsize<%=instance%>">
							<a href="javascript:;" title="글자크기">9pt</a>
						</div>
						<div id="tx_fontsize_menu<%=instance%>" class="tx-fontsize-menu tx-menu" unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left tx-group-font">

					<li class="tx-list">
						<div unselectable="on" class=" tx-btn-lbg 	tx-bold" id="tx_bold<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="굵게 (Ctrl+B)">굵게</a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class=" tx-slt-tbg 	tx-forecolor" id="tx_forecolor<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="글자색">글자색</a>
							<a href="javascript:;" class="tx-arrow" title="글자색 선택">글자색 선택</a>
						</div>
						<div id="tx_forecolor_menu<%=instance%>" class="tx-menu tx-forecolor-menu tx-colorpallete"
					 unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class=" tx-slt-brbg 	tx-backcolor" id="tx_backcolor<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="글자 배경색">글자 배경색</a>
							<a href="javascript:;" class="tx-arrow" title="글자 배경색 선택">글자 배경색 선택</a>
						</div>
						<div id="tx_backcolor_menu<%=instance%>" class="tx-menu tx-backcolor-menu tx-colorpallete"
					 unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left tx-group-align">
					<li class="tx-list">
						<div unselectable="on" class=" tx-btn-lbg 	tx-alignleft" id="tx_alignleft<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="왼쪽정렬 (Ctrl+,)">왼쪽정렬</a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class=" tx-btn-bg 	tx-aligncenter" id="tx_aligncenter<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="가운데정렬 (Ctrl+.)">가운데정렬</a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class=" tx-btn-bg 	tx-alignright" id="tx_alignright<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="오른쪽정렬 (Ctrl+/)">오른쪽정렬</a>
						</div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class=" tx-btn-rbg 	tx-alignfull" id="tx_alignfull<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="양쪽정렬">양쪽정렬</a>
						</div>
					</li>
				</ul>
			</div></div>
	<div id="tx_canvas<%=instance%>" class="tx-canvas">
		<div id="tx_loading<%=instance%>" class="tx-loading"><div><img src="js/editor/images/icon/editor/loading2.png" width="113" height="21" align="absmiddle"/></div></div>
		<div id="tx_canvas_wysiwyg_holder<%=instance%>" class="tx-holder" style="display:block;">
			<iframe id="tx_canvas_wysiwyg<%=instance%>" name="tx_canvas_wysiwyg" allowtransparency="true" frameborder="0"></iframe>
		</div>
		<div class="tx-source-deco">
			<div id="tx_canvas_source_holder<%=instance%>" class="tx-holder">
				<textarea id="tx_canvas_source<%=instance%>" rows="30" cols="30"></textarea>
			</div>
		</div>
		<div id="tx_canvas_text_holder<%=instance%>" class="tx-holder">
			<textarea id="tx_canvas_text<%=instance%>" rows="30" cols="30"></textarea>
		</div>
	</div>
		</div>
	</form>
	<div class="text_merge_wrap">
		<p class="text_merge_text">합성할 문자 추가</p>
		<a href="#" class="text_merge_help" onclick="return false;">도움말</a>
		<button class="whiteBtn text_merge_button" id="ddr">{DATA} 추가</button>
	</div>
	
