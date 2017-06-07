<form name="ff" id="ff" class="form-horizontal " action="/system/addMenu" method='post'>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增导航</h4>
    </div>
    <div class="modal-body">

        <!-- BEGIN FORM-->
        <div class="control-group">
            <label class="control-label">导航名称</label>
            <div class="controls">
                <input name="menu_name" type="text" placeholder="请输入导航名称..." class="m-wrap span4" />
                <!-- <span class="help-inline">This is inline help</span> -->
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">上级导航</label>
            <div class="controls">
                <select name="parent_id" class="span6 select2" placeholder="请选择导航...">
                    <option value="0">顶级导航</option>
                    {{foreach from=$system_menu item=m}}
                        <option value="{{$m['id']}}">{{$m['menu_name']}}</option>
                    {{/foreach}}
                </select>
            </div>
        </div>


        <div class="control-group">
            <label class="control-label">链接</label>
            <div class="controls">
                <input name="link" type="text" placeholder="请输入链接..." class="m-wrap span6" />
                <span class="help-inline"></span>
            </div>

        </div>

        <div class="control-group">
            <label class="control-label" >图标</label>
            <div class="controls">
                <!-- <select name="icon" class="span6 select2" data-placeholder="请选择图标..." tabindex="1">
                    <option value=""></option>
                    <option value="icon-plus"><img class="icon-plus" /></option>
                    <option value="icon-plus"><i class="icon-plus">yy</i></option>

                    <option value="Category 2">Category 2</option>
                    <option value="Category 3">Category 5</option>
                    <option value="Category 4">Category 4</option>
                </select> -->

                <input name="icon" type="text" placeholder="请输入图标..." value="icon-plus" class="m-wrap span6" />
                <span class="help-inline"></span>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" >是否启用</label>
            <div class="controls">
                <label class="radio">
                <input type="radio" name="status" value="1" checked />
                启用
                </label>
                <label class="radio">
                <input type="radio" name="status" value="2" />
                禁用
                </label>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">备注</label>
            <div class="controls">
                <input name="note" type="text" placeholder="请输入备注..." class="m-wrap span6" />
                <span class="help-inline"></span>
            </div>

        </div>

        <!-- END FORM-->


    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary blue">保存</button>
    </div>
</form>
