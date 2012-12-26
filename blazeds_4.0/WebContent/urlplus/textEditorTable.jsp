<%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	int instance = SLibrary.intValue(request.getParameter("instance"));

%><br/>
<form name="tx_editor_form<%=instance%>" id="tx_editor_form<%=instance%>" method="post" accept-charset="utf-8">
		<div id="tx_trex_container<%=instance%>" class="tx-editor-container">
			<div id="tx_toolbar_basic<%=instance%>" class="tx-toolbar tx-toolbar-basic"><div class="tx-toolbar-boundary">
				<ul class="tx-bar tx-bar-left">
					<li class="tx-list">
						<div unselectable="on" class="		 tx-btn-lrbg 	tx-table" id="tx_table<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="표만들기">표만들기</a>
						</div>
						<div id="tx_table_menu<%=instance%>" class="tx-table-menu tx-menu" unselectable="on">
							<div class="tx-menu-inner">
								<div class="tx-menu-preview"></div>
								<div class="tx-menu-rowcol"></div>
								<div class="tx-menu-deco"></div>
								<div class="tx-menu-enter"></div>
							</div>
						</div>
					</li>
				</ul>
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
				<ul class="tx-bar tx-bar-right">
					<li class="tx-list">
						<div unselectable="on" class="tx-btn-nlrbg tx-advanced" id="tx_advanced<%=instance%>">
							<a href="javascript:;" class="tx-icon" title="툴바 더보기">툴바 더보기</a>
						</div>
					</li>
				</ul>
				
			</div></div>
			<!-- 툴바 - 더보기 시작 -->
			<div id="tx_toolbar_advanced<%=instance%>" class="tx-toolbar tx-toolbar-advanced"><div class="tx-toolbar-boundary">
				<!--
				<ul class="tx-bar tx-bar-left">
					<li class="tx-list">
						<div class="tx-tableedit-title"></div>
					</li>
				</ul>-->

				<ul class="tx-bar tx-bar-left tx-group-align">
					<li class="tx-list">
						<div unselectable="on" class="tx-btn-lbg tx-mergecells" id="tx_mergecells<%=instance%>">
							<a href="javascript:;" class="tx-icon2" title="병합">병합</a>
						</div>
						<div id="tx_mergecells_menu<%=instance%>" class="tx-mergecells-menu tx-menu" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="tx-btn-bg tx-insertcells" id="tx_insertcells<%=instance%>">
							<a href="javascript:;" class="tx-icon2" title="삽입">삽입</a>
						</div>
						<div id="tx_insertcells_menu<%=instance%>" class="tx-insertcells-menu tx-menu" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div unselectable="on" class="tx-btn-rbg tx-deletecells" id="tx_deletecells<%=instance%>">
							<a href="javascript:;" class="tx-icon2" title="삭제">삭제</a>
						</div>
						<div id="tx_deletecells_menu<%=instance%>" class="tx-deletecells-menu tx-menu" unselectable="on"></div>
					</li>
				</ul>

				<ul class="tx-bar tx-bar-left tx-group-align">
					<li class="tx-list">
						<div id="tx_cellslinepreview<%=instance%>" unselectable="on" class="tx-slt-70lbg tx-cellslinepreview">
							<a href="javascript:;" title="선 미리보기"></a>
						</div>
						<div id="tx_cellslinepreview_menu<%=instance%>" class="tx-cellslinepreview-menu tx-menu"
							 unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div id="tx_cellslinecolor<%=instance%>" unselectable="on" class="tx-slt-tbg tx-cellslinecolor">
							<a href="javascript:;" class="tx-icon2" title="선색">선색</a>

							<div class="tx-colorpallete" unselectable="on"></div>
						</div>
						<div id="tx_cellslinecolor_menu<%=instance%>" class="tx-cellslinecolor-menu tx-menu tx-colorpallete"
							 unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div id="tx_cellslineheight<%=instance%>" unselectable="on" class="tx-btn-bg tx-cellslineheight">
							<a href="javascript:;" class="tx-icon2" title="두께">두께</a>

						</div>
						<div id="tx_cellslineheight_menu<%=instance%>" class="tx-cellslineheight-menu tx-menu"
							 unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div id="tx_cellslinestyle<%=instance%>" unselectable="on" class="tx-btn-bg tx-cellslinestyle">
							<a href="javascript:;" class="tx-icon2" title="스타일">스타일</a>
						</div>
						<div id="tx_cellslinestyle_menu<%=instance%>" class="tx-cellslinestyle-menu tx-menu" unselectable="on"></div>
					</li>
					<li class="tx-list">
						<div id="tx_cellsoutline<%=instance%>" unselectable="on" class="tx-btn-rbg tx-cellsoutline">
							<a href="javascript:;" class="tx-icon2" title="테두리">테두리</a>

						</div>
						<div id="tx_cellsoutline_menu<%=instance%>" class="tx-cellsoutline-menu tx-menu" unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left">
					<li class="tx-list">
						<div id="tx_tablebackcolor<%=instance%>" unselectable="on" class="tx-btn-lrbg tx-tablebackcolor"
							 style="background-color:#9aa5ea;">
							<a href="javascript:;" class="tx-icon2" title="테이블 배경색">테이블 배경색</a>
						</div>
						<div id="tx_tablebackcolor_menu<%=instance%>" class="tx-tablebackcolor-menu tx-menu tx-colorpallete"
							 unselectable="on"></div>
					</li>
				</ul>
				<ul class="tx-bar tx-bar-left">
					<li class="tx-list">
						<div id="tx_tabletemplate<%=instance%>" unselectable="on" class="tx-btn-lrbg tx-tabletemplate">
							<a href="javascript:;" class="tx-icon2" title="테이블 서식">테이블 서식</a>
						</div>
						<div id="tx_tabletemplate_menu<%=instance%>" class="tx-tabletemplate-menu tx-menu tx-colorpallete"
							 unselectable="on"></div>
					</li>
				</ul>

			</div></div>
			<!-- 툴바 - 더보기 끝 -->
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
