require([
    'base',
    'ztree'
],function(){
    var ztree = null;

    var setting = {
            view: {
                expandSpeed: 'fast',
                nameIsHTML: true,
                // showIcon: false
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'pId',
                    rootPid: 0
                }
            }
        };

    var $ztreeView = $('#ztree-view'),
        $ztreeExpandAll = $('.ztree-expand-all'),
        $ztreeCollapseAll = $('.ztree-collapse-all');


    var loadZTreeFromUrl = function (url) {
        $.get(url).done(function (zNodes) {
            console.log(zNodes);
            zNodes = $.parseJSON(zNodes);

            // zNodes = [
            //     { id:1, pId:0, name:"parentNode 1", open:true},
            //     { id:11, pId:1, name:"parentNode 11",isParent:true},
            //     { id:111, pId:11, name:"leafNode 111"},
            //     { id:112, pId:11, name:"leafNode 112"},
            //     { id:12, pId:1, name:"parentNode 12",isParent:true},
            //     { id:121, pId:12, name:"leafNode 121"},
            //     { id:13, pId:1, name:"parentNode 13", isParent:true},
            //     { id:2, pId:0, name:"parentNode 2", isParent:true}
            // ];

            $.fn.zTree.init($ztreeView, setting, zNodes);

            ztree = $.fn.zTree.getZTreeObj('ztree-view');

            ztree.expandAll(true); // 默认展开

            $ztreeExpandAll.on('click', function() {
                ztree.expandAll(true);
                $(this).css('color', 'gray');
                $ztreeCollapseAll.css('color', '#2a6496');
            });

            $ztreeCollapseAll.on('click', function() {
                ztree.expandAll(false);
                $(this).css('color', 'gray');
                $ztreeExpandAll.css('color', '#2a6496');
            });

            // 注册事件
            // click();
        });
    };

    loadZTreeFromUrl('/ztree/tree');


});






