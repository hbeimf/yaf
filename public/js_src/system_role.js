//动态异步加载js


require([
    'base',
    'jquery.multi-select'
    // 'bootstrap-datepicker',
    // 'bootstrap-datetimepicker',
    // 'form-components'

        // 'bootstrap-fileupload',
        // 'chosen.jquery.min',
        // 'select2.min',
        // 'wysihtml5-0.3.0',
        // 'bootstrap-wysihtml5',
        // 'jquery.tagsinput.min',
        // 'jquery.toggle.buttons',
        // 'clockface',
        // 'date',
        // 'daterangepicker',
        // 'bootstrap-colorpicker',
        // 'bootstrap-timepicker',
        // 'jquery.inputmask.bundle.min',
        // 'jquery.input-ip-address-control-1.0.min',
        // 'jquery.multi-select'
        // 'bootstrap-modal',
        // 'bootstrap-modalmanager'
],function(){


    $(function () {
        TableManaged.init();
        // FormComponents.init();

        console.log('add role');

        var $add = $('#mod_1000');
        // var $alert = $('#myModal2');
        // var $confirm = $('#myModal3');


        $add.on('shown.bs.modal', function (e) {
            // FormComponents.init();

            // $('#ss').multiSelect();

            // $(this).find('#btn_add').click(function () {
            //     $("#ff").ajaxSubmit({
            //         url:'/demo/add/',  //访问这个方法用来得到图片名称
            //         type: "post",
            //         success: function (data) {
            //             // console.log(data);
            //             // $alert.modal({backdrop:false, keyboard:false});
            //             var msg = 'test msg xx';
            //             // $confirm.find('p').html(msg);
            //             // $confirm.modal({backdrop:false, keyboard:false});

            //             alert_message($alert, msg)
            //         }
            //     });

            // });
        });

        // $add.on("hidden.bs.modal",function(){
        //     $add.unbind('shown.bs.modal');
        // });



    });
});






