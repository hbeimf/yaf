//动态异步加载js

// http://blog.csdn.net/u013991154/article/details/54346745
// http://www.cnblogs.com/skybreak/p/6137035.html
// http://blog.csdn.net/webdev_l/article/details/70859986
// http://www.bootcdn.cn/bootstrap/



require([
    'base'
    // 'form-samples'
    // 'jquery.multi-select'
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
        // TableManaged.init();
        // FormSamples.init();

        // $.fn.modal.Constructor.prototype.enforceFocus = function() {};
        // $.fn.modal.Constructor.prototype.enforceFocus = function() {};
        // $.fn.modal.Constructor.prototype.enforceFocus = function () {};

        console.log('add role');

        var $add = $('#mod_1200');
        // var $alert = $('#myModal2');
        // var $confirm = $('#myModal3');

//         <style>
// .select2-container--open{
//         z-index:9999999
// }
// </style>

        // $('.select2-container--open').attr('z-index', 9999999);

        $add.on('shown.bs.modal', function (e) {
            // $.fn.modal.Constructor.prototype.enforceFocus = function () {};

            console.log('fff');

            // use select2 dropdown instead of chosen as select2 works fine with bootstrap on responsive layouts.
            // $(this).find('.select2_category').select2({
            //     placeholder: "Select an option",
            //     allowClear: true
            // });

            $(this).find('.select2_category').select2();

            $(this).find('.select2_sample1').select2({
                placeholder: "Select a State",
                allowClear: true
            });


            // $(this).find(".select2_sample2").select2({
            //     placeholder: "Type to select an option",
            //     allowClear: true,
            //     minimumInputLength: 1,
            //     query: function (query) {
            //         var data = {
            //             results: []
            //         }, i, j, s;
            //         for (i = 1; i < 5; i++) {
            //             s = "";
            //             for (j = 0; j < i; j++) {
            //                 s = s + query.term;
            //             }
            //             data.results.push({
            //                 id: query.term + i,
            //                 text: s
            //             });
            //         }
            //         query.callback(data);
            //     }
            // });

            $(this).find(".select2_sample3").select2({
                tags: ["red", "green", "blue", "yellow", "pink"]
            });





            // FormSamples.init();

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






