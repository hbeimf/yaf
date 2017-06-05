

function alert_only(msg) {
    var $obj_modal = $('#myModal2');
    console.log(msg);
    $obj_modal.find('p').html(msg);
    $obj_modal.modal({backdrop:false, keyboard:false});
}


function alert_refresh(msg) {
    var $obj_modal = $('#myModal22');
    // console.log(msg);
    $obj_modal.find('p').html(msg);
    $obj_modal.modal({backdrop:false, keyboard:false});
}
