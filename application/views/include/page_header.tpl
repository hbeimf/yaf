<div class="row-fluid">
	<div class="span12">
		<!-- BEGIN STYLE CUSTOMIZER -->
		<div class="color-panel hidden-phone">
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
		</div>

		<!-- END BEGIN STYLE CUSTOMIZER -->

		<!-- BEGIN PAGE TITLE & BREADCRUMB-->
		<h3 class="page-title">
			{{$current_menu['menu_name']}} <!-- <small>managed table samples</small> -->
		</h3>
		<ul class="breadcrumb">
			<li>
				<i class="icon-home"></i>
				<a href="/">控制台</a>
				<i class="icon-angle-right"></i>
			</li>
			<li>
				<a href="javascript:;">{{$current_menu['parent_menu_name']}}</a>
				<i class="icon-angle-right"></i>
			</li>
			<li><a href="javascript:;">{{$current_menu['menu_name']}}</a></li>
		</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
	</div>
</div>
