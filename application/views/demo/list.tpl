{{include file="include/header.tpl"}}
	<!-- BEGIN CONTAINER -->
	<div class="page-container row-fluid">
		<!-- BEGIN SIDEBAR -->
		<div class="page-sidebar nav-collapse collapse">
			<!-- BEGIN SIDEBAR MENU -->
            {{include file="include/menu1.tpl"}}
            <!-- END SIDEBAR MENU -->
		</div>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- <div id="portlet-config" class="modal hide">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button"></button>
					<h3>portlet Settings</h3>
				</div>
				<div class="modal-body">
					<p>Here will be a configuration form</p>
				</div>
			</div> -->

			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- BEGIN PAGE CONTAINER-->        
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->
				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN STYLE CUSTOMIZER -->
						<!-- <div class="color-panel hidden-phone">
							<div class="color-mode-icons icon-color"></div>
							<div class="color-mode-icons icon-color-close"></div>
							<div class="color-mode">
								<p>THEME COLOR</p>
								<ul class="inline">
									<li class="color-black current color-default" data-style="default"></li>
									<li class="color-blue" data-style="blue"></li>
									<li class="color-brown" data-style="brown"></li>
									<li class="color-purple" data-style="purple"></li>
									<li class="color-grey" data-style="grey"></li>
									<li class="color-white color-light" data-style="light"></li>
								</ul>
								<label>
									<span>Layout</span>
									<select class="layout-option m-wrap small">
										<option value="fluid" selected>Fluid</option>
										<option value="boxed">Boxed</option>
									</select>
								</label>
								<label>
									<span>Header</span>
									<select class="header-option m-wrap small">
										<option value="fixed" selected>Fixed</option>
										<option value="default">Default</option>
									</select>
								</label>
								<label>
									<span>Sidebar</span>
									<select class="sidebar-option m-wrap small">
										<option value="fixed">Fixed</option>
										<option value="default" selected>Default</option>
									</select>
								</label>
								<label>
									<span>Footer</span>
									<select class="footer-option m-wrap small">
										<option value="fixed">Fixed</option>
										<option value="default" selected>Default</option>
									</select>
								</label>
							</div>
						</div> -->

						<!-- END BEGIN STYLE CUSTOMIZER -->  

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="page-title">
							列表示例 <!-- <small>managed table samples</small> -->
						</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">控制台</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>
								<a href="/demo/list/">示例</a>
								<i class="icon-angle-right"></i>
							</li>
							<li><a href="/demo/list/">分页列表</a></li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">

					<div class="span12">

						<!-- BEGIN EXAMPLE TABLE PORTLET-->
							<div class="portlet-body">
								<div class="clearfix">
									<div class="btn-group pull-right">
										<button id="sample_editable_1_new" class="btn green">
										Add New <i class="icon-plus"></i>
										</button>
									</div>
								</div>
								<!-- 搜索开始 -->
								<div class="row-fluid">
										<div id="sample_1_length" class="dataTables_length">
											<label>records per page
												<select size="1" name="sample_1_length" aria-controls="sample_1" class="m-wrap small">
													<option value="5" selected="selected">5</option>
													<option value="15">15</option>
													<option value="20">20</option>
													<option value="-1">All</option>
												</select> 
												&nbsp;&nbsp;
											</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
											<label>Search: <input type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>

											<label><button id="sample_editable_1_new" class="btn blue">查找 <!-- <i class="icon-plus"> --></i></button></label>
										</div>
								</div>
								<!-- 搜索结束  -->

								<table class="table table-striped table-bordered table-hover" id="sample_1">
									<thead>
										<tr>
											<th style="width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
											<th>Username</th>
											<th class="hidden-480">Email</th>
											<th class="hidden-480">Points</th>
											<th class="hidden-480">Joined</th>
											<th ></th>
										</tr>
									</thead>
									<tbody>
										<tr class="odd gradeX">
											<td><input type="checkbox" class="checkboxes" value="1" /></td>
											<td>shuxer</td>
											<td class="hidden-480"><a href="#">shuxer@gmail.com</a></td>
											<td class="hidden-480">120</td>
											<td class="center hidden-480">12 Jan 2012</td>
											<td ><span class="label label-success">Approved</span></td>
										</tr>
										<tr class="odd gradeX">
											<td><input type="checkbox" class="checkboxes" value="1" /></td>
											<td>looper</td>
											<td class="hidden-480"><a href="#">looper90@gmail.com</a></td>
											<td class="hidden-480">120</td>
											<td class="center hidden-480">12.12.2011</td>
											<td ><span class="label label-warning">Suspended</span></td>
										</tr>
									</tbody>
								</table>

								<div class="row-fluid">
									<div class="span6">
										<div class="dataTables_info" id="sample_1_info">Showing 1 to 2 of 2 entries</div>
									</div>
									<div class="span6">
										<div class="dataTables_paginate paging_bootstrap pagination">
											<ul>
												<li class="prev disabled"><a href="#">← <span class="hidden-480">Prev</span></a></li>
												<li class="active"><a href="#">1</a></li>
												<li><a href="#">2</a></li>
												<li><a href="#">3</a></li>

												<li class="next disabled"><a href="#"><span class="hidden-480">Next</span> → </a></li>
											</ul>
										</div>
									</div>
								</div>

							</div>
						<!-- END EXAMPLE TABLE PORTLET-->
					</div>


				</div>
				<!-- END PAGE CONTENT-->
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->


{{include file="include/footer.tpl"}}




