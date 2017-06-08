//动态异步加载js


require([
 	'base',
 	'bootstrap-tree',
 	'ui-tree'
],function(){


    $(function () {
		UITree.init();

		// var $addMenu = $('#mod_900');

		// $addMenu.on('shown.bs.modal', function (e) {
		// 	$(this).find('.select2').select2();

		// 	$(this).find('#btn_add').click(function () {
		// 		// $(this).find("#ff").ajaxSubmit({
		// 		$("#ff").ajaxSubmit({

		// 	        url:'/system/addMenu/',  //访问这个方法用来得到图片名称
		// 	        type: "post",
		// 	        success: function (data) {
		// 	        	var json = $.parseJSON(data);
		// 	        	if (json.flg) {
		// 	        		alert_refresh(json.msg);
		// 	        	} else {
		// 	        		alert_only(json.msg);
		// 	        	}
		// 	        }
		// 		});

		// 	});
		// });


	});
});






