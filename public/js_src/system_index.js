//动态异步加载js  


require([
	// '/js_src/config.js',
	'jquery',
    'jquery-migrate',
    'jquery-ui',
    'bootstrap',
    'jquery.slimscroll',
    'jquery.blockui',
    'jquery.cookie',
    'jquery.uniform',
    'select2',
    'jquery.dataTables',
    'DT_bootstrap',
    'app',
    'table-managed',
    'jquery.form',
    'functions',
    'bootstrap-tree',
    'ui-tree'

],function($){  
    
    
    $(function () {
    	App.init();

    	// $('#tree_1_collapse').click(function () {
     //        $('.tree-toggle', $('#tree_1 > li > ul')).addClass("closed");
     //        $('.branch', $('#tree_1 > li > ul')).removeClass("in");
     //    });

     //    $('#tree_1_expand').click(function () {
     //        $('.tree-toggle', $('#tree_1 > li > ul')).removeClass("closed");
     //        $('.branch', $('#tree_1 > li > ul')).addClass("in");
     //    });

		UITree.init();


		// console.log('demo');

		// var $add = $('#add');
		// var $alert = $('#myModal2');
		// var $confirm = $('#myModal3');


		// $add.on('shown.bs.modal', function (e) {
		// 	$(this).find('#btn_add').click(function () {
		// 		$("#ff").ajaxSubmit({
		// 	        url:'/demo/add/',  //访问这个方法用来得到图片名称
		// 	        type: "post",
		// 	        success: function (data) {
		// 	        	// console.log(data);
		// 	        	// $alert.modal({backdrop:false, keyboard:false});
		// 	        	var msg = 'test msg xx';
		// 	        	// $confirm.find('p').html(msg);
		// 	        	// $confirm.modal({backdrop:false, keyboard:false});

		// 	        	alert_message($alert, msg)
		// 	        }
		// 		});

		// 	});
		// });

	 //    $add.on("hidden.bs.modal",function(){
	 //    	$add.unbind('shown.bs.modal');
	 //    });


		
	});
}); 






