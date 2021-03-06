{{include file="include/header.tpl"}}

<!-- BEGIN PAGE CONTENT-->
<div class="row-fluid">
	<div class="span6">
		<div class="portlet box grey">
			<div class="portlet-title">
				<div class="caption"><i class="icon-comments"></i>导航</div>
				<div class="actions">
					<a data-toggle="modal" data-target="#mod_900" href="/system/addMenu/" id="add_menu" class="btn red">增加</a>
					<a href="javascript:;" id="tree_1_collapse" class="btn green">收起</a>
					<a href="javascript:;" id="tree_1_expand" class="btn yellow">展开</a>
				</div>
			</div>

			<div class="portlet-body fuelux">
				<ul class="tree" id="tree_1">
					<li>
						<a href="#" data-role="branch" class="tree-toggle" data-toggle="branch" data-value="Bootstrap_Tree">
						导航
						</a>
						<ul class="branch in">
							{{foreach from=$system_menu item=m}}
								<li>
									<a href="" class="tree-toggle closed parent_menu" data-toggle="branch" data-value="Bootstrap_Tree" >
										<span id="{{$m['id']}}">{{$m['menu_name']}} ++</span>
									</a>
										<ul class="branch">
											{{foreach from=$m['child'] item=mm}}
											<li>
												<a data-toggle="modal" data-target="#mod_900" href="/system/addMenu/id/{{$mm['id']}}" data-role="leaf">
													<i class="icon-plus"></i>{{$mm['menu_name']}}
													[{{if $mm['type']=='1'}}导航{{else}}<font color=red>功能</font>{{/if}}]
												</a>
											</li>
											{{/foreach}}
										</ul>
								</li>
							{{/foreach}}
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<!-- END PAGE CONTENT-->

{{include file="include/footer.tpl"}}




