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

	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->
	<script src="/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="/js/bootstrap.min.js?{{$rand}}" type="text/javascript"></script>

	

	<!--[if lt IE 9]>
	<script src="/js/excanvas.min.js"></script>
	<script src="/js/respond.min.js"></script>  
	<![endif]-->   
	<script src="/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/js/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/js/select2.min.js"></script>
	<script type="text/javascript" src="/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="/js/DT_bootstrap.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/js/app.js"></script>
	<script src="/js/table-managed.js"></script>
	<script src="/js/jquery.form.js"></script>





	<script>
		jQuery(document).ready(function() {       
		   App.init();
		   TableManaged.init();

		  
		});
	</script>

	<script src="/js_src/{{$js}}.js?t={{$rand}}"></script>

	</body>
<!-- END BODY -->
</html>