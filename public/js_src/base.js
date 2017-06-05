//动态异步加载js


require([

],function(){

    $(function () {
        App.init();


        // var $alert = $('#myModal2');
        var $alert_refresh = $('#myModal22');

        var $mod_800 = $('#mod_800');
        var $mod_900 = $('#mod_900');
        var $mod_1000 = $('#mod_1000');
        var $mod_1100 = $('#mod_1100');
        var $mod_1200 = $('#mod_1200');

        $mod_800.on("hidden.bs.modal",function(){
            $mod_800.unbind('shown.bs.modal');
        });

        $mod_900.on("hidden.bs.modal",function(){
            $mod_900.unbind('shown.bs.modal');
        });

        $mod_1000.on("hidden.bs.modal",function(){
            $mod_1000.unbind('shown.bs.modal');
        });

        $mod_1100.on("hidden.bs.modal",function(){
            $mod_1100.unbind('shown.bs.modal');
        });

        $mod_1200.on("hidden.bs.modal",function(){
            $mod_1200.unbind('shown.bs.modal');
        });

        $alert_refresh.on("hidden.bs.modal",function(){
            window.location.reload();
        });

    });
});






