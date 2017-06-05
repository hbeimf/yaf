//动态异步加载js


require([

],function(){

    $(function () {
        App.init();


        // var $alert = $('#myModal2');
        var $alert_refresh = $('#myModal22');

        // var $confirm = $('#myModal3');
        var $mod_800 = $('#mod_800');

        $mod_800.on("hidden.bs.modal",function(){
            $mod_800.unbind('shown.bs.modal');
        });

        $alert_refresh.on("hidden.bs.modal",function(){
            window.location.reload();
        });

    });
});






