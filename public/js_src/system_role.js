//动态异步加载js


// http://www.bootcdn.cn/bootstrap/
// http://www.cnblogs.com/skybreak/p/6137035.html

require([
    'base'
],function(){


    $(function () {
        // TableManaged.init();
        // FormSamples.init();

        console.log('add role');

        var $add = $('#mod_1200');
        // var $alert = $('#myModal2');
        // var $confirm = $('#myModal3');

        $add.on('shown.bs.modal', function (e) {

            console.log('fff');

            // $(this).find('.select2_category').select2();

            // $(this).find('.select2_sample1').select2();

            // $(this).find('.select2').select2();


            // $(this).find(".select2_sample3").select2({
            //     tags: ["red", "green", "blue", "yellow", "pink"]
            // });



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






