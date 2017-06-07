//动态异步加载js


require([

],function(){

    $(function () {
        App.init();

        var $alert_refresh = $('#myModal22');

        $alert_refresh.on("hidden.bs.modal",function(){
            window.location.reload();
        });

        var mod_array = [$('#mod_800'), $('#mod_900'), $('#mod_1000'), $('#mod_1100'), $('#mod_1200')];

        for (var i = 0; i < mod_array.length; i++) {
            mod_array[i].on("shown.bs.modal",function(){
                $(this).find('.select2').select2();
            });


            mod_array[i].on("hidden.bs.modal",function(){
                $(this).unbind('shown.bs.modal');
            });

        };

    });
});






