//动态异步加载js


require([
 	'base'
],function(){


    $(function () {
		UITree.init();

		var $mod_800 = $('#mod_800');

		$mod_800.on('shown.bs.modal', function (e) {
			$(this).find('#btn_add').click(function () {
				// $(this).find("#ff").ajaxSubmit({
				$("#ff").ajaxSubmit({

			        url:'/system/addMenu/',  //访问这个方法用来得到图片名称
			        type: "post",
			        success: function (data) {
			        	var json = $.parseJSON(data);
			        	if (json.flg) {
			        		alert_refresh(json.msg);
			        	} else {
			        		alert_only(json.msg);
			        	}
			        }
				});

			});
		});


	});
});






