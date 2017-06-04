function test(){
	console.log('test function...');
}


function alert_message($obj_modal, msg) {
	console.log(msg);
	$obj_modal.find('p').html(msg);
	$obj_modal.modal({backdrop:false, keyboard:false});
}
