<form name="ff" id="ff" class="form-horizontal form-row-seperated validator-popover" action="/system/addMenu" method='post'>

    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增</h4>

    </div>
    <div class="modal-body">
        <div>
            名称: <input type="text" name="menu_name" id="menu_name" data-required=""
            class="form-control input" value="test" />
        </div>
        <div>
            上级导航: <input type="text" name="parent_id" id="parent_id" data-required=""
            class="form-control input" value="0" />
        </div>

        <div>
            链接: <input type="text" name="link" id="link" data-required=""
            class="form-control input" value="/system/" />
        </div>

        <div>
            图标: <input type="text" name="icon" id="icon" data-required=""
            class="form-control input" value="icon" />
        </div>

        <div>
            状态: <input type="text" name="status" id="status" data-required=""
            class="form-control input" value="1" />
        </div>

        <div>
            备注: <input type="text" name="note" id="note" data-required=""
            class="form-control input" value="note" />
        </div>
    </div>


    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary">保存</button>
    </div>
</form>
