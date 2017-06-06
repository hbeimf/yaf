//动态异步加载js


require([
	'base'
],function(){


    $(function () {
		TableManaged.init();
		// FormComponents.init();

		console.log('demo');

		var $add = $('#add');
		var $alert = $('#myModal2');
		var $confirm = $('#myModal3');


		$add.on('shown.bs.modal', function (e) {
			$(this).find('#btn_add').click(function () {
				$("#ff").ajaxSubmit({
			        url:'/demo/add/',  //访问这个方法用来得到图片名称
			        type: "post",
			        success: function (data) {
			        	// console.log(data);
			        	// $alert.modal({backdrop:false, keyboard:false});
			        	var msg = 'test msg xx';
			        	// $confirm.find('p').html(msg);
			        	// $confirm.modal({backdrop:false, keyboard:false});

			        	alert_message($alert, msg)
			        }
				});

			});
		});

	    $add.on("hidden.bs.modal",function(){
	    	$add.unbind('shown.bs.modal');
	    });



	});
});






