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

		<!-- BEGIN PAGE CONTAINER-->        
		<div class="container-fluid">
			<!-- BEGIN PAGE HEADER-->
			{{include file="include/page_header.tpl"}}
			<!-- END PAGE HEADER-->

			<!-- BEGIN PAGE CONTENT-->
			<div class="row-fluid">

				<div class="span12">

					<!-- BEGIN EXAMPLE TABLE PORTLET-->
						<div class="portlet-body">
							<div class="clearfix">
								<div class="btn-group pull-right">
									<a data-toggle="modal" data-target="#add" href="/demo/add/" class="btn green" >
									新增 <i class="icon-plus"></i>
									</a>
								</div>

								
								<!-- <div class="btn-group pull-left">
									<a data-toggle="modal" data-target="#show_demo" href="/demo/mod/" class="btn red" >
									模态框 
									</a>

								</div> -->
								
							</div>
							<!-- 搜索开始 -->
							<div class="row-fluid">
								<form>
									<div id="sample_1_length" class="dataTables_length">
										<label>records per page
											<select size="1" name="page_size" aria-controls="sample_1" class="m-wrap small">
												<option value="5" selected="selected">5</option>
												<option value="15">15</option>
												<option value="20">20</option>
												<option value="-1">All</option>
											</select> 
											&nbsp;&nbsp;
										</label>
										<label>名称: <input name="name" type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
										<label>邮箱: <input name="email" type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
										

										<label><button id="btn_search" class="btn blue">查找 <!-- <i class="icon-plus"> --></i></button></label>
									</div>
								</form>
							</div>
							<!-- 搜索结束  -->

							<table class="table table-striped table-bordered table-hover" id="sample_1">
								<thead>
									<tr>
										<th style="width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th>
										<th class="hidden-480">姓名</th>
										<th class="hidden-480">邮箱</th>
										<th class="hidden-480">创建时间</th>
										
									</tr>
								</thead>
								<tbody>
									{{foreach from=$users item=r}}
									<tr class="odd gradeX">
										<td><input type="checkbox" class="checkboxes" value="{{$r['id']}}" /></td>
										<td>{{$r['name']}}</td>
										<td>{{$r['email']}}</td>
										<td>{{$r['created_at']}}</td>
									</tr>
									{{/foreach}}
									
								</tbody>
							</table>

							<!-- 分页开始 -->
							{{include file="include/page_list.tpl"}}
							<!-- 分页结束 -->

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




