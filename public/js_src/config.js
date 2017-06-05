// //全局配置
require.config({
    // baseUrl:'/js_src',
    paths:{
        'jquery':'/js/jquery-1.10.1.min',
        'jquery-migrate':'/js/jquery-migrate-1.2.1.min',
        'jquery-ui':'/js/jquery-ui-1.10.1.custom.min',
        'bootstrap':'/js/bootstrap.min',
        'jquery.slimscroll':'/js/jquery.slimscroll.min',
        'jquery.blockui':'/js/jquery.blockui.min',
        'jquery.cookie':'/js/jquery.cookie.min',
        'jquery.uniform':'/js/jquery.uniform.min',
        'select2':'/js/select2.min',
        'jquery.dataTables':'/js/jquery.dataTables',
        'DT_bootstrap':'/js/DT_bootstrap',
        'app':'/js/app',
        'table-managed':'/js/table-managed',
        'jquery.form':'/js/jquery.form',
        'bootstrap-tree': '/js/bootstrap-tree',
        'ui-tree': '/js/ui-tree',
        'base': '/js_src/base',
        'functions' : '/js_src/functions'
    },
    shim: {
        // jQuery
        'jquery-migrate': ['jquery'],
        'jquery.slimscroll': ['jquery'],
        'jquery.uniform': ['jquery'],
        'jquery-ui': ['jquery'],
        'jquery.form': ['jquery'],
        'bootstrap': ['jquery'],
        'select2': ['jquery'],
        'DT_bootstrap': ['jquery', 'bootstrap'],
        'bootstrap-tree': ['jquery', 'bootstrap'],
        'ui-tree': ['jquery', 'bootstrap'],
        'base': ['jquery', 'jquery-migrate', 'jquery-ui', 'bootstrap', 'jquery.slimscroll', 'jquery.blockui',
                    'jquery.cookie', 'jquery.uniform', 'select2', 'jquery.dataTables', 'DT_bootstrap',
                    'app', 'table-managed', 'jquery.form', 'bootstrap-tree', 'ui-tree', 'functions'],
        'functions':['app', 'jquery']
    },
    waitSeconds: 100 // ie load modules timeout bug fixed
});






