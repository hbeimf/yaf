//动态异步加载js

require([

],function(){

    $(function () {
        App.init();

        var $alert_refresh = $('#myModal22');

        // 提示信息modal关闭后reload 当前页面
        $alert_refresh.on("hidden.bs.modal",function(){
            window.location.reload();
        });

        var mod_array = [$('#mod_800'), $('#mod_900'), $('#mod_1000'), $('#mod_1100'), $('#mod_1200')];

        for (var i = 0; i < mod_array.length; i++) {
            mod_array[i].on("shown.bs.modal",function(){
                var $current_modal = $(this);
                $current_modal.find('.select2').select2();

                $current_modal.find('#btn_add').click(function () {
                    var $form = $current_modal.find('.ajax_form');
                    var action = $form.prop('action');

                    console.log(action);

                    $form.ajaxSubmit({
                        url: action,
                        type: "post",
                        success: function (reply_json) {
                            console.log(reply_json);
                            var reply = $.parseJSON(reply_json);
                            if (reply.code == 200) {
                                alert_refresh(reply.msg);
                            } else {
                                alert_only(reply.msg)
                            }
                        }
                    });

                });
            });

            // 解决隐藏modal后再次打开，重复注册事件bug
            mod_array[i].on("hidden.bs.modal",function(){
                $(this).unbind('shown.bs.modal');
            });

        };

    });
});






