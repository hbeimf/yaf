			<!-- 打印sql 开始　-->
			{{if $APP_ENV eq 'DEVELOPMENT'}}
				<div class="row-fluid">
	    			<div class="span12">
	    				<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption"><i class="icon-comments"></i>SQL查询记录</div>
								<div class="actions">
								</div>
							</div>

							<div class="portlet-body fuelux">
								{{queryLog}}
							</div>
						</div>
	    			</div>
	    		</div>
    		{{/if}}
    		<!-- 打印sql　结束　-->


			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->

	<!-- BEGIN FOOTER -->
	<div class="footer">
		<div class="footer-inner">
			2013 &copy; Metronic by keenthemes.Collect from
		</div>
		<div class="footer-tools">
			<span class="go-top">
			<i class="icon-angle-up"></i>
			</span>
		</div>
	</div>

	{{include file="include/modal.tpl"}}

	<script src="/js/require.js" type="text/javascript"></script>
	<script type="text/javascript">
	    require({
	        baseUrl: '/js_src/',
	        config:{}
	    });
	    require(["config"], function () {
	    	require(["{{if isset($js)}}{{$js}}{{else}}default_empty{{/if}}"]);
	    });
	</script>


	</body>
<!-- END BODY -->
</html>
