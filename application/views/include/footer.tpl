{{include file="include/modal.tpl"}}

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

	<script src="/js/require.js" type="text/javascript"></script>
	<script type="text/javascript">
	    require({
	        baseUrl: '/js_src/',
	        config:{}
	    });
	    require(["config"], function () {
	    	require(["{{$js}}"]);
	    });
	</script>


	</body>
<!-- END BODY -->
</html>