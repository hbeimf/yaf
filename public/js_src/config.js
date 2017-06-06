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
        'functions' : '/js_src/functions',
        'base': '/js_src/base',

        'form-components':'/js/form-components',
        'ckeditor':'/js/ckeditor',
        'bootstrap-fileupload':'/js/bootstrap-fileupload',
        'chosen.jquery.min':'/js/chosen.jquery.min',
        'wysihtml5-0.3.0':'/js/wysihtml5-0.3.0',
        'bootstrap-wysihtml5':'/js/bootstrap-wysihtml5',
        'jquery.tagsinput.min':'/js/jquery.tagsinput.min',
        'jquery.toggle.buttons':'/js/jquery.toggle.buttons',
        'bootstrap-datepicker':'/js/bootstrap-datepicker',
        'bootstrap-datetimepicker':'/js/bootstrap-datetimepicker',
        'clockface':'/js/clockface',
        'date':'/js/date',
        'daterangepicker':'/js/daterangepicker',
        'bootstrap-colorpicker':'/js/bootstrap-colorpicker',
        'bootstrap-timepicker':'/js/bootstrap-timepicker',
        'jquery.inputmask.bundle.min':'/js/jquery.inputmask.bundle.min',
        'jquery.input-ip-address-control-1.0.min':'/js/jquery.input-ip-address-control-1.0.min',
        'jquery.multi-select':'/js/jquery.multi-select',
        'bootstrap-modal':'/js/bootstrap-modal',
        'bootstrap-modalmanager':'/js/bootstrap-modalmanager'
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


        'bootstrap-datepicker': ['jquery', 'bootstrap'],
        'bootstrap-datetimepicker': ['jquery', 'bootstrap'],
        'ckeditor':['jquery', 'bootstrap'],
        'bootstrap-fileupload':['jquery', 'bootstrap'],
        'chosen.jquery.min':['jquery', 'bootstrap'],
        'wysihtml5-0.3.0':['jquery', 'bootstrap'],
        'bootstrap-wysihtml5':['jquery', 'bootstrap'],
        'jquery.tagsinput.min':['jquery', 'bootstrap'],
        'jquery.toggle.buttons':['jquery', 'bootstrap'],
        'bootstrap-datepicker':['jquery', 'bootstrap'],
        'bootstrap-datetimepicker':['jquery', 'bootstrap'],
        'clockface':['jquery', 'bootstrap'],
        'date':['jquery', 'bootstrap'],
        'daterangepicker':['jquery', 'bootstrap'],
        'bootstrap-colorpicker':['jquery', 'bootstrap'],
        'bootstrap-timepicker':['jquery', 'bootstrap'],
        'jquery.inputmask.bundle.min':['jquery', 'bootstrap'],
        'jquery.input-ip-address-control-1.0.min':['jquery', 'bootstrap'],
        'jquery.multi-select':['jquery', 'bootstrap'],
        'bootstrap-modal':['jquery', 'bootstrap'],
        'bootstrap-modalmanager':['jquery', 'bootstrap'],
        'form-components':['jquery', 'bootstrap'],



        'base': ['jquery', 'jquery-migrate', 'jquery-ui', 'bootstrap', 'jquery.slimscroll', 'jquery.blockui',
                    'jquery.cookie', 'jquery.uniform', 'select2', 'jquery.dataTables', 'DT_bootstrap',
                    'app', 'table-managed', 'jquery.form', 'functions'],
        'functions':['app', 'jquery']
    },
    waitSeconds: 100 // ie load modules timeout bug fixed
});



