<form name="ff" id="ff" class="form-horizontal ajax_form" action="/system/addRole" method='post'>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增角色</h4>
    </div>
    <div class="modal-body">

<!-- BEGIN FORM-->
<div class="control-group">

    <label class="control-label">角色名称</label>

    <div class="controls">

        <input name="role_name" type="text" placeholder="small" class="m-wrap span6" />

        <span class="help-inline">This is inline help</span>

    </div>

</div>

<div class="control-group">
    <label class="control-label">访问导航权限</label>
    <div class="controls">
            <select name="menu_ids[]" class="span6 m-wrap select2" multiple placeholder="请选择导航...">
                {{foreach from=$system_menu item=m}}
                    <optgroup label="{{$m['menu_name']}}">
                        {{foreach from=$m['child'] item=mm}}
                            <option value="{{$mm['id']}}">{{$mm['menu_name']}}</option>
                        {{/foreach}}
                    </optgroup>
                {{/foreach}}
            </select>
    </div>
</div>


<div class="control-group">
    <label class="control-label" >是否启用</label>
    <div class="controls">
        <label class="radio">
        <input type="radio" name="status" value="1" />
        启用
        </label>
        <label class="radio">
        <input type="radio" name="status" value="2" checked />
        禁用
        </label>
    </div>
</div>

<div class="control-group">
    <label class="control-label">备注</label>
    <div class="controls">
        <input name="note" type="text" placeholder="note" class="m-wrap span6" />
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
