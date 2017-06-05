{{include file="include/header.tpl"}}

<!-- BEGIN PAGE CONTENT-->
<div class="row-fluid">
	<div class="span6">
		<div class="portlet box grey">
			<div class="portlet-title">
				<div class="caption"><i class="icon-comments"></i>Inline Tree</div>
				<div class="actions">
					<a data-toggle="modal" data-target="#mod_800" href="/system/addMenu/" id="add_menu" class="btn red">增加</a>
					<a href="javascript:;" id="tree_1_collapse" class="btn green">收起</a>
					<a href="javascript:;" id="tree_1_expand" class="btn yellow">展开</a>
				</div>
			</div>

			<div class="portlet-body fuelux">
				<ul class="tree" id="tree_1">
					<li>
						<a href="#" data-role="branch" class="tree-toggle" data-toggle="branch" data-value="Bootstrap_Tree">
						Bootstrap Tree
						</a>
						<ul class="branch in">
							<li>
								<a href="#" class="tree-toggle closed" data-toggle="branch" data-value="Bootstrap_Tree" id="nut3">
								Projects
								</a>
								<ul class="branch">
									<li><a data-toggle="modal" data-target="#mod_800" href="/demo/add/" data-role="leaf"><i class="icon-glass"></i> Internal</a></li>
									<li><a data-toggle="modal" data-target="#mod_900" href="/demo/add/" data-role="leaf"><i class="icon-group"></i> Client Base</a></li>
									<li><a data-toggle="modal" data-target="#mod_1000" href="/demo/add/" data-role="leaf"><i class="icon-retweet"></i> Product Base</a></li>
									<li><a data-toggle="modal" data-target="#mod_1100" href="/demo/add/" data-role="leaf"><i class="icon-retweet"></i> Product Base</a></li>
									<li><a data-toggle="modal" data-target="#mod_1200" href="/demo/add/" data-role="leaf"><i class="icon-retweet"></i> Product Base</a></li>

								</ul>
							</li>

							<li>
								<a data-toggle="modal" data-target="#add" href="/demo/add/" data-role="leaf">
								<i class="icon-share"></i> Another External Link
								</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<!-- END PAGE CONTENT-->

{{include file="include/footer.tpl"}}




