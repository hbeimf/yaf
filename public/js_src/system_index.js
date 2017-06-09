require([
 	'base',
 	'bootstrap-tree',
 	'ui-tree'
],function(){

    $(function () {
		UITree.init();

        $('.parent_menu').find('span').click(function(){

            var id = $(this).prop('id');
            console.log(id);

            // 此处弹出编辑框
            //

        });
	});
});






