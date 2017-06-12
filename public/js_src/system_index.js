require([
 	'base',
 	'bootstrap-tree',
 	'ui-tree'
],function(){

    $(function () {
		UITree.init();

        $addMenu = $('#mod_900');

        $('.parent_menu').find('span').click(function(){

            var id = $(this).prop('id');
            // 此处弹出编辑框
            var link = '/system/addMenu/id/'+id;
            $addMenu.find('.modal-content').load(link);
            $addMenu.modal('show');
        });
	});
});






